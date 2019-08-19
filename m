Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF69C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279BF2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566219393;
	bh=UO4FTZseWCp9eDIq9wbqfeQcfvQgOuhKZNq4SSQZlCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=woeTUDxwRtxe5auCjH/ASqrOFfOxNH4AVMgkfNmRQ8/fICBzdJnSl9xIy98YvxpgS
	 9yw9o0paM1eIgb6gtLG/L6H7NVz0WbhcfAAIKJYS2gj8Hi0FybMxExYZ1eFh+24kcf
	 bSrlbWWvTL8GP1PO5DPxx4NRsrZdTTsyHBRi/o4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfHSM4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:56:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073A7205C9;
        Mon, 19 Aug 2019 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566219391;
        bh=UO4FTZseWCp9eDIq9wbqfeQcfvQgOuhKZNq4SSQZlCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6j37x4gi/6X0L/ntZnqejE/KABlXoc3rhzuaqGTCUYmRqon5h34OLBgOYes5raz7
         /D4umugtstfQker4f99YG3DdWKtSK+LqlwZWJLF5vfd2dgSPVSF1gZvYXLRoBjdsKm
         2/iMibknt0kPfzelxOg5ZQteaN74tyOH0e3mBE9A=
Date:   Mon, 19 Aug 2019 13:56:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
Message-ID: <20190819125625.bu3nbrldg7te5kwc@willie-the-truck>
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
> __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
> but it will modify pointer tag into 0xff, so there is a false positive.
> 
> When enable tag-based kasan, phys_to_virt() function need to rewrite
> its original pointer tag in order to avoid kasan report an incorrect
> memory corruption.

Hmm. Which tree did you see this on? We've recently queued a load of fixes
in this area, but I /thought/ they were only needed after the support for
52-bit virtual addressing in the kernel.

Will
