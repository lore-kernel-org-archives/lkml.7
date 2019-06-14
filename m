Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9872177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odTDkmau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFNSQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:16:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:16:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f21so1994857pgi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PbI2AaJV5OGbUvXuaZ8xvq+0MioqIy25hz3zwSGI/6I=;
        b=odTDkmauhKoEk4o2w9rUx7xDRZL74iqtmVgU8sRqDb9hGIIRB+hByQ77yPQaHA3sWr
         nEpafjGXO1rDrrX7axNprXRtBDBp+8Mnyd+mUJ/gQFhAhxVQPxkUZR8SQALKM5Qm1p9e
         SzE4bc9/hmNKtW6tCcMRK33iBeEB8W5Is1XGsfm1/PfsTEVebo7Ov3SGS4GwRVDxwFUD
         mV0d0uKD/afxvsfh4sEYSozzhL7N3TdcmzKBpbDQ9FLtCkkmi/JWT+8fXaIw4D7McVkw
         immnUy+JAhYUeiT6vR9+KAmJZvl20FUodTy/G1usu7tABeCwOUEup2bEk7sQN5uJIdAj
         kDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PbI2AaJV5OGbUvXuaZ8xvq+0MioqIy25hz3zwSGI/6I=;
        b=FtgSnm15BiTfhwXJhf3NzplCyX/8XWLg4kHKAnEnqB6PiY9jUwa7PWqnemlu5R91E0
         QkGxTbszjs4nd/MFBApZ9jsa1Zkeas+1+EguC4i+ZKcwOS9LHJ2jCPe3AHqGVmwh126O
         Dh4NB0hQp+dVQPz8klRuUp3iolkbU4AcWR5742X9wfJAWyZwyakWQFAKs6Cti6R21buL
         ijbBYVsGTNBVi9IsSq+hVLRst1NrYKp7MCV1b+NR4n3x7bVFA46E3qW1x4brAakCW+aY
         moKI4i/rTHWw/nu7qGm/vqEb2YEAoBCa1vCGIVxL+aH7xIPgWVdd6kD72j8X3OSzc9Qi
         038g==
X-Gm-Message-State: APjAAAW2NxWePU7MVcOAuHma2LQpTD3gf2CYwL+nDp+rbFIQrGhoBs0F
        NUTSse2cIdPkA+b32apr6k4=
X-Google-Smtp-Source: APXvYqyDzmF1i7RpE0aPWt4rZMw6ybxepLHW8Tdd6Msq/cJjXorHOukm3EmsuOJgiXF3AypKN9M7jQ==
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr12446159pjv.36.1560536179510;
        Fri, 14 Jun 2019 11:16:19 -0700 (PDT)
Received: from ahmlpt0706 ([106.222.0.33])
        by smtp.gmail.com with ESMTPSA id u97sm3514804pjb.26.2019.06.14.11.16.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:16:18 -0700 (PDT)
Date:   Fri, 14 Jun 2019 23:46:06 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     groeck@google.com, linux-kernel@vger.kernel.org,
        groeck@chromium.org, adurbin@chromium.org, dlaurie@chromium.org
Subject: Re: [PATCH] gsmi: replace printk with relevant dev_<level>
Message-ID: <20190614181606.GA4448@ahmlpt0706>
References: <20190613185705.GA16951@ahmlpt0706>
 <20190614060919.GA7271@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614060919.GA7271@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 08:09:19AM +0200, Greg KH wrote:
> On Fri, Jun 14, 2019 at 12:27:05AM +0530, Saiyam Doshi wrote:
> > Replace printk() with dev_* macros for logging consistency.
> > In process of replacing printk with dev_err, dev_info etc.,
> > removed unnecessary "out of memory" debug message.
> 
> That is multiple things done in the same patch, please break this up
> into a patch series, only doing one "logical" thing per patch.

Agreed. I could have broken it into patch set.

> Note, generic cleanup patches like this are tough to get done in the
> "real" part of the kernel, I strongly recommend you start out in
> drivers/staging/ where these types of changes are welcomed.  Get
> experience there and then move out into other areas of the kernel if you
> want to, that way you don't annoy developers/maintainers with basic
> errors like this.
> 
> good luck!

Noted. Thanks Greg for feedback and suggestion.
