Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610570;
	bh=BO6Q3LeR74hWH6fO4Z2YxuwA+OpqTZMJEe+77T7oqGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iV8eyAW+PlPMLFJye0H88RfYIOXXMBvw7MFiyciC/K/bgmWPycxPcZFhJ2twydO/U
	 vqLm1IKVZQrAMnmHwan3PDfmj+9b6LjbgDFieWukO+YZ6tV8bLNTxOCP7lFP3jF8zo
	 RW/+DGmswdAX6RPtHdRqUig/mxlXcRE42a3TGo6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbfDRSCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390415AbfDRSCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E3621872;
        Thu, 18 Apr 2019 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610565;
        bh=BO6Q3LeR74hWH6fO4Z2YxuwA+OpqTZMJEe+77T7oqGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaPR/W2tXesuNcFNlOodxp6kaTOAvXhUvUM5O5dIokDynHSoC+gqqaNQAVexVcuFS
         BrQKEnZGaerlxX/DZ4tfhckmfvZh5WsFy8iH2hNFfosjPMmsvwr1ftgV1KkHok1WfY
         qGf1TPAtamOgKO670E4URVD4n0HkniB6I31gSXU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 4.19 110/110] [PATCH 4.19.y 2/2] mm: hide incomplete nr_indirectly_reclaimable in sysfs
Date:   Thu, 18 Apr 2019 19:57:39 +0200
Message-Id: <20190418160447.859444349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

In upstream branch this fixed by commit b29940c1abd7 ("mm: rename and
change semantics of nr_indirectly_reclaimable_bytes").

This fixes /sys/devices/system/node/node*/vmstat format:

...
nr_dirtied 6613155
nr_written 5796802
 11089216
...

Cc: <stable@vger.kernel.org> # 4.19.y
Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/node.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -197,11 +197,16 @@ static ssize_t node_read_vmstat(struct d
 			     sum_zone_numa_state(nid, i));
 #endif
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		/* Skip hidden vmstat items. */
+		if (*vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
+				 NR_VM_NUMA_STAT_ITEMS] == '\0')
+			continue;
 		n += sprintf(buf+n, "%s %lu\n",
 			     vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
 			     NR_VM_NUMA_STAT_ITEMS],
 			     node_page_state(pgdat, i));
+	}
 
 	return n;
 }


