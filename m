Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF4C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BFB20815
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Uom5FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfEVIKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:10:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfEVIKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:10:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id o11so727879pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eti3TImRx56hinakaM+GO4KiRjx+tMNw0bxj57lLePA=;
        b=D9Uom5FGuRUl6X5RivO2rLKVbgOAJvOnWsg32AR6UpqgoGxlHq5MF4ojlx3u+aZZty
         vq0E17FZhku4nBGqRMdDYrnumWdcPkNfnbNvjnPuB9tHnwSpQtyziPr2JbKdSxcepcET
         pRM8bEIcMxL3yv/Wlv9/mw/C7G7vyMFRGetBGGfHliAKdIS1+U2i6ES2QBha5gblCt4z
         wWpgSTejFzk6bIHqFzpMDanP8TJYLHiZGb6Rzc2cB0UM+O1GvQ8Lm/FPn4+FRXBGcj3j
         i3+joGrqpLsLwoxSgkzDZPFyrX1S++YqUOtWLpd2TOfGv8ero7BfeRBGW2tw091/tnum
         sRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eti3TImRx56hinakaM+GO4KiRjx+tMNw0bxj57lLePA=;
        b=bX6u84Ii2DhoTjMtigoc9RfmzjGqHUa2mtxDeT5GrrtWbel/FhiE510e/+Xx6eSZIA
         fYUVGQqNr5A3OYFUFvKvmDljZpo4J2fsz0uTPYbtBx1rdT4ktHAvq/8gJZ+bZ3bIaAuZ
         35C9OE3WvS3/eYA+jILn8Fu/49KErCH+agIs7M1DNkjD6B10PdljnYI3EGuKOk6KuVWE
         ooKjg3GkzHEWqOb/hWFZOaOI6Ot2GB5mTwtlDC4lh7dCa75ZEoMBat2d7AUNbqRnYFAU
         akxv70VNF/5D+7NlHg95yjkn2uCgPhm8gA+W67zr3bW0sBKIDw1vZo/nH9UfmDLT/8Cy
         qedQ==
X-Gm-Message-State: APjAAAWz6OshjEZUQv1F9ui+xGAkGNMQC50lSsCNRTVHbjjBEUsn+crX
        nLiLUVEkv6LnUE4IskIxFrE=
X-Google-Smtp-Source: APXvYqwUSdJheWXGz2kRmSkOFY6sRR2tOnw3/flcVVM5hW6b5AwLhuzSEoDP0fIk5gOpxxKsrd+mfQ==
X-Received: by 2002:a63:1045:: with SMTP id 5mr44165466pgq.55.1558512647450;
        Wed, 22 May 2019 01:10:47 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e10sm45898976pfm.137.2019.05.22.01.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:10:46 -0700 (PDT)
Date:   Wed, 22 May 2019 16:10:29 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190522081029.GB5109@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521030905.GB5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
 <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
 <20190521073901.GF5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:43:11PM -0400, Nicolas Pitre wrote:
> On Tue, 21 May 2019, Gen Zhang wrote:
> 
> > On Tue, May 21, 2019 at 12:30:38AM -0400, Nicolas Pitre wrote:
> > > Now imagine that MIN_NR_CONSOLES is defined to 10 instead of 1.
> > > 
> > > What happens with allocated memory if the err_vc condition is met on the 
> > > 5th loop?
> > Yes, vc->vc_screenbuf from the last loop is still not freed, right? I
> > don't have idea to solve this one. Could please give some advice? Since
> > we have to consider the err_vc condition.
> > 
> > > If err_vc_screenbuf condition is encountered on the 5th loop (curcons = 
> > > 4), what is the value of vc_cons[4].d? Isn't it the same as vc that you 
> > > just freed?
> > > 
> > > 
> > > Nicolas
> > Thanks for your explaination! You mean a double free situation may 
> > happen, right? But in vc_allocate() there is also such a kfree(vc) and 
> > vc_cons[currcons].d = NULL operation. This situation is really confusing
> > me.
> 
> What you could do is something that looks like:
> 
> 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> 		vc_cons[currcons].d = vc = kzalloc(...);
> 		if (!vc)
> 			goto fail1;
> 		...
> 		vc->vc_screenbuf = kzalloc(...);
> 		if (!vc->vc_screenbuf)
> 			goto fail2;
> 		...
> 
> 	return 0;
> 
> 	/* free already allocated memory on error */
> fail1:
> 	while (curcons > 0) {
> 		curcons--;
> 		kfree(vc_cons[currcons].d->vc_screenbuf);
> fail2:
> 		kfree(vc_cons[currcons].d);
> 		vc_cons[currcons].d = NULL;
> 	}
> 	console_unlock();
> 	return -ENOMEM;
> 
> 
> Nicolas
Thanks for your patient explaination, Nicolas!
I will work on it and resubmit it.
Thanks
Gen
