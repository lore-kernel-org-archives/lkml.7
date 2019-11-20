Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ADBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCAF20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfKTPpl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:45:41 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:21658 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732397AbfKTPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:36 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xAKFhcS0093125
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Nov 2019 23:43:38 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 20 Nov 2019 23:43:45
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kevin.tang@unisoc.com>, <baolin.wang@unisoc.com>,
        <chunyan.zhang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH V2 0/2] Add syscon name support
Date:   Wed, 20 Nov 2019 23:41:46 +0800
Message-ID: <20191120154148.22067-1-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xAKFhcS0093125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our SoCs have a lot of glabal registers which is hard to be managed in
current syscon structure.

Same register's offset is different in different SoCs. We used chip
config macro to manage them which prevents driver from being compiled
in all-in-one image.

So I add syscons, syscon-names and an optional #vendor-cells property
as syscon consumer node's bindings. And implement coresponding helper
functions.

They have no side effect to current syscon consumer.

Thanks,
Orson

Changes in V2:

As per suggestion from Arnd:

* Remove #syscon-cells from syscon node.
* Add "#vendor-cells" into consumer node not affecting referred syscon
  itself.
* Change helper funcions parameter accordingly.

-----
Orson Zhai (2):
  dt-bindings: syscon: Add syscon-names to refer to syscon easily
  mfd: syscon: Find syscon by names with arguments support

 .../devicetree/bindings/mfd/syscon.txt        | 43 +++++++++++
 drivers/mfd/syscon.c                          | 75 +++++++++++++++++++
 include/linux/mfd/syscon.h                    | 26 +++++++
 3 files changed, 144 insertions(+)

--
2.18.0

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
