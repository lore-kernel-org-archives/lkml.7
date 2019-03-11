Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B53214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334296;
	bh=X1oppJNfwUc2ScPfniRvMe+j+iX78dxmg214MRw/Id0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g0fJ2rAsaVQq4MambTDLOFpmkd3S2nptgtxEDTNleieh4togiNTvqO7sq1GtjR2ge
	 DDMx5PWHmkvqC08sJGUqp9mMpR1RX34bbwlwN9Jqof/dSDkeplrb3hmU21zpnmJ4A1
	 Tet56CpnaTtfRUs+jMkIuZvz+n3O2+PKCTE6jnsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfCKT6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbfCKT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DDE214AF;
        Mon, 11 Mar 2019 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334288;
        bh=X1oppJNfwUc2ScPfniRvMe+j+iX78dxmg214MRw/Id0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOuV1BigK0+Qfoy5Y/4JQ6oY36HVW4sXSwSS2qPeQ+gfinTfPJPdWMXF+T6orPmC1
         grg/vwCe3ZW5Qssu5u11m+cdFCQ7jJ8IlWUgZWhpHrOxgawvKc2vgreSiIEQVQr6wf
         Y1TZ6JbmndRWKXyyZ7MJxngt+ydq3FPq/HgbtLUo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/44] net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()
Date:   Mon, 11 Mar 2019 15:56:53 -0400
Message-Id: <20190311195700.138462-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8d6ea932856c7087ce8c3d0e79494b7d5386f962 ]

The value of ->num_ports comes from bcm_sf2_sw_probe() and it is less
than or equal to DSA_MAX_PORTS.  The ds->ports[] array is used inside
the dsa_is_user_port() and dsa_is_cpu_port() functions.  The ds->ports[]
array is allocated in dsa_switch_alloc() and it has ds->num_ports
elements so this leads to a static checker warning about a potential out
of bounds read.

Fixes: 8cfa94984c9c ("net: dsa: bcm_sf2: add suspend/resume callbacks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index fc8b48adf38b..bb26a193361e 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -692,7 +692,7 @@ static int bcm_sf2_sw_suspend(struct dsa_switch *ds)
 	 * port, the other ones have already been disabled during
 	 * bcm_sf2_sw_setup
 	 */
-	for (port = 0; port < DSA_MAX_PORTS; port++) {
+	for (port = 0; port < ds->num_ports; port++) {
 		if (dsa_is_user_port(ds, port) || dsa_is_cpu_port(ds, port))
 			bcm_sf2_port_disable(ds, port, NULL);
 	}
-- 
2.19.1

