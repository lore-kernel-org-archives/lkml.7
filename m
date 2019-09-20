Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB813C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F412080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yLfvnX9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbfITOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:21:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387817AbfITOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:21:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so3922468edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BsObysdauMqFxQskSLuaANmrbU7y5OuxMxy3HbJkoH8=;
        b=yLfvnX9xGqCtoBtlknnpzBw2B3alTmNk3CXvDaf3MoBnN9PZaUdqLKOkT9Zzh/n2OZ
         SbD1/4Gj6cP3aQ3iwHLpmUQ2nYoif61BK45NZZpQ4xgYet8vCIJtZZ0g2qNLLsC7NQ8Z
         DjkOXKCNXhfgfNkhIvAiJmmSTB3991s02/L1RlMXWEpQWTyCZBRv0OCy9MJOENQS/bav
         6t/uTMbrBaUhwoSZkv76hO5m1yScZU92EeaOPA4UzOax8JCzIFw23PfzQl3JBdx6KdyI
         hsQ4SUOsTdBkoEC4cbFw3wKzPEQvIhKU7o5rgqrJlGmwI5fBkqR0xZ8bMGc+EnyV6y67
         ZWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BsObysdauMqFxQskSLuaANmrbU7y5OuxMxy3HbJkoH8=;
        b=lYPYpvhyZWwMhE7aWxjyoDaHz3L8sNGUo5RemDJYLH+G4DZxq1qzwcsD1x2+fgswJg
         PFuFXsI2YXyU3jv0gMWfs75knpC1p6iKJuQO/iu0bSX53nguzrk2HVTf/dOxGTz8HVuQ
         e3NMS1LFx+bgQnujjL3/p0qdn4LA2t1gNjJQaptRH5m18ZNh76Y6UEJjwhh6cftRbvvb
         vLFwKLCF+j+QB1wznYO81cVY3qhH4zy+2+BMuGXTubl3Xd6Q5YudpFJUQReSK6O1NQ20
         6m5zOQJd/G6PAGvbxCS2sbNRGhG8URkg0SW31fqIGorfCnIBSidjgF5lEipfCqRhNoON
         3Arg==
X-Gm-Message-State: APjAAAW63WNxvgGjvXkXafmiW/OeDW0ckCb74GAUUaBqnMvPH0hQOa0U
        LUv53YAwabyBb3ULWyBZhzc6CQ==
X-Google-Smtp-Source: APXvYqynqm5TTKBimN51b6OZzEkRrwe+U7oN1i3ygL0xADjoA6jCeUaZdJrdhbRfLIjJwN06Jc3i/Q==
X-Received: by 2002:a17:906:6d95:: with SMTP id h21mr19767726ejt.192.1568989273886;
        Fri, 20 Sep 2019 07:21:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g15sm352149edp.0.2019.09.20.07.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 07:21:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6733D101405; Fri, 20 Sep 2019 17:21:13 +0300 (+03)
Date:   Fri, 20 Sep 2019 17:21:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190920142113.52mdiflo4yghlsmu@box>
References: <20190920135437.25622-1-justin.he@arm.com>
 <20190920135437.25622-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920135437.25622-4-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:54:37PM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case.(by Kirill)
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
