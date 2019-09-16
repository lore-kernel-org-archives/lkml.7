Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1EC2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568645592;
	bh=j7NgZL4rNppJ3DNXmjv6GwzAYFbVWPDCAbj62JG0SvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1MSW94Q7rjpYvRf8SfIdniUv5EECp6VQnGwP4kDPb9qQWO7Pmm+Tdama62+mBtFWr
	 jakikiwDvqcpVq1q7e8O3IMZxClkejbTUiHwHhN3i11RWd0jOShLUyxud6VVNqRgVk
	 EizCWjGcf3BrBdhUnZlnnFqW1GCeq5H8aGP4In7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbfIPOxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:53:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIPOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:53:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so29466313wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BIxRZcPCxemm3w3c90iYG9SEIp3wWGWvFQcOwYAS7KI=;
        b=gjY6ySzfqUiv73erAouVCG8ExSbabj3HV0tIGoWswYpz5Ksu+334Xzkl96/6Ut6qdQ
         B4VtxrluXHNvE54lYsFHddGKGDOtZg/0JTMpgnyuk8Z4dEkQGgAMos1GRskpiQRAiB0f
         PRRPfpc5yjej/b5NsCJd1ji7o6678tGO0bdn5+B8gvlv6Pfedx+wLGlZwjgk3g+3UIRE
         jKYoFi9U2B0y3MSsgTJrqJOdW/BmEj4Y+d5uz7rQPlK9zwKjYWfOBcN8y9PPBJ++yLHe
         MRrJ2fldtFr7c1BIVOEIhmciM4vWOtCCqymoRBqUaJL51sQZR+DEhKzVUeB8t+ZG4e+n
         YrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BIxRZcPCxemm3w3c90iYG9SEIp3wWGWvFQcOwYAS7KI=;
        b=sKicQfgWx1tcoaX16cSBZQlNQefDFhExTZV8Bh3LXq2NRpkbPrw4GS6Q3QGYmMI2dH
         zivdOZUCcAHBZYoxCRLkPb/1Is5UcXd3NGIrzdPhxU5FLV1QXDigUyvUcm2Q18dPiVzw
         4nehq8RoWKU38FxbbGiIpdXyF1kf/xI5wurYKgN+FhokUXv8gVg9oMimDu65YEPlE2sg
         XoTyDqqX4xHENuCCWo9J2O0idskhjjRBHqTIQqFxK9HqtRp6LyfJqL7+rLE+Uk6RjyMP
         WTFagpMhelcNwZI0CFad7lKW4mzmHN2w6ZzIWKBBB9ruf+ZzFW1ArAs4GBlg+V+fO2Ce
         umZw==
X-Gm-Message-State: APjAAAWhqM8bHoibhSgqK2O/K4yiEUEyB0VcXQWuN25sUVKAnjiqjEPB
        2y+MAlkturiYOzDfSl4LDgR5Lgna
X-Google-Smtp-Source: APXvYqxNRU6rzmKIm5asYmfPhm1QaZnSQXAejuft7hw7TIBzZ+GWUKy4q92ALQ0MtEuqxJtZK8uXlQ==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr114245wrq.257.1568645587990;
        Mon, 16 Sep 2019 07:53:07 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t6sm104711wmf.8.2019.09.16.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:53:07 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:53:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Enable 5-level paging support by default
Message-ID: <20190916145305.GA30629@gmail.com>
References: <20190913095452.40592-1-kirill.shutemov@linux.intel.com>
 <8435951c-d88a-a5c6-5328-90c9f2521664@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8435951c-d88a-a5c6-5328-90c9f2521664@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/13/19 2:54 AM, Kirill A. Shutemov wrote:
> > The next major release of distributions expected to have
> > CONFIG_X86_5LEVEL=y.
> 
> It's probably worth noting that this exposes to two kinds of possible
> performance issues:
> 
> First is the overhead of having the 5-level code on 4-level hardware.
> We haven't seen any regressions there in quite a while.  Kirill talked
> about this in the changelog.
> 
> Second is the overhead of having 5-level paging active on 5-level
> hardware versus using 4-level paging on hardware *capable* of 5-level.
> That is, of course, much harder to measure since 5-level hardware is not
> publicly available.  But, we've tested this quite a bit and we're pretty
> confident that it will not cause regressions, especially on systems
> where apps don't opt in to the larger address space.
> 
> I do think endeavoring to have mainline's defaults match the most common
> distro configs is a good idea, and now is as good of a time as any.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Ok - in terms of timing it's obviously *way* too late for v5.4, so I've 
queued it up for the v5.5 merge window in tip:x86/mm. This should give it 
2-3 months of additional testing to shake out any weird interactions and 
quirks.

Thanks,

	Ingo
