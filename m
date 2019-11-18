Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B222C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8E720748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BtVtcRzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfKRLZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:25:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33751 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfKRLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so19021124wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=BtVtcRzODZ8MQHGzYCVSDPVdMWLdRIEn5FSDxW2pv1/RNrvGTyDeG/pgWB86cSvaIv
         TNZNSFsrEdvVIiE/woLEJuWE8Lw+0gQ9MXrSekMCN9clwVZSZaJ+i5oBqoP2hIOTM4Dr
         AtwK+Z0xVzRVdRSAV1aHZtBvtqhp4cgkNfOQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=bOojg2t+EFwc/PrmSBkw9/48Ogr8htWu/VBFPeaznDShEVHac2J/FPqwlTGwd02ebg
         8vL89eAulPfL97mjcTd3b+PqYisJWyOlvJ8PdjZYXyEdAmc/GFoepItglovyl07/fjV6
         4USdmOz7oc0H1c+oJPF3hzhCcQwZDuWlSFWU7XSrm1DyQK44yvhUHJPa75wtRsCibobJ
         ZmtpVhduCPLZxyvbe8PbWnhRJugRolmTxPkOu/P3cf1W84aZjsxpShNFGUIh34cZFwI4
         vwpomi0vJVVT/9mGjMdCxTu/wzcM8ZX6CgWfLEgmGwD/koPUpw2q9ZCy6K0UnHjsTyEO
         4Pug==
X-Gm-Message-State: APjAAAUKn+HN2rZBnmXfnakyH2CqRFWOSEq0LxZgR6cSlEObHfpNkirE
        KB7Lpmmob4asTksTOUSaavV59w==
X-Google-Smtp-Source: APXvYqySwYyYLwaAMIcShPAMqzsR8c5V+8U/1LZVhB9UFBPpSlbgcxnFk8Ug1vEVntOXvm4iiz96Mg==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr20477009wrv.367.1574076246235;
        Mon, 18 Nov 2019 03:24:06 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:05 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 27/48] soc/fsl/qe/qe.h: update include path for cpm.h
Date:   Mon, 18 Nov 2019 12:23:03 +0100
Message-Id: <20191118112324.22725-28-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h under arch/powerpc is now just a wrapper for including
soc/fsl/cpm.h. In order to make the qe.h header usable on other
architectures, use the latter path directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 9cac04c692fd..521fa3a177e0 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -17,7 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
+#include <soc/fsl/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
2.23.0

