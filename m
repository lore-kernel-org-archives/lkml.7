Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A4FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728AC2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QbfmzLpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfIDQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:50:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33062 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731599AbfIDQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:50:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8548858pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMapkRhSgN1SGL2l9oMWf44cELAHaLmXe43jUFl8ge4=;
        b=QbfmzLpBBM1tiB62I45Rx0ioISKADbOrKugzWvi1lErH0hXEbE9ZS6kJgkezaWKNVj
         lTl3usJiczDBZsEGMnQ/Iw+6QF1tSNnmZXu6xX56afwUgzjXrlzuFU6b1Z3SfpxaJQqm
         jlf7EXX6hFJzjdaMWPtSy2VmMZTZE7iikopsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMapkRhSgN1SGL2l9oMWf44cELAHaLmXe43jUFl8ge4=;
        b=PnrcNsPrl5hbKJC1PAsGfJcUnebEk2gqFgKm7bE/onJr9RqI2bm68pD2oWe2xxyaiR
         Jc6TCCoTNK1FWed28NFhCT1ZhS7I3Hp6vS35pou79wHs1sWKFre+MbbqRa3445apho2e
         0AbPtYzogp1/Z3r4rg10YsW7XWfD7p9SLlOqdjZbij2NEHfVkpImwPwHX/Daf5dra6Uj
         4Iki89PFzwxnSEPWqWIPdyzoB5uIuS1NEWoFCiDoJD9DxhL0MmDiPstLD+IQs59PIZHj
         uQs1wgCMkVOAMSjGKpspxH7X6JFI2a9zrl9ukzzW2aNnxxVU5sjH6B8W+wZ6O4udpb2P
         Q1GA==
X-Gm-Message-State: APjAAAUZEPPMeLzy4SXBf9/a45TFGU+tmWP8bBSe4VrpVMTsYR7h2VJX
        dc6sjCgVCR+7yQC1eb25T3pGRw==
X-Google-Smtp-Source: APXvYqx7Efgt6IKBu7pQKwH/Ba598K0d/IYdrQkM02/A9jX3xglkigZo/az7B7A1FSYMbGjy/P7/ug==
X-Received: by 2002:a17:90a:9409:: with SMTP id r9mr6017500pjo.10.1567615808064;
        Wed, 04 Sep 2019 09:50:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm12456231pfg.159.2019.09.04.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 09:50:07 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:50:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <201909040942.7BC809C5E@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830083415.GI27757@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 09:34:18AM +0100, Dave Martin wrote:
> Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> early-terminate the scan if we can, but my feeling so far was that the
> scan is cheap, the number of properties is unlikely to be more than a
> smallish integer, and the code separation benefits of just calling the
> arch code for every property probably likely outweigh the costs of
> having to iterate over every property.  We could always optimise it
> later if necessary.

I feel like there are already a lot of ways to burn CPU time with
mangled ELF files, so this potential inefficiently doesn't seem bad to
me. If we want to add limits here, perhaps cap the property scan depth
(right now, IIRC, the count is u32, which is big...)

> I need to double-check that there's no way we can get stuck in an
> infinite loop with the current code, though I've not seen it in my
> testing.  I should throw some malformed notes at it though.

I think the cursor only performs forward movement, yes? I didn't see a
loop, but maybe there's something with the program headers that I
missed.

> Do you have any objection to merging patch 1 with this one?  For
> upstreaming purposes, it seems overkill for that to be a separate patch.

I don't _object_ to it, but I did like having it separate for review.

> Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
> so they're documenting assumptions rather than protecting against
> anything real.  Maybe I should replace them with comments.

I think they're fine as self-documentation. My rule of thumb has been:

- don't use BUG*() unless you can defend it to Linus who wants 0 BUG()s.
- don't use WARN*() if userspace can reach it (and if you're not sure,
  use the WARN*ONCE() version)
- use pr_*_ratelimited() if unprivileged userspace can reach it.

-- 
Kees Cook
