Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C09B205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211253;
	bh=4dIzeMO8XR4YiZuQG+uaIMqLbAGHDd8/rcfjmH0VutM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F6gXGMxN8kh4S8Y17kg8bjvoc2/kAszl6zGCc9YkEuJ5pWd62ljmfaXOHhDTzgp/Y
	 ULt52I026aD+fr7VJOMphKPaiV0qTUQM02TnfIEvoyHmeZWdBu0mEgYr3dsDuFanHn
	 I/XqAcuB5rTYBxIvZwOiEuduLecjlfDiwG4ZIHe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfJ0VUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbfJ0VUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:45 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DF52070B;
        Sun, 27 Oct 2019 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211245;
        bh=4dIzeMO8XR4YiZuQG+uaIMqLbAGHDd8/rcfjmH0VutM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1EWB4eZ/1m6mYAy+04zD4ToItSwmwOEi5N1veN4AQx6j/Z8sJl2lmwY4uL0pxr5tT
         GPXjQc3yK0anilgMPrwuxX2fIG15FdN3ZQ/JqUF9MCdhTrKMfRxcgyZcMtrDEa4nuP
         ti5GVdyDbrdaWD86m4BRRh2PrkitAdWTn84dddsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 081/197] net: aquantia: temperature retrieval fix
Date:   Sun, 27 Oct 2019 21:59:59 +0100
Message-Id: <20191027203356.074304789@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Russkikh <Igor.Russkikh@aquantia.com>

[ Upstream commit 06b0d7fe7e5ff3ba4c7e265ef41135e8bcc232bb ]

Chip temperature is a two byte word, colocated internally with cable
length data. We do all readouts from HW memory by dwords, thus
we should clear extra high bytes, otherwise temperature output
gets weird as soon as we attach a cable to the NIC.

Fixes: 8f8940118654 ("net: aquantia: add infrastructure to readout chip temperature")
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -337,7 +337,7 @@ static int aq_fw2x_get_phy_temp(struct a
 	/* Convert PHY temperature from 1/256 degree Celsius
 	 * to 1/1000 degree Celsius.
 	 */
-	*temp = temp_res  * 1000 / 256;
+	*temp = (temp_res & 0xFFFF) * 1000 / 256;
 
 	return 0;
 }


