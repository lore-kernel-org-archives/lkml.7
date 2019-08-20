Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C31214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APMDSk3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfHTOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:22:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40189 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfHTOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:22:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so2812616wmj.5;
        Tue, 20 Aug 2019 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zOwERsJ6pnvcMb1zFd5T4pWVO52IElodtx1VRz6WwZc=;
        b=APMDSk3K4vfysSa6iwAgwywlG0bhR9RPzJaIfw6l0XZ/Z6pmcw20OHla33HS5ZprcW
         SnbcsIPkiz1YIX9guf+vvqzZq36lwrCFjtq/9HcW8k02OqgNVHyRecbX3EG2pnkAY1KH
         lnzUnQntNaqsS4aUVIz9gQGA8ItHZo5iyyNEDhqyUnR3U4BTVh/FSuCQYLbY41OZk5fF
         LGcodFbV9Mx3zrO9BKE4I1iDdSlOeUz7NWezHmMHJoGglgFvDn/xkK4+YgP4grGTh6V8
         iv0wEjGXUeNb74hmYbBJcckrRiGGS2mTVhBdt3RSoTFQFCBKtTSBF9NZn2BEgiEJLYiY
         lkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zOwERsJ6pnvcMb1zFd5T4pWVO52IElodtx1VRz6WwZc=;
        b=Cm2MRyCxK6GTJNgAUdK4Pd3Kpx4Nzxc9/D6ebiarab2q2AMZzgPB9OSJlE+jduRRZl
         8iaTkp3i6NXzcG5C0C2ZTNvMjiWbweFSK8mQ+bGlyFV0XVbLv6wUMt5KgV7I4u6fHO9v
         NMh/F0ixw69t3l0+F2cqs4fjhhENzq/0vsOmd64W1Qh7cMTvjxS4+DJLvYQ9EIgUeyfM
         Zi0FnMAbdoBIQrA7p+GGrpt6rJlkamQTW1HD6y0TlqH4RgzvaxgxGf6SC7HWQrneY2qK
         fzBAFDpVapavj1NcllraFFBO6UPaSW+wkavMNP8+IkP0Vo8r7+OJDQo4d/gf6TpR6tUU
         dNNw==
X-Gm-Message-State: APjAAAVJfgG5CnUGKRxi1VI5xTGs2oZlBnMNsUgkB/dEIvs2sso4MAF0
        W+H5QBWFMpj1pXqjax+eXV8=
X-Google-Smtp-Source: APXvYqyoDJ+NhJVYkNMxkYTyJ1Ifs7tzzAIOI7wRqpQx7KO/aRu50l0+u1djS46XPRVVv2rqVvTPhA==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr264094wmh.122.1566310926375;
        Tue, 20 Aug 2019 07:22:06 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g12sm19798762wrv.9.2019.08.20.07.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:22:05 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:22:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Message-ID: <20190820142204.x352bftlvnb7s57n@pali>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
 <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 August 2019 14:21:33 Enrico Weigelt, metux IT consult wrote:
> On 20.08.19 13:17, Pali Rohár wrote:
> > On Tuesday 20 August 2019 12:56:12 Enrico Weigelt, metux IT consult wrote:
> > > From: Enrico Weigelt <info@metux.net>
> > > 
> > > IS_ERR() already calls unlikely(), so this extra unlikely() call
> > > around IS_ERR() is not needed.
> > > 
> > > Signed-off-by: Enrico Weigelt <info@metux.net>
> > > ---
> > >   drivers/input/mouse/alps.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > > index 34700ed..ed16614 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
> > >   		/* On V2 devices the DualPoint Stick reports bare packets */
> > >   		dev = priv->dev2;
> > >   		dev2 = psmouse->dev;
> > > -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> > > +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
> > >   		/* Register dev3 mouse if we received PS/2 packet first time */
> > >   		if (!IS_ERR(priv->dev3))
> > >   			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> > 
> > Hello! Two months ago I already saw this patch. See discussion:
> > https://patchwork.kernel.org/patch/10977099/
> 
> phuh, that's long chain of links to folow ;-)
> 
> So, your primary argument is just *documenting* that this supposed to
> be a rare condition ?

Yes. Also Dmitry said that prefer explicit unlikely.

> In that case, wouldn't a comment be more suitable for that ?

And why to add comment if current state of code is more-readable and
does not need it?

I do not see anything wrong on this code path.

People normally add comments to code which is problematic to understand
or is somehow tricky, no so obvious or document how should code behave.

> It seems that this issue is coming up again and again ... when people
> run cocci scans (like I didn't), I'd suspect this to happen even more
> in the future.

People first need to understand that static code analysis cannot work
100% reliably and always is needed to properly review changes.

And if the only reason for this change is to satisfy some static code
analysis program, would not it better to teach this program to no
generate such false-positive results?

-- 
Pali Rohár
pali.rohar@gmail.com
