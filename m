Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82ACC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4D72064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127709;
	bh=58m6HmBlYzQtWsLSf1zVanyyXZYFQuwUSk8EsntzOn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L68zWcXafTVGNzTSwnLv0A06viYiaRopBstKtc9ZFyWyf8jfa+WggBBw/kyrbomLl
	 k57hEarOHfS7krBieqxquQphTMsCrSCQLObPN4j8ScdqiTtb46nvnsyphAn7sdP6qu
	 se8/l+UhJO9uNYlQZLL69Wfwx0SkAbiB9b8xHgvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392081AbfDXRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390639AbfDXRga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:30 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006E32054F;
        Wed, 24 Apr 2019 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127389;
        bh=58m6HmBlYzQtWsLSf1zVanyyXZYFQuwUSk8EsntzOn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi5TtgcBMuRxKdPp1l0q1+qFWdC2OUjEcergRoXWUOFdcnx4vRNbAa+pAJyHTsvyB
         PxoajlCdgNS+oF+D6XjXoC/yllmO5XwbzxqSvz2ep/NIb1DO6HnSDV3jpOFbBzt40+
         mbUGnZk8BgPSVi11nNhJqo90i7FSed4Pl6K0BCVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Tariq Toukan <tariqt@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 029/115] net/mlx5e: Switch to Toeplitz RSS hash by default
Date:   Wed, 24 Apr 2019 19:09:25 +0200
Message-Id: <20190424170926.744433917@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 7ee2ace9c544a0886e02b54b625e521df8692d20 ]

Although XOR hash function can perform very well on some special use
cases, to align with all drivers, mlx5 driver should use Toeplitz hash
by default.
Toeplitz is more stable for the general use case and it is more standard
and reliable.

On top of that, since XOR (MLX5_RX_HASH_FN_INVERTED_XOR8) gives only a
repeated 8 bits pattern. When used for udp tunneling RSS source port
manipulation it results in fixed source port, which will cause bad RSS
spread.

Fixes: 2be6967cdbc9 ("net/mlx5e: Support ETH_RSS_HASH_XOR")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4574,7 +4574,7 @@ void mlx5e_build_rss_params(struct mlx5e
 {
 	enum mlx5e_traffic_types tt;
 
-	rss_params->hfunc = ETH_RSS_HASH_XOR;
+	rss_params->hfunc = ETH_RSS_HASH_TOP;
 	netdev_rss_key_fill(rss_params->toeplitz_hash_key,
 			    sizeof(rss_params->toeplitz_hash_key));
 	mlx5e_build_default_indir_rqt(rss_params->indirection_rqt,


