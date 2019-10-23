Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51875CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303AE21925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405882AbfJWN14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:27:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405872AbfJWN1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:27:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 339D1C4DD676861ED316;
        Wed, 23 Oct 2019 21:27:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:27:38 +0800
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] audit: remove redundant condition check in kauditd_thread()
Message-ID: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
Date:   Wed, 23 Oct 2019 21:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning is found by the code analysis tool:
  "the condition 'if(ac && rc < 0)' is redundant: ac"

The @ac variable has been checked before. It can't be a null pointer
here, so remove the redundant condition check.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..193f3a1f4425 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -830,7 +830,7 @@ static int kauditd_thread(void *dummy)
 		rc = kauditd_send_queue(sk, portid,
 					&audit_hold_queue, UNICAST_RETRIES,
 					NULL, kauditd_rehold_skb);
-		if (ac && rc < 0) {
+		if (rc < 0) {
 			sk = NULL;
 			auditd_reset(ac);
 			goto main_queue;
@@ -840,7 +840,7 @@ static int kauditd_thread(void *dummy)
 		rc = kauditd_send_queue(sk, portid,
 					&audit_retry_queue, UNICAST_RETRIES,
 					NULL, kauditd_hold_skb);
-		if (ac && rc < 0) {
+		if (rc < 0) {
 			sk = NULL;
 			auditd_reset(ac);
 			goto main_queue;
-- 
2.7.4.3

