Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA576217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd6hDHZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfC1Uhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:37:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41551 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfC1Uhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:37:40 -0400
Received: by mail-io1-f68.google.com with SMTP id v10so7742541iom.8;
        Thu, 28 Mar 2019 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+vYEnBKMLIXqpko9A7PloU03l+PO+bBCG9nvGVEgpw=;
        b=Xd6hDHZACaAt3vQ7SbrO+1jWqOPIcxAAI3nR9rcALBTl9DZz2qz4+SDhC0aiwK9bfW
         5atTpHeSPpqvsq4aSC9r46xtRmW/md9/IyV34emGILzIXaDNebfUkCCS5visFoxHUjxQ
         QLul5AUqDzD1VqzHx+XtQCyqPJC8AFui5ggbV5c9IqpO2JWtGpHUSVmgHggcfzq9yF63
         OEDMOfw6Kj1e8efNqaf55JZdCVOuHKRikoXO/3qoOyaWhslooB3/i4bC6d3v/7xecNvH
         OFsAYeZJzcCX2eWc+vefAM4zWknVev3VQqJRJL06G7ZTGaqrGwT8Q5vNiXYRYNDharpc
         Zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+vYEnBKMLIXqpko9A7PloU03l+PO+bBCG9nvGVEgpw=;
        b=mNbPyjpJj9wBcTxy7IhUfvVSX72coMh3Jidx4+g2NuFLSTx9uRaYAkk56NNdUWdtFL
         +0NPQXQux2UtpOLKLBsaq0wLJQwc4kafSQ4RjxfY2COo5uwOMYAVf2thRSwW8/yqihO8
         qjIGjoWc+PXyWAjQ21QHudqnW/2/p0/9wUAAW7hsECSS/vyNP4CLJph1hcfxMtW09bKI
         Xn8gZkmrZGehRNy1EW0ILjM3ZEB18cdufZ5bTtjDZltqjvIPhUvt/QCo3r6DzuGeCD2a
         XItBd63/RYW2wlObCFh76NcdbXuvsHywhqdrBa9oD04Omw/o09/g34F/toMRU+IDYifE
         NNIg==
X-Gm-Message-State: APjAAAXaoCorLUQtF9BSXC6+rzw99KC0pqxk9eknzpc2VtwgRAyTknlT
        XWntO9xmwFsVRqMY6MMVTXc=
X-Google-Smtp-Source: APXvYqxBQlG2P4VCMuZwZ79qRml5Hk2HGqXljnfwRnlpYnT5K+INq0qUvVS38a2MZWfFXQteytuW+Q==
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr34194910iop.33.1553805459293;
        Thu, 28 Mar 2019 13:37:39 -0700 (PDT)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id v10sm11394993iob.30.2019.03.28.13.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:37:38 -0700 (PDT)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH 1/1] dt-bindings: power: supply: add missing semi-colon in example
Date:   Thu, 28 Mar 2019 16:35:18 -0400
Message-Id: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the example documentation which is missing a semi-colon.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/gpio-charger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..ddf7b7b971e1 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -20,7 +20,7 @@ Example:
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
 		gpios = <&gpf0 2 0 0 0>;
-	}
+	};
 
 	battery {
 		power-supplies = <&usb_charger>;
-- 
2.20.1

