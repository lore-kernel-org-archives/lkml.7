Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93429C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58999233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493908;
	bh=Gff5SQSPmRmvtp8vZDvZq7goePM271B+gwda976FxFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPD6ktgIXRvSaxgVNiKR0SNHZiZE3l3zzC+zR7kJVkAG3O9C/pNMpvNyEqsQrn0/H
	 2E3XsUcKuMTP/JyuYIW9AR/FyBzCF3UEfuoYf3GhepfGE7hdfAu3b3lZamnw1y1DyJ
	 GGAEx9TP6EjcrQ+xwY91vmILAaLKvOnOtX1/vlQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbfHVRLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbfHVRJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:16 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A4B23407;
        Thu, 22 Aug 2019 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493755;
        bh=Gff5SQSPmRmvtp8vZDvZq7goePM271B+gwda976FxFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2acb7KXMRi0oKpTKDOoiJCjAgggkKSP7K1edUK2AdpFwl7N/56u+bIuZGMF4hsSZ
         q7FZXdL5sPSuNbGzNjyTAh+Zm8U/0Co35n/BZJxHxMjeyarOG0BLFYEqqKlGi1td/G
         8d6nhNrTiSp0XMzgyvlJCX6fdqxFQx15FXEaLXpw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 113/135] sctp: fix memleak in sctp_send_reset_streams
Date:   Thu, 22 Aug 2019 13:07:49 -0400
Message-Id: <20190822170811.13303-114-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 6d5afe20397b478192ed8c38ec0ee10fa3aec649 ]

If the stream outq is not empty, need to kfree nstr_list.

Fixes: d570a59c5b5f ("sctp: only allow the out stream reset when the stream outq is empty")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 25946604af85c..e83cdaa2ab765 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -316,6 +316,7 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
 		nstr_list[i] = htons(str_list[i]);
 
 	if (out && !sctp_stream_outq_is_empty(stream, str_nums, nstr_list)) {
+		kfree(nstr_list);
 		retval = -EAGAIN;
 		goto out;
 	}
-- 
2.20.1

