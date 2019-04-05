Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A73C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C7C21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLsK7EXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDEUz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:55:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDEUz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:55:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so3915088pfn.3;
        Fri, 05 Apr 2019 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6Mfz37qY9DmaYXfENP4Z+htB5yyptzgabJS8sJC+1/g=;
        b=cLsK7EXo83ftfYOTyBJqTAC12dvy8KDTHjVvdfPkgHz0uFdkq2ATmiSsdu0J9dmErK
         gh2E+pohWI5H0xjRhykVkr3+ImwMHcXSlZhTTlNob0dY0qjjn4Qcespyicawf2eCxRDB
         BOUlRFzlYW8UgQHbN7LiF8Po9FQi84LAMKYTCWIy8CyOfAcpH4JNKD3uFDNcre6TkVoW
         PJeFA/VyaZ1D3a1F3Sv7lizvV5vL+t77nIHiYihKIFecJw9RNJi/kS3iKBSA9FmyKwhw
         DIXvLgi4HpZk/yiIJd2qpw0P2jKGeQ2L7TFESbOuzi/3X86s7XwzKZ4KcPtcBf+kALxe
         Xx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6Mfz37qY9DmaYXfENP4Z+htB5yyptzgabJS8sJC+1/g=;
        b=pjrYIwbIzFiz6ObDzVgavOvnJ9/UUC8aKxNqw0C/VzpXLmmyewzMC/E9aTyVKStyby
         1Afb/QWfneHucdc0bPemgSoIJw0h9l010yDKqblTnfG2QmsbZEWeXALjLuoIdv4HtQMf
         zvoOEMKY+k9JSBTAuga0QQ0EA5fja3wLLeU1i6NdefMhtOxgQAyn1pHxyZA6W14jIt58
         8SZbB65f9+vAW0zWS0z2D3apNoetPge9ez2vDlR0ffItaQpWcz1b6CCGiKhpy2RWOe+P
         RRRWUk1/mWFBcsvS6BoYDc1Z4TAPZKINe55HOTBhXB8ZJUs09upIRdIefEZA4fkBd+iv
         Cr2Q==
X-Gm-Message-State: APjAAAXeshD7Z/9VNNOCE4EUO54WRUCDvIWORlflDaURTq53cSl+RK/s
        4s3uqhw4ZWdchzl+Rz6wjVI=
X-Google-Smtp-Source: APXvYqyNaUd3JADUyZ7ZT1m0mFdGTzx84ccg0rxCeIA+60BVs8jccQjc8nS6oxalkt67P6jE51yQOA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr15212949pfc.9.1554497757604;
        Fri, 05 Apr 2019 13:55:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6sm2373877pfb.171.2019.04.05.13.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:55:56 -0700 (PDT)
Date:   Fri, 5 Apr 2019 13:55:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: alim7101: Mark expected switch fall-through
Message-ID: <20190405205555.GA20974@roeck-us.net>
References: <20190320181658.GA6749@embeddedor>
 <e041fd69-0cbc-edb8-cc30-037b333e29cc@roeck-us.net>
 <9a839da8-d2ba-a856-16a7-2ed180ca7864@embeddedor.com>
 <779afa51-5700-ccb1-6761-b51e4227ef81@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779afa51-5700-ccb1-6761-b51e4227ef81@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:04:27PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this?

I added it to my watchdog-next branch. Usually Wim will pick it up from there.

Guenter

> 
> Thanks
> --
> Gustavo
> 
> On 3/20/19 7:15 PM, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 3/20/19 7:12 PM, Guenter Roeck wrote:
> >> On 3/20/19 11:16 AM, Gustavo A. R. Silva wrote:
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warning:
> >>>
> >>> drivers/watchdog/alim7101_wdt.c: In function ‘fop_ioctl’:
> >>> drivers/watchdog/alim7101_wdt.c:279:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>     wdt_keepalive();
> >>>     ^~~~~~~~~~~~~~~
> >>> drivers/watchdog/alim7101_wdt.c:282:2: note: here
> >>>    case WDIOC_GETTIMEOUT:
> >>>    ^~~~
> >>>
> >>> Notice that, in this particular case, the /* Fall through */
> >>> comment is placed at the very bottom of the case statement,
> >>> which is what GCC is expecting to find.
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>
> >>> This patch is part of the ongoing efforts to enabling
> >>> -Wimplicit-fallthrough.
> >>>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >>
> > 
> > Thanks, Guenter. :)
> > 
> > --
> > Gustavo
> > 
> >>> ---
> >>>   drivers/watchdog/alim7101_wdt.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
> >>> index 12f7ea62dddd..f5ada07e9202 100644
> >>> --- a/drivers/watchdog/alim7101_wdt.c
> >>> +++ b/drivers/watchdog/alim7101_wdt.c
> >>> @@ -277,8 +277,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >>>               return -EINVAL;
> >>>           timeout = new_timeout;
> >>>           wdt_keepalive();
> >>> -        /* Fall through */
> >>>       }
> >>> +        /* Fall through */
> >>>       case WDIOC_GETTIMEOUT:
> >>>           return put_user(timeout, p);
> >>>       default:
> >>>
> >>
