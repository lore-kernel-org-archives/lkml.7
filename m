Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11204C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6624258
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559167574;
	bh=rWWvSy2SCl28ReiT8I2BWwARbIr04tpQHSj7QNq/5YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=18jePAZm2cFRqDA+q9lp5bhAwZfyKnhG7GSPUZXofSQ/dJuhWRvCvw4mR1HJ6+Sm5
	 pWzTRQ5OORcy/D6Y1VaK8WTFvkVmMSTr1eYZ9E/nVVsFUSWbl3llhqoBVGJ4Kk06KL
	 o1S1JcUMQ8/znZbVl+nQl7VeatVqT/TKt3OhRhpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2WGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfE2WGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:06:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5589024257;
        Wed, 29 May 2019 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559167573;
        bh=rWWvSy2SCl28ReiT8I2BWwARbIr04tpQHSj7QNq/5YE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gerrou/CZt1Rss49kiuG2BG724zLbGiugPqeN8w79MuOdLxnGvWczrM8RB6V9L42i
         zA4kb/wlkjvupHprLPu31fdVa7RSi89A82U4qS1bVdg4CAs2w4/GdbvDYSjNBzLwol
         3FIiGIoC+mL0ttq79m2ihlSfHUAa91+n+iX0Nxgc=
Date:   Wed, 29 May 2019 15:06:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, mhocko@suse.com,
        ira.weiny@intel.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, james.morse@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V5 0/3] arm64/mm: Enable memory hot remove
Message-Id: <20190529150611.fc27dee202b4fd1646210361@linux-foundation.org>
In-Reply-To: <1559121387-674-1-git-send-email-anshuman.khandual@arm.com>
References: <1559121387-674-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 14:46:24 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This series enables memory hot remove on arm64 after fixing a memblock
> removal ordering problem in generic __remove_memory() and one possible
> arm64 platform specific kernel page table race condition. This series
> is based on latest v5.2-rc2 tag.

Unfortunately this series clashes syntactically and semantically with
David Hildenbrand's series "mm/memory_hotplug: Factor out memory block
devicehandling".  Could you and David please figure out what we should
do here?
