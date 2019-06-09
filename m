Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF32C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA1A2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098695;
	bh=g+hd2iLdmdvsV99V+ur7k869hgf102FOOHf4hvs7/pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VA/mjwjwkuRaoD0/P192DDx+caeggpy3pjJAS6S9v1XHntjCFZ1MiSdfFgLMyK4OD
	 D1wOkCD5d5BTAyeKAr+S8Rj1B9pOsSMjOAOumBmkjNvB6XKJctKYO+aGG1cEVdZAeU
	 qw0qgvAPKknyJk0deT2JxxT3dyxDzrBfH7T68cVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfFIQox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfFIQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDAA2084A;
        Sun,  9 Jun 2019 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098689;
        bh=g+hd2iLdmdvsV99V+ur7k869hgf102FOOHf4hvs7/pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hL7qzB+0U0H95ofJ0HW4QQXPGoRbW8B/QthSEunhJTNP6iCQD0l0Mb3l2jy/Jrizb
         Ethc9vvMq5a+wruxk++GphsQOLIW5qktBd1z2m/1JcYvA0LY1ubTsKbwf6OAbWt5kW
         QN6wOUcZncn3k25AR2mHLU7mInKiZ9504b0gGx4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.1 25/70] parisc: Use implicit space register selection for loading the coherence index of I/O pdirs
Date:   Sun,  9 Jun 2019 18:41:36 +0200
Message-Id: <20190609164129.119219324@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John David Anglin <dave.anglin@bell.net>

commit 63923d2c3800919774f5c651d503d1dd2adaddd5 upstream.

We only support I/O to kernel space. Using %sr1 to load the coherence
index may be racy unless interrupts are disabled. This patch changes the
code used to load the coherence index to use implicit space register
selection. This saves one instruction and eliminates the race.

Tested on rp3440, c8000 and c3750.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parisc/ccio-dma.c  |    4 +---
 drivers/parisc/sba_iommu.c |    3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -565,8 +565,6 @@ ccio_io_pdir_entry(u64 *pdir_ptr, space_
 	/* We currently only support kernel addresses */
 	BUG_ON(sid != KERNEL_SPACE);
 
-	mtsp(sid,1);
-
 	/*
 	** WORD 1 - low order word
 	** "hints" parm includes the VALID bit!
@@ -597,7 +595,7 @@ ccio_io_pdir_entry(u64 *pdir_ptr, space_
 	** Grab virtual index [0:11]
 	** Deposit virt_idx bits into I/O PDIR word
 	*/
-	asm volatile ("lci %%r0(%%sr1, %1), %0" : "=r" (ci) : "r" (vba));
+	asm volatile ("lci %%r0(%1), %0" : "=r" (ci) : "r" (vba));
 	asm volatile ("extru %1,19,12,%0" : "+r" (ci) : "r" (ci));
 	asm volatile ("depw  %1,15,12,%0" : "+r" (pa) : "r" (ci));
 
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -575,8 +575,7 @@ sba_io_pdir_entry(u64 *pdir_ptr, space_t
 	pa = virt_to_phys(vba);
 	pa &= IOVP_MASK;
 
-	mtsp(sid,1);
-	asm("lci 0(%%sr1, %1), %0" : "=r" (ci) : "r" (vba));
+	asm("lci 0(%1), %0" : "=r" (ci) : "r" (vba));
 	pa |= (ci >> PAGE_SHIFT) & 0xff;  /* move CI (8 bits) into lowest byte */
 
 	pa |= SBA_PDIR_VALID_BIT;	/* set "valid" bit */


