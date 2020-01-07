Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3BC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DF8206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Pa/g/f8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlJR6u0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgAGHgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:36:37 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:45909 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgAGHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:36:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 52F6F5B5D;
        Tue,  7 Jan 2020 02:36:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Jan 2020 02:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=Mg4fIAkD6eFfbiT3IolICMGiWQ
        TzkVNAbk4h1mfqhog=; b=Pa/g/f8oo4cQx9NkhcnuK8oTgbYSBRDaiA5Q/MH5Dn
        Tyj9WAlBUWXg917wPOzrzbbIEFEFdHvLleHYIVvyHNPiXdiSdT6oUCBRFVeJ7cMd
        XZ7mlIPhEQPRwr4EW4lrAMuiVFPD5SXhyBu7SrDtLLzvPkjsNUVthk0Cy9PRr6EZ
        zh6ZSzE+8e00pS+47Lehc/cLNgld80r97Ps3NJFWnb5dTUZlPM0QVfWzybNiXib1
        /0Pkltn9mps8wt5PukVxuXiX3yeiS7nh85dNhBBvXGjh25zq3Fji7HHKip/OECqK
        ceaM46nMTk1Zh2w0BqMSc2h/kutYOUeelfbAcBwDMDBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Mg4fIAkD6eFfbiT3I
        olICMGiWQTzkVNAbk4h1mfqhog=; b=jlJR6u0A/S33tF2m/zZWkOsttnXnfuJ+e
        L+aKvoe2H7OWbk6FOK2wI/RHpPQlBxsw1eCeHR95uRzAvPJQnx/W+DT2p8MUywVA
        CmjhhC9JHiBFiU2CZLnYH3QqZzyCWyUPogn60BAXuTcF6sER9nUbMQEIs83wUEUk
        zkS6wuyqzRVfoyCuNYRPM8HPERo0QDQbfjRn3g7dlZYZoMGIgWTmVw2lLTMc80Fd
        ZBtnz3n1LYS3o52FrBhDLBIh/jNb04leVsFxEzvNztCbAsrEaEUkVOfYk2QQHvY+
        fgaCRfkaMXI98rGsmagsdxdA45Qq3y9JN7QlrDwxGyGUYxSNU4yfQ==
X-ME-Sender: <xms:ATUUXtC04Pdby9YlFx0yTeLRcoW0Su3lNt9A_bMy9TgabagrtshVIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    eplhhipheirdhfrhenucfkphepledtrdekledrieekrdejieenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthhenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:ATUUXpCMr6x-uR8_vveBYfxKvomej8cH-ut68a0jQSNptSbroHAJUg>
    <xmx:ATUUXkpPPb7QkGwGwZ0__9vL0nBechXn8-ktFuoxYAlvmMR9r7Et0w>
    <xmx:ATUUXlAmAPjIPjr1xTXdhqsNWchEq2CoJxyYQAUSc_mznsbGafTqqA>
    <xmx:AzUUXjXxKnjhbOWv9HT4Yi9lplYR8mokbJy0dRWgmk-V2iitaoC5HA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B71880061;
        Tue,  7 Jan 2020 02:36:33 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] coccinnelle: Remove ptr_ret script
Date:   Tue,  7 Jan 2020 08:36:29 +0100
Message-Id: <20200107073629.325249-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptr_ret script script addresses a number of situations where we end up
testing an error pointer, and if it's an error returning it, or return 0
otherwise to transform it into a PTR_ERR_OR_ZERO call.

So it will convert a block like this:

if (IS_ERR(err))
    return PTR_ERR(err);

return 0;

into

return PTR_ERR_OR_ZERO(err);

While this is technically correct, it has a number of drawbacks. First, it
merges the error and success path, which will make it harder for a reviewer
or reader to grasp.

It's also more difficult to extend if we were to add some code between the
error check and the function return, making the author essentially revert
that patch before adding new lines, while it would have been a trivial
addition otherwise for the rewiever.

Therefore, since that script is only about cosmetic in the first place,
let's remove it since it's not worth it.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
 1 file changed, 97 deletions(-)
 delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci

diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
deleted file mode 100644
index e76cd5d90a8a..000000000000
--- a/scripts/coccinelle/api/ptr_ret.cocci
+++ /dev/null
@@ -1,97 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-///
-/// Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
-///
-// Confidence: High
-// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
-// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
-// URL: http://coccinelle.lip6.fr/
-// Options: --no-includes --include-headers
-//
-// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
-// Version min: 2.6.39
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-@depends on patch@
-expression ptr;
-@@
-
-- if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
-+ return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
-- if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
-+ return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
-- (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
-+ PTR_ERR_OR_ZERO(ptr)
-
-@r1 depends on !patch@
-expression ptr;
-position p1;
-@@
-
-* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
-
-@r2 depends on !patch@
-expression ptr;
-position p2;
-@@
-
-* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
-
-@r3 depends on !patch@
-expression ptr;
-position p3;
-@@
-
-* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
-
-@script:python depends on org@
-p << r1.p1;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-
-@script:python depends on org@
-p << r2.p2;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on org@
-p << r3.p3;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r1.p1;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r2.p2;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r3.p3;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-- 
2.24.1

