Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEFA2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402733;
	bh=W95AYDwAJnNW+zQXXgJRscFzlUAPbfC/sWs9ATA/zUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bi+9+NaZX1xsP1OOWvHa7rERdEgHeqK0cIeJ39tljdw2cbuEiPKoTIQ0/QW7DJ3T1
	 nxmsrs9fObL13HzdeJ7w365bat0uAPLQtl99+g0+HOEljdc8GWejmntX+HAcGqSjSQ
	 lrOQpl/ErYHgKpNmaIR2rA9Bjf9YMMfA0Pwu301M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfKVGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbfKVGCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E1320659;
        Fri, 22 Nov 2019 06:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402552;
        bh=W95AYDwAJnNW+zQXXgJRscFzlUAPbfC/sWs9ATA/zUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIPew2QxTSkWpiwgjWSMeMgWZXdmMRNRMJj4G41oPHqPlz6UKvbHihexkALP6EoHG
         zf9k8KywoaSDWFKt/fra3bPDHQuBXc63U0MrpUtSBM2TSCxJueRpM4i/w0gjBuHRRk
         LlP02ZlCr26zCHWBMvP9b1i2Q76fOs1nA6sXSgu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 58/91] powerpc/pseries: Fix node leak in update_lmb_associativity_index()
Date:   Fri, 22 Nov 2019 01:00:56 -0500
Message-Id: <20191122060129.4239-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 47918bc68b7427e961035949cc1501a864578a69 ]

In update_lmb_associativity_index() we lookup dr_node using
of_find_node_by_path() which takes a reference for us. In the
non-error case we forget to drop the reference. Note that
find_aa_index() does modify properties of the node, but doesn't need
an extra reference held once it's returned.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c0a0947f43bbb..e65ef3067afb5 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -294,6 +294,7 @@ static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
 
 	aa_index = find_aa_index(dr_node, ala_prop, lmb_assoc);
 
+	of_node_put(dr_node);
 	dlpar_free_cc_nodes(lmb_node);
 	return aa_index;
 }
-- 
2.20.1

