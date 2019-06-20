Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFD32084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054439;
	bh=rJUSdW4DU2T4HKZutJOiDPs0iaZmDRAoAusiRXVmM7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uvK6ALN7l4GfzEJWev3hKbhSBH/MSsXu8UmAXZ5r/LfSQeBivBIvI1hOEpNVlnQHJ
	 445NKGuGpi0Ga1wmvYRXkRzq9T+LTz6Kybu3WQAV9BJ1XLgLKxM8Bc2WKSgKdLNgYo
	 lyYBVgs/HbOB4wfVTlBABFSaa5Rn68RtF88VC3qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfFTSN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfFTSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC282082C;
        Thu, 20 Jun 2019 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054434;
        bh=rJUSdW4DU2T4HKZutJOiDPs0iaZmDRAoAusiRXVmM7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJWrkftX+ru+OJRDn+cgKY+ssB8GpF+uDslRXGXARHVVzM8NWnKLBtXOJR0IjxeDk
         X+avL/e+l6eYYbyagVKjxBi7AFEhSGVWIBteIFa++Nqj2UKGQsLJOFjYeg7VKlk3Fz
         MZi7GYPT4GVn/YnDue88e4dpUEKMLfJgLYZj/sQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 28/98] mlxsw: spectrum_buffers: Reduce pool size on Spectrum-2
Date:   Thu, 20 Jun 2019 19:56:55 +0200
Message-Id: <20190620174350.411020754@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

Due to an issue on Spectrum-2, in front-panel ports split four ways, 2 out
of 32 port buffers cannot be used. To work around this, the next FW release
will mark them as unused, and will report correspondingly lower total
shared buffer size. mlxsw will pick up the new value through a query to
cap_total_buffer_size resource. However the initial size for shared buffer
pool 0 is hard-coded and therefore needs to be updated.

Thus reduce the pool size by 2.7 MiB (which corresponds to 2/32 of the
total size of 42 MiB), and round down to the whole number of cells.

Fixes: fe099bf682ab ("mlxsw: spectrum_buffers: Add Spectrum-2 shared buffer configuration")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -411,9 +411,9 @@ static const struct mlxsw_sp_sb_pr mlxsw
 	MLXSW_SP_SB_PR(MLXSW_REG_SBPR_MODE_STATIC, MLXSW_SP_SB_INFI),
 };
 
-#define MLXSW_SP2_SB_PR_INGRESS_SIZE	40960000
+#define MLXSW_SP2_SB_PR_INGRESS_SIZE	38128752
+#define MLXSW_SP2_SB_PR_EGRESS_SIZE	38128752
 #define MLXSW_SP2_SB_PR_INGRESS_MNG_SIZE (200 * 1000)
-#define MLXSW_SP2_SB_PR_EGRESS_SIZE	40960000
 
 static const struct mlxsw_sp_sb_pr mlxsw_sp2_sb_prs[] = {
 	/* Ingress pools. */


