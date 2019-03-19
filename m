Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8B12146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dcvnkaxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCSSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:38:39 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:60276 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfCSSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:38:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D5228707
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sx5Pa72Whr_N for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 13:38:37 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id A1FE965C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:38:37 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id p17so16875114ios.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I6qRup8VMPuct1r1QJUlHwRd45kwJLJuSXVIrTNz1B0=;
        b=dcvnkaxbmJPEPFpty5Xz1NhbtHEXkYx6wV2NFy46yZkxoMQuC7pWi9uViUWTSB7vSf
         L7chlqodKtAGNLrDKxTztsNm6YWjnKN4N95anxBzQA0iKGmUJFiESD8uh4BwGAUTLvJh
         XMpT8sqdCPtWsJ+++5jj2Kzz8dFNG4dPMOO/OEH7spTJEFicl3enhARNcjukDUsg+hLd
         E23qJFrf1Pr8rvxyrYgvjTVbp0tiaFGU6AMVVITUARqRsBSxjE6wg98jRQk/JNJfOoes
         KlECP/v/jDMAgnvT9QkRvgem6y6xI/A5ZYq3Ew8e9cbqA4y9OwZoFkf2zyB7R8bAvKbl
         6Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I6qRup8VMPuct1r1QJUlHwRd45kwJLJuSXVIrTNz1B0=;
        b=FQWfeRjsn0f+AdA3RgHqXCd/ExrBMfhcJfHkNJokq2zD7DDxuJxQtbI6bwczIbwjjn
         1SAV9gbS3ltEN/7BGLJAReydCDfE3wubqzPfNINGHPz6p9ma6VAOrQX6bAH2nO3Eoa8b
         GoGG8nAMH/2PUvQdfC9ry1tWzvhUJIc+BwL/xeI5xrjt4j9RnEmB+ushDFt3GosikDrn
         IB6UMurIx38WywxDMQmHnH59Q45XheEFvx2svGK/zgngk8YRynzP9ubU129Lbo4n91Zg
         wbDrYw/sjZ50pst51jxt61R8pOWXMccob8ElX38JvTPZUmZgetvoZe2gq4TKtyG1FsAw
         MtTw==
X-Gm-Message-State: APjAAAV46zKnERHeTSm1Nv6uFBCdcwXCzjIBq7+b+A0OJKVSg8pk8QBk
        x/9OeQtssN0TpXLNXa7JuRO63ovpVM8suaFtfxe9pPPyvvhx6WI96EGgghrhW3SDbqFOvmQEfn1
        Sxy1kZPqyUH114EC5qYITEnI4hJ1H
X-Received: by 2002:a6b:e317:: with SMTP id u23mr2393802ioc.206.1553020717319;
        Tue, 19 Mar 2019 11:38:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyanw6flQJSQvz4oz4Jb+6T4oWb+tybh90WMO4DV8uC/BI6jCrzkemopeETWskc0vQakimiZw==
X-Received: by 2002:a6b:e317:: with SMTP id u23mr2393791ioc.206.1553020717166;
        Tue, 19 Mar 2019 11:38:37 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d184sm1847400itc.17.2019.03.19.11.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 11:38:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix to check the return value of kmemdup
Date:   Tue, 19 Mar 2019 13:38:34 -0500
Message-Id: <20190319183834.14503-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uuid in add_switch is allocted via kmemdup which can fail. The patch
logs the error in such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/thunderbolt/icm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af682..8df8057cd79e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -473,6 +473,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	WARN_ONCE(!sw->uuid, "%s: sw->uuid = NULL", __func__);
 	sw->connection_id = connection_id;
 	sw->connection_key = connection_key;
 	sw->link = link;
-- 
2.17.1

