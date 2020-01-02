Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00767C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB57120866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005999;
	bh=1+1H71gkxh1RMYV0boeJNEBPTmDAqEBkqTBL8rFOMXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1v6oQVsfBP+KXOrBeBsOMEblfVSidpTfLGLQN8Vl9iXbFHxmFox9ElFaf7x5W+iY
	 H56+YtQKbSNYc33rK+HGx+339C+Rh2ShF6bKXDYNjJnkDKshC0PV1/d7K5sBtFDRcx
	 3eHXYxmBG56aatUyJa+ylh5Evg4KQY0G6fRcoFuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgABW76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgABWNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2A922525;
        Thu,  2 Jan 2020 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003215;
        bh=1+1H71gkxh1RMYV0boeJNEBPTmDAqEBkqTBL8rFOMXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcATy+zTYMRPF3UYFbNEsm3I3wx8Tczouin9vlkKTFEukAKuIAFz9h1O3klXxUh59
         7L3tlvNfQ8YN3DZ9u49X58Z+FHHm1VZfqOPKeI3qTnnuNvVaDz3rPuRD0wp+DbH2dp
         PJCqaldRuDzdHRFlILnwzEb7RaLCAvI6SerTFPRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/191] PCI: rpaphp: Correctly match ibm, my-drc-index to drc-name when using drc-info
Date:   Thu,  2 Jan 2020 23:05:50 +0100
Message-Id: <20200102215837.241451641@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 4f9f2d3d7a434b7f882b72550194c9278f4a3925 ]

The newer ibm,drc-info property is a condensed description of the old
ibm,drc-* properties (ie. names, types, indexes, and power-domains).
When matching a drc-index to a drc-name we need to verify that the
index is within the start and last drc-index range and map it to a
drc-name using the drc-name-prefix and logical index.

Fix the mapping by checking that the index is within the range of the
current drc-info entry, and build the name from the drc-name-prefix
concatenated with the starting drc-name-suffix value and the sequential
index obtained by subtracting ibm,my-drc-index from this entries
drc-start-index.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-10-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index abb10b3c0b70..32eab1776cfe 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -248,9 +248,10 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 		/* Should now know end of current entry */
 
 		/* Found it */
-		if (my_index <= drc.last_drc_index) {
+		if (my_index >= drc.drc_index_start && my_index <= drc.last_drc_index) {
+			int index = my_index - drc.drc_index_start;
 			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-				my_index);
+				drc.drc_name_suffix_start + index);
 			break;
 		}
 	}
-- 
2.20.1



