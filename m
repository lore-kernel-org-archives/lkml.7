Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8805A21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887179;
	bh=DAjtfsZlNLaNHrIyH1KYYh8DO8Rh66dcIIvAzpcYzEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zS25sglLZqQDlv8XPRputEp5KAtycqxNf61pm/vlVsTPW4HlgaDD9jYOin2QPi85o
	 EDfUq3OY3GN1RcEdpysAM53f154SUajm3/ff8Jt9RNiCy0Hpt6Jk++aGbgqWXbCMKz
	 /VNS0kMvpADLkW+vf+8fPndsVm+tgleiC82EZ8uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfK0Uji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbfK0Ujd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D74121771;
        Wed, 27 Nov 2019 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887173;
        bh=DAjtfsZlNLaNHrIyH1KYYh8DO8Rh66dcIIvAzpcYzEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFh1wwNBz0CSjBnKO7DSENyhykR2R8yE82nIwxWysYUgIOSm0vj/shZUrzcRUhb25
         IFAzxAaPTdai4I82y6rwqdovbBwJjNaKyuU1s/4uBxSuTPldO+0T2GrZC6IxUGXb3L
         DKpqH2zkoUlrKDx/b0l0FtY/irjjUvaFkmIZx6kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.9 001/151] net/mlx4_en: fix mlx4 ethtool -N insertion
Date:   Wed, 27 Nov 2019 21:29:44 +0100
Message-Id: <20191127203001.720968405@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
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
@@ -1679,6 +1679,7 @@ static int mlx4_en_get_rxnfc(struct net_
 		err = mlx4_en_get_flow(dev, cmd, cmd->fs.location);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
+		cmd->data = MAX_NUM_OF_FS_RULES;
 		while ((!err || err == -ENOENT) && priority < cmd->rule_cnt) {
 			err = mlx4_en_get_flow(dev, cmd, i);
 			if (!err)


