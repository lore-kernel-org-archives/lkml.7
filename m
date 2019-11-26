Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D81C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01352206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKZIs3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:48:29 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:38080 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbfKZIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:48:28 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xAQ8kiPO006450
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Nov 2019 16:46:44 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.88) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 26 Nov 2019 16:46:48
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 0/3] Add Unisoc's SC9863A support
Date:   Tue, 26 Nov 2019 16:46:41 +0800
Message-ID: <20191126084644.17207-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.88]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com xAQ8kiPO006450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about it on the website: http://www.unisoc.com/sc9863a

Changes from v2:
* Discard some dt-bindings patches which have been applied by Rob Herring.
* Added a new dt-binding file for sprd global-regs, also added a vendor directory for sprd.
* Moved sprd.yaml to the vendor directory.
* Addressed comments from Rob:
- fixed dtbs_check errors;
- move gic under to the bus node;
- removed msi-controller from gic, sinceSC9863A doesn't provide ITS;
- added specific compatible string for syscon nodes;
- cut down registers range of syscon nodes;
- removed unnecessary property "sprd,sc-id";
- added earlycon support in devicetree.

Changes from v1:
- Convert DT bindings to json-schema.

Chunyan Zhang (3):
  dt-bindings: arm: sprd: add global registers bindings
  dt-bindings: arm: move sprd board file to vendor directory
  arm64: dts: Add Unisoc's SC9863A SoC support

 .../bindings/arm/sprd/global-regs.yaml        |  34 ++
 .../bindings/arm/{ => sprd}/sprd.yaml         |   0
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         | 526 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         | 148 +++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  39 ++
 6 files changed, 749 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd/global-regs.yaml
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (100%)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

--
2.20.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
