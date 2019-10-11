Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBAC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89130214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD2AppS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfJKFwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:52:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46033 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:52:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so3936681pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tekSgsGuy1fdkhbY2/YHSwUbdUzMIOOOe19bzI/3Gw=;
        b=MD2AppS7dJSr7wAUqTZ+e0XpyMhGWv7bSlSK0PbguEEyDwcyYNjfeWPCFG7zgyXW3r
         hRZNj2+Pr+LdyYUWZQ+891v1c4LducXp3HciwOLgv17aND53S0sB/6VAMy19bN9iM3kq
         HT2Rvl+vQRoHY2QlC8w+AZWndz8X0GLcIIRvRHHlaNb6lswgVS8m8dZ4J4ktIvsnjsm2
         b9a8Yog+ag292LE0lMYG0m4506UaAL0OUKDbz9cuomQe2ZZgQ+dKLRMpEhqL1tIrCZcs
         GTLfreUlqfDqsm1oEeMm0BjmfRQ0DKGhQWqqTKzZOBaG/Kz+y6bm+gpMS6xGCS0uvO/M
         V10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tekSgsGuy1fdkhbY2/YHSwUbdUzMIOOOe19bzI/3Gw=;
        b=cA6NqtSIlxLPwYwvbJReF/PxFeMuGPkH0yPI9fTlkaxz9eKXJqKP2UhsNEX9UjpZh8
         1m4fgCFSsi0m92PiL/iD8q9WGTJCC47hHkF23rZrn/yVIufl1gWhW8b4Uz52xpOIQ4Hs
         zmavIzAYgn8Wtf//E+yeDagcVemf58NRPk+Gru76j2RZRiBZwGFJVFIZnoXpYyMg3QV3
         BzMGKCGALItTNoyCpKis9m4ZK9WuciHjaET5f5i5zRFF9bmx5zP+bINyXwdg1RypMf8J
         SkOVuno8aKVnZC5ov78e05GHStfyNSS5PKsjVo6L4BLfzGI4/IzCsw2GI3IGRhOvpwkj
         wB1g==
X-Gm-Message-State: APjAAAVFqWUu8uen9uzjvuqIMfZDTuvtvzs2Wbfjws4Bf/Enm+fC9Ds+
        tRLd20cG4xUMgmk+O8+zXQrCcur9TYvFaA==
X-Google-Smtp-Source: APXvYqwUyqJsLZQcNBU6/sK5svCQcUWSY36wp0/xdySy/dv4We5qiDUmWS3DJieUBpVy8OCdeOrUhA==
X-Received: by 2002:a63:d151:: with SMTP id c17mr2814629pgj.423.1570773127245;
        Thu, 10 Oct 2019 22:52:07 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id i184sm10257782pge.5.2019.10.10.22.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:52:06 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, michael.scheiderer@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] KPC2000: kpc2000_spi.c: Fix style issues (missing blank line)
Date:   Thu, 10 Oct 2019 22:51:52 -0700
Message-Id: <20191011055155.4985-2-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011055155.4985-1-chandra627@gmail.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 81d79b116ce0..d1f7360cd179 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -50,6 +50,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
-- 
2.20.1

