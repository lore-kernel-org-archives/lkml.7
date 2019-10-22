Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A325FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbfJVLsD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:48:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2489 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387973AbfJVLsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:48:03 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 6AF7EABB2C0A136A3B6A;
        Tue, 22 Oct 2019 19:48:00 +0800 (CST)
Received: from dggeme761-chm.china.huawei.com (10.3.19.107) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 22 Oct 2019 19:48:00 +0800
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggeme761-chm.china.huawei.com (10.3.19.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 22 Oct 2019 19:47:59 +0800
Received: from dggeme762-chm.china.huawei.com ([10.8.68.53]) by
 dggeme762-chm.china.huawei.com ([10.8.68.53]) with mapi id 15.01.1713.004;
 Tue, 22 Oct 2019 19:47:59 +0800
From:   linfeilong <linfeilong@huawei.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts: fix memleak error in read_file
Thread-Topic: [PATCH] scripts: fix memleak error in read_file
Thread-Index: AdWIy2TaZdJlKP2sR+evaSWkQsNSfg==
Date:   Tue, 22 Oct 2019 11:47:59 +0000
Message-ID: <bf5c73b4b8534189be0f0df81fe863f0@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error is found by the static code analysis tool: "memleak"
Fix this by add free before return.

Signed-off-by: Feilong Lin <linfeilong@huawei.com>
---
 scripts/insert-sys-cert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836..22d99a8 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -250,6 +250,7 @@ static char *read_file(char *file_name, int *size)
 	}
 	if (read(fd, buf, *size) != *size) {
 		perror("File read failed");
+		free(buf);
 		close(fd);
 		return NULL;
 	}
-- 
1.8.3.1
