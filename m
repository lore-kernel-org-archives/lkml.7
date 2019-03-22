Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26699C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA551218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255085;
	bh=IDhXuNHHtMWNL7duP0Bmwecayz+wm44k+qIbqLL1r0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhD5wVyLb8S/AemL5DdXfleU7QkjSkFQ3iKK9JR7sBslAAgiUnuHhSDA/TA04qI7l
	 4efxnhDeQS03ZXJQnTL8D7J+DYGG3NyAQoa+waUR+2kLOkQxraT3UoPRHutreJQ/Eb
	 QlOLZviSpyAr2qDmFpMuztd41GW0E0VseCuwsy50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfCVLon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731836AbfCVLok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:44:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77D62082C;
        Fri, 22 Mar 2019 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255079;
        bh=IDhXuNHHtMWNL7duP0Bmwecayz+wm44k+qIbqLL1r0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwm/AW/YH8oc6uw7nXJcs4xLJhnMbxVwzHPjnSWGGproaECURoKfe4Tx4mrxTcIps
         xZ+ApN0fMgigD8jQsJKOVyBq94ry+chfT+3KFbq+6dbhyiETfpCv2xOTTEiZd7QYi4
         PW5C8Fgnm3DOb8TZTontIlGMCdsQkvG15prMk5T4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.9 099/118] ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
Date:   Fri, 22 Mar 2019 12:16:11 +0100
Message-Id: <20190322111223.401213152@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit e2477233145f2156434afb799583bccd878f3e9f upstream.

Fix boolean expressions by using logical AND operator '&&' instead of
bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
[krzk: Fix -Wparentheses warning]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -70,16 +70,16 @@ static int osiris_dvs_notify(struct noti
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if ((old_dvs && !new_dvs) ||
+		    (cur_dvs && !new_dvs)) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if ((!old_dvs && new_dvs) ||
+		    (!cur_dvs && new_dvs)) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);


