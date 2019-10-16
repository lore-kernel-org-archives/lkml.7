Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1096FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB252168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfJPMzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:55:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbfJPMzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:55:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB3528;
        Wed, 16 Oct 2019 05:55:43 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F6E33F68E;
        Wed, 16 Oct 2019 05:55:42 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:55:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4] arm64: use generic free_initrd_mem()
Message-ID: <20191016125539.GH49619@arrakis.emea.arm.com>
References: <1569657746-31672-1-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569657746-31672-1-git-send-email-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Queued for 5.5. Thanks.

-- 
Catalin
