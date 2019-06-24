Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E283C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20E6213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370388;
	bh=rmZhShVbSyi1ZR/CTwHwPw4v+qk5JBg4Vmc46R0vNs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oRuXFtsje9p/IXuAO32AaAyrf+iR6MLrCt5qcxNtmm7j67VMqNWGTaT9dOoBjXGXV
	 Qm7x7jVpbs/QcLhjIy5wrk1sXDfGMroCoCBLhXVMxa/Cbqjcp+cWeq2x+O98BkiA8l
	 Lfz0u8rPCfAdONIo6A3t9Hk8b9L3kS1cB3/LO66c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFXJ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfFXJ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:59:45 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F23205ED;
        Mon, 24 Jun 2019 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370385;
        bh=rmZhShVbSyi1ZR/CTwHwPw4v+qk5JBg4Vmc46R0vNs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnkSmBhWKegeE6V7d7A6VAxmucQCkVqeg72on9jbQYDoR6F+XFdlL0TKqCWLp3r2O
         xVUPeo2EW1iwPO+1PZ7U/Cne6JMvEJu+ZLiWRsZDuqQzLPCA3O68b4fncpVcdcxJKF
         gBW/it+9MFZfRfbjPoxgcAiqT5Fuhd9aIKKCF9oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 39/51] btrfs: start readahead also in seed devices
Date:   Mon, 24 Jun 2019 17:56:57 +0800
Message-Id: <20190624092310.601848981@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
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
@@ -770,6 +771,10 @@ static void __reada_start_machine(struct
 		mutex_unlock(&fs_devices->device_list_mutex);
 		total += enqueued;
 	} while (enqueued && total < 10000);
+	if (fs_devices->seed) {
+		fs_devices = fs_devices->seed;
+		goto again;
+	}
 
 	if (enqueued == 0)
 		return;


