Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB99C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE5208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441368;
	bh=7eM4eOqVLu7LG+qzdh/QS+6/vwe1CL0oyvbo63MD9XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTSUOsu2wnzcCOHdFL5bzvj4LI5tL4zOCLKPs80/rhfD7aDMsvVdIwKsz1UBIeFZo
	 M0YNcFlkx6e2BulYnhMI5IR19gG7tbv69hjhKcnulPUuUti/H0wu6qBL98mCr5qVvb
	 HLZWqKnT6NmgcBWgKXnnzPYwo4oX8w827CnIVOmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfFMP4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbfFMIv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:51:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4F3215EA;
        Thu, 13 Jun 2019 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415888;
        bh=7eM4eOqVLu7LG+qzdh/QS+6/vwe1CL0oyvbo63MD9XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K03Uw2dL4RxTTc1+BJCbTJCHD+e5B1eSEGLCEQFU5Rh2yYwkqxGHzYJRVQYjp0mXE
         +c/XvjT1gxA8uZDyp5O6lXP4aHO8STwdrh3ztRxBcf6JrwlMI7+pta0ccgnvfFskvM
         AWBC78mrAygL/T428aVZbYCxRtH1mzmaFmNg9s9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 151/155] percpu: do not search past bitmap when allocating an area
Date:   Thu, 13 Jun 2019 10:34:23 +0200
Message-Id: <20190613075701.276754551@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c43004af01635cc9fbb11031d070e5e0d327ef2 ]

pcpu_find_block_fit() guarantees that a fit is found within
PCPU_BITMAP_BLOCK_BITS. Iteration is used to determine the first fit as
it compares against the block's contig_hint. This can lead to
incorrectly scanning past the end of the bitmap. The behavior was okay
given the check after for bit_off >= end and the correctness of the
hints from pcpu_find_block_fit().

This patch fixes this by bounding the end offset by the number of bits
in a chunk.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/percpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index d832793bf83a..d38bd83fbe96 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -988,7 +988,8 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
 	/*
 	 * Search to find a fit.
 	 */
-	end = start + alloc_bits + PCPU_BITMAP_BLOCK_BITS;
+	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
+		    pcpu_chunk_map_bits(chunk));
 	bit_off = bitmap_find_next_zero_area(chunk->alloc_map, end, start,
 					     alloc_bits, align_mask);
 	if (bit_off >= end)
-- 
2.20.1



