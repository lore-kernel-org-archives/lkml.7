Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51A2214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431514;
	bh=x80/44W5sNRnef/gurAabMagadcvgV7gB3jqA2KmPF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lswdeWn1TRw5nCGgHEHcEC2ck007Kzka3/LZMDVnGuigDQjf2svtca5jLcT7/FnYB
	 f2virKWyR4lSoLE9abluADidnAceMOMPqT70seEczrcMPm4ME5KsmAw11c+IxVUG/o
	 Qo7FKa2ow5T82B/L9yFd6/qRbN8K4t7ToqumNGIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgAGVLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgAGVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98EE520880;
        Tue,  7 Jan 2020 21:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431498;
        bh=x80/44W5sNRnef/gurAabMagadcvgV7gB3jqA2KmPF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SNYJW28M/qjoR7y3HAW57tfib5uNhD6moF1RtLT7qCSaTTfQkzqlC0NjlaL6Mtjt
         4LHkQQ1tQ+i+zN/CBs6NgWszXz6w8ENjSxsKvE0W+qLwX+O/OKk5+MIDwqORFE3gNc
         /htTc+k725JQ/JwBLuM7Hp1Nid1u5vNU4hckRQyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Paul Durrant <pdurrant@amazon.co.uk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        SeongJae Park <sjpark@amazon.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 73/74] xen/blkback: Avoid unmapping unmapped grant pages
Date:   Tue,  7 Jan 2020 21:55:38 +0100
Message-Id: <20200107205236.749959243@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

[ Upstream commit f9bd84a8a845d82f9b5a081a7ae68c98a11d2e84 ]

For each I/O request, blkback first maps the foreign pages for the
request to its local pages.  If an allocation of a local page for the
mapping fails, it should unmap every mapping already made for the
request.

However, blkback's handling mechanism for the allocation failure does
not mark the remaining foreign pages as unmapped.  Therefore, the unmap
function merely tries to unmap every valid grant page for the request,
including the pages not mapped due to the allocation failure.  On a
system that fails the allocation frequently, this problem leads to
following kernel crash.

  [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
  [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
  [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
  [  372.012562] Oops: 0002 [#1] SMP
  [  372.012566] Modules linked in: act_police sch_ingress cls_u32
  ...
  [  372.012746] Call Trace:
  [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
  [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
  ...
  [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
  ...
  Decompressing Linux... Parsing ELF... done.
  Booting the kernel.
  [    0.000000] Initializing cgroup subsys cpuset

This commit fixes this problem by marking the grant pages of the given
request that didn't mapped due to the allocation failure as invalid.

Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")

Reviewed-by: David Woodhouse <dwmw@amazon.de>
Reviewed-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Paul Durrant <pdurrant@amazon.co.uk>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkback/blkback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 987d665e82de..c1d1b94f71b5 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -929,6 +929,8 @@ next:
 out_of_memory:
 	pr_alert("%s: out of memory\n", __func__);
 	put_free_pages(ring, pages_to_gnt, segs_to_map);
+	for (i = last_map; i < num; i++)
+		pages[i]->handle = BLKBACK_INVALID_HANDLE;
 	return -ENOMEM;
 }
 
-- 
2.20.1



