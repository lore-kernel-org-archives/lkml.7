Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877FE2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889542;
	bh=3DAjZdfgGJhDyTl/Lgq1TVe46KLbVY3g+DqvfFZjYK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+cLl0Y5CVkuj8su+dAuOyw7R+W3sOtH17UXJ/ZB/d4XFQCxxwixBTSt2vH8v1A9x
	 UDLymlBIJxo16PW84mfBYijs53CYiXz8RtIlRCjRBNxqboLO5316CU8IiywKq7Wchk
	 h5wwlP5Ad15KVr3l3YO95/N/gFAyMl6HnnL7I43k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfK0VTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733129AbfK0VLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:11:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6328121789;
        Wed, 27 Nov 2019 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889070;
        bh=3DAjZdfgGJhDyTl/Lgq1TVe46KLbVY3g+DqvfFZjYK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCa53/QBy4/B0FsbVONYfYUhQA4KzX2F8EtbEGwiTmhyzzuh4zu+znSPgXsejQUCx
         c3vOv/tHqrkXiwtjXOWNZPam5xn+WbYzywzpzlMdMaJxj+XE/yUOcL/MGzF8pmFGzz
         UkFFqLu4ROf/pIjso1nCeWgSWiV9jc33YP06eLvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chester Lin <clin@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.3 45/95] ARM: 8904/1: skip nomap memblocks while finding the lowmem/highmem boundary
Date:   Wed, 27 Nov 2019 21:32:02 +0100
Message-Id: <20191127202911.769097383@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chester Lin <clin@suse.com>

commit 1d31999cf04c21709f72ceb17e65b54a401330da upstream.

adjust_lowmem_bounds() checks every memblocks in order to find the boundary
between lowmem and highmem. However some memblocks could be marked as NOMAP
so they are not used by kernel, which should be skipped while calculating
the boundary.

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mm/mmu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1197,6 +1197,9 @@ void __init adjust_lowmem_bounds(void)
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
 
+		if (memblock_is_nomap(reg))
+			continue;
+
 		if (reg->base < vmalloc_limit) {
 			if (block_end > lowmem_limit)
 				/*


