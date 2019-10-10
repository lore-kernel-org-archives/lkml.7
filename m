Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCCC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE73920650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VO/LbGQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJJVA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:00:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41190 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJJVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:00:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so3381571plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ORG+HsGy3iRF0g1A3SvuSaUHioZzX6MFBQbaXv8rsek=;
        b=VO/LbGQCFTqvqDL7wZtd0QnnzymNdlzpMyVPi2Q3Im5nIx7lSuCiM7f58PJ+uMEIjI
         koX9U8d4if0Nz77wYV7FZDwfESeFSOIkf3jlTnmYWbDohkrLYYUgPGqfw/Y6hrketL3U
         KnXHyezm27STWnjXlgfGF3Sg2GPXkzdLniSOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORG+HsGy3iRF0g1A3SvuSaUHioZzX6MFBQbaXv8rsek=;
        b=aNhR62P+RaooNpls3gBNio5oqWnVoHnfXqVuBTk5WE9j/O00Su4r9fuqKm40MiJBkC
         +4dCL1P0vBRQUExz6FolxXxntnskEmmtOQq5N/wlUJfSW2C0XXcD3Huj8yPaVOEPpBwG
         QEOwtoPcO3hFol+5Z84NEc+JQO0/cx7BY4puMu+B0kUvSjBtKzNS4SfAYfhcyn+e/vvK
         601iYmDJxKi+65iK6mwMh7Rk93xG+zbzSYR3V0YQFixvBV5mY8QVHoUVZobXg8McIldu
         XtfZHgRXLqbBr5eTijFXaZZdjQ1Wx/h0sOFfIBu2R9m1yu3sfAR1XXHIHQbmLbar8yGI
         b+yg==
X-Gm-Message-State: APjAAAWPQmZE1MfxrC26SKV6Zg9ifoVHMkJxrpy1cVvfKBrf/jvV94Us
        b5yz6e3ZpJZh//7kjTWqUUWQ7A==
X-Google-Smtp-Source: APXvYqyqdYFFugXyLXLIipZ/O7fa8NdhYSO5j+/CU441LMhNnsoOUgYoHdj+Hn3IqSCxZ9gCqhpxQw==
X-Received: by 2002:a17:902:304:: with SMTP id 4mr10659484pld.106.1570741256418;
        Thu, 10 Oct 2019 14:00:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm6745946pfj.41.2019.10.10.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:00:55 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:00:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <mark.brown@arm.com>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <201910101359.9B3B84B@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
 <20191009125913.GE27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009125913.GE27757@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:59:13PM +0100, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 09:34:17AM +0100, Dave Martin wrote:
> > On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> > > On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > > > ELF program properties will needed for detecting whether to enable
> > > > optional architecture or ABI features for a new ELF process.
> > > > 
> > > > For now, there are no generic properties that we care about, so do
> > > > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > > > 
> > > > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > > > phdrs entry (if any), and notify each property to the arch code.
> > > > 
> > > > For now, the added code is not used.
> > > > 
> > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Thanks for the review.
> > 
> > Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> > early-terminate the scan if we can, but my feeling so far was that the
> > scan is cheap, the number of properties is unlikely to be more than a
> > smallish integer, and the code separation benefits of just calling the
> > arch code for every property probably likely outweigh the costs of
> > having to iterate over every property.  We could always optimise it
> > later if necessary.
> > 
> > I need to double-check that there's no way we can get stuck in an
> > infinite loop with the current code, though I've not seen it in my
> > testing.  I should throw some malformed notes at it though.
> > 
> > > Note below...
> > > 
> > > > [...]
> > > > +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> > > > +			      struct arch_elf_state *arch,
> > > > +			      bool have_prev_type, u32 *prev_type)
> > > > +{
> > > > +	size_t size, step;
> > > > +	const struct gnu_property *pr;
> > > > +	int ret;
> > > > +
> > > > +	if (*off == datasz)
> > > > +		return -ENOENT;
> > > > +
> > > > +	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
> > > > +		return -EIO;
> > > > +
> > > > +	size = datasz - *off;
> > > > +	if (size < sizeof(*pr))
> > > > +		return -EIO;
> > > > +
> > > > +	pr = (const struct gnu_property *)(data + *off);
> > > > +	if (pr->pr_datasz > size - sizeof(*pr))
> > > > +		return -EIO;
> > > > +
> > > > +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> > > > +	if (step > size)
> > > > +		return -EIO;
> > > > +
> > > > +	/* Properties are supposed to be unique and sorted on pr_type: */
> > > > +	if (have_prev_type && pr->pr_type <= *prev_type)
> > > > +		return -EIO;
> > > > +	*prev_type = pr->pr_type;
> > > > +
> > > > +	ret = arch_parse_elf_property(pr->pr_type,
> > > > +				      data + *off + sizeof(*pr),
> > > > +				      pr->pr_datasz, ELF_COMPAT, arch);
> > > 
> > > I find it slightly hard to read the "cursor" motion in this parse. It
> > > feels strange, for example, to refer twice to "data + *off" with the
> > > second including consumed *pr size. Everything is fine AFAICT in the math,
> > > though, and I haven't been able to construct a convincingly "cleaner"
> > > version. Maybe:
> > > 
> > > 	data += *off;
> > > 	pr = (const struct gnu_property *)data;
> > > 	data += sizeof(*pr);
> > > 	...
> > > 	ret = arch_parse_elf_property(pr->pr_type, data,
> > > 				      pr->pr_datasz, ELF_COMPAT, arch);
> > 
> > Fair point.  The cursor is really *off, which I suppose I could update
> > as we go through this function, or cache in a local variable and assign
> > on the way out.
> > 
> > > But that feels disjoint from the "step" calculation, so... I think what
> > > you have is fine. :)
> > 
> > It's good to be as clear as possible about exactly how far we have
> > parsed, so I'll see if I can improve this when I repost.
> > 
> > 
> > Do you have any objection to merging patch 1 with this one?  For
> > upstreaming purposes, it seems overkill for that to be a separate patch.
> > 
> > I may also convert elf_gnu_property_align to upper case, since unlike
> > the other related definitions this one isn't trying to look like a
> > struct tag.
> > 
> > Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
> > so they're documenting assumptions rather than protecting against
> > anything real.  Maybe I should replace them with comments.
> 
> FYI, I'm going to be inactive for a while, so I'm not going to be able
> to push this patch further.
> 
> Mark Brown will be picking up the arm64 BTI series, so it will probably
> make sense if he pulls it into that series.
> 
> Any thoughts?

Okay, sounds good. Mark, I think these patches are in good shape. Can
you include me on CC where you pick these up?

Thanks!

-Kees

-- 
Kees Cook
