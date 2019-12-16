Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B612072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519387;
	bh=ifH8X5vkN/6z3kuCQ1cHLW7FJruu9svUDegwE67t3VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gErKS8VBmFFQw+UXlWeJj/GUf8MppMYuOFjE1JKDhVILFy1Znsgqui8dFqoD2jq2Y
	 ASftER4iI9iEJkVnAPHDGbyQ+Wt7J4nbA6tnF0MmcFDvsthni5ptUpytn3YK/Zw3Sc
	 ms8lcl1AR0V9JRrCMy6qiM2L6+rYsxFK3xyjAUuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfLPSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbfLPSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56692207FF;
        Mon, 16 Dec 2019 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519379;
        bh=ifH8X5vkN/6z3kuCQ1cHLW7FJruu9svUDegwE67t3VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etp/XYjvG9XyApXbq/30f7X3cf9LAZtgv0a/0C22LIQUhS5cjonUR8mL+7GxYyNCt
         GkbubOPHoKn2iV+hYU9ljidZglqnLjL5pEU6mAVL21xD/NAiLKclUgXE4RnwJ0KNKM
         D4dnPNuFyBz4c+XkJPprhS8GzsuXcDXduIV6e560=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 041/140] btrfs: Remove btrfs_bio::flags member
Date:   Mon, 16 Dec 2019 18:48:29 +0100
Message-Id: <20191216174800.009954528@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 34b127aecd4fe8e6a3903e10f204a7b7ffddca22 upstream.

The last user of btrfs_bio::flags was removed in commit 326e1dbb5736
("block: remove management of bi_remaining when restoring original
bi_end_io"), remove it.

(Tagged for stable as the structure is heavily used and space savings
are desirable.)

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.h |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -304,7 +304,6 @@ struct btrfs_bio {
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	unsigned long flags;
 	void *private;
 	atomic_t error;
 	int max_errors;


