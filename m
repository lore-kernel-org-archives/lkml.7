Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E572083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTwEfVnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHNLOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:14:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46210 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNLOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:14:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so5885979ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ZIDcmD7X9+jIZGyUFHQ8LhoRhdMyG2P4fRASmcVc1Q=;
        b=WTwEfVnw5ImjU6WACwLtERPD6LysVPlAh3KDnuA+i6X9BhmfJFWJQopoc4ZMLhz/k0
         QTnQ56CAe4UTiesTp0X7elvbXBRqE1k/Ri4OCF6Php8PsJ/eV2PJmNQp01sGHfE9DMTs
         fPEqXuW2dUf3UYCkaE2Aegg0k7s59iRXtCSk58L8O3OxNzxVCJUBUbMlT1FeulRs6GUe
         SlfCFYYw9KfVdjmS/RHHkbHBzhu+3FnqM8LuA762Tt46sodGmJG+lH+9qQ3gTppfcN2n
         mWE6+rKi0bTgsNFYSnp+hNETqJHGTtvlUxL+crM+zVo/6UzqoBomacdZLLfswLQ5mrYs
         5zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ZIDcmD7X9+jIZGyUFHQ8LhoRhdMyG2P4fRASmcVc1Q=;
        b=VmFGu2tcLxJUynD/tHO/4MkSTDvBA+9L0YILbYTUivTSx2w4vvKidj8UCkJmG6w2xF
         S6iWqJ4Taloa1c+SzVk/m/iW/2jpJlstp0Y5KBOX/RxdOV8JcSWfmKOhvBXH9/d8XZBl
         2qaCYM/0+wjp9pC9O4nBbUlKPHCoReCb/ihtjGkORWWsWPgtZc2SQIoVbrNHuDagWWVE
         3xmGYsQPoXzPE29tNx5w/sIHaHDPjCPY2iNxkJeo4GbA9jMO1rPzyqsOxmHQL1yVSQnV
         aFxDYkveHAq9DLpaknGLUK/m8Tt3/YKX7D9cNMyjvEugH7YPM3aFhxwjkAMdfv3hULKf
         ooFw==
X-Gm-Message-State: APjAAAUJQxcaKSVJ8EGQc1aQZU6u5BgWOAxLbpZ8Hplgq4LAwZ2ts4JD
        GKQhowlF0VpsTutuf57BOJm3JA==
X-Google-Smtp-Source: APXvYqzOGhAnvDvwpFEWKGuQF65aV2cnlADgSTNlgmMKUNekTDnb/t4n/TuCdkFfKzUPESjXoML8/g==
X-Received: by 2002:a2e:6101:: with SMTP id v1mr1469685ljb.42.1565781282209;
        Wed, 14 Aug 2019 04:14:42 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id i17sm20215973lfp.94.2019.08.14.04.14.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:14:41 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: tpm2: install python files
Date:   Wed, 14 Aug 2019 13:14:35 +0200
Message-Id: <20190814111436.27920-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both test_smoke.sh and test_space.sh require tpm2.py and tpm2_test.py.

Rework so that tpm2.py and tpm2_test.py gets installed, added them to
the variable TEST_PROGS_EXTENDED.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/tpm2/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 9dd848427a7b..1a5db1eb8ed5 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,3 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh
+TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
-- 
2.20.1

