Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2650EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DB0217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887569;
	bh=sF0MbDNgGvZVLd10BjgaxgtQZf6HRf/9lU77UlNzvtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WP0gk90H5eJnqmQT7OelkGalxQT7QupxpUMIBlYGDbI4zxkl9f7tkt1Pj9WgrQx0O
	 VVlJZg+zp5mzffZOno6MmzSTHqo5KoykxE9rS8W1+adup60Xmyo5R4Sk2Bvk8jh0Rr
	 TYAT1wzs+ZcbishfKnsWvrD4bLO4ePbZ88ZcKayg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfK0UqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfK0UqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:46:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A1F21835;
        Wed, 27 Nov 2019 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887564;
        bh=sF0MbDNgGvZVLd10BjgaxgtQZf6HRf/9lU77UlNzvtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBb6L9pvVfLIR84kYSu6ve9kg4W2RacEmT++tjClvV2c60gHuUxCh0j/K5dctIEAJ
         ebPcuCmYToG52FnGO9nUX9oUgjqeNCbwnsrNUqCTnFgHvT7AMJiSrVOv9COckjgSAH
         wn12uP1+ve50TaPnLEjNebkjGEaOsMBLB4qZK4Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.14 001/211] net/mlx4_en: fix mlx4 ethtool -N insertion
Date:   Wed, 27 Nov 2019 21:28:54 +0100
Message-Id: <20191127203049.588851589@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luigi Rizzo <lrizzo@google.com>

[ Upstream commit 34e59836565e36fade1464e054a3551c1a0364be ]

ethtool expects ETHTOOL_GRXCLSRLALL to set ethtool_rxnfc->data with the
total number of entries in the rx classifier table.  Surprisingly, mlx4
is missing this part (in principle ethtool could still move forward and
try the insert).

Tested: compiled and run command:
	phh13:~# ethtool -N eth1 flow-type udp4  queue 4
	Added rule with ID 255

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1722,6 +1722,7 @@ static int mlx4_en_get_rxnfc(struct net_
 		err = mlx4_en_get_flow(dev, cmd, cmd->fs.location);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
+		cmd->data = MAX_NUM_OF_FS_RULES;
 		while ((!err || err == -ENOENT) && priority < cmd->rule_cnt) {
 			err = mlx4_en_get_flow(dev, cmd, i);
 			if (!err)


