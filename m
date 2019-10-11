Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDA0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E721A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570795792;
	bh=e0k/MZXeZ8iSfaf9YCQWVrhAlEuXi+xlo5m4GcQ3Bho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LZVlw1MfgsjsECGdH64mUfZKz0Azrl23ZJetKnCOD4XAFLyYQBt3WofJvnMT/5Pyc
	 gkUGGh9t/ZMFjOXX11YeMIvkXuaPq8lSqULXtpxtmv7lvdmAE46zmObowNUmod4HgR
	 wolg//ZO3lNI8on37t5qzQ/jOiuNiVdoEy9v/McQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfJKMJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfJKMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:09:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCB5214E0;
        Fri, 11 Oct 2019 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570795790;
        bh=e0k/MZXeZ8iSfaf9YCQWVrhAlEuXi+xlo5m4GcQ3Bho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAhZOkerWZeMzD3HPXqDap273VI9oEEoBKnzcPZgxuxkiFEDLn7ZCbC7L2B2vgtiv
         9ik6eIn5g91HnxSeDc5kMY0ki1F7K8mbjx3EYRtZK7nvvzsbT7TXuwF33lmAd3CGmB
         2LQiVOFO+k2GbC8qkt83ijDBVYo7ScCmlnKv9d4Q=
Date:   Fri, 11 Oct 2019 13:09:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 06/10] lib/refcount: Move saturation warnings out of
 line
Message-ID: <20191011120918.3o7z6p5degsnpzzc@willie-the-truck>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-7-will@kernel.org>
 <201910101342.B6B4B3B6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910101342.B6B4B3B6@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:48:20PM -0700, Kees Cook wrote:
> On Mon, Oct 07, 2019 at 04:46:59PM +0100, Will Deacon wrote:
> > Having the refcount saturation and warnings inline bloats the text,
> > despite the fact that these paths should never be executed in normal
> > operation.
> > 
> > Move the refcount saturation and warnings out of line to reduce the
> > image size when refcount_t checking is enabled. Relative to an x86_64
> > defconfig, the sizes reported by bloat-o-meter are:
> > 
> >  # defconfig+REFCOUNT_FULL, inline saturation (i.e. before this patch)
> >  Total: Before=14762076, After=14915442, chg +1.04%
> > 
> >  # defconfig+REFCOUNT_FULL, out-of-line saturation (i.e. after this patch)
> >  Total: Before=14762076, After=14835497, chg +0.50%
> 
> The downside of this change is that this means we get one warning per
> refcount_saturation_type, where as before it was once per refcount
> usage. I think, ultimately, this is okay, but it is a behavioral change
> that might be worth pointing out.

Good point; I'll add something to the commit message.

> > diff --git a/lib/refcount.c b/lib/refcount.c
> > index 3a534fbebdcc..6a61d39f9390 100644
> > --- a/lib/refcount.c
> > +++ b/lib/refcount.c
> > @@ -8,6 +8,34 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/bug.h>
> >  
> > +#define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
> 
> This define seems like overkill for just adding a prefix to 5 uses...

I dunno. It doesn't hurt and I did get bored of typing that prefix.

> > +void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
> > +{
> > +	refcount_set(r, REFCOUNT_SATURATED);
> > +
> > +	switch (t) {
> > +	case REFCOUNT_ADD_NOT_ZERO_OVF:
> > +		REFCOUNT_WARN("saturated; leaking memory");
> > +		break;
> > +	case REFCOUNT_ADD_OVF:
> > +		REFCOUNT_WARN("saturated; leaking memory");
> > +		break;
> > +	case REFCOUNT_ADD_UAF:
> > +		REFCOUNT_WARN("addition on 0; use-after-free");
> > +		break;
> > +	case REFCOUNT_SUB_UAF:
> > +		REFCOUNT_WARN("underflow; use-after-free");
> > +		break;
> > +	case REFCOUNT_DEC_LEAK:
> > +		REFCOUNT_WARN("decrement hit 0; leaking memory");
> 
> Even the longest doesn't line wrap:
> 
> 		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory\n");
> 
> > +		break;
> > +	default:
> > +		WARN_ON(1);
> 
> This deserves a string too, yes?
> 
> 		WARN_ONCE(1, "refcount_t: unknown saturation event!?\n");

Ok.

> 
> > +	}
> > +}
> > +EXPORT_SYMBOL(refcount_warn_saturate);
> > +
> >  /**
> >   * refcount_dec_if_one - decrement a refcount if it is 1
> >   * @r: the refcount
> > -- 
> > 2.23.0.581.g78d2f28ef7-goog
> > 
> 
> Otherwise, okay, I grudgingly accept the loss of warnings when running
> the lkdtm tests in order to gain back some text size... :)

Thanks :)

Will
