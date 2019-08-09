Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA2C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D562166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6iGPlil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405664AbfHIHYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:24:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIHYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:24:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so614443wmm.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C5YgxiRdWg1QeF0RKI1Qt9EbdjzocEjmRbp/WRepaaE=;
        b=y6iGPlilN8Si8QhpWCJ9jAq3We6ZMX7x6l04tVExxbpkgl4qKg9Dj98hDdVl7XWf8y
         PV3WfvEwgUvjE7oGBt/zg5N+39uCB7dUHoUdKPCtiLHMgrKvCYxNX2PhKBSjqFWwgGzp
         6Qz/slTlHhh8Hrpf6CVmmYFnCBm0Xd/j2crNXq78Dy4j9qQDyafXTpX1rD1XFAwPTqyA
         eKbxucva1RMOlQQ6OpUGTEpxL29e5/jioOouxU4KYUjFKudIJaxLhzNkDHqieMfkZNOU
         E3HlzzQ9vbOJSbVzD6y9s/gyAQpxQDe+yyf4X2R6KRsl5tWkHBNOY00kybUw7UWKOdCx
         mHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5YgxiRdWg1QeF0RKI1Qt9EbdjzocEjmRbp/WRepaaE=;
        b=Wg7tqlRoS1K5QoWeUoFm+Y92m+9ETi9LWUiozRpexCsalphqNFOPsCYiXEoIjHi0Yd
         uvVdko5dfiO4+kax9DNDeaJCaeHitfEFU/LD75mIDAdHrPBW3HuY+puXeIv0NWOLyGll
         j+gvdKZUGukYP60ubkkKi8oiOvtlKWu6DO0cnoCBn9YRCb82DuNbf/tQ2RfQ38wlPctK
         C93ZO0/O23CFe7UZIbdFrMuT1mVF2oQTY0DbHzV3nLSN5GfBx9yksY1oMkA2pNfgpd/F
         DJwijXim6ncpLRCqVe9Wv1hZ028SLwrIXU2p4t/kaj5r7DWXwGThBi8I6YSC8QfykxUX
         5rww==
X-Gm-Message-State: APjAAAUZAxTxyNEnJCHUyQkKn+GDetVQn7UERYgihXPdvXSWAZW+dnGu
        jA4U0m6b3ytZv8oNpGuLYHCuGg==
X-Google-Smtp-Source: APXvYqzY/NrXDMMzWYfoIwzHh3sPo0P5ORJ4j0cOgeIwUdZDRDI4SZtMfr6mDW9pMufCtCpKa+OJ4Q==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr8407951wmg.134.1565335460541;
        Fri, 09 Aug 2019 00:24:20 -0700 (PDT)
Received: from hackbox2.linaroharston ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id p13sm26232705wrw.90.2019.08.09.00.24.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:24:19 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     naresh.kamboju@linaro.org, pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 1/2] selftests: kvm: Adding config fragments
Date:   Fri,  9 Aug 2019 08:24:14 +0100
Message-Id: <20190809072415.29305-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests kvm all test cases need pre-required kernel config for the
tests to get pass.

CONFIG_KVM=y

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..14f90d8d6801
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1 @@
+CONFIG_KVM=y
-- 
2.17.1

