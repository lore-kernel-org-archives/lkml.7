Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE48C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC9620748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FJS0TtmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKRL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:26:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKRLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so19019380wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KU/n1Q/VNXJbWwIQys/qt9rGcT4PXz5RLqrj6x2UwvM=;
        b=FJS0TtmG/jIPVNlEvRYNbHS7KlZCHuGz6CUPsWvUt1QV6oHtM21RxQlxfjjBNlVeW+
         XeTw6nbrzgWNykF2salXwrDKTSCLvLfTf19GDNCrQUWPyXXDvcPqm7WFxyV3CelgJzT8
         PdtJal2sRKC1JwBaMf1O9plmceT42dddG2qeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KU/n1Q/VNXJbWwIQys/qt9rGcT4PXz5RLqrj6x2UwvM=;
        b=GvEdlDtItSuYNOVvaUKx4vdMFwUy4j2npczalvjE3SGqF/IkdbPiDXG9yAZy6IOc42
         q9sHrQAdacdaT7isEtHn7CCK7ZhhdNAbWgzsj23HS+BubawBO7/4sHQWNF/VkLwwNHRY
         kV6rjhfpjtulRcNCHxTDSF3C5646dIf5hw/S0UduAzxjlr6wjIznovXvTXpCE4VgWTgv
         M3xJ0a4fTj4zNy9rXQF+OUW0xDw1CRKZGk0LTeMhL8BAYbelsreCJHd5QaQ+V+1vRjle
         iUP94qdxMpasAvZYrKvaWKnRYAXMmJ4si9CMzS7QOeicGEQbBy8B23MQrjXI6BtZt8HV
         6wgw==
X-Gm-Message-State: APjAAAX56ZtpH/XpIYYaRAFTXgfxqrE4wMjCtPgdR0sfePOw9h1suD4a
        zkIcIy3UiL0LZpU4d+V6rBsgYg==
X-Google-Smtp-Source: APXvYqyPQm+B81w16dT5qlbUrmwgSz4DU30stL8NFxzi/qes8PdjwUM+cBepFJ8SjYpTgHgVXnBf+A==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr20474114wrv.367.1574076219455;
        Mon, 18 Nov 2019 03:23:39 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:39 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 07/48] soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
Date:   Mon, 18 Nov 2019 12:22:43 +0100
Message-Id: <20191118112324.22725-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e5c5c8d23fef (soc/fsl/qe: only apply QE_General4 workaround on
affected SoCs) introduced use of pvr_version_is(), saying

    The QE_General4 workaround is only valid for the MPC832x and MPC836x
    SoCs. The other SoCs that embed a QUICC engine are not affected by this
    hardware bug and thus can use the computed divisors (this was
    successfully tested on the T1040).

I'm reading the above as saying that the errata does not apply to the
ARM-based SOCs with QUICC engine. In any case, use of pvr_version_is()
must be guarded by CONFIG_PPC32 before we can remove the PPC32
dependency from CONFIG_QUICC_ENGINE, so introduce qe_general4_errata()
to keep the necessary #ifdeffery localized to a trivial helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 85737e6f5b62..1d8aa62c7ddf 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -197,6 +197,14 @@ EXPORT_SYMBOL(qe_get_brg_clk);
 #define PVR_VER_836x	0x8083
 #define PVR_VER_832x	0x8084
 
+static bool qe_general4_errata(void)
+{
+#ifdef CONFIG_PPC32
+	return pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x);
+#endif
+	return false;
+}
+
 /* Program the BRG to the given sampling rate and multiplier
  *
  * @brg: the BRG, QE_BRG1 - QE_BRG16
@@ -223,7 +231,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	/* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
 	   that the BRG divisor must be even if you're not using divide-by-16
 	   mode. */
-	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
+	if (qe_general4_errata())
 		if (!div16 && (divisor & 1) && (divisor > 3))
 			divisor++;
 
-- 
2.23.0

