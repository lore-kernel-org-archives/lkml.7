Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D76C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12D218A2
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291268;
	bh=xAKeC1Ay7OyxgDDNdrMmEq8ZYbemYt/h0OLCkvugigg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dlrYiJg40JmRJL2+l6zLbw6zas7yeUhVhJPRxucEV9Zcg1ye5X47A8wdfYjc+p1Kz
	 kAZ4TpHVyRuGoU6DlmOeBtDDZbIOf/OMec3IDqD7qQ00vjO3IFJ0tOpEhGz3fd+B1z
	 LCMljU+LVi97MDAdgORdsuGEYsS+np5jWViQArpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404748AbfHHTHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404734AbfHHTHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766F21882;
        Thu,  8 Aug 2019 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291264;
        bh=xAKeC1Ay7OyxgDDNdrMmEq8ZYbemYt/h0OLCkvugigg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kppK8OQWshod7DEpogYyBT5kNfqWONtN926bAb7vdSKY/U0qjHZIIPXyB0WnBR9Av
         L2E+DOFd0lBpVAqUJiB1Vj94ETORYVxTGLQ3zYtKWPzO8hOigShqKBUAnLWezO6Q1o
         9toshc9BeyOMV+q/0WdzKycwbqwlYWFVx7Q+XpiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 50/56] mlxsw: spectrum_buffers: Further reduce pool size on Spectrum-2
Date:   Thu,  8 Aug 2019 21:05:16 +0200
Message-Id: <20190808190455.242734555@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 744ad9a357280d03d567538cee7e1e457dedd481 ]

In commit e891ce1dd2a5 ("mlxsw: spectrum_buffers: Reduce pool size on
Spectrum-2"), pool size was reduced to mitigate a problem in port buffer
usage of ports split four ways. It turns out that this work around does not
solve the issue, and a further reduction is required.

Thus reduce the size of pool 0 by another 2.7 MiB, and round down to the
whole number of cells.

Fixes: e891ce1dd2a5 ("mlxsw: spectrum_buffers: Reduce pool size on Spectrum-2")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -437,8 +437,8 @@ static const struct mlxsw_sp_sb_pr mlxsw
 			   MLXSW_SP1_SB_PR_CPU_SIZE, true, false),
 };
 
-#define MLXSW_SP2_SB_PR_INGRESS_SIZE	38128752
-#define MLXSW_SP2_SB_PR_EGRESS_SIZE	38128752
+#define MLXSW_SP2_SB_PR_INGRESS_SIZE	35297568
+#define MLXSW_SP2_SB_PR_EGRESS_SIZE	35297568
 #define MLXSW_SP2_SB_PR_CPU_SIZE	(256 * 1000)
 
 /* Order according to mlxsw_sp2_sb_pool_dess */


