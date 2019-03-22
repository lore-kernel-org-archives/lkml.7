Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7E920657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253986;
	bh=6zZXyh6ObCwwl4V2tIiGwrv1BdjEWUmH4N4hUXbou3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzIk5RmySibX/s0FNY4yAlm3Mk/wpLZ3CKj1oYeiyKGZKXLErKbsKmOLhizw6+Ljj
	 SNH9cHTxPR5Yq0Fl4kSDjuWadgkZwnc1lzpQfjxweenCc57T6O2IQGyuR37FSBCNJc
	 rtXA8ZamhoMK3nlHwVblmdYT++iZphEKzb7ymhVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfCVL0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfCVL0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D2E20657;
        Fri, 22 Mar 2019 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253974;
        bh=6zZXyh6ObCwwl4V2tIiGwrv1BdjEWUmH4N4hUXbou3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxSqqDl8NSQymZwUvZ62vfnG5Iwnnn9d9CPJzRM1klfnfItgO6xp4b00jnV5Pp33T
         5ArgZCQSxniZDuZKZ5Ywv5atrtON6r01GDM26d9AxwRGAmzXxMQoeYmicdPNwZ4r3b
         tBaZwBqNPvmJTW5jJV5OQFBqIDKs2sCDupPMBMNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3.18 128/134] ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
Date:   Fri, 22 Mar 2019 12:15:41 +0100
Message-Id: <20190322111219.755765860@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


