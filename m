Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E374EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847521929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138391;
	bh=QNt5eS9HUmF8VI1Dw71TfY/iSpr7WWA7t3X6E/j/Qkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgkFRfwChIn0zRy3i4SiSM7D393/RfHGNT73hHo/e02trk55COXJ9UI1lvAXzToGG
	 d1QZJslDi4uIyutDAUcNHvCPWrNwSvp465JD9CdjTKf8w6AzagM+B0yjqpVW4t3YpV
	 vnbuO4qPy0VP7HzfFXz4xl9yLlW1mbcM4UhLWwyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDARGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfDARG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3256B21929;
        Mon,  1 Apr 2019 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138386;
        bh=QNt5eS9HUmF8VI1Dw71TfY/iSpr7WWA7t3X6E/j/Qkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlBl2HsJcWUuQwz5SL8I2lW/ueC1ayoBP29g0FjsuTvdvfEtWNBCG6XocOBbEfdhe
         t/LPClkb1B/x4xfz+hxt5BPPS38/4Js1CkMeh32iuIENqhLNIf91gKCsMKEpDe/Yjv
         Zzq62f2n8i2pRZ9S8KaZV+ieTlGjCtONJLaOMZQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 052/146] NFSv4.1 dont free interrupted slot on open
Date:   Mon,  1 Apr 2019 19:01:04 +0200
Message-Id: <20190401170053.020178920@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2938,7 +2938,8 @@ static int _nfs4_open_and_get_state(stru
 	}
 
 out:
-	nfs4_sequence_free_slot(&opendata->o_res.seq_res);
+	if (!opendata->cancelled)
+		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
 }
 


