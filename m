Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJ3Hn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:43:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3Hn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:43:26 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1iPidX-0006NG-Dq
        for linux-kernel@vger.kernel.org; Wed, 30 Oct 2019 07:43:23 +0000
Received: by mail-wr1-f69.google.com with SMTP id b4so889583wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2kgY/Eb4NrL0J9edPQFC8rYWl1U1ZwS7+lel270Qps=;
        b=K5cNi9kGg1NeYTIwMnL5KVFoMlf2uP1Ta5ysOEYisaUtDeVbYYnfwrgnoLIDPnM0B5
         MgA5uuwNoXCSHXRu1i6xcWa5PVZozgrRHoxppcIYcWuD/r5orXyfnikV7DfHu49gmN9n
         ugxue5Kd+CKLIWvj2s81zedJ5J0gm2RyBeKDcJsGsVFFajmYAoWPPDDp3f8jQJfJOkI0
         2aVElzp4Md4k6ghTV4MbLyaYWwxwGqXlfrAQrBGN5YBXVuGOtqHEEyQuMqdXinTbP3jl
         iDUKxmoyQrqGCaX7nryWYl7wv/ZpAnDmWdZQ+8LY/V6a0tLs6+RRtv58IrFNra9NFXV3
         4YUg==
X-Gm-Message-State: APjAAAWE2EMImUnpmHmDP/PlZ0EDgzGssmu42HQM+aneg+pn4oaeFKJ/
        ewm3uzcYLbAdJBnLiawj4Swy1YAE9nDrhwSeG9wfMtzXDtLwuXsv77FdnnFqxDw4Q5nH8znJB2R
        ASxEoPC4RdK7Cf8Mz/oDQA6Wdw2JHze2P469fT8Po8A==
X-Received: by 2002:adf:b219:: with SMTP id u25mr22414456wra.327.1572421403072;
        Wed, 30 Oct 2019 00:43:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLmwt311jFlTSkqSoJBn/UrU6mv9JWrlxZTNb9CaaMKdyQWyaslF1hIc5G7liA+tivNC4DKA==
X-Received: by 2002:adf:b219:: with SMTP id u25mr22414436wra.327.1572421402800;
        Wed, 30 Oct 2019 00:43:22 -0700 (PDT)
Received: from localhost ([91.217.168.176])
        by smtp.gmail.com with ESMTPSA id c8sm1149783wml.44.2019.10.30.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:43:22 -0700 (PDT)
Date:   Wed, 30 Oct 2019 08:43:21 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-ID: <20191030074321.GD2656@xps-13>
References: <20191029182320.GA17569@mwanda>
 <87zhhjjryk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhhjjryk.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 02:02:11PM -0500, Eric W. Biederman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > The "fix" struct has a 2 byte hole after ->ywrapstep and the
> > "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
> > on the compiler.
> >
> > Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I have 13 more similar places to patch...  I'm not totally sure I
> > understand all the issues involved.
> 
> What I have done in a similar situation with struct siginfo, is that
> where the structure first appears I have initialized it with memset,
> and then field by field.
> 
> Then when the structure is copied I copy the structure with memcpy.
> 
> That ensures all of the bytes in the original structure are initialized
> and that all of the bytes are copied.
> 
> The goal is to avoid memory that has values of the previous users of
> that memory region from leaking to userspace.  Which depending on who
> the previous user of that memory region is could tell userspace
> information about what the kernel is doing that it should not be allowed
> to find out.
> 
> I tried to trace through where "info" and thus presumably "info->fix" is
> coming from and only made it as far as  register_framebuffer.  Given
> that I suspect a local memset, and then a field by field copy right
> before copy_to_user might be a sound solution.  But ick.  That is a lot
> of fields to copy.

I know it might sound quite inefficient, but what about making struct
fb_fix_screeninfo __packed?

This doesn't solve other potential similar issues, but for this
particular case it could be a reasonable and simple fix.

-Andrea
