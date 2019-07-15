Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEAC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901CA212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198672;
	bh=tCAFSJ72N2B7u1RuSo/hxbVTBdcMr4i+W3a7SrvW+nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7S+8/4weGUzl/Gbz3l8OWydM3LGmXCQqwTl1ZrgnXJG+OcZVS9SAPmqBtu9U/BVr
	 4JLOB1yMyOOL9BZHREIPFsGl8zMUR4eSFGMDYZG79kjShEFVCdMwXGY6RCHsTg+p6P
	 f2TBdS/Z94MkSeWRq034I3op0E9Wo1CUVWA3Lk1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfGONvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731819AbfGONvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:51:07 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 714722086C;
        Mon, 15 Jul 2019 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198666;
        bh=tCAFSJ72N2B7u1RuSo/hxbVTBdcMr4i+W3a7SrvW+nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHvDIzL38gzkQr1dIJBRq+WhXxPvtXY9ZQzj4wCbL1RC40HFCZ62wKQ7ueFuh1efe
         8efayA/FVzKQJ6UWrG39+Vv2wdWEmnUniUIDG76HLRQL1TjM01ltsrUZFPyai+85sQ
         +hTjzgOCUs/iqzaJzP+E+WFTqDXo1uw0RpRzU3tM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 078/249] RAS/CEC: Fix pfn insertion
Date:   Mon, 15 Jul 2019 09:44:03 -0400
Message-Id: <20190715134655.4076-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit 6d8e294bf5f0e85c34e8b14b064e2965f53f38b0 ]

When inserting random PFNs for debugging the CEC through
(debugfs)/ras/cec/pfn, depending on the return value of pfn_set(),
multiple values get inserted per a single write.

That is because simple_attr_write() interprets a retval of 0 as
success and claims the whole input. However, pfn_set() returns the
cec_add_elem() value, which, if > 0 and smaller than the whole input
length, makes glibc continue issuing the write syscall until there's
input left:

  pfn_set
  simple_attr_write
  debugfs_attr_write
  full_proxy_write
  vfs_write
  ksys_write
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

leading to those repeated calls.

Return 0 to fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 673f8a128397..f5795adc5a6e 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -369,7 +369,9 @@ static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	return cec_add_elem(val);
+	cec_add_elem(val);
+
+	return 0;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
-- 
2.20.1

