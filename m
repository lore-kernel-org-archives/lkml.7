Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F721473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139393;
	bh=16E1iSjjBz9IP9jB7Rv7AOXbHiJ957bknwStVe2ke8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vMEUDocKlkgpDhjrzWgiHr12wRDCj/mro2RazhyObXL/jaoVvpJrJaXtY5K9NSR77
	 YSQOMlNGCgGFdiXaGQbemKrJ9/PaAagAkfsFpYR9ARgduWVnmC76RvmimNTerl7G8I
	 iI7VYQVyaLDEYzFn8rN1AArn56ICX+mRH3yOyH/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDARXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfDARXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:23:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950ED206C0;
        Mon,  1 Apr 2019 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139389;
        bh=16E1iSjjBz9IP9jB7Rv7AOXbHiJ957bknwStVe2ke8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ug6pB52AumqGbrmnCXp8eOLjEpgSF9YC3VAS7VfwgDlYMq8Mc3f5gqsvyXVcRVB7s
         Rir6E0V0BETnBER08JkTPPKN38Bsz04qO00GnDyaorKB9gzr7fcmQyWlk6/0pmAxzp
         d2CLvQyn50KevzammATE8FUhRp9aM+bXVBbZWlzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 061/107] NFSv4.1 dont free interrupted slot on open
Date:   Mon,  1 Apr 2019 19:02:16 +0200
Message-Id: <20190401170051.262269728@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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
@@ -2746,7 +2746,8 @@ static int _nfs4_open_and_get_state(stru
 			nfs4_schedule_stateid_recovery(server, state);
 	}
 out:
-	nfs4_sequence_free_slot(&opendata->o_res.seq_res);
+	if (!opendata->cancelled)
+		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
 }
 


