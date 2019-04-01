Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1783C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8BA21900
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138911;
	bh=Bs7DGrdFYxjIPnTxbrXZn3BYH7IPmZaU1ZaxO0iYO+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnFoIgJT/sJrI3xFkZR8Ev5uw5cPg+g7iXcfktLjiSk5REGReJ6FOU6M8rvXOBMCh
	 Qec16EzPDWxkKz5fERicwiuDJT7xiolx/DH5HCQruSBNCrMtxGBdHRJKpHqIMS84Tu
	 2g4JwReNx863rSS9OyA8lXyRkaqJd/7dp3urQRUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfDARPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbfDARPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5A62133D;
        Mon,  1 Apr 2019 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138905;
        bh=Bs7DGrdFYxjIPnTxbrXZn3BYH7IPmZaU1ZaxO0iYO+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHX1/ZMZ7nuskCZH6DhVHC9NNiGtU28AqzTQ7BfRXJ38XHD0v8LL8H9/OwTZo2pQN
         6MGOlMRRcpnquWxKgEdlRS2V+iHddQWdGhNcOY1/CvBg9qqafHViN6jdmursSABx34
         FuagwL/3F31+dsmdm0psaFAMhOAcaWOV+WtLlwsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 055/134] NFSv4.1 dont free interrupted slot on open
Date:   Mon,  1 Apr 2019 19:01:31 +0200
Message-Id: <20190401170049.658711304@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <kolga@netapp.com>

commit 0cb98abb5bd13b9a636bde603d952d722688b428 upstream.

Allow the async rpc task for finish and update the open state if needed,
then free the slot. Otherwise, the async rpc unable to decode the reply.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: ae55e59da0e4 ("pnfs: Don't release the sequence slot...")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2909,7 +2909,8 @@ static int _nfs4_open_and_get_state(stru
 	}
 
 out:
-	nfs4_sequence_free_slot(&opendata->o_res.seq_res);
+	if (!opendata->cancelled)
+		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
 }
 


