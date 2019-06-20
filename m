Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45A72082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054394;
	bh=XSmt2kupemjqB1GXrcptmo3Q9SLtuR3ACvyPs23UnSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjIWY/OuCF2xOAv6G7bSuM1PwxcqmACX5T/MV7REdhv2gEf5aj2BAgmx/kkl00iPC
	 ZTqr6WkqCFWxMcGz4bf3rU6ITe2Ty3pG/5aXfdClsoc4Sg++7pr8aZHSPk70VQDDjR
	 EYFWec9k6qRF0CqoGDBvGZxcP5PjFozIniWPBcrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfFTSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfFTSNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08396205F4;
        Thu, 20 Jun 2019 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054386;
        bh=XSmt2kupemjqB1GXrcptmo3Q9SLtuR3ACvyPs23UnSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slbr1RpDYoE18+S01DISYibGpDHMryGNT0xJnQz39AMSm7GOyPIAyHgUWWN9P6TnY
         z1uU8X0I2WiCTQnezUcOYZFJhD6fGIRkj+Ji7x4BXFpxm4obhwpP1hQEX6r8XT3Ayn
         RZLAGWXxrPMJRGOlfz0IQ6Mmk0kvGTHTI/GGGbxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <92siuyang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 11/98] nfc: Ensure presence of required attributes in the deactivate_target handler
Date:   Thu, 20 Jun 2019 19:56:38 +0200
Message-Id: <20190620174349.861479740@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>

[ Upstream commit 385097a3675749cbc9e97c085c0e5dfe4269ca51 ]

Check that the NFC_ATTR_TARGET_INDEX attributes (in addition to
NFC_ATTR_DEVICE_INDEX) are provided by the netlink client prior to
accessing them. This prevents potential unhandled NULL pointer dereference
exceptions which can be triggered by malicious user-mode programs,
if they omit one or both of these attributes.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -922,7 +922,8 @@ static int nfc_genl_deactivate_target(st
 	u32 device_idx, target_idx;
 	int rc;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
+	    !info->attrs[NFC_ATTR_TARGET_INDEX])
 		return -EINVAL;
 
 	device_idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);


