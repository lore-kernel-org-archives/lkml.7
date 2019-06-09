Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31769C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E62206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098932;
	bh=nivdYKoZARgxbWl3AqCchq7gvJlFuVnq6+rMMSYgJPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uamGYAteC18R/C6GOGU1NBobmKiQ+9tAsRras1opA0YrsrB3waWtX8/n3475yRT+L
	 xthhRD0iQkthdrliZGTnKJhKwJxTbl/KqV3pm+JCv1QdSQLJFtqk6ttGdBkt+lHvuR
	 8vySyj7O4cvWKL+slwTGmPN9EE/zIsGUX10aOpCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfFIQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbfFIQst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147132081C;
        Sun,  9 Jun 2019 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098928;
        bh=nivdYKoZARgxbWl3AqCchq7gvJlFuVnq6+rMMSYgJPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs1meAFtEw2eqQNxa3DuwWD9bHRDcLKlCeHtnHew9PkVcklYYYuXn1Tx2sTmTGPRx
         hBvNPIxTgTzBjLqbns+MRAXtdh2N6T/NirClh4YWbiA0o6URlkjJ5voR7VHbNXVYJl
         jLZGpnw6O3/N/NRv3Nw7ODIuSeJwQAvqzB23Uw1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 08/51] net: mvpp2: Use strscpy to handle stat strings
Date:   Sun,  9 Jun 2019 18:41:49 +0200
Message-Id: <20190609164127.593165268@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit d37acd5aa99c57505b64913e0e2624ec3daed8c5 ]

Use a safe strscpy call to copy the ethtool stat strings into the
relevant buffers, instead of a memcpy that will be accessing
out-of-bound data.

Fixes: 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistics")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1310,8 +1310,8 @@ static void mvpp2_ethtool_get_strings(st
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_regs); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       &mvpp2_ethtool_regs[i].string, ETH_GSTRING_LEN);
+			strscpy(data + i * ETH_GSTRING_LEN,
+			        mvpp2_ethtool_regs[i].string, ETH_GSTRING_LEN);
 	}
 }
 


