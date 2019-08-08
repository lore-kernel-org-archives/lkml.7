Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6BF2189D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7eo+W1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfHHMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:32:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389970AbfHHMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:31:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so4628900wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=719/5DFvRfWwCLtGmiwAoLfgu4awkKtG7JiiAlJQkos=;
        b=e7eo+W1fI12hnUdWyfetUQNy8huNzKGC0JTjy2Uf12H39LvQJjs2VSYqyNWH5IowtM
         O4gs4wf1RNCEvAh4neSGwqpIbrJ1EDZa3A/kRSS5nlnBh8rja5DroiXGQG6/GnjSx07X
         tcKyenRHFV4OQHg41LLJqa4joXEWOL/hZMtVTzHh017ouCrFd7R2wa03aVkvTIguwOLw
         Diq4RiUuMUwT+kolbxDoDVmvLmgJWG8Qsnt5QBcF7HO/AVYmLbd7cIMTxtWFOUj5IJtQ
         a+ci9bA2UTszQbarL4LpCpi9a8+F3xt6nbZ6B05RoktxiufweNYAosdPGGu1AlHtJUQl
         L1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=719/5DFvRfWwCLtGmiwAoLfgu4awkKtG7JiiAlJQkos=;
        b=jPgZc9DUoV2Q1eGKlZ6qGGmGKiTo3EaTMaojWcpZOuDxH6FUBFLgF1QehGjU8L+FDx
         8MNhzLsIvcWUrIT3N2ZuEJjD00TmdYondWMSCTC965+dPxIGEtz2/fUiT4dRk/dIOqJl
         lsgpMaRxRr5Z78Oiiuo6uZtChYqtDwp1piOVfdMZnFsChNQspPKfSfm/QINBKnV2ehse
         jHT8V55z0m4YW83ZHlCpYEWkpQB99mLfWOoR08f0xI9DdewU/DhRMT9qE0jsyBnwQbxy
         oKYlCY0M/5uZnxhSJ6YhPHqa35tENytaw07izAOeLS9WiciP/w2POmrWv8dLYrfo43vV
         fwsA==
X-Gm-Message-State: APjAAAWgE9WJR5Vby3dXRJnjXW2WR/X27fAAypud+UJB+b3bctrn1g37
        behJj+BZmiauFgPuY73kSd5PAQ==
X-Google-Smtp-Source: APXvYqwlq7Scq3WaphemqYY+kgeK5uDkZrYgbJ3SRXsQJKsK6KIXuoAOPIVRKn+9+pdgqHpZk4NGJQ==
X-Received: by 2002:adf:9486:: with SMTP id 6mr17484262wrr.242.1565267509386;
        Thu, 08 Aug 2019 05:31:49 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id h97sm3206111wrh.74.2019.08.08.05.31.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:31:48 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] selftests: kvm: Adding config fragments
Date:   Thu,  8 Aug 2019 13:31:40 +0100
Message-Id: <20190808123140.25583-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests kvm all test cases need pre-required kernel configs for the
tests to get pass.

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

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

