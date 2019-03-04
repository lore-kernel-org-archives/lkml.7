Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA85C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4178C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688563;
	bh=2k9LYoTKgj6XtJn1jACL5PKRRyJRjOWlAh6LhoHTV8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dk2A0fpO91a8gY7/ajNW+XDljQEH7043GS+kKt3RhzoKK2ppd8cN6OlkxMZy20h5V
	 4/bxhQl/emAIALMh6i8uv//nrabSrOtSHPCpHZRLDDfYyljo0aNGS8pay3l7zEqHre
	 oAd3X+cJbzvqePglSnWb56NnYpzziGnoykSN4u6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfCDIgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfCDIf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DFD21019;
        Mon,  4 Mar 2019 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688558;
        bh=2k9LYoTKgj6XtJn1jACL5PKRRyJRjOWlAh6LhoHTV8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAWJrqaMy5x4x5ZUs5CXTSgEAo+H1BVrK9O49zaXdi5qDegn5C9BahhYfN7O+lnOA
         NIY+zBBTy4ZmYXW4vWVvFjMpCH/fo0lQAi1XWcBWR9wh3CYB4YbqNnshDFkVagsSlP
         YXcSIPrsOBD7tIVy9xytw0vRdqhVeIO5Z0lkxRhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 4.20 81/88] MIPS: fix memory setup for platforms with PHYS_OFFSET != 0
Date:   Mon,  4 Mar 2019 09:23:04 +0100
Message-Id: <20190304081633.897912798@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

commit e0bf304e4a00d66d90904a6c5b93141f177cf6d2 upstream.

For platforms, which use a PHYS_OFFSET != 0, symbol _end also
contains that offset. So when calling memblock_reserve() for
reserving kernel the size argument needs to be adjusted.

Fixes: bcec54bf3118 ("mips: switch to NO_BOOTMEM")
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -384,7 +384,8 @@ static void __init bootmem_init(void)
 	init_initrd();
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
-	memblock_reserve(PHYS_OFFSET, reserved_end << PAGE_SHIFT);
+	memblock_reserve(PHYS_OFFSET,
+			 (reserved_end << PAGE_SHIFT) - PHYS_OFFSET);
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages


