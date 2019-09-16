Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F485C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376D214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QV3c00Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfIPJwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:52:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47028 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfIPJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:52:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so26873431lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4z9v3NYegxXdjjzaWrNbCyzb5jhowutdx27d6OJp9NU=;
        b=QV3c00PtvCC5fm3iOXFZ1vRXl+Fdp8MViwfaPWYQQ3iSW1C6xGEysKjKTGB2KGAdFt
         ZcL9jw4Bxx6cGBgZnR8NuL1sq1+Yhm46He9AXRJKkjpwgjObkgOytQm4plOPWsjqu7G6
         ZcIRCNRHnSBl6OnpTfJKRi4xsA3SlxI5yDTDE1V0H+CsZuQDAImD2iS7LVPX0Biir+LU
         BJyQKG1BbYwO2UM7ekySIgdPHVRl+nuQpfn3G6dIdwZ1yi3x7NW4FHSF4VisVqoXvh/Z
         4cPJK1d4xLEnowz2UH8bV4sj9x3swUayOZJ8G89BGg3Hd64unDJATK8tTGSJOBMHDbV8
         930w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4z9v3NYegxXdjjzaWrNbCyzb5jhowutdx27d6OJp9NU=;
        b=ZSrw9EzfZtO/EY4J+vaSKT+usODNJx7M1Yb8ok9mqargXQ8c/Ylk4xedn0yyqJvBKz
         LTykXE2qI9Zday29ww1YuiHN58x4PXpRQE+UvpO9U1Ch9wbt8Ir0KvnqZrZGOUmSDq6G
         SYCX8bWUnwIFXD4pfhyb/PKi2N5nRqhYjULIhq3wNWydVov48sn891SP00V6GBQFsF+L
         UBucXIwU/i/t2oLOV9JbNpst+ssLqefCeMOlpFwVD/DkKxukeTOgekQt8Nn6h93tbrXA
         KHNrU5K6BoWlTUkUMqQ5kWWRzSEdS97O+D3owsNmEMQxI2QUvSAsquHCXg7bmAuX17vO
         Z/sw==
X-Gm-Message-State: APjAAAU0JCnfEkonDczmbuC+PqUhGv0ToyxA7CMBaVgWMDkewQx2Op8N
        x5idB/uowzeqK1PAfKhQL/Lwiw==
X-Google-Smtp-Source: APXvYqw3ecRETzqvleE77nMvWYqX32rVanMwZNRW/sQHAmpHqxaIXb9LrF9Qil+vDe1gGLHaAZ+biA==
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr5712041lfl.74.1568627548765;
        Mon, 16 Sep 2019 02:52:28 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id k16sm8432187lje.56.2019.09.16.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 02:52:27 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: vm: add fragment CONFIG_TEST_VMALLOC
Date:   Mon, 16 Sep 2019 11:52:17 +0200
Message-Id: <20190916095217.19665-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running test_vmalloc.sh smoke the following print out states that
the fragment is missing.

 # ./test_vmalloc.sh: You must have the following enabled in your kernel:
 # CONFIG_TEST_VMALLOC=m

Rework to add the fragment 'CONFIG_TEST_VMALLOC=m' to the config file.

Fixes: a05ef00c9790 ("selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/vm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
index 1c0d76cb5adf..93b90a9b1eeb 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -1,2 +1,3 @@
 CONFIG_SYSVIPC=y
 CONFIG_USERFAULTFD=y
+CONFIG_TEST_VMALLOC=m
-- 
2.20.1

