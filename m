Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA1C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253B120693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFdXzWhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405453AbfIFOdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:33:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394477AbfIFOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:33:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so6874778wrr.0;
        Fri, 06 Sep 2019 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=mFdXzWhACWV++JfzBVMl/qtkaQU/q8GXKi6aMfmFvNTy6iP8Lwg8AcN56qGoxFjo0N
         gztrZNcB3uUIKF1eYTvjtxDzZqZ0zKaXHaub7uSy26zm8+HGFFea9PO2ntl+uspZOXGp
         y+gh9e8U/kKF6TZuNMuXnNlLUMybhnk6T4zfqP4oDjU+AXSEeyUfRq1EY3neMOBsoemJ
         CfXj65oPwNM+6F+Wf1g9y1VQs0j0gv3kJl2AYBbxPk+XDS5ll5cdgiHE/KRQGYowlvar
         xlFcu9W8tPLIzkN6coihm0A+KMEX0D4lE2avVDvrlPm767iD3tOemnMENJmyvHeQ6PY8
         GbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=aX0uYExfytLfeyb0Z7qPEIwzFw1HD0JM5Hnz5kra+F9zWBPi+5tVZTiNP/N9c8fsph
         Wu6tUz65/NqclxuoSuQ50L/hd3+zqBEdwK1K5LRdUaU2CdrtbJp4M94LIs3UuH2yxzgg
         G4MmeKII8i7Evx4gcWnJQSdM+fxbJPmBEQLiYQY6i7GZwR7iE2kI6FEJ7H3Noyl/shzn
         ss3ZgC5C2n6557smzVqDS4n3cq5JWsJsfiYkwKeetxBV351MKHD3ga9kftdvK3m25m2E
         85zkZwkSxXqeDWI05LhW6H97MJBX/addH1qcIKauvswz9JFgYPg98QMljUNmVqZ0UjRi
         QWzQ==
X-Gm-Message-State: APjAAAWzZasmdn5uTm2B11lRfg9SClZG1zVCFFly/uunDeXrmSyb+I2p
        ZlIQRR0gu8JhZKrZ3+W2sWU=
X-Google-Smtp-Source: APXvYqzBAReJq+3peN16SujBUA+cXIgQaYdFruB3+QzVVcKMrYkBIGnOlKtxgEC2JmNeefOXSa1EKA==
X-Received: by 2002:adf:f404:: with SMTP id g4mr6931930wro.353.1567780408517;
        Fri, 06 Sep 2019 07:33:28 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s9sm9300198wme.36.2019.09.06.07.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:33:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [RESEND PATCH v3 2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6
Date:   Fri,  6 Sep 2019 18:32:33 +0400
Message-Id: <1567780354-59472-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com>
References: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
S922X chipset.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

