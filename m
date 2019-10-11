Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C94C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CCE214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7ZMdJu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJKQRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:17:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46130 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJKQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:17:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id b8so6044784pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6/IFpPoU257BJiL2mb6swVia+fv7D9KqIWwxXtVps8=;
        b=n7ZMdJu9GcirVZwa482sMtWvpemyN7XlK3d3GfnhUUihVHQkZLlGoapJ2WRSXMEKtJ
         vx4U2l+l1aMAQo/GLwsObOag7IHFOKMq0WmswdUSNJn0eAQNijfDZffSGoTguf8NSQKq
         u0I+l1RlR6OTVNOngPaqoSlLN89Lkl9N8vWh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6/IFpPoU257BJiL2mb6swVia+fv7D9KqIWwxXtVps8=;
        b=G3CSDD1MqBKUR4jUCelhCgnoMhEQFJBEE7KyLxTCZdVixxbQeYCZ8JB/oGM9Ppl2ay
         4UZx/PngEJY3I0jn+ZjXgCjyfvZoFMucaAwAh52WThunOsYeE/sR9dul8i2X1HITSVHf
         kj/fhQIZWyDMrQb64zh6VrUxXCq91XP2y/Rwri/rptgM/RYEVL4uh4Gq0SnCkosHKQat
         kMO1yfzScCUoX/YySrRaz5/oOgHi2hC07kONYLtbOG3vN9TtH77QII4RO8szPrP9KXmq
         mGyAreJoQItEWGJ+WbDvFcyXfr2ISrc0OuDIZ94O5REKsMcsYUx60MZ6DzjnVNLW6DeY
         jsYg==
X-Gm-Message-State: APjAAAUcER315CSLw7qemaUYeh+5p54HcyYtUIa8xhq4/RC8GdGNysXB
        4E6L3lhkqR6VueyIXooYl1Fe4A==
X-Google-Smtp-Source: APXvYqwVlV7zsenA02qPfOZWKOdpF4/HgEN/UQewF65E65s6FbxjOvYETd3Rk7fMHH7/TUZnGZedKA==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr18385927pjq.106.1570810620254;
        Fri, 11 Oct 2019 09:17:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r21sm11559722pfc.27.2019.10.11.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 09:16:59 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:16:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dragan Cvetic <draganc@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Message-ID: <201910110916.2DC522EA@keescook>
References: <201910021000.5E421A6F8F@keescook>
 <201910101535.1804FC6@keescook>
 <20191010163905.70a4d6e1@lwn.net>
 <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
 <20191011100223.6f3eff7e@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011100223.6f3eff7e@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:02:23AM -0600, Jonathan Corbet wrote:
> On Fri, 11 Oct 2019 08:59:22 +0000
> Dragan Cvetic <draganc@xilinx.com> wrote:
> 
> > Yes, please add the file.
> 
> OK, I've applied the patch, thanks.  I took the liberty of sticking on a
> final newline while I was at it.

Yay! Thank you! :)

-- 
Kees Cook
