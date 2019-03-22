Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E892C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532C021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GB8BOiVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCVAXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:23:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33456 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:23:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 619C3891A9;
        Fri, 22 Mar 2019 13:23:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553214228;
        bh=gmDZXesZ5+z2Gp52tgVQewSdHUpRe1DQglNKxNF+gHo=;
        h=From:To:Cc:Subject:Date;
        b=GB8BOiVZLlQos/aqL7SvedRITY5uuEpUeHpzTx+prAzXc9SGyVQkqDbA83UV9eCsx
         3fsjWRjkt+lOM2gcJWbfcV9Zch7Lc2UB/b79fE2NmOZQ82awHHxETpu2nYcV0bCMkW
         WWh6Mbxot+zXKkMLyigGUUCJAeYy8g0EK7FPKRk5eJHLC9rhNbSKUw+zw5qXDGG8ce
         LaWtGzpsppypJurHcAitXD3CmmSEKyMIXGz/DI/onhVW00uoxPXiquyyIGc0g7ro2O
         3fApAXjt0yEfRtaZj5Gu1GPObHEOuaPC3ZroKiFOwtYVrFwo6sQ7adm13xV53jgivL
         v2gBcVk/pyxuQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c942b120000>; Fri, 22 Mar 2019 13:23:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 5ACB013EC40;
        Fri, 22 Mar 2019 13:23:48 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2A0B11E1DDF; Fri, 22 Mar 2019 13:23:48 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] of: use correct function prototype for of_overlay_fdt_apply()
Date:   Fri, 22 Mar 2019 13:23:41 +1300
Message-Id: <20190322002342.24831-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_OVERLAY is not enabled the fallback stub for
of_overlay_fdt_apply() does not match the prototype for the case when
CONFIG_OF_OVERLAY is enabled. Update the stub to use the correct
function prototype.

Fixes: commit 39a751a4cb7e ("of: change overlay apply input data from unf=
lattened to FDT")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 include/linux/of.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index e240992e5cb6..28797e1a9982 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1449,7 +1449,8 @@ int of_overlay_notifier_unregister(struct notifier_=
block *nb);
=20
 #else
=20
-static inline int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)
+static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fd=
t_size,
+				       int *ovcs_id)
 {
 	return -ENOTSUPP;
 }
--=20
2.21.0

