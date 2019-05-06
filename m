Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63565C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287772054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155102;
	bh=uKMG32aR6XD0AtLePyWTs52oPupPMpoNb530NBGu0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fxrsF4loDBqChO4suupVyaLDCF2RppTuSqdS2jR+nBfcMhSjBCSwItn+HcZz/niNy
	 LUiZXmhtTrUQGQQrv8dJsenBi12SrugaznHEMgAlpyJlpO8JwPsQddEcjnMuxTtr6k
	 +UnrZh6v5EfbQDnlyg/xS51flCRYJYrA2NOn5jmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfEFPFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfEFOjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73B020449;
        Mon,  6 May 2019 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153540;
        bh=uKMG32aR6XD0AtLePyWTs52oPupPMpoNb530NBGu0Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEdqUyTLWucGBa4/M1hZICJmJvDzA8VoGfhoIkt1VniFvpoipCRJvnXT1riFBmKN4
         4qYrR6gqegzotFfJFsLVT894UUsmHx1ie/CQaAAgZUm5UHFMosFJOQHZ4IAdmBADUd
         B0wiHTptupJgIcwHTelO4zjMu7vVLfbmGk5wULtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 106/122] IB/core: Unregister notifier before freeing MAD security
Date:   Mon,  6 May 2019 16:32:44 +0200
Message-Id: <20190506143104.143017284@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

commit d60667fc398ed34b3c7456b020481c55c760e503 upstream.

If the notifier runs after the security context is freed an access of
freed memory can occur.

Fixes: 47a2b338fe63 ("IB/core: Enforce security on management datagrams")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/security.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -727,9 +727,10 @@ void ib_mad_agent_security_cleanup(struc
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return;
 
-	security_ib_free_security(agent->security);
 	if (agent->lsm_nb_reg)
 		unregister_lsm_notifier(&agent->lsm_nb);
+
+	security_ib_free_security(agent->security);
 }
 
 int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)


