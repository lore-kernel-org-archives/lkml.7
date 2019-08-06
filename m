Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183FBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2ED208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHk9KRvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfHFT1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:27:00 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33294 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHFT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:26:59 -0400
Received: by mail-vs1-f74.google.com with SMTP id x140so22416717vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D3pdZ1hpsDBBSSu9uYSfSRCE32NuFY9z8QfNXGGTrto=;
        b=LHk9KRvN4gVYqdpbzH/h6AXDTltFI1mcEX8tIfDeaaz7Pp/s1h6kD5/luThnNVkRXo
         RFprVeqH+KMHp8FIm6SlOg6lN817W54y8MNPmJ2PPAZSmanotW9ORWMMT7bLPtY/Ogw1
         l0/wUU+j2GL2oPXGJQAK/smUR/uZAZ8uvIXwSeGYNr+5rbJaOwhWQfTDWRAIrdOnXsRC
         oDnLW2t6xqw9H4TGRe9jA7NjyIzr621ALRjr8ny9y6N5BzR8aiT7q7zykTyhfszTICrY
         3bbTdssMsUOKUCJiIAMDjpzv7t5+paMDYudQmEGzotuahcrwMAyB3nMw7QmMjnIOz+hB
         aTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D3pdZ1hpsDBBSSu9uYSfSRCE32NuFY9z8QfNXGGTrto=;
        b=RRt39lqbAM7dFQTpzLoY0iZjSxDh9D9hNdd5HH7dGY2H3aqnWkiW7rWr9iF4lww5Zt
         /dcDEaQ1f0S1Sux6tjZ2Mo49G06oHdEVB+3Z/6AGQdb+4VTCVia0Ndw6eQDQwiaifBbR
         t9nuTKzqAHr5OntE6qdF9kFrEn1XBl+88axLSXW0iXlil6o69IynOCG2zBWfi7czK42s
         KIMuLTvhrcZaRlQA1tsPhJ5FTxSAHU1OBHQGCS6S5g9sRlXo29Uzq0kQljBT1h88fr7c
         k4hWzPbHwGh8Cant4HVuQMEsBrh5oeyinRTRIVJTg/eTIIB9hbh8NvxmhYIL8Nq5VVRO
         wdBg==
X-Gm-Message-State: APjAAAWhyp7rO3pFAc+LltmVBHCoEHxidxvw9Q7ayq7T3qrt5IK2Bw6W
        gJvKFZJwdrW2d4aqgIQF+jd45rw2MKYVO4I=
X-Google-Smtp-Source: APXvYqxGDu8U5booa1l1NNHse+Ok3XBT02Jwb4vocS7V3EHzsgihODf2xQqyNWYaIEk7cAN9qJAShbo0brkax0k=
X-Received: by 2002:ab0:6503:: with SMTP id w3mr3177460uam.99.1565119618579;
 Tue, 06 Aug 2019 12:26:58 -0700 (PDT)
Date:   Tue,  6 Aug 2019 12:26:53 -0700
Message-Id: <20190806192654.138605-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH 1/2] of/platform: Fix fn definitons for of_link_is_valid() and of_link_property()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_link_is_valid() can be static since it's not used anywhere else.

of_link_property() return type should have been int instead of bool.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 21838226d68a..f68de5c4aeff 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -506,7 +506,7 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
-bool of_link_is_valid(struct device_node *con, struct device_node *sup)
+static bool of_link_is_valid(struct device_node *con, struct device_node *sup)
 {
 	of_node_get(sup);
 	/*
@@ -625,7 +625,7 @@ static const struct supplier_bindings bindings[] = {
 	{ },
 };
 
-static bool of_link_property(struct device *dev, struct device_node *con_np,
+static int of_link_property(struct device *dev, struct device_node *con_np,
 			     const char *prop)
 {
 	struct device_node *phandle;
-- 
2.22.0.770.g0f2c4a37fd-goog

