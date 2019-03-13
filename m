Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C276206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MwBfI0NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCMU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35582 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCMU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id d6so2138865eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoQ110Vrf5AK+4bC4NE84QgdDWXytINhD/OhnOqdP2Q=;
        b=MwBfI0NZjszFzNLhr1fJeVHKiGFqVJQjiIB6RxXNhf2174KRQtYnw6sZ2xxzspapl7
         9iyn6kv2mrJVugX9uY0NBLx4Idon+H1gzFVX0OKL97PAPdvSDs2AfGxPR3wwRxu/uzKU
         cXUSQIqnHOo5o+XymWOS6WLOuT660PFcId3gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoQ110Vrf5AK+4bC4NE84QgdDWXytINhD/OhnOqdP2Q=;
        b=FXCaJGSxjGGTd/rl8qrHIf4sbrzkxANxaWTaKK8iogFe7NFPwhUUQwaw8BvCMMolEw
         NJDEUUbEEpQZP1PdjDIF8ImP7wW1o8UZvRvwLkONz9V/RS29O4o3U/SK1swcAooq/roC
         vFhrl8k0I4vDf6dtmJ/EjAYcI31wqGYR4pna98n3hQmaUSdRR+fxwwHlI62bDEJ/+eVB
         1GZdZRg5aYhmg2+XUsb6lXd+HF8in9/TnwJSi6dRY/4WE6zD7arODFiv0M+Csm9honYn
         eA0Z5CCzIJtxMIBEp+OVs29Yv2qzDbmZS7jgOQE2G0Sqp1WUs/0yUuFMW5sYdGaDm9YM
         cxow==
X-Gm-Message-State: APjAAAX/CICyIQXbKy/kqODyLj7wC89B2fdcGJ39yEGh5umAdQO+brBo
        KkaAn5O67HEBaenmYiuN/ck+yQ==
X-Google-Smtp-Source: APXvYqzyR2ioTrKgfMibS44UtjcMICBtQ/Yj4VbrtfMLWR7BbFWFGkwzPmoebWVnodbm0hPhP6/FQg==
X-Received: by 2002:a50:8d86:: with SMTP id r6mr8887656edh.103.1552508781968;
        Wed, 13 Mar 2019 13:26:21 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id m32sm940170edc.17.2019.03.13.13.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:21 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/4] leds: netdev trigger: add documentation to leds/common.txt
Date:   Wed, 13 Mar 2019 21:26:14 +0100
Message-Id: <20190313202615.22883-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various sysfs files used to configure a netdev-triggered LED are
already documented, but let's also add "netdev" to the list of things
one can reasonably set linux,default-trigger to.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/leds/common.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 70876ac11367..7cb88460a47c 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -39,6 +39,9 @@ Optional properties for child nodes:
      "timer" - LED flashes at a fixed, configurable rate
      "pattern" - LED alters the brightness for the specified duration with one
                  software timer (requires "led-pattern" property)
+     "netdev" - LED can be configured via sysfs files (see
+                Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
+                to reflect the state and activity of a net device.
 
 - led-pattern : Array of integers with default pattern for certain triggers.
                 Each trigger may parse this property differently:
-- 
2.20.1

