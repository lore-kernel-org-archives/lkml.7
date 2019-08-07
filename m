Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C0C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE721E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVIW9zlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfHGN6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:58:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfHGN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:58:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so91495491wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/q1A4PrAblYMBCQgI2N1FaerB81pHXKu9hE/Sa+XUXA=;
        b=vVIW9zlPe5Sze48sRoyXSlGRmh5x3AQpyelKbs+7nugJJ3s7eW40oTSh4LS+0TepSH
         H28kfwS3fIVk1nXC4oYrri7e/or/i1HcprEvxcR19ur7bYuBxlTnf2+zoeMhd0tFus+l
         dhPcWRwqjlNeh2qaEFHYIj99UE/75l3L45NgGD1JuYO7Rw9ffCQktznfRf+uLUg8XcZ5
         YCTqSUTBUzwI7fRA0nt1jA3AYY1NPvZ30qp5pr402FeeWyQKFBx4FQ8qvFNCGqWLva0l
         NgM8yXtvwZqYTopT2tRhnwuEau+wHMziDjEQlrSBPIRxAITECY+Zl3mBfANfcUvIx5h0
         MSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/q1A4PrAblYMBCQgI2N1FaerB81pHXKu9hE/Sa+XUXA=;
        b=HEeev/rHdkeUqiBOqd8oFYAiCqtQ87Or/wRKGeknNwbqEhw+uKn08LgN1/b9NVMSPC
         shrfagXw/CQbc1Nz9kDPzf/IqQdAAA1yqu8dbSyrelEJuUUog7oFUakkMHp9RSbpiyHe
         id+3OPjY9xPaTFjnOu6DLYYOMKp33dXsaDLYnF1bnVXv0lB8raJeimlC8GpXJRdtOVtp
         WvU1zZBkhydt6YNVCmhqtx9tH2n5eZv/wEi3jsjrvyhDMNCC2NYdNBn4UdRMu4hdbLqm
         TU/NwPqRvjQ1GJarWWHk9j79MMyWK3wbYWRTaszF5q+PzNVVEsBDz5Pdxm6vp4J5AKXf
         9ekQ==
X-Gm-Message-State: APjAAAWjT6MEaUMSDoyxpbOa9mvqybMcFubYHOt7m7QdY66XmxpVydhW
        VzeM9OkLUUDj5mL+LVgiQ8WnNklmYyYHog==
X-Google-Smtp-Source: APXvYqxZjoJ4iUF7J7s+ussP5b6+gLvzvOyEPFVQwRFhxv+xdTUkl3QcOk/Eg+A0DCXIq10UbctGYw==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr10524405wra.328.1565186297540;
        Wed, 07 Aug 2019 06:58:17 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id n12sm2912467wrw.25.2019.08.07.06.58.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 06:58:16 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] selftests: kvm: Adding config fragments
Date:   Wed,  7 Aug 2019 14:58:14 +0100
Message-Id: <20190807135814.12906-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests kvm test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/kvm/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..63ed533f73d6
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1,3 @@
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
-- 
2.17.1

