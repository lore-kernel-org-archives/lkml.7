Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1F820854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nnVtm/8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCSDTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:19:51 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:46916 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCSDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:19:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id E115CBA3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S6GUL1HcdxTP for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 22:19:48 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id AAF7BB8A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:19:48 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id r136so16315653ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fHMSauccrIJ9HihNDOavw9LAVGK09QKXxKSO/H0MbjE=;
        b=nnVtm/8MN7bK1K66rhuZ624aJBIK8T50Z2c/ARXOugIpTiH6hl+Z87hhFe5Ak0l0DI
         fbBhh7o18k3HQ80Rv87c+OIxwHB1I+yL6sJ/khrCB302jQREZBN/gSibY8vMUtsN4U7w
         FfMSo9m28zmzzyGl2CSSLX5SitSDbRQLxruAsuO3Ro44HlXUhoZ/zuzrf3Nc+vsjxlFy
         x8YZXCjb2cSyaMOoGV8t1WjNKJsAwfnSaLFITDwhMkCNC08b03doZXoUyve1Wx7qmB1h
         P3+wKpzDDwO11QbkrRSzHjUIWfxiZ2d+JxlG94mI7kavc09LHeSUei7Osh3wCT7mZ42u
         gqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fHMSauccrIJ9HihNDOavw9LAVGK09QKXxKSO/H0MbjE=;
        b=kKiTp+2dK7NvprrMXp0x8qeDcHaWAaklt1h9T/qOg9kxCEWQmEJjqjjrqVplep2qNn
         lg0uX3JPdw3UhCEawD9hEzfXGDV2EfIeS/U57FveqmTB4K3P9yHMcXHWmx2Rpns7BHqS
         6nXzy3uuKy/x9h5JQjKvTpZMA/Zzp0f68mSW3WE5DtMaB1kZJgvfHJ1LP3mkdtIYQCB7
         wjrC2J3MJ13K6X2Y4wE6htBvgJ0sAMhf2FrY1lari+Y1mRhwQJGy8/SddlSL0HDALE88
         BSCESGcd9cIQ6yVSTtjqtlOPQDZupSgGVbIX1t4MLSDfD7GGYSPijdDOfFEXGoow9aUA
         IsnQ==
X-Gm-Message-State: APjAAAUvXTvp6HJugA1py3EGHlLYbhSKQqxOSg0qFG8PS46UYhliN46Y
        vUFeF0bzUyFPjiBt+mJS4Ir+WQMvOJOMw9B6S0UqtCvv9Lfw2ajkb+phCCGGg1Y60XWOC5OyJyL
        4UD2FyeAYYindTCCDzHx7WG/3W4TS
X-Received: by 2002:a02:b703:: with SMTP id g3mr137939jam.106.1552965588332;
        Mon, 18 Mar 2019 20:19:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzeoP/kvrNPPv201hX0xDPECjhwxZLnNlLFv8wbsnFiAV5IMiJ8QiU35yw/YyQCLM2CyVLyA==
X-Received: by 2002:a02:b703:: with SMTP id g3mr137934jam.106.1552965588156;
        Mon, 18 Mar 2019 20:19:48 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id 202sm940459itl.1.2019.03.18.20.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:19:47 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: Fix to check for kmemdup failure
Date:   Mon, 18 Mar 2019 22:19:44 -0500
Message-Id: <20190319031944.18984-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of kmemdup failure while setting the service name the patch
returns -ENOMEM upstream for processing.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/nfc/llcp_sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index ae296273ce3d..17dcd0b5eb32 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -726,6 +726,10 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	llcp_sock->service_name = kmemdup(addr->service_name,
 					  llcp_sock->service_name_len,
 					  GFP_KERNEL);
+	if (!llcp_sock->service_name) {
+		ret = -ENOMEM;
+		goto sock_llcp_release;
+	}
 
 	nfc_llcp_sock_link(&local->connecting_sockets, sk);
 
@@ -745,10 +749,11 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	return ret;
 
 sock_unlink:
-	nfc_llcp_put_ssap(local, llcp_sock->ssap);
-
 	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 
+sock_llcp_release:
+	nfc_llcp_put_ssap(local, llcp_sock->ssap);
+
 put_dev:
 	nfc_put_device(dev);
 
-- 
2.17.1

