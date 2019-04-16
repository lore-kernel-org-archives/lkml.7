Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A85C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FBD20674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfDPO7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:59:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:21870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPO7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:59:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 07:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="143410589"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2019 07:59:37 -0700
Date:   Tue, 16 Apr 2019 09:01:30 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv2 2/2] hmat: Register attributes for memory hot add
Message-ID: <20190416150130.GA20546@localhost.localdomain>
References: <20190415151654.15913-1-keith.busch@intel.com>
 <20190415151654.15913-3-keith.busch@intel.com>
 <9f130b73-e5ae-0529-69a1-28bd2ca29581@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f130b73-e5ae-0529-69a1-28bd2ca29581@inria.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:55:21PM +0200, Brice Goglin wrote:
> Hello Keith
> 
> Several issues:
> 
> * We always get a memory_side_cache, even if nothing was found in ACPI.
>   You should at least ignore the cache if size==0?
> 
> * Your code seems to only work with a single level of cache, since
>   there's a single cache_attrs entry in each target structure.
> 
> * I was getting a section mismatch warning and a crash on PMEM node
>   hotplug until I applied the patch below.
> 
> WARNING: vmlinux.o(.text+0x47d3f7): Section mismatch in reference from the function hmat_callback() to the function .init.text:hmat_register_target()
> The function hmat_callback() references
> the function __init hmat_register_target().
> This is often because hmat_callback lacks a __init 
> annotation or the annotation of hmat_register_target is wrong.
> 
> Thanks
> 
> Brice

Oh, thanks for the notice. I'll add multi-level and no-caches into my
test, as I had it fixed to one. Will need to respin this series.
