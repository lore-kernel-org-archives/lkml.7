Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3831AC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D69F2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599171;
	bh=wpwdzJuoZK1zlq8R5d781zyo3qt9jWO09bVCUZoijKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CETNqzkLxCk4dHoBVs6WQb4HNFKo8lYSL9nEeywhg8nzDtRorWQH/0kTDsVtxMp5C
	 gEZmsOxobTw51rNxXjRz6BnNECG7+MFefpCfGx5mtdN/LnJkdqXaZpo6/bRTgPI2He
	 8Ioma5BO9BXH2IDxs2VnIkfdhYU4XQIb6S/ufsJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfGHPTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733238AbfGHPTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:19:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510712171F;
        Mon,  8 Jul 2019 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599164;
        bh=wpwdzJuoZK1zlq8R5d781zyo3qt9jWO09bVCUZoijKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUlO8UY8qPEY4mgmmiU9Y2cpPL7CuUepgEWzpur9puVEMRiWVcZiWcCEGbIharySX
         aJ3FQKZhZMwTj9C3DtE+NRZ/hnNNc9vE7YifFKHyEKyNrcZpQ2NhBA7hsf6OddyOIV
         LhIvLqnLdeh8mNgg9iV0peoX25xaAm4vAaHbhNcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 026/102] btrfs: start readahead also in seed devices
Date:   Mon,  8 Jul 2019 17:12:19 +0200
Message-Id: <20190708150527.627272415@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

commit c4e0540d0ad49c8ceab06cceed1de27c4fe29f6e upstream.

Currently, btrfs does not consult seed devices to start readahead. As a
result, if readahead zone is added to the seed devices, btrfs_reada_wait()
indefinitely wait for the reada_ctl to finish.

You can reproduce the hung by modifying btrfs/163 to have larger initial
file size (e.g. xfs_io pwrite 4M instead of current 256K).

Fixes: 7414a03fbf9e ("btrfs: initial readahead code and prototypes")
Cc: stable@vger.kernel.org # 3.2+: ce7791ffee1e: Btrfs: fix race between readahead and device replace/removal
Cc: stable@vger.kernel.org # 3.2+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/reada.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -759,6 +759,7 @@ static void __reada_start_machine(struct
 	u64 total = 0;
 	int i;
 
+again:
 	do {
 		enqueued = 0;
 		mutex_lock(&fs_devices->device_list_mutex);
@@ -771,6 +772,10 @@ static void __reada_start_machine(struct
 		mutex_unlock(&fs_devices->device_list_mutex);
 		total += enqueued;
 	} while (enqueued && total < 10000);
+	if (fs_devices->seed) {
+		fs_devices = fs_devices->seed;
+		goto again;
+	}
 
 	if (enqueued == 0)
 		return;


