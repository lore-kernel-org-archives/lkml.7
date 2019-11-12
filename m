Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B1321A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SabtPLLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKLWfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:35:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42211 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:35:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so102675pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nOqv3GVC/sOv/psVpK3OUgRa5dRR0J6o4196+nUyO4E=;
        b=SabtPLLvxVL9plXPPEfVE1Efsg2zBLJfYRr7wAEkHn55lx5jRAeqdMQJbdtO+3deLX
         5NfmJmBWAkk++uIcY9vLg2ooc8/x6xvfjXxw7uaeoQkSxKTYBdIIooc9+7YLRCclFubM
         xmEJ7LhzaR7uIXEsWi4NR7+CA+sZAuY6uAQX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOqv3GVC/sOv/psVpK3OUgRa5dRR0J6o4196+nUyO4E=;
        b=oUY/nj+y89Z2u9P0M0hgnD6YONrMr2quGXfTxx/Gdojn9AeCeU+bSR/AZO1ci3nsIp
         KEnVhZ6TksSKplPSYJPc3/btPntbBVikn0L7GGA0rAKRJgsJ67q141jnMil63dYcz9nc
         5KOIbrERPTdQApBQ6ykiW4GI/07rgquv/lOio36BjZGaRrdAZWxdJALzQReF2Uo+FL9C
         fJPKrESZQmTyW+uenKnEe3B7XAsX9S5a4KJBLZmnPYxXvCJAltxN69F9MnjSWAq1F1i9
         6lYoBwjsxFOHNSps8FWGGTmQQn0HyyCs/psQcjKI6TMht8fRSLaG4y7nXB338byzW58q
         Na3Q==
X-Gm-Message-State: APjAAAVhMh6d36fCMjlV0wM2pWrjcjxSPglYE+MscTqrS24So3SvITjc
        PY06s5ofTfGqTLFsJ+QSzGhh4Nfq3+8=
X-Google-Smtp-Source: APXvYqzSms2sequeDq1u4xwoS0zPQjGQZ/GqRMNLwcDTdxHXQyCuGIXshc0sMv6JwPzxK3rplp2NEw==
X-Received: by 2002:a17:90a:1a41:: with SMTP id 1mr281490pjl.28.1573598145086;
        Tue, 12 Nov 2019 14:35:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y36sm14678pgk.66.2019.11.12.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:35:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:35:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, tyhicks@canonical.com,
        colin.king@canonical.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: only administrator can read the configurations.
Message-ID: <201911121434.FF26FF3FE@keescook>
References: <20191105071714.27376-1-zhangxiaoxu5@huawei.com>
 <201911081236.57A127A@keescook>
 <20191108205031.GH4503@zn.tnic>
 <201911081320.5D3CD1A4CD@keescook>
 <20191108213307.GI4503@zn.tnic>
 <201911110934.AC5BA313@keescook>
 <20191112174956.GB32336@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112174956.GB32336@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 06:49:56PM +0100, Borislav Petkov wrote:
> On Mon, Nov 11, 2019 at 09:56:16AM -0800, Kees Cook wrote:
> > Some recap from being accidentally offlist:
> > 
> > - this patch should check capabilities at open time (or retain the
> >   checks on the opener's permissions for later checks).
> > 
> > - changing the DAC permissions might break something that expects to
> >   read mtrr when not uid 0.
> > 
> > - if we leave the DAC permissions alone and just move the capable check
> >   to the opener, we should get the intent of the original patch. (i.e.
> >   check against CAP_SYS_ADMIN not just the wider uid 0.)
> > 
> > - *this may still break things* if userspace expects to be able to
> >   read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN.
> >   If *that* is the case, then we need to censor the contents using
> >   the opener's permissions (as done in other /proc cases).
> > 
> > I think the most cautious way forward is something like
> > 51d7b120418e ("/proc/iomem: only expose physical resource addresses to
> > privileged users"). Untested (and should likely be expanded to know
> > about read vs write for lockdown interaction):
> 
> I'm back'n'forth on this.
> 
> So tglx and I agree that it doesn't make a whole lotta sense for
> non-privileged luserspace to be able to read /proc/mtrr because it is a
> small leak and normal users shouldn't care about the caching attributes
> of memory regions in the first place.
> 
> So maybe we should do the second variant.
> 
> But then we're not supposed to break luserspace.
> 
> But then we can revert it if we do...
> 
> Ugh.

Shall I send a patch for just moving the capable() checks into open()
and if someone yells we switch to the other option on the assumption
that then we'll have a real-world case we can test the other solution
against?

-- 
Kees Cook
