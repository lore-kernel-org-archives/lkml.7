Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DA220656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MogJTY+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfDXJRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:17:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728520AbfDXJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9AKK1018404
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Wjeih4drKxvCXgraFNPv3LrPtimhzFKHZMw/UQDDo9g=;
 b=MogJTY+sxUi5Eixza1waPiWVNAgY9W50Ipk5t5x/0D1m7928+J0c4v6PCyYagX+WePbL
 rdORfdLL/dJAEVt2nqeQAmDpX4RgW9Uz0wOjuHcrvGxYHlN44ALd1ZWqKXZedmqkGyGR
 SEWTbVP0TvEVw4VHrdzn5ohFgcud6gEOfWw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2k8f8emq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:16:36 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 24 Apr 2019 02:16:35 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id AAAE013BA5DD3; Tue, 23 Apr 2019 14:20:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Date:   Tue, 23 Apr 2019 14:20:37 -0700
Message-ID: <20190423212037.1983760-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eth_addr_inc function in etherdevice.h to increment MAC address. One
of the use cases is in ncsi stack, where the host's MAC address needs to
be incremented to get BMC's MAC address.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 include/linux/etherdevice.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e2f3b21cd72a..d48e3a724c54 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -448,6 +448,19 @@ static inline void eth_addr_dec(u8 *addr)
 	u64_to_ether_addr(u, addr);
 }
 
+/**
+ * eth_addr_inc - Increment the given MAC address
+ *
+ * @addr: Pointer to a six-byte array containing Ethernet address to increment
+ */
+static inline void eth_addr_inc(u8 *addr)
+{
+	u64 u = ether_addr_to_u64(addr);
+
+	u++;
+	u64_to_ether_addr(u, addr);
+}
+
 /**
  * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
  * @dev: Pointer to a device structure
-- 
2.17.1

