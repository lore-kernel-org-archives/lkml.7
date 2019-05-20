Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A83FC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32EF214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355644;
	bh=evbFVzhLxEg4SbCoKYUaCDJhdyPgsuUfMr8WxKWYoSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxKPW7HT6eZav7xlvBmuvsr458XAIDPWVqpAHN8JcjtiUU+aTkXi4u2HoQQ9l9LWK
	 brDsnK8kwEXC7LsJJ/vXvAFnLqgTkHdXksPGIAnuzGDLjtyGIBSdl/JjzONvaxDT8Z
	 FLhH3PUl9SgG2hLju8HThvNt3G+RsLwxuVpiq9To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbfETMeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733307AbfETMeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:34:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE07204FD;
        Mon, 20 May 2019 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355639;
        bh=evbFVzhLxEg4SbCoKYUaCDJhdyPgsuUfMr8WxKWYoSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi/ZjgZpIa5N2zbyDfBAc5c93bbWdlggeESZy5O5RPtlPEGuNWbWHkUaxSes2wfZM
         ApaqpiIL6kWMukNSIlKa2JKixJO2SAodo8qC7TCw7ZEMglpR4U0yb3VD+RJBCwijxs
         wu4OGQ0gZ0xsY0EOZ+t1N6Yk1K88XTqgRQGT0M5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofir Drang <ofir.drang@arm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 068/128] crypto: ccree - handle tee fips error during power management resume
Date:   Mon, 20 May 2019 14:14:15 +0200
Message-Id: <20190520115254.401097564@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Drang <ofir.drang@arm.com>

commit 7138377ce10455b7183c6dde4b2c51b33f464c45 upstream.

in order to support cryptocell tee fips error that may occurs while
cryptocell ree is suspended, an cc_tee_handle_fips_error  call added
to the cc_pm_resume function.

Signed-off-by: Ofir Drang <ofir.drang@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_pm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_pm.c
+++ b/drivers/crypto/ccree/cc_pm.c
@@ -11,6 +11,7 @@
 #include "cc_ivgen.h"
 #include "cc_hash.h"
 #include "cc_pm.h"
+#include "cc_fips.h"
 
 #define POWER_DOWN_ENABLE 0x01
 #define POWER_DOWN_DISABLE 0x00
@@ -50,12 +51,13 @@ int cc_pm_resume(struct device *dev)
 	}
 
 	cc_iowrite(drvdata, CC_REG(HOST_POWER_DOWN_EN), POWER_DOWN_DISABLE);
-
 	rc = init_cc_regs(drvdata, false);
 	if (rc) {
 		dev_err(dev, "init_cc_regs (%x)\n", rc);
 		return rc;
 	}
+	/* check if tee fips error occurred during power down */
+	cc_tee_handle_fips_error(drvdata);
 
 	rc = cc_resume_req_queue(drvdata);
 	if (rc) {


