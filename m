Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E639E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254082;
	bh=Uob69VCzih5ZrMqeTpFr+J+cOWI20p9KSwr+UUTVWDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iiPRor6TfXQbMAWA9y5ldNZElW9ImNzpAjnvIzsLDP7dj9JRnN5L0sgTDSPDr5ICX
	 G62g49qZgUwBSIhnNYViKaMQlZV8qaEvn/tnPDwX+NDs8FARU6ks6sjm6+vT8icSqR
	 O9D9ZG2wXud3CfqNt3BOS5env0irPmrPO/Yu5rwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfCVL2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbfCVL15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63092183E;
        Fri, 22 Mar 2019 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254077;
        bh=Uob69VCzih5ZrMqeTpFr+J+cOWI20p9KSwr+UUTVWDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpvB/ujraVu9kUMf0wTTqHpQHYZ8+1eLOcAgthYU8giixFrLH4aCGAT168EKKKqud
         QEvEfCzYKwsGEBQD5RUeKlqt2XS8tlJv636RWJULIlG1F+9Nu+5ptOq2SuKl8utTTr
         8rFUruypW4WPwDCxrChqUqiW9peKV0AvOnWkvdpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 009/230] mfd: wm5110: Add missing ASRC rate register
Date:   Fri, 22 Mar 2019 12:12:27 +0100
Message-Id: <20190322111237.400626637@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 04c801c18ded421845324255e660147a6f58dcd6 ]

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wm5110-tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 2bb2d0467a92d..c47efe6dcb01b 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -1622,6 +1622,7 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000ECD, 0x0000 },    /* R3789  - HPLPF4_2 */
 	{ 0x00000EE0, 0x0000 },    /* R3808  - ASRC_ENABLE */
 	{ 0x00000EE2, 0x0000 },    /* R3810  - ASRC_RATE1 */
+	{ 0x00000EE3, 0x4000 },    /* R3811  - ASRC_RATE2 */
 	{ 0x00000EF0, 0x0000 },    /* R3824  - ISRC 1 CTRL 1 */
 	{ 0x00000EF1, 0x0000 },    /* R3825  - ISRC 1 CTRL 2 */
 	{ 0x00000EF2, 0x0000 },    /* R3826  - ISRC 1 CTRL 3 */
@@ -2877,6 +2878,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_ASRC_ENABLE:
 	case ARIZONA_ASRC_STATUS:
 	case ARIZONA_ASRC_RATE1:
+	case ARIZONA_ASRC_RATE2:
 	case ARIZONA_ISRC_1_CTRL_1:
 	case ARIZONA_ISRC_1_CTRL_2:
 	case ARIZONA_ISRC_1_CTRL_3:
-- 
2.19.1



