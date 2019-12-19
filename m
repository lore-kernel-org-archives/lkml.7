Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB3F206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781674;
	bh=5I7uet99nY5CsYucqDFzdA7hVwXlvyamRwgRlYepYbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipXQJg8pZPoN31sUsPjoCc7YCpvk6Lxe2nCCmyDlIkXqO9gssYchLUM2hiPod+sna
	 npowNFe4JCvagFpT7QETQ7odSRBfzzVcA09bkc+BPZJcSLrSoTLfmClQFiJlVJ/yOU
	 a1PTQPMqysaF8CaS3E2AwJgeINKzYEB3ekB4gBGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfLSSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbfLSSy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD130227BF;
        Thu, 19 Dec 2019 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781668;
        bh=5I7uet99nY5CsYucqDFzdA7hVwXlvyamRwgRlYepYbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iijNqeAyJf4LZDi8McX74jsfCLCupSB5aN2JtL56P37I1bY3W9dt9pzHncNe0Kg5L
         2xNBZoLKwiXySaQ7dQM6XBH3Qv9gE4eG6A2aLpHujFm8ap1C1k6ZNI/PZ4QvgZ5RFP
         MkxvHwncIWRbIscqKOdJt470WPTNT74Vlw6jAf7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 30/80] cifs: smbd: Add messages on RDMA session destroy and reconnection
Date:   Thu, 19 Dec 2019 19:34:22 +0100
Message-Id: <20191219183104.225917310@linuxfoundation.org>
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

commit d63cdbae60ac6fbb2864bd3d8df7404f12b7407d upstream.

Log these activities to help production support.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1476,6 +1476,7 @@ void smbd_destroy(struct TCP_Server_Info
 	info->transport_status = SMBD_DESTROYED;
 
 	destroy_workqueue(info->workqueue);
+	log_rdma_event(INFO,  "rdma session destroyed\n");
 	kfree(info);
 }
 
@@ -1505,8 +1506,9 @@ create_conn:
 	log_rdma_event(INFO, "creating rdma session\n");
 	server->smbd_conn = smbd_get_connection(
 		server, (struct sockaddr *) &server->dstaddr);
-	log_rdma_event(INFO, "created rdma session info=%p\n",
-		server->smbd_conn);
+
+	if (server->smbd_conn)
+		cifs_dbg(VFS, "RDMA transport re-established\n");
 
 	return server->smbd_conn ? 0 : -ENOENT;
 }


