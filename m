Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D406EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2849206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="TPDi/Vcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLJGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:38:42 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16162 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfLJGim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:38:42 -0500
X-AuditID: 0a650161-773ff700000078a3-9f-5def53d9721c
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 13.51.30883.9D35FED5; Tue, 10 Dec 2019 16:14:17 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1575959926; h=from:subject:to:date:message-id;
        bh=hqoqQbi45Fb5Dj2x7IlQIGlYDPBJE9s/9LwxAYD7TQ8=;
        b=TPDi/VczfI3iJNTDv/sjBijmIuB8/d0bxksjICxeJhVnEDOe3BOR9975XvX0PvrDcwGCAZwCBdL
        EALRYPwYS2wjUBox2Rsjj1kFTEd2fl0fjG0gEMVJ6D9RP5hNelqBz0FgbJhfGogsqZpekrCUSu2fx
        rP9pJrf0n1pIqJPgDgY=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 10 Dec 2019 14:38:42 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH V2] lib/dynamic_debug: make better dynamic log output
Date:   Tue, 10 Dec 2019 14:38:20 +0800
Message-ID: <20191210063820.26766-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209094437.14866-1-sjhuang@iluvatar.ai>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXClcqYpnsz+H2swY71IhaTrx5gs5ix+Dir
        xeVdc9gcmD0mH1nA7HHr2VpWj8+b5AKYo7hsUlJzMstSi/TtErgypj26zF7wjb2ie9t39gbG
        nWxdjJwcEgImEnPm3mfsYuTiEBI4wSixfd1cRpAEs4CExMEXL5hBEiwCb5kkzt+9ygxR1cYk
        ceLFLmaQKjYBDYm5J+4C2RwcIgLiEu/nu0I0x0rM7doHViIs4CrRfGkdO4jNIqAqsfzQGxYQ
        m1fAQmLqfoi4hIC8xOoNB8DqOQUsJQ5dfcMEYgsB1VyYd4kZol5Q4uTMJywgq4QEFCRerNSC
        aFWSWLJ3FhOEXSjx/eVdlgmMQrOQvDALSfcCRqZVjPzFuel6mTmlZYkliUV6iZmbGCFBm7iD
        8UbnS71DjAIcjEo8vDtC38UKsSaWFVfmHmKU4GBWEuE93gYU4k1JrKxKLcqPLyrNSS0+xCjN
        waIkziv072mMkEB6YklqdmpqQWoRTJaJg1OqgWmp7/fAeWl8UXqCJTFbWw4aTJwl36iQ/clq
        +UPD7oVLfFZ02/27ZeY048nBys2qBeWP1/6oENkrsnTtoScL31potv94WnifTdNgz9lXW5IT
        2UXunmP26GE+ufbgjRc7ZvH2Tou7fNZHRKW8afaZer62SVLObzZpaC4qVn3waa7bQqO9n887
        6ddyrv+w8HpkGNfK+Wqq/spXjyr5aFzZojfX4+6E3cGL32s1H36aYV+1yvaek8pd27mWjNwb
        eAK+ZXaWnu5YdMrNs/6WRf08l9/2c09yrunKfdV9JWDt6oNuBZUp+vcT7ijdm/fTxFHwcXfh
        fd5bHGX/FM4me8ikpYkKSJ5rqt/vfE8zdpfgLH0lluKMREMt5qLiRAC7V/nF1wIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings and device name is not changed for the driver's dynamic
log output. But the dynamic_emit_prefix() which contains the function names
may change when the function names change.

So the patch makes the better dynamic log output.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v1 -- >v2
   Add a whitespace between driver strings and dev name.
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..f6665af6abd4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s: %pV",
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
-- 
2.17.1

