Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CAC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877D1206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781697;
	bh=TRjs8bxBQvu1ekSCCmNtZ0zJVUQ5t1Naq2n7iuyAVjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzp8e4b7XJwY/fu6bPy+dVPC8mV+hb0LjtZVCBmGXdYhmYA2I+ks2OOJx3cj/Fo5u
	 Wxdya+G93ZUBxBHX5ql0tJADZhCpBy9KiUL/j3pctp/DJhstqadpqKTwSvW3bgjkTk
	 kjrLxKhKtpZPtxRWPdYTKX2PpoQo04F2ZzqaDKRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfLSSy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbfLSSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E95227BF;
        Thu, 19 Dec 2019 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781690;
        bh=TRjs8bxBQvu1ekSCCmNtZ0zJVUQ5t1Naq2n7iuyAVjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5XRWXWcekJIQFacQgjJC+EUf0tvE0x4J6HPiOMDm/vhXvBaLA+0ILMPCrm6C4hGn
         49M08XZPLxTg0BaaEzW73KBcVR2gjI7pMgTlTzpStF42i4ezRoB7cIJW2YALGlJQmS
         UXMjyGQThEcSJQMK3Td1/Y/bw0KVSZHPi+QdzdsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 33/80] cifs: Dont display RDMA transport on reconnect
Date:   Thu, 19 Dec 2019 19:34:25 +0100
Message-Id: <20191219183106.105637638@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

commit 14cc639c17ab0b6671526a7459087352507609e4 upstream.

On reconnect, the transport data structure is NULL and its information is not
available.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_debug.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -256,6 +256,11 @@ static int cifs_debug_data_proc_show(str
 		if (!server->rdma)
 			goto skip_rdma;
 
+		if (!server->smbd_conn) {
+			seq_printf(m, "\nSMBDirect transport not available");
+			goto skip_rdma;
+		}
+
 		seq_printf(m, "\nSMBDirect (in hex) protocol version: %x "
 			"transport status: %x",
 			server->smbd_conn->protocol,


