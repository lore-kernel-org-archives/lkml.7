Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CEF2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEX58afM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfCDPTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:19:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:47080 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:19:34 -0500
Received: by mail-io1-f68.google.com with SMTP id k21so4202204ior.13;
        Mon, 04 Mar 2019 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBdSxOpRVCPLT+WOZO0rjdgqq+WENx8KAyprRn80FIA=;
        b=lEX58afMkYcjZRG5lmr+tGUJuaWuIIV8ASdNBbJlpmsV4PToEUpUqqu9skivru2HBa
         MZiFTM1ZjholnQs99n228dc1RCrN9gqr5ScUolaEdK4aua3xSj18CJCTct9l9ijNb7Jf
         thZh8KOeWL8wpyuEMluHyklbNTifubGEi3oTBihMPOTY7chzLH7ddEJjgXCUpMc/7t7h
         RjM+dBK5CpApCQOsVyjOF1TXsQYDRjlU3TmDLOQefOyFxm25ZulZPBqAEBLWeOodOImw
         cFWB4gc00rxVrxXPu2ZG7414qA0ar62jMm7Wcxu8W/lfh05dVZBJFn4S6IlTXS4co7JX
         pqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBdSxOpRVCPLT+WOZO0rjdgqq+WENx8KAyprRn80FIA=;
        b=gJdH+tVEjcFnZztvtSIQxXHysOZKtFEDQTSGcYeNbuli3tT6t0LnfwjhLlvb2P8gTX
         qze1r+7hEh+QYpf1UkXz4CWz6hlXqsHWTO4rT3pYj4jSRY/6FCsAemVZBfoTxG5GkyX/
         HTyrmtsHj5zQBFs2bn1m1UYLIxUrJIsX4GDTvHyOXdZ6bydMetzm7YCG2SWycPYRnJb5
         GXHLw84Tn+oYH6wQcJ12lMu1frwhy7YWySqDNRWOuC64zP599UuPrv+/4FNFP6CrMIfc
         kIFKXYi6oq94FfsXG5vjyqVl7PydfjGmyoJ8hIXXiGe8tnBe+gieV//+nH5WcwmPKX4w
         IAcQ==
X-Gm-Message-State: APjAAAWc46gMqM/Lganx5htNZgrFPVzLtIXfWnpb1Y660+x1/6hOG9ri
        hKLaMy1yhLM6VmpfnFWqMA9CO/k=
X-Google-Smtp-Source: APXvYqx0X4wEZm14rqO7qL+nHSqmpxUgkCsMzzndWWirMNtW83WF2UmSL5ISomxuvBtLgHtlFcYXaw==
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr11234305iog.147.1551712773697;
        Mon, 04 Mar 2019 07:19:33 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id 5sm3240615ity.40.2019.03.04.07.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:19:33 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Kionix, Inc.
Date:   Mon,  4 Mar 2019 10:19:10 -0500
Message-Id: <20190304151912.11485-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304151912.11485-1-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kionix manufactured MEMs sensors. There are Kionix acceleromoter sensor
drivers which can be used with device tree.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index bb6f6e8a2eee..e389904ee9bf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -210,6 +210,7 @@ kiebackpeter    Kieback & Peter GmbH
 kinetic Kinetic Technologies
 kingdisplay	King & Display Technology Co., Ltd.
 kingnovel	Kingnovel Technology Co., Ltd.
+kionix	Kionix, Inc.
 koe	Kaohsiung Opto-Electronics Inc.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
-- 
2.17.1

