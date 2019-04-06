Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA38C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974021019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHuKYCvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDFXGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:06:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39914 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDFXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:06:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so2710432otb.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CLeQ2xVrGuuCQrbf2eH5fzOKL2CstlL+dKrFSPpYbHU=;
        b=eHuKYCvtfS6ZjWTbmhR+pMgZzDv2d7peja7Vq6PpDJovFMCE+3tL1nOcSozK1jepdM
         crJuiJLIN/rK2m/KtgfRKhsTAIkByItTF9gAwD+fNaChSCHY1NcDT48tJnKU++gf2L52
         LAkXdVWyaps0vkYy/4ujVB79VZGTAmeLtXXBPEJJ+HaGgv170T6zxd0t2yXCs4mLCu89
         AKzD6YQQHHo74DJII1F7WH6ZbdCoEhgy4nnqGHO6Y9n1aWbRtfCTKrV6doCmjiqzxQiZ
         GqCzyt/Fqd9sCIChbcGsfugxww0NinvaImXZV8UfHD8KYuQyAp/prKntIAbwwM7ampqq
         23mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CLeQ2xVrGuuCQrbf2eH5fzOKL2CstlL+dKrFSPpYbHU=;
        b=SfIXihfYZfCh3anLM9ocOt3MdKgEH/c5n0BnSZivW84KNiOreHMlr2Pm11Vu44Cg7Z
         ky5B1fyqo7xJUAmx1xyLaFPjFRAynaxPinmAXbFgeyRzDLF8f6dWrI7+7XFR9CHkFyno
         Ejh/w5yHnl8sICIMelV8GwiMCAkhaMspbN7ICvcquMYFQXkyLjFD83E6vRpD2FguBNQ+
         9fsPoB00YteENEmyASCtj/z5EWQI1VfDLuQpr0rLX4FcbqF06PrOmgEbaSpybMclPuhW
         8zapGvYiUCczai+5P6XlQV19lrFqes6DE7vWNXPILNXTnwGqh9NPz917bL2whAOBxf/S
         qq8Q==
X-Gm-Message-State: APjAAAUxFS9x5BmR2U/DDCclzQ7HSX2PLb1x+5GozGpVGr2/nkGSUem0
        t3jiKQaYLm3Oct+dqE0raanthwaYOtyPEg==
X-Google-Smtp-Source: APXvYqwQBrc8OqsihM1zjx6Lx7C+wG5+ZTbHz3asUCPL5j0G7lHkCSnZJha2tB1SEPuHJnGFRqRi7w==
X-Received: by 2002:a05:6830:7:: with SMTP id c7mr12964643otp.85.1554591996479;
        Sat, 06 Apr 2019 16:06:36 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:f0cf:ad07:6e62:18ae])
        by smtp.gmail.com with ESMTPSA id s63sm7647729oif.52.2019.04.06.16.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 16:06:35 -0700 (PDT)
Date:   Sat, 6 Apr 2019 18:06:33 -0500
From:   Madhumthia Prabakaran <madhumithabiw@gmail.com>
To:     Alex Elder <elder@linaro.org>, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: Fix spinlock_t
 definition without comment
Message-ID: <20190406230632.GB9140@madhuleo>
References: <20190405200046.20600-1-madhumithabiw@gmail.com>
 <20190405205304.GS32590@kadam>
 <fd59f7d5-84a0-35ca-b096-a1d2c7e30336@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd59f7d5-84a0-35ca-b096-a1d2c7e30336@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:50:10PM -0500, Alex Elder wrote:
> On 4/5/19 3:53 PM, Dan Carpenter wrote:
> > On Fri, Apr 05, 2019 at 03:00:46PM -0500, Madhumitha Prabakaran
> > wrote:
> >> Fix spinlock_t definition without comment.
> >> 
> >> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> 
> Madhumitha, the reason one would want a comment associated with
> a lock field in a structure is to get some understanding of why
> it's needed.  Saying "protect structure fields" is not enough,
> because that can pretty much be assumed, so a comment like that
> adds no value.

That's true. It doesn't make much sense.

> 
> Looking at the code, you can see the lock field protects the
> connection's operations list.  It also appears to be needed
> for accessing the state field (reading or updating).
> 

Along with that, in some cases the spinlocks are protecting hd_links and
bundle_links list.

Lines : drivers/staging/greybus/connection.c#895 #896


> Given that, a better comment might be:
> 
>         spinlock_t                      lock;	/* operations list and state */
> 
> >> --- drivers/staging/greybus/connection.h | 2 +- 1 file changed, 1
> >> insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/staging/greybus/connection.h
> >> b/drivers/staging/greybus/connection.h index
> >> 5ca3befc0636..0aedd246e94a 100644 ---
> >> a/drivers/staging/greybus/connection.h +++
> >> b/drivers/staging/greybus/connection.h @@ -47,7 +47,7 @@ struct
> >> gb_connection { unsigned long			flags;
> >> 
> >> struct mutex			mutex; -	spinlock_t			lock; +	spinlock_t			lock; /*
> >> Protect structure fields */ enum gb_connection_state	state;
> > 
> > What does the mutex do then?  Why can't we just use the spinlock for 
> > everything?
> 
> The mutex needs to be held during enable and disable of a connection.
> Johan might be able to give you a more complete answer but these
> operations (or at least the enable) need to block, so can't hold a
> spinlock.
> 
> 					-Alex

Thanks for explaining it. Checking on the code, mutexes protect spinlock_t
for gb_connection_state fields and gb_connection_state fields itself in
struct gb_connection.

> 
> > I did glance at the code and it wasn't immediately obvious to me.
> > 
> > regards, dan carpenter
> > 
> > _______________________________________________ greybus-dev mailing
> > list greybus-dev@lists.linaro.org 
> > https://lists.linaro.org/mailman/listinfo/greybus-dev
> > 
> 
