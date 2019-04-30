Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99929C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552352075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625151;
	bh=CgX1STdH28Hfo++kxSUzPDQtF1OyjNe5UgvR/78FXns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8q2mfTkHciOZKxFscZ3f7E+JvGWnrA7N8geD98e/DWsrt74nXS91cg74ql8vAEDk
	 5+NXbajOhyYshD8QAaM7PXEw5EXNf88wEa6Uiswr28qybJf51K/bfPs4n2H8V00xHK
	 kUl3Yh+NN/UDtOEExVZaOoZWByK6PdD2K5jX9Bl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfD3Lvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbfD3Lv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D7721670;
        Tue, 30 Apr 2019 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625087;
        bh=CgX1STdH28Hfo++kxSUzPDQtF1OyjNe5UgvR/78FXns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fih/sLmFLg89x9PrZ20YZZ16vLy0d0iSqmjybu6PMDWdl8VOgp7uzhcIIhYby8J10
         WYnoJIfq8ZU2rmoqWk+kwtgtn5U2IzcblICexNpYhti48i4VS1xVGSYn+Q0/eq1Ug7
         3HLV4R8SyT/uN5syc/2x3rF0haYN1UrvGEwN/nUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 85/89] mlxsw: spectrum: Put MC TCs into DWRR mode
Date:   Tue, 30 Apr 2019 13:39:16 +0200
Message-Id: <20190430113613.781436399@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit f476b3f809fa02f47af6333ed63715058c3fc348 ]

Both Spectrum-1 and Spectrum-2 chips are currently configured such that
pairs of TC n (which is used for UC traffic) and TC n+8 (which is used
for MC traffic) are feeding into the same subgroup. Strict
prioritization is configured between the two TCs, and by enabling
MC-aware mode on the switch, the lower-numbered (UC) TCs are favored
over the higher-numbered (MC) TCs.

On Spectrum-2 however, there is an issue in configuration of the
MC-aware mode. As a result, MC traffic is prioritized over UC traffic.
To work around the issue, configure the MC TCs with DWRR mode (while
keeping the UC TCs in strict mode).

With this patch, the multicast-unicast arbitration results in the same
behavior on both Spectrum-1 and Spectrum-2 chips.

Fixes: 7b8195306694 ("mlxsw: spectrum: Configure MC-aware mode on mlxsw ports")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2961,7 +2961,7 @@ static int mlxsw_sp_port_ets_init(struct
 		err = mlxsw_sp_port_ets_set(mlxsw_sp_port,
 					    MLXSW_REG_QEEC_HIERARCY_TC,
 					    i + 8, i,
-					    false, 0);
+					    true, 100);
 		if (err)
 			return err;
 	}


