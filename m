Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41220835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyBmnvGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437640AbfIWN65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:58:57 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51757 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408340AbfIWN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:58:53 -0400
Received: by mail-wm1-f54.google.com with SMTP id 7so10118314wme.1;
        Mon, 23 Sep 2019 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=PyBmnvGAVmeNZXVQCdhZuMm5xmUKjafJcs39w+VF3xZRW1ukATZ9MM17I1J5yZNxWd
         xUXioii8j849Qsr7+EivroplglGGCZmkQFXoQ8fVDUs/smlVzNX0ym7X/kShnNnWHB8V
         1Joo5oMJhn4DUS2E4CZgWJvij8n3nb5xNxJd96p0X6zQPPVfWEUFQDuNCLIXEAS2/a3a
         F+NDc+WB4bAOsDhi6UWEGLNKXBHwi93vC+i2ha9Snfv/jB94tcyK3Lyr/suRBfoCIa2m
         jVIGyxhMZqkJRUVn6UDhL+BT4Envnv0yumFDIlBfCM90X6Tt8lyH1tysSSG4FfA9c44E
         f5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=lK/LLzniFaJoqwMunA5SR4lITludUFMzTqdP8e6HGZaGOpAl+XP5rr8qgV9rM917ps
         ymUmRSK5gfMPxKXSV/YjaKfZWgIpVhcOfW/gaMmkE1Kz19dcZdKZNoZwbWxaavM/VN0o
         Mf9yT2+Iw4WX0v4MYzIBOHosrIYYMfLQ03ATFjQkSHN7VN7b9tXVciw2eDT11oPJBRmp
         2zfmPmCvfrTFk2nOxzice0Q/3300HrwDNGRO5fPQnBqiXYWJY39JiFGzCElQMmRKKXTd
         GnCe6jmJKWpu60JZ+I912q2W65vLNu66ohk1g9woUFiPuT2EQ5ygDnGPYcyzDkjW/VnB
         1l+A==
X-Gm-Message-State: APjAAAUfw6BJ0sMDu6fJErQt/Y43wpXRkzjaQFCSBpy6V7jITXCw+MNs
        h2iQPgbfvD9ul3Q8tzo6xcE=
X-Google-Smtp-Source: APXvYqwbM1mVAeEhkw7RAsOqpdjVQEUzhYsQX0hZyFely5cFNmwIhidNTc5umAi2fF9q96DYEPgpIg==
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr638211wmb.82.1569247130847;
        Mon, 23 Sep 2019 06:58:50 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm25266184wme.6.2019.09.23.06.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 06:58:50 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Mon, 23 Sep 2019 17:57:55 +0400
Message-Id: <1569247077-5212-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569247077-5212-1-git-send-email-christianshewitt@gmail.com>
References: <1569247077-5212-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes/Dongles,
Digital Signage and Advertisement Solutions [0].

[0] (https://ugoos.com)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..d962be9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -965,6 +965,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ugoos,.*":
+    description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.7.4

