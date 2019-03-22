Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75172082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255723;
	bh=/z0e6DG3neE8qfP4Q+UZDVQ7UJVYMd/Pqu5irUJlHyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGO1dMsmzGr7zEUqMQe014zPp/x5bat605yrTqKIuDLtGEYSWVODR9yowZfW3uGds
	 YhwicqtNubuOtig90Zstf7bK2uowKtCagcDTlPDh44NW3V7lo7tWVIfRvvZUmjEiK4
	 54XheP8bqGsHGgT2N83ua7RidUe3IRufwHrjoVcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfCVLzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbfCVLzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:55:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B550F2192B;
        Fri, 22 Mar 2019 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255718;
        bh=/z0e6DG3neE8qfP4Q+UZDVQ7UJVYMd/Pqu5irUJlHyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaW3gy3qZnDILVIncicTAcdZz2vglChpX1P49SN9v+37JQ5zroUdlKgh29S8iUuSR
         6wT19lniyhVn1w80NsYjirGBwNceJ1PA4aAdV9SuKB6xxI50YTo9Pe6jQ9qK04w+hG
         FE9Pf2XdlmBxScihZGs6vTeVX+qZAxdHjAsYLsHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 159/183] NFSv4.1: Reinitialise sequence results before retransmitting a request
Date:   Fri, 22 Mar 2019 12:16:27 +0100
Message-Id: <20190322111253.426168668@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit c1dffe0bf7f9c3d57d9f237a7cb2a81e62babd2b upstream.

If we have to retransmit a request, we should ensure that we reinitialise
the sequence results structure, since in the event of a signal
we need to treat the request as if it had not been sent.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -914,6 +914,13 @@ nfs4_sequence_process_interrupted(struct
 
 #endif	/* !CONFIG_NFS_V4_1 */
 
+static void nfs41_sequence_res_init(struct nfs4_sequence_res *res)
+{
+	res->sr_timestamp = jiffies;
+	res->sr_status_flags = 0;
+	res->sr_status = 1;
+}
+
 static
 void nfs4_sequence_attach_slot(struct nfs4_sequence_args *args,
 		struct nfs4_sequence_res *res,
@@ -925,10 +932,6 @@ void nfs4_sequence_attach_slot(struct nf
 	args->sa_slot = slot;
 
 	res->sr_slot = slot;
-	res->sr_timestamp = jiffies;
-	res->sr_status_flags = 0;
-	res->sr_status = 1;
-
 }
 
 int nfs4_setup_sequence(struct nfs_client *client,
@@ -974,6 +977,7 @@ int nfs4_setup_sequence(struct nfs_clien
 
 	trace_nfs4_setup_sequence(session, args);
 out_start:
+	nfs41_sequence_res_init(res);
 	rpc_call_start(task);
 	return 0;
 


