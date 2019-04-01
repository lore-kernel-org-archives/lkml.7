Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293DC20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139624;
	bh=LgxbULNNqkA797Cw9+3tRfhXSmGnCmjDLGN64ahgpYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1OZAEHJjUvzDwIvb6EP/C6ZpcU9UNJ0/EWoigxNT2DoQwKgs4tpjAxNZuOB7qFQe
	 4JB6Cwv4fqZwTNpYq5b0XRMPjC9rdfecykLdNHQntEOyU63rKc9XXVGQyfb8pXh7QX
	 JRSI3rQIChHT7QSbcaq6sDew4oxuWNJsVLdnxWb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfDAR1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbfDAR1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A9320883;
        Mon,  1 Apr 2019 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139620;
        bh=LgxbULNNqkA797Cw9+3tRfhXSmGnCmjDLGN64ahgpYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dwt/mJmTXcC8rMQitz/GkBs2HMUqYkglUtzcIjLA80ceNVbknhzuaJg8xbdxYTR3
         h8ZY80H2SCGl4JHUUlYYSUP+F13du8DzVNEvWHzhef8ePwCtzd50yE7/UqnRCSaihD
         yQqilrevvucYAsTZG/fkBHjCDReu7CiylDZufhLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 21/56] NFSv4.1 dont free interrupted slot on open
Date:   Mon,  1 Apr 2019 19:02:37 +0200
Message-Id: <20190401170105.133091652@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2748,7 +2748,8 @@ static int _nfs4_open_and_get_state(stru
 			nfs4_schedule_stateid_recovery(server, state);
 	}
 out:
-	nfs4_sequence_free_slot(&opendata->o_res.seq_res);
+	if (!opendata->cancelled)
+		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
 }
 


