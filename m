Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF12C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1CE21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571100426;
	bh=XVqGlOyzVGQHZ9hOvBUdLU3ajK2qd0Ivd5OqEzf/XY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bgECjWBcNAzns7MFHrqw1TqCRBuymAheKWolz5zocRPfLdOGDZgjNRiJDUAy3nqFG
	 4EvdA88wtn1Jqq/AX7C5nadsMWax5LS2x4xdz/UR9bPaRYRzjH7A4KFQOocPZ0C7F5
	 2njQT4InZvpcAj9hFX9YEPaxhkMl2vRfHvR4cS3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfJOArE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfJOArE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:47:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988E42089C;
        Tue, 15 Oct 2019 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571100424;
        bh=XVqGlOyzVGQHZ9hOvBUdLU3ajK2qd0Ivd5OqEzf/XY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9NGZ3K9So8Qvzi/fHJnzuXRu0Gkdzgx3NTiN02B3K6V3yxqk1FgGvVmh0q5HLhn0
         BLc6J6nMzrAll0JsM/Maj6xFNvv8xbMjVlCmcOTJkRyaC0GLn11FsjO3DmJpFX6YTZ
         i3xGyxzEeYnO1WUdttjbv0X4sMtoJ/rRJzI9bsaI=
Date:   Tue, 15 Oct 2019 01:46:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4] arm64: use generic free_initrd_mem()
Message-ID: <20191015004659.l5xbxv4mlpzqpsdl@willie-the-truck>
References: <1569657746-31672-1-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569657746-31672-1-git-send-email-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 11:02:26AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> arm64 calls memblock_free() for the initrd area in its implementation of
> free_initrd_mem(), but this call has no actual effect that late in the boot
> process. By the time initrd is freed, all the reserved memory is managed by
> the page allocator and the memblock.reserved is unused, so the only purpose
> of the memblock_free() call is to keep track of initrd memory for debugging
> and accounting.
> 
> Without the memblock_free() call the only difference between arm64 and the
> generic versions of free_initrd_mem() is the memory poisoning.
> 
> Move memblock_free() call to the generic code, enable it there
> for the architectures that define ARCH_KEEP_MEMBLOCK and use the generic
> implementation of free_initrd_mem() on arm64.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> v4:
> * memblock_free() aligned area around the initrd

Looks straightforward to me:

Acked-by: Will Deacon <will@kernel.org>

Will
