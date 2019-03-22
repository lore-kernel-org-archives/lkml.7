Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ADB2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256230;
	bh=ONq/1aIIF9nFaMGbFLCcFbhx+z4PYd9bAyHZyNYSHBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TmuJ47lkMnikSx3UFyBeNAVVpN6ARNXjwDVxDT6DPY8ZjAMPz0HLGo6yggMwhEKi1
	 l95CQw2ADBemZGDk4GtWT35JaJwwbVqXL/EQuCUykqk8Cb5sT5mTmzg3oBeSLb8m8n
	 B6UInchDdzgsTROWe0kNfSPRC4iYsZ1vWUm8R+7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfCVMDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388559AbfCVMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5627E2196E;
        Fri, 22 Mar 2019 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256224;
        bh=ONq/1aIIF9nFaMGbFLCcFbhx+z4PYd9bAyHZyNYSHBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLAynQNSuHGkra1NAwD+o+jlQfZWsEN/tdH0RkdyOm8+ATiuJDxB7x715eqKy6XpN
         ouAoJz4qeSBEtjSqro9JbGhVL9Gu8D7AdYEM/9h+ar1w2UxE857/lwEkV1KjFCxXAN
         unpy6DTnI51ZSJJsBXXnas7UQ3sGZX8WirEVW1ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yang <richardw.yang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 118/280] libnvdimm, pfn: Fix over-trim in trim_pfn_device()
Date:   Fri, 22 Mar 2019 12:14:31 +0100
Message-Id: <20190322111314.673999207@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richardw.yang@linux.intel.com>

commit f101ada7da6551127d192c2f1742c1e9e0f62799 upstream.

When trying to see whether current nd_region intersects with others,
trim_pfn_device() has already calculated the *size* to be expanded to
SECTION size.

Do not double append 'adjust' to 'size' when calculating whether the end
of a region collides with the next pmem region.

Fixes: ae86cbfef381 "libnvdimm, pfn: Pad pfn namespaces relative to other regions"
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pfn_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -619,7 +619,7 @@ static void trim_pfn_device(struct nd_pf
 	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
 				IORES_DESC_NONE) == REGION_MIXED
 			|| !IS_ALIGNED(end, nd_pfn->align)
-			|| nd_region_conflict(nd_region, start, size + adjust))
+			|| nd_region_conflict(nd_region, start, size))
 		*end_trunc = end - phys_pmem_align_down(nd_pfn, end);
 }
 


