Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B69C48BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794952080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z77iLpOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfFTNT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:19:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35424 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbfFTNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:19:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so2130994oii.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IDImd+SyL7qusfZ7LEqZyeCM5Jqrmah1crodqgym2o=;
        b=Z77iLpOXmS+LuG22+Pytd77vIOhESlIw9v0v/o6wz3WFxUVyZVuXJyx4weKeiAaHLC
         ICyqNfMfDaMIR6ayB8jyTxh7WaXJguH7MAKdKF5UvpkAZpzjDSudYBycegmdv+cu3y15
         GJfnWza79menUVnjzVj/C188QZVNtvPmC6BkufiJg4QDBfrgLETYgTboXga0ksf6Bg0E
         mgqxLmAc+KD2Hbfv9VTXfG5MrxmYg+pZk4V6eZnGbPIEzp2SgIAXb6JEo3IdYTIKxYw/
         9heW8RVFfJ52e0uQ8KD/L8xbVktXc9+p8AmFlk7oON8FotA+3R0q1CsjGObin7blMxo6
         osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IDImd+SyL7qusfZ7LEqZyeCM5Jqrmah1crodqgym2o=;
        b=MgsGy+aULUCa4hpeD2VAyiEMv+98BiQyFUF/LZDkg7vw07pE5x2AtIh7eYACVxiENl
         2ISJc0riWSa70pcdmJNO2YS8t19Jr1Y8bmdljPCjXAkZM+cYPP3K3d6WbRZT/T9W6gCX
         z3k5PrDQcqaRqwSCg5HLpVWE4kilCRjgg1mdUMeyPeaR8GcyGxwfzGIdlunHbJvSg4lX
         LmQAYP0FNpgBagPw02kVI8mURLG0oPu7pHUDlsrXO9f3/u1k1EEwQXJ58QEUrpViPQzS
         8CuEq1SQuyFmYtnRl4YS36j9sDDRVmD+k3kYNLndaIksLPJL1eOz6dgbo3J6er4cmgnE
         KYvQ==
X-Gm-Message-State: APjAAAXazT3o/Xk8x1BuOMhTjYRhIavyLfebtw4Tgww6sul/JNygm2M6
        PISZT1dzELBHKBB1rUkKLpP8Aw==
X-Google-Smtp-Source: APXvYqyRboXu4SbkOVXdL7maf5yqjeeaiBdvJH/64vyWK0jWSoHwuU7EkLw3RE1uOYLsi2ZI6ZrlCQ==
X-Received: by 2002:aca:4b42:: with SMTP id y63mr6256321oia.168.1561036794590;
        Thu, 20 Jun 2019 06:19:54 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-218-29-147.Hosts.InterCable.net. [189.218.29.147])
        by smtp.googlemail.com with ESMTPSA id t6sm7878945otk.36.2019.06.20.06.19.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 06:19:53 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/tpm2: Install run-time Python modules
Date:   Thu, 20 Jun 2019 08:18:19 -0500
Message-Id: <20190620131822.28944-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ordinarily running the tests, upon `make install', the
following error is encountered:
  ImportError: No module named tpm2_tests
because the Python files are not installed at the moment.

Fix this by adding both Python modules as accompanying
TEST_FILES in the Makefile.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/tpm2/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 9dd848427a7b..bf401f725eef 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,3 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh
+TEST_FILES := tpm2.py tpm2_tests.py
-- 
2.20.1

