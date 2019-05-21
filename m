Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BAEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846B21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5AMhsix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfEUHjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:39:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33244 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEUHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:39:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so8157600pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ertU93vLyvZbyhqI5mMBCSgKS6RS62cHiIXJIbfZNjU=;
        b=O5AMhsixq0BooHonQfVIB2VNXmTe/upfgN0xFMResCgzVpKx7PZuo61IDBt/QfI8Mx
         h/TTholMO0hFP/jLW2R0GvL5yHsCbPwdDDJyDRsMzUZyIU319q12ERfoxn5kdrRNrm8R
         Wc5k+PxcNkwpEyVz7LdLXGMPTzZFVe2JHM8nMXgbduYLjfc2lW8ttCewuzVKGl6ZRUcr
         u2X2AioGajC9HHYWrL3YsQT6NwZFoJ8D2sio2OrLAztRJJbshsjZMm2fDyIh/V+dGGab
         AKf4SwIl0f5kVzz/Qpd9V+gtHdkW2SevAMnbNC/6tZpvveJ7HqCUJLmlMB36hYOV+ngv
         LvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ertU93vLyvZbyhqI5mMBCSgKS6RS62cHiIXJIbfZNjU=;
        b=gZkQ0xzz0EbTHCX4u9DtghHu1JepasHG+o1RYFcA9PAqoD8aHHkv2yNWWud8g/R+Pn
         yMlslPsuxZ1O1kGQm537FI4vNHH6t81FWOtz2CTAAdngogAHQ9efMPYv6LOXa9Iza5nE
         keH1sW6WdicxeOv28bJaQnxmvIhUcx0IEGfmsiKKyp5gXzCAVH628L6sATM5kYKKLAVZ
         WI7zkj0rZXXn9N/3zenEgXvjkX4PH7PuoSV3UTdYTAd5Q6QQQxsEuA62b1I5185ak7Qx
         AamVVT+KZKQ8x1D4V4XFjAGu/OGQp/LC1+ojbXxsQ5AIMbsDYm7q3nD36J3GZ4GIUZVC
         U+Iw==
X-Gm-Message-State: APjAAAXpIgER1nQa9+gbE7bU05SVZW3r/2raTAmAm6xaeyXXf3Oooky6
        2AiV7/xCRtUkHmZQwgEUQm/LfCTycs0=
X-Google-Smtp-Source: APXvYqyFMJXJBetRH/tQItKUh0um5jcuAmaHg3cXa+hKpXi0zE3v54WVcDDI6HQmI2Z3O51KkVljdw==
X-Received: by 2002:a63:2c14:: with SMTP id s20mr62763921pgs.182.1558424352594;
        Tue, 21 May 2019 00:39:12 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id s66sm23940174pfb.37.2019.05.21.00.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:39:12 -0700 (PDT)
Date:   Tue, 21 May 2019 15:39:01 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521073901.GF5263@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521030905.GB5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
 <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:30:38AM -0400, Nicolas Pitre wrote:
> Now imagine that MIN_NR_CONSOLES is defined to 10 instead of 1.
> 
> What happens with allocated memory if the err_vc condition is met on the 
> 5th loop?
Yes, vc->vc_screenbuf from the last loop is still not freed, right? I
don't have idea to solve this one. Could please give some advice? Since
we have to consider the err_vc condition.

> If err_vc_screenbuf condition is encountered on the 5th loop (curcons = 
> 4), what is the value of vc_cons[4].d? Isn't it the same as vc that you 
> just freed?
> 
> 
> Nicolas
Thanks for your explaination! You mean a double free situation may 
happen, right? But in vc_allocate() there is also such a kfree(vc) and 
vc_cons[currcons].d = NULL operation. This situation is really confusing
me.
Thanks
Gen
