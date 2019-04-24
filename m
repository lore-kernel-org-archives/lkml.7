Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92EA2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGTn/dHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfDXVNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:13:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41147 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733089AbfDXVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:13:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so15803226lfd.8;
        Wed, 24 Apr 2019 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KhsaICucBSzIi6pewqFTD0VbH13k2SXqO4xc5eabvQ=;
        b=ZGTn/dHyWO9Gx2gdgM7KVXB0ZSwP+cwl9ETPZMYpSdbQIB1/8NHjcF64SpIP8CvAWV
         2L19ZIKjafS/Ho6ZMLeTU8cx4XhBf25l0AxjgjY63sq2VBPlnlkGUixOzG8BXYDCuoW3
         cVWQAniDFtABn0nybUfTG6AW82YgjGzMAF6fEgNSY5E/CajJhUNNp80FSlKbb3nWWNvK
         LqpW3fdn6JTzAPIRjBVqN5zQId2TqBteh2xYVMW+osABZqherxIUlm30tl9V28bhz5yU
         1q/M4Rs4lo1CNIzKu0hGvq8rRg08oC5DQN/+hbK8pezPmljsnKI6pnywmboeyCRXOuOu
         FgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KhsaICucBSzIi6pewqFTD0VbH13k2SXqO4xc5eabvQ=;
        b=jY053dcsBwoF8nn8ZbyfIf34tVukJzYpAAoqrP2D9Tp4K4MN9K7mEP/tggDGeT1Z+g
         H59BbDFqKr2w1p8LO8OrZgeRlDpFIRu9z4m4hE/H9R23Z+E1KLFh/SLlYmDuvO//45b6
         /5FiZnmHaxNSGYX7GkigGD2n8H1LmmvO3/Ss/HbOhLsR3vEbEt5+NF3XJMVzXCk2L4LR
         c8PlJT32ROq2Ir6QdCtd6ns9g/4QM9eWV1ahodRUz46UQOxcWfT4zJYtfzoQNQEaLn7a
         Hdy6b8yYjsWhJz/Sa7UNjtrqNvHFszjQ5lIBQvS6AbtEtTbAwJj0M5ediWcWFEaeGFP8
         TaAw==
X-Gm-Message-State: APjAAAXp/Frin2IlN85AocXAvZm9Y1If0LW5r7d/jOplik9nIhbHVXRy
        2IERgPQLm8hhlM7PxbCB08A=
X-Google-Smtp-Source: APXvYqz3jkwKHMkN+3DBn3mIqQAkYt0FNl1kCkLC+6au9GLE2u46bh2FX0DM89GvtAaYleliKEMUYg==
X-Received: by 2002:ac2:598b:: with SMTP id w11mr19531195lfn.62.1556140414975;
        Wed, 24 Apr 2019 14:13:34 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m3sm4540248lfh.94.2019.04.24.14.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:13:34 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: usb251xb: Add US lanes inversion dts-bindings
Date:   Thu, 25 Apr 2019 00:12:05 +0300
Message-Id: <20190424211208.17499-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424211208.17499-1-fancer.lancer@gmail.com>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a separate US ports lanes polarity inversion property is going to
be available the bindings doc-file should be updated with information
about swap-us-lanes bool property, which will be responsible for it.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 Documentation/devicetree/bindings/usb/usb251xb.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb251xb.txt b/Documentation/devicetree/bindings/usb/usb251xb.txt
index 17915f64b8ee..bc7945e9dbfe 100644
--- a/Documentation/devicetree/bindings/usb/usb251xb.txt
+++ b/Documentation/devicetree/bindings/usb/usb251xb.txt
@@ -64,8 +64,10 @@ Optional properties :
  - power-on-time-ms : Specifies the time it takes from the time the host
 	initiates the power-on sequence to a port until the port has adequate
 	power. The value is given in ms in a 0 - 510 range (default is 100ms).
- - swap-dx-lanes : Specifies the ports which will swap the differential-pair
-	(D+/D-), default is not-swapped.
+ - swap-dx-lanes : Specifies the downstream ports which will swap the
+	differential-pair (D+/D-), default is not-swapped.
+ - swap-us-lanes : Selects the upstream port differential-pair (D+/D-)
+	swapping (boolean, default is not-swapped)
 
 Examples:
 	usb2512b@2c {
-- 
2.21.0

