Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308FC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0460208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380530;
	bh=awY45/ht+lyuUV0fbMcLrqlDylGYw3vE8THQWBXkhZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EySDEMjZcog4evbfpGISFaSbXJgpeHLR3y84ds6eUuizx5V7mqDoTc6fwOEnGUMry
	 K0o4zVQmXd0N92OyxaOe+v8OuTr8pt6bbQ29D/FwTIYVOBgn8BAW/sGhUptQi/nNJL
	 SIX/tlmdMFrDqvl0f+piG8l5rQ++RkKYYUG8o5DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbfIMNP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389070AbfIMNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:22 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8C8214D8;
        Fri, 13 Sep 2019 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380522;
        bh=awY45/ht+lyuUV0fbMcLrqlDylGYw3vE8THQWBXkhZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqsDg+R0EJZxXqunC8F0SOR90xTey5DthivZrGijLZYgybrUziSpOyaODl+ipa2G2
         fhchQNi9AZ/WFsCATTFGURN9Sp7/KV84jbIsWRSrX+snphKsnnWFQLVQFfHGa0eOC3
         wj0qT4LU795tW9APvUfbjNfjYt1JFo28LL/6eYcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/190] btrfs: volumes: Make sure no dev extent is beyond device boundary
Date:   Fri, 13 Sep 2019 14:05:28 +0100
Message-Id: <20190913130605.428254115@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 05a37c48604c19b50873fd9663f9140c150469d1 ]

Add extra dev extent end check against device boundary.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6e008bd5c8cd1..c20708bfae561 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7411,6 +7411,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
+	struct btrfs_device *dev;
 	u64 stripe_len;
 	bool found = false;
 	int ret = 0;
@@ -7460,6 +7461,22 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 			physical_offset, devid);
 		ret = -EUCLEAN;
 	}
+
+	/* Make sure no dev extent is beyond device bondary */
+	dev = btrfs_find_device(fs_info, devid, NULL, NULL);
+	if (!dev) {
+		btrfs_err(fs_info, "failed to find devid %llu", devid);
+		ret = -EUCLEAN;
+		goto out;
+	}
+	if (physical_offset + physical_len > dev->disk_total_bytes) {
+		btrfs_err(fs_info,
+"dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
+			  devid, physical_offset, physical_len,
+			  dev->disk_total_bytes);
+		ret = -EUCLEAN;
+		goto out;
+	}
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.20.1



