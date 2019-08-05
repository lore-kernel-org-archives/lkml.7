Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49509C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B3520651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011681;
	bh=E+gX5LX6CA8aQTOIvXbPnuz9idaM8uOhX3i/MdZY0NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vTF+roPqvixP0Zk4IC0qTXM4brodWuzK03WZ7bi9NKccAjIVhUmU4QQ1W18NwzcZ
	 CXlS3huYQQQVgv9TYY6RUmXRen4dFtg/hTYlBFGgNQy2jqQhd6+njONVjq9j0B0ugF
	 ki/xYk0EeT19H+5xKSpZ+WUl9FdRbkAXoUzb7W/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfHENYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbfHENYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:24:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128E520651;
        Mon,  5 Aug 2019 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011442;
        bh=E+gX5LX6CA8aQTOIvXbPnuz9idaM8uOhX3i/MdZY0NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGMJ/K/NnccMtj3R9xaS6diNsWBgXGf/Q/1Zuros6oxYYD71mXgZ9a6LIxa0IcvTQ
         dULCHxNMd1K4nQ8noxGxv/yvAGNVp97T4Ae7csQJRnf2RxlMuDuy9KVFTGxN6hhkz2
         mD1uKWhJw3hITKmm6YSiRvs6EC3OnsBRxmAPA6XQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 5.2 090/131] IB/hfi1: Fix Spectre v1 vulnerability
Date:   Mon,  5 Aug 2019 15:02:57 +0200
Message-Id: <20190805124957.993665583@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 6497d0a9c53df6e98b25e2b79f2295d7caa47b6e upstream.

sl is controlled by user-space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

Fix this by sanitizing sl before using it to index ibp->sl_to_sc.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Link: https://lore.kernel.org/r/20190731175428.GA16736@embeddedor
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/verbs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -54,6 +54,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <rdma/opa_addr.h>
+#include <linux/nospec.h>
 
 #include "hfi.h"
 #include "common.h"
@@ -1536,6 +1537,7 @@ static int hfi1_check_ah(struct ib_devic
 	sl = rdma_ah_get_sl(ah_attr);
 	if (sl >= ARRAY_SIZE(ibp->sl_to_sc))
 		return -EINVAL;
+	sl = array_index_nospec(sl, ARRAY_SIZE(ibp->sl_to_sc));
 
 	sc5 = ibp->sl_to_sc[sl];
 	if (sc_to_vlt(dd, sc5) > num_vls && sc_to_vlt(dd, sc5) != 0xf)


