Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E7EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC05206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKMVrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:47:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:47:21 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV0Tm-0006yP-AS; Wed, 13 Nov 2019 22:47:10 +0100
Date:   Wed, 13 Nov 2019 22:47:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Borislav Petkov <bp@alien8.de>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, tyhicks@canonical.com,
        colin.king@canonical.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: only administrator can read the
 configurations.
In-Reply-To: <201911121434.FF26FF3FE@keescook>
Message-ID: <alpine.DEB.2.21.1911132246220.2507@nanos.tec.linutronix.de>
References: <20191105071714.27376-1-zhangxiaoxu5@huawei.com> <201911081236.57A127A@keescook> <20191108205031.GH4503@zn.tnic> <201911081320.5D3CD1A4CD@keescook> <20191108213307.GI4503@zn.tnic> <201911110934.AC5BA313@keescook> <20191112174956.GB32336@zn.tnic>
 <201911121434.FF26FF3FE@keescook>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019, Kees Cook wrote:
> On Tue, Nov 12, 2019 at 06:49:56PM +0100, Borislav Petkov wrote:
> > On Mon, Nov 11, 2019 at 09:56:16AM -0800, Kees Cook wrote:
> > > Some recap from being accidentally offlist:
> > > 
> > > - this patch should check capabilities at open time (or retain the
> > >   checks on the opener's permissions for later checks).
> > > 
> > > - changing the DAC permissions might break something that expects to
> > >   read mtrr when not uid 0.
> > > 
> > > - if we leave the DAC permissions alone and just move the capable check
> > >   to the opener, we should get the intent of the original patch. (i.e.
> > >   check against CAP_SYS_ADMIN not just the wider uid 0.)
> > > 
> > > - *this may still break things* if userspace expects to be able to
> > >   read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN.
> > >   If *that* is the case, then we need to censor the contents using
> > >   the opener's permissions (as done in other /proc cases).
> > > 
> > > I think the most cautious way forward is something like
> > > 51d7b120418e ("/proc/iomem: only expose physical resource addresses to
> > > privileged users"). Untested (and should likely be expanded to know
> > > about read vs write for lockdown interaction):
> > 
> > I'm back'n'forth on this.
> > 
> > So tglx and I agree that it doesn't make a whole lotta sense for
> > non-privileged luserspace to be able to read /proc/mtrr because it is a
> > small leak and normal users shouldn't care about the caching attributes
> > of memory regions in the first place.
> > 
> > So maybe we should do the second variant.
> > 
> > But then we're not supposed to break luserspace.
> > 
> > But then we can revert it if we do...
> > 
> > Ugh.
> 
> Shall I send a patch for just moving the capable() checks into open()
> and if someone yells we switch to the other option on the assumption
> that then we'll have a real-world case we can test the other solution
> against?

Makes sense.

Thanks,

	tglx
