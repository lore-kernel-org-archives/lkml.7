Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4194C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7ED214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011214;
	bh=03r97VGqXp/QJvnNHJqH2nCO4ax7jaxJtClnvljdmhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OvTw89DUqePSjUb158BIGgQdElCegtT+u+djwDENU/sZGpeIFGmDB0tiyHFtpaerL
	 jAml2/pJaOGFBbIPa86xkR2AKhKYIJ40WFnP1hAKoF8IFuXI1uFuXsbgNVb277Fiid
	 IbUZ7laeSme/Gs9M9uata3hNaMjhoL8V3uKEEjbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfHENUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbfHENUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:20:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140802067D;
        Mon,  5 Aug 2019 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011202;
        bh=03r97VGqXp/QJvnNHJqH2nCO4ax7jaxJtClnvljdmhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJVb+tSiXuJJjorosxvmz6oYKJB3UwqW6kMce+zh2EMUL1m2d9VsJucHspP0hThOF
         tbLEpIXcNQOjefhZCsOk6L5dgEqMpJoDdt625TWXa7WxOMgX+ufv1o8JwWjR21uHqi
         To16fgvTR8fi13ODt16nhmFkX/hrwwztCDY8plQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.19 49/74] IB/hfi1: Fix Spectre v1 vulnerability
Date:   Mon,  5 Aug 2019 15:03:02 +0200
Message-Id: <20190805124939.857760420@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
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
@@ -1596,6 +1597,7 @@ static int hfi1_check_ah(struct ib_devic
 	sl = rdma_ah_get_sl(ah_attr);
 	if (sl >= ARRAY_SIZE(ibp->sl_to_sc))
 		return -EINVAL;
+	sl = array_index_nospec(sl, ARRAY_SIZE(ibp->sl_to_sc));
 
 	sc5 = ibp->sl_to_sc[sl];
 	if (sc_to_vlt(dd, sc5) > num_vls && sc_to_vlt(dd, sc5) != 0xf)


