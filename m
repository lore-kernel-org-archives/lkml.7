Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A232064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211374;
	bh=lCqS4E0uEPjyXJmJtHuFFGjg724ePFJdZapNyiHa+hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=giI34ZAYGFNMXN/uNEIGfeYm7RjOSVx73fjqjK2GThLomU1XLfmLuDStUZu13zD1W
	 hXFE5PvR6iL7LTatrKPuKihtGum1Qn/r1pXVFxXCrydDbxabisI7FFje3uvsrXsokt
	 HqygWFlY0KgnOXiiCC/PNDrrPFVYNuKHnGfX4174=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfJ0VWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbfJ0VWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:22:49 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DD4205C9;
        Sun, 27 Oct 2019 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211368;
        bh=lCqS4E0uEPjyXJmJtHuFFGjg724ePFJdZapNyiHa+hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeXRP9onOgp/092WsvlkH7Ul05NIB7IuMzhuJET0wyLRQ41fOycWNzlXCXB34q+PL
         wC57TEgskHRneBjZTfHYS7WRyU+/j7V9vgtIYOs4OFByDebzapMJPd5kIidqQtajnE
         nLxjo0K9Ppjl8CDPKATM6H9MULJsgmWRJ9qtJaSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 5.3 125/197] drm/ttm: Restore ttm prefaulting
Date:   Sun, 27 Oct 2019 22:00:43 +0100
Message-Id: <20191027203358.480134362@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 941f2f72dbbe0cf8c2d6e0b180a8021a0ec477fa upstream.

Commit 4daa4fba3a38 ("gpu: drm: ttm: Adding new return type vm_fault_t")
broke TTM prefaulting. Since vmf_insert_mixed() typically always returns
VM_FAULT_NOPAGE, prefaulting stops after the second PTE.

Restore (almost) the original behaviour. Unfortunately we can no longer
with the new vm_fault_t return type determine whether a prefaulting
PTE insertion hit an already populated PTE, and terminate the insertion
loop. Instead we continue with the pre-determined number of prefaults.

Fixes: 4daa4fba3a38 ("gpu: drm: ttm: Adding new return type vm_fault_t")
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/330387/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_bo_vm.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -278,15 +278,13 @@ static vm_fault_t ttm_bo_vm_fault(struct
 		else
 			ret = vmf_insert_pfn(&cvma, address, pfn);
 
-		/*
-		 * Somebody beat us to this PTE or prefaulting to
-		 * an already populated PTE, or prefaulting error.
-		 */
-
-		if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
-			break;
-		else if (unlikely(ret & VM_FAULT_ERROR))
-			goto out_io_unlock;
+		/* Never error on prefaulted PTEs */
+		if (unlikely((ret & VM_FAULT_ERROR))) {
+			if (i == 0)
+				goto out_io_unlock;
+			else
+				break;
+		}
 
 		address += PAGE_SIZE;
 		if (unlikely(++page_offset >= page_last))


