Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C01C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBE92073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcsFv2I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfLKRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:12:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLKRM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:12:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so24906997wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87+nbO7EsRQpe1wmSikO8vry0s4iwAAY074PAWZUn2w=;
        b=HcsFv2I+5GpN8tthV67smYXfufVMlWaYkFgMpkaFzDGdfjp3TGIZLjlMspfT4yePt8
         dFSnPi7iQLJduP3wwTLzsCAM9YhX++2smHKxYvO/dNtL0r/Cfx0wTLsJASTpLU33FaFd
         vV2cmdcUjYag4Yspdav4q6tvir6wnV5/6ZWzOCYOIEzS2dVUKOv+w6eTtgQxfZSIyIeI
         tY8Q3yuYWrKD7iczRVzQMwyU0sz8+NBZyQZj5hcREfBBKevQUlvjvfh2mRKNXC9eaaid
         HtqBvKiHPHM4TD/9eJI85G//q4Q5ANEs2JUVrHz+jwzjo7KLz3C4KxqzjOSCx9RpkIFM
         jWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87+nbO7EsRQpe1wmSikO8vry0s4iwAAY074PAWZUn2w=;
        b=Fu7JxZsfeCf00OWFha/Dnnt9EE4glCwehb2mSkeQyBVeKg5DgwOcvHGTwi4EBbCW9C
         aht1uos7K+6Vr6GM60Lb+Qh/X6j5jys2sVX0u4kFmNTo6Y2r8xzG8KH2QCfFQa48WP/q
         27CclF8g86cVlWPBZqv5Y8daVikzj4yWqUVGUSs5FPPnvbdMqFdkuQHdm69PyZ2eFb6F
         24P5oegwBZN7RyYZaY39s2WeswvoR5zSY6A9N7txBICLlCihnkRL/bkQYFOTg857SF6a
         7KW8Qp0xr3UhWg4laG2wHyhqiBQb0YjdRwoCedvA3SLXW4rCE4IEVqPPZRArV3avWJNk
         jAAQ==
X-Gm-Message-State: APjAAAVHyZO/WEGpKgKG1gL6bJnG691Yt3LmiWJQ+oiIHeI05h5+ppVw
        X8FWAhmz6pIqNwlKrj8HOPr+37pa
X-Google-Smtp-Source: APXvYqweJn+YpFwyn3LDIvxX4iMjbKa0WcfWqrhUUtEz4LpLSFHJwQKsC27YRGAVas14wLiu98uruA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr996018wrl.260.1576084374686;
        Wed, 11 Dec 2019 09:12:54 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40f6:4600:d98a:4956:14c2:2b5d])
        by smtp.gmail.com with ESMTPSA id 2sm2973189wrq.31.2019.12.11.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:12:53 -0800 (PST)
Date:   Wed, 11 Dec 2019 18:12:52 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steven Price <steven.price@arm.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, kbuild-all@lists.01.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v16 13/25] mm: pagewalk: Don't lock PTEs for
 walk_page_range_novma()
Message-ID: <20191211171252.fdbdqn2nrze637gm@ltop.local>
References: <20191206135316.47703-14-steven.price@arm.com>
 <201912101842.KIXI4yCg%lkp@intel.com>
 <e0fd5594-fb4e-9ead-e582-544f47cb1f8b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0fd5594-fb4e-9ead-e582-544f47cb1f8b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:54:06PM +0000, Steven Price wrote:
> On 10/12/2019 11:23, kbuild test robot wrote:
> >>> include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'walk_pte_range' - unexpected unlock
> 
> I believe this is a false positive (although the trace here is useless).
> This patch adds a conditional lock/unlock:
> 
> pte = walk->no_vma ? pte_offset_map(pmd, addr) :
> 		     pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> ...
> if (!walk->no_vma)
> 	spin_unlock(ptl);
> pte_unmap(pte);
> 
> I'm not sure how to match sparse happy about that. Is the only option to
> have two versions of the walk_pte_range() function? One which takes the
> lock and one which doesn't.

Yes.

-- Luc
