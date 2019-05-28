Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F78C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0057D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="droyNunc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE1L47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:56:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45145 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1L47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:56:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so6186805pga.12;
        Tue, 28 May 2019 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y0nU1mnDjk5DEaEAqhn6A+e5w54A9UaAagHSxcoB+rI=;
        b=droyNuncHFCAXk2oz9b91V/DwkejmqPm50x4ZBfqch9PSfHoEpw76fBWY+hcNLkPNG
         cAs+EV160TX6U78yQ58egeBfws+a5Kl9Vi73WP8uPWje0+UdOI6CSy2I3oK4zn9m5OSm
         rp0CnbvZF13HQwXk6gfgGlzeSh0pPuBWAAV3SNBT+5GvDKiWKgcqdt4Hz5LnSSLoyozn
         OW+7OptgTqrxMQwKxrGvbDY3I21Ni6H4sSgK3k/aQj8atL5WEPs2ssJntXR7Dzo+klVf
         Y6u8YfVBM2PbMjmlw19zeQgjjs1qsSUV3vjPyGFZqmt0zX/WNp+EuY+je7xDsFPoAcfc
         1YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y0nU1mnDjk5DEaEAqhn6A+e5w54A9UaAagHSxcoB+rI=;
        b=k4erHXWSicV/QX2pyIoZjuFxE3p6932rlB3ec8wGcNfTHSaxnrVB5uk0ddkfcZTM2p
         Q13AAPIQJbA+A7QuoQobsU6pDsdTDnAwenP2XJHh9bIRdNSaKxfd9OLraysiB+VerZrq
         Qw0f+vf+XH/t4J4ofgSKWp4/zgDq4nPsq6MlQtPsKKmKEx/ITOhNVlyPcQtaoSgxS0qd
         5gseQSrN+N4MlmXrC/sJA4bJ97gaFvK9/JDmZ5MO94vJVbhrFkeI4SYNEyI19cWiC1oe
         dGMLc9JH1JoD4BoWkhos7oF+/wvPvUy8eAXlNsemjqP8LHtx9Lxso2y/Pn3wC7n5Dfpn
         zgHQ==
X-Gm-Message-State: APjAAAXqP8bhESgfq74nAbDlgMBY8ddN9hnN1Z69wNAU7DnbrygnB1xs
        hu1M+8CQY93rkuCugpq18UI=
X-Google-Smtp-Source: APXvYqx3Up2B1eZPaaTAWMBFlw4GilIcCB4OB4SrH4CoVtGbovwboWob5c34WdwFXy9KG22xN4xmnw==
X-Received: by 2002:a17:90a:9602:: with SMTP id v2mr5467175pjo.59.1559044618864;
        Tue, 28 May 2019 04:56:58 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id r1sm16272313pfg.65.2019.05.28.04.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 04:56:57 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     jeffrey.t.kirsher@intel.com, davem@davemloft.net,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] ixgbevf: fix possible divide by zero in ixgbevf_update_itr
Date:   Tue, 28 May 2019 19:58:02 +0800
Message-Id: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next call to ixgbevf_update_itr will continue to dynamically
update ITR.

Copy from commit bdbeefe8ea8c ("ixgbe: fix possible divide by zero in
ixgbe_update_itr")

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d189ed2..d2b41f9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1423,6 +1423,9 @@ static void ixgbevf_update_itr(struct ixgbevf_q_vector *q_vector,
 	 */
 	/* what was last interrupt timeslice? */
 	timepassed_us = q_vector->itr >> 2;
+	if (timepassed_us == 0)
+		return;
+
 	bytes_perint = bytes / timepassed_us; /* bytes/usec */
 
 	switch (itr_setting) {
-- 
2.7.4

