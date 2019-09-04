Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41436C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122EF22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620828;
	bh=izBRRnXiw9mOfutHNB06OnVP5gsPFMTfZ8E+HUYKFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKiCB3B3Kv55z7X/vOxMSAXKr0hNyQSxXbkmZRLlH0prFVSDqVn4Hkggf0Yn1PYPx
	 zRBR1Pv/7XSApE7qQxzkbnLV++Bs1vfIm2MPjJAu+G0GKQNlwWSpPvqN6oaN5q62lZ
	 +gvCETMO1XaifMaP4PF6TU2KZ+jc8DYE7iGIfiGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbfIDSNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389972AbfIDSNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC79D208E4;
        Wed,  4 Sep 2019 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620822;
        bh=izBRRnXiw9mOfutHNB06OnVP5gsPFMTfZ8E+HUYKFVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g53H2+YvJ7V0o1HGulFNEvw7tbfyLiR0ZHtfNKayhX74uZud4ELH1mJM5EtaEGhJN
         xW1zRsn1BRi2nIOv2t1qYReK3SPFWtx9LcAKI8hATFnE4AKIMItTvvSLtnbbAsc0W9
         uGni6C+5Jz4XFwhdpotxQhyn3ble3uxF4vSc8OHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 5.2 109/143] lib: logic_pio: Add logic_pio_unregister_range()
Date:   Wed,  4 Sep 2019 19:54:12 +0200
Message-Id: <20190904175318.668350121@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

commit b884e2de2afc68ce30f7093747378ef972dde253 upstream.

Add a function to unregister a logical PIO range.

Logical PIO space can still be leaked when unregistering certain
LOGIC_PIO_CPU_MMIO regions, but this acceptable for now since there are no
callers to unregister LOGIC_PIO_CPU_MMIO regions, and the logical PIO
region allocation scheme would need significant work to improve this.

Cc: stable@vger.kernel.org
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/logic_pio.h |    1 +
 lib/logic_pio.c           |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -117,6 +117,7 @@ struct logic_pio_hwaddr *find_io_range_b
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
 int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range);
 resource_size_t logic_pio_to_hwaddr(unsigned long pio);
 unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
 
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -99,6 +99,20 @@ end_register:
 }
 
 /**
+ * logic_pio_unregister_range - unregister a logical PIO range for a host
+ * @range: pointer to the IO range which has been already registered.
+ *
+ * Unregister a previously-registered IO range node.
+ */
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range)
+{
+	mutex_lock(&io_range_mutex);
+	list_del_rcu(&range->list);
+	mutex_unlock(&io_range_mutex);
+	synchronize_rcu();
+}
+
+/**
  * find_io_range_by_fwnode - find logical PIO range for given FW node
  * @fwnode: FW node handle associated with logical PIO range
  *


