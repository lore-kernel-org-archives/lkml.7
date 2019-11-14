Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90827C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED0206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:23:29 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:21092 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbfKNMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:23:27 -0500
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id xAEBnZKr019497;
        Thu, 14 Nov 2019 19:49:35 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAEBlhnU017628
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 14 Nov 2019 19:47:43 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 14 Nov 2019 19:47:47
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <steven.tang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 0/2] Add syscon name and #cells support
Date:   Thu, 14 Nov 2019 19:45:23 +0800
Message-ID: <20191114114525.12675-1-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAEBlhnU017628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Our SoCs have a lot of glabal registers which is hard to be managed in 
current syscon structure.

Same register's offset is different in different SoCs. We used chip
config macro to manage them which prevents driver to be compiled in
all-in-one image.

After talking with Arnd and Rob at Linaro Connect 2017, I got the
idea to extend syscon with #cells support. And furthe, I added syscon
names support to help access multiple syscon nodes more easier.

These patches has been tested in our internal tree about 2 years.

They have no side effect to current syscon consumer.

Thanks,
Orson

--------------------
Orson Zhai (2):
  dt-bindings: Add syscon-names support
  mfd: syscon: Add syscon-names and phandle args support

 .../devicetree/bindings/mfd/syscon.txt        | 36 ++++++++++
 drivers/mfd/syscon.c                          | 65 +++++++++++++++++++
 include/linux/mfd/syscon.h                    | 22 +++++++
 3 files changed, 123 insertions(+)

-- 
2.18.0


