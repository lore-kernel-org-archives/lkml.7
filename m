Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D440320692
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfKTPqd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:33 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:21657 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732410AbfKTPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:37 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xAKFheDl093128
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Nov 2019 23:43:40 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 20 Nov 2019 23:43:47
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kevin.tang@unisoc.com>, <baolin.wang@unisoc.com>,
        <chunyan.zhang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to syscon easily
Date:   Wed, 20 Nov 2019 23:41:47 +0800
Message-ID: <20191120154148.22067-2-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191120154148.22067-1-orson.zhai@unisoc.com>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xAKFheDl093128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make life easier when syscon consumer want to access multiple syscon
nodes with dozens of items.
Add syscon-names and relative properties to help to manage different
cases when accessing more than one syscon node even with arguments.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 .../devicetree/bindings/mfd/syscon.txt        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index 25d9e9c2fd53..4c7bdb74bb0a 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -30,3 +30,46 @@ hwlock1: hwspinlock@40500000 {
        reg = <0x40500000 0x1000>;
        #hwlock-cells = <1>;
 };
+
+
+
+==Syscon Name==
+
+Syscon name is a helper to be used in consumer nodes who refer to system
+controller node. It provides a way to refer to syscon node by names with
+phandle args in syscon consumer node. It will help people who have a lot
+of syscon references to be managed. It is not a must feature and has no
+effect to syscon node itself at all.
+
+Required properties:
+- syscons: List of phandles and any number of arguments if needed. Arguments
+  is specific to differnet vendors and its usage should be described at each
+  vendor's bindings. For example: In Unisoc SoCs, the 1st arg will be treated
+  as register address offset and the 2nd is bit mask.
+
+- syscon-names:        List of syscon node name strings sorted in the same order as
+  what it represents in property syscons.
+
+Optional property:
+- #.*-cells: Represents the number of arguments in single phandle in syscons
+  list. ".*" is vendor specific. If this property is not set, default value
+  will be 0.
+
+Examples:
+
+apb_regs: syscon@20008000 {
+       compatible = "sprd,apb-glb", "syscon";
+       reg = <0x20008000 0x100>;
+};
+
+aon_regs: syscon@40008000 {
+       compatible = "sprd,aon-glb", "syscon";
+       reg = <0x40008000 0x100>;
+};
+
+display@40500000 {
+       ...
+       #syscon-disp-cells = <2>;
+       syscons = <&ap_apb_regs 0x4 0xf00>, <&aon_regs 0x8 0x7>;
+       syscon-names = "enable", "power";
+};
--
2.18.0

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
