Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EABC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA320637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419819;
	bh=W6Cv9nYKuyieexMWJNDnH/JK4Gkfrg+rFkLPx5ydw7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drPcIFXehFaXgclcuJr0kF+TfmGMa1npmbfn3Sk/HUT8lFNOpTAda+I29UKfIeO2B
	 G0MzfVm4LLzy05vrjlP6sfNCyRvJQnhiecR9lY9oqsmyKhz8bjS28Q+5Q/GE9Ol22l
	 ngHkyR4Zzq0QQALEP6HyGGu/SA94bOYIYRSfu6Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfKVKuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbfKVKuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:50:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1213620637;
        Fri, 22 Nov 2019 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419812;
        bh=W6Cv9nYKuyieexMWJNDnH/JK4Gkfrg+rFkLPx5ydw7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQpYgpxWBYbZnqpWBOXX+4B0Tu+7M/MmDBI3RoJVR0hhywsjDx2G5cQPhRxdeyDaS
         cCSCgw/wrw080LCAiRUdjEPuClnpLCZsenthV9oCJ5Jul6CbN3kcK3KmmulJEwPoNj
         p0+y9MqGO3ENOU4mw2jwAawBk3YxwjmI/Q2WOcD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 018/122] IB/hfi1: Ensure ucast_dlid access doesnt exceed bounds
Date:   Fri, 22 Nov 2019 11:27:51 +0100
Message-Id: <20191122100735.333707874@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Dalessandro <dennis.dalessandro@intel.com>

[ Upstream commit 3144533bf667c8e53bb20656b78295960073e57b ]

The dlid assignment made by looking into the u_ucast_dlid array does not
do an explicit check for the size of the array. The code path to arrive at
def_port, the index value is long and complicated so its best to just have
an explicit check here.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
index a72278e9cd274..9c8ddaaa6fbbf 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
@@ -351,7 +351,8 @@ static uint32_t opa_vnic_get_dlid(struct opa_vnic_adapter *adapter,
 			if (unlikely(!dlid))
 				v_warn("Null dlid in MAC address\n");
 		} else if (def_port != OPA_VNIC_INVALID_PORT) {
-			dlid = info->vesw.u_ucast_dlid[def_port];
+			if (def_port < OPA_VESW_MAX_NUM_DEF_PORT)
+				dlid = info->vesw.u_ucast_dlid[def_port];
 		}
 	}
 
-- 
2.20.1



