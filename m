Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA161C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B937221D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnQTlfoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfJDUYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:24:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33240 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbfJDUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:24:51 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so16402861ior.0;
        Fri, 04 Oct 2019 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F3ySIZ4/duEVfH7DHFr2m0McTeZBYhdVN68XE7r/04k=;
        b=KnQTlfoi+UGI7MPzvLsZInxJPu/o1h+/zbDDErvXrnBlbkoc8qI/OmWbIELnaifbEL
         6dXxE5bEfmGPQ+yO6kxK4ygTAKPZ0LPVX/eimEhd5mKxwsBDo0zTm6NxZE5kuhcCWvA8
         4Dpz5++J/kHQArKlxL7DY1YYjzRu/cMcABCUcIpXqTDJ/oXx33i9YNsj1bHLWBogEqLL
         UT8OEQWNQzcSnVTTAUcK2LJGjastLt1KIXjm2r5ogk1q4MxDZYjQPQgas/rYSW7xIDen
         FUS0izzKXndjLe3/18tpFr9pBI06i0/Qvpq/jQCL1f1sh4n7r3ap8qSRuHOu33OSfwG2
         ykKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F3ySIZ4/duEVfH7DHFr2m0McTeZBYhdVN68XE7r/04k=;
        b=Z4lWzW6UVR7cWRAUL/9SOPIpTdyr54nZs6+kcUQMGDsSr6xeTkVttNs9KDFrge7Jrr
         W88+GHMhQW+Mze+2okyF3ScE13jdTpBuZtVDS2We5qTLBYAOMyXCa1PGJu+h2RAr1qqW
         2XV6Rp/nbtpiph2hMlt01p4J11M02Qlnup6ZpOsFJ1anG7iGwWZq8asdRhbTBwGZXB5k
         LBk4n6yshZeoCJ6g+EOGZ+Gnj+XVZJ2tzZKy6Q5s1x5Ut5vd2+iC2eXIJdqvxHocRhoz
         PK1RROmxUBm8lEuSnUalaButFXKScxzEzNI0FrlaWo9SaSVmFatr+L+Si8iF441lGt0S
         g9Kw==
X-Gm-Message-State: APjAAAU+K/v52NPKyCD4FnU6a8id0Zruj8m2tb3fwXkP2eqp8GOZEYIw
        YYphe8aCZN7wa2OzTbsbrR0=
X-Google-Smtp-Source: APXvYqyo4DTpoBRn0UM4Zw0eMOmE4CkhPt+zUC4pUNGSkBalFQCKCMafvxnhifdvFv8yKca0/ETfgw==
X-Received: by 2002:a92:5f13:: with SMTP id t19mr18012641ilb.163.1570220689419;
        Fri, 04 Oct 2019 13:24:49 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r22sm4044093ilb.85.2019.10.04.13.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:24:48 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qlogic: Fix memory leak in ql_alloc_large_buffers
Date:   Fri,  4 Oct 2019 15:24:39 -0500
Message-Id: <20191004202440.26100-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ql_alloc_large_buffers, a new skb is allocated via netdev_alloc_skb.
This skb should be released if pci_dma_mapping_error fails.

Fixes: 0f8ab89e825f ("qla3xxx: Check return code from pci_map_single() in ql_release_to_lrg_buf_free_list(), ql_populate_free_queue(), ql_alloc_large_buffers(), and ql3xxx_send()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 457444894d80..b4b8ba00ee01 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -2787,6 +2787,7 @@ static int ql_alloc_large_buffers(struct ql3_adapter *qdev)
 				netdev_err(qdev->ndev,
 					   "PCI mapping failed with error: %d\n",
 					   err);
+				dev_kfree_skb_irq(skb);
 				ql_free_large_buffers(qdev);
 				return -ENOMEM;
 			}
-- 
2.17.1

