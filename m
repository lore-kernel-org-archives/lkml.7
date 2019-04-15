Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B7C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355521;
	bh=n3YyooG6qZ6QxwIfPpFwm6tsMuahv2hnsb1KqnDfX44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYN/4LCHj96cL3ep07R2id07XU7gA6wYMo+dIcaiAtnZS8rQMkO+MejE0+e8x28m0
	 yPLArHNKd7wptMWdS/b3QX/ymeK4+fov/TiAZLF+C3jVsJ0YkpXeQlDHO/mguFXC3L
	 HOKHzSAQdpknvTvU8y9UOCa0IFqsYJGsTMjwgHuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfDOTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfDOTLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDD218FF;
        Mon, 15 Apr 2019 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355509;
        bh=n3YyooG6qZ6QxwIfPpFwm6tsMuahv2hnsb1KqnDfX44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpWuB9MswBlmBcJi9A4lE01+K54IjzV6KmWB6VvUAAcmuME5hCRjm63EQDnGGVt62
         QILtXOpKWXCqz4Hfmi88qdZMvVLSt3vIBXXFZVN8XPw5DCqRUxiZOFWzYXAB70YC0Q
         kcLdMrbuoHCxWAh8nyQ95L/9qCsAAVWsLuicPpZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.0 048/117] hwmon: (occ) Fix power sensor indexing
Date:   Mon, 15 Apr 2019 21:00:18 +0200
Message-Id: <20190415183747.437695436@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

commit 8e6af454117a51dbf6c8a47c00180a0c235052fe upstream.

In the case of power sensor version 0xA0, the sensor indexing overlapped
with the "caps" power sensors, resulting in probe failure and kernel
warnings. Fix this by specifying the next index for each power sensor
version.

Fixes: 54076cb3b5ff ("hwmon (occ): Add sensor attributes and register ...")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/occ/common.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -889,6 +889,8 @@ static int occ_setup_sensor_attrs(struct
 				s++;
 			}
 		}
+
+		s = (sensors->power.num_sensors * 4) + 1;
 	} else {
 		for (i = 0; i < sensors->power.num_sensors; ++i) {
 			s = i + 1;
@@ -917,11 +919,11 @@ static int occ_setup_sensor_attrs(struct
 						     show_power, NULL, 3, i);
 			attr++;
 		}
-	}
 
-	if (sensors->caps.num_sensors >= 1) {
 		s = sensors->power.num_sensors + 1;
+	}
 
+	if (sensors->caps.num_sensors >= 1) {
 		snprintf(attr->name, sizeof(attr->name), "power%d_label", s);
 		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
 					     0, 0);


