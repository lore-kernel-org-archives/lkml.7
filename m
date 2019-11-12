Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91095C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5PeEuZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKLXAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:00:19 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36804 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLXAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:00:18 -0500
Received: by mail-yb1-f195.google.com with SMTP id v2so42613ybo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqcrXvyrUhEeGGCBTq1/xcdd+m/MFp2jfaMUakDcF9E=;
        b=L5PeEuZk/YnUneg+xRE3pQop1ItlOqsY/HUOGV3RnDGEIqfDSW1NZGYHQsZsnC7JF1
         PtdH/5NC4prhjbRrQ+NU0rNcW6Bq55KWOq6NNRLIXMBm8Nc4A8PgnS308VY7m2ohdu1L
         IB0KKqRvg6kBMAcmyMMKbxPrOzOV5ia8w7cv2U8aaWLLKbjyMXIc3M3h/s1HJ6GBpvUS
         Z+U60/Vv19GAezky7tW4zEcTF/xxr2tH31nA3gr6Qs1nAKxnIUwxTZyy0dXBhAdNzWDw
         oQvlMN+8ifSVFAgGHfBs5/MlviSuehxi2tIxJsw7B5qlpTvddhQaRXAWOFCz57uApXCF
         DF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YqcrXvyrUhEeGGCBTq1/xcdd+m/MFp2jfaMUakDcF9E=;
        b=MjiAEPuUix5yVoBdIt9/rDD+1BL1uRYBb4k7F5oFt4i81CGFTbV1v7t8SvmL6iDRuR
         Py0nbdtBdirZAMCK8eIhfwTNWE6hezs5/s+aR5NCwyAtvkSDHVWlPSGsFHPHPJ+mPYgP
         C5w87UEIEIxcEBd5VTooUbBW6tmzCc/uv88gk1oitQFcOZ8uEaNxgv3XfwlERIus3bfW
         3U5w5V7AeRBLUsze0DydAivRTRs4ihAWWhlcvUyaonXMmTiMESMccw3uLpP1vP0BDlN0
         BZnVYgSBS1Qxbip50k8Tlg7WFayijEiBgkCbSRF8asDkfo6o8L+JKj2b/cdnMk/J07aC
         PZ4Q==
X-Gm-Message-State: APjAAAW+DgkSEC7oksI/smcyG38qdCFhPwKBuQukUNmHXdvoQXz5ctqq
        17seUE5LS+qeJWiv1nhQ/8Q=
X-Google-Smtp-Source: APXvYqzousErKZ8TL6DAgYgmgPeA/h/8ureGLm48RIrBZdjBtTMZTPttrRHzw315GjhO3lfvgIpf3g==
X-Received: by 2002:a25:3d83:: with SMTP id k125mr380091yba.226.1573599616522;
        Tue, 12 Nov 2019 15:00:16 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id h138sm122994ywa.68.2019.11.12.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:00:15 -0800 (PST)
Date:   Tue, 12 Nov 2019 18:00:12 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] Re: [PATCH 7/9] staging: rtl8723bs: Fix
 incorrect type in argument warnings
Message-ID: <20191112230012.rl7z3sbde5vtahcm@gmail.com>
Mail-Followup-To: Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
 <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
 <c243860eeabf9406d166deb6204a69255c51867d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c243860eeabf9406d166deb6204a69255c51867d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:11:42AM -0800, Joe Perches wrote:
> On Tue, 2019-11-12 at 11:55 -0500, Javier F. Arias wrote:
> > Fix incorrect type in declarations to solve the 'incorrect
> > type in argument 3' warnings in the rtw_get_ie function calls.
> > Issue found by Sparse.
> []
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> []
> > @@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
> >  {
> >  	struct iw_event iwe;
> >  	u16 cap;
> > -	u32 ht_ielen = 0;
> > +	sint ht_ielen = 0;
> 
> more likely the rtw_get_ie function should used u32
> and not sint.

Thanks for your feedback. I'll update the patchset and CC you as
I can't send anything else to the Outreachy maillist.

> one day a sed of 's/\bsint\b/int/g' would be good too.

I'll probably do this on a couple of involved files.

> 
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/c243860eeabf9406d166deb6204a69255c51867d.camel%40perches.com.
