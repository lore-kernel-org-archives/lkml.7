Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB83C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99472083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyZlW9rE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHNLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:16:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46436 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:16:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so5891812ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM+lOG3uuaZKO9SiLPdJ+4deUlKV/b5HbUdj3Mc9GeI=;
        b=DyZlW9rEyj+EVzbT42xD4GrOCx8/nZME5s1x9ubtqPvmzO3OboHv2sJX6yUbEIHv8I
         VJeZOl5WCXgmjaoXlMtr+GU4OSoVo9m2HdDGg6ma9v7dv79kZXAa4eHOQPkPavbyFn+Z
         LmVee68sPKqFRaEehadGBa9OSzLoWu7goRFs3nf90Wxg/kHBHrXxSYTK2wndU3zORTkC
         UOX8E2oWqHFTJiazrI7Xv40sqBbRdSViRNeSDBSnoVsXQ7AQPJetvC21HTDU5G1LhGog
         +VaFBgwg0tdww7ZnKwLqt5Xh0O3zHbQuTmDdkfFTDpbkiN7jrd14O5xaxAP3SkOnv2MU
         pBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM+lOG3uuaZKO9SiLPdJ+4deUlKV/b5HbUdj3Mc9GeI=;
        b=r4D5TMz0q24udTwKHY30Ce/ELocRFboBzOtzDMefncpVZ4wSRB1UlqSVdwvbgCUZT/
         Ubafr7KgcMpAVRK60VRSCJatVPJ0ckrnPAwMNKus8EoiHp8uqXTRb2/kfKG8Jj0+Sgkw
         Ejrqwj5S5hs2f0Yo4/thsPCcshm+1Em6PfHk6HQnNX3wsgdUJ9icBbzn54NSLY4EIyaZ
         M1iySYn3wqJGverQh+lUUTtx6rm8dJKVIDVO8SU6nMRDGx0/EJzvbHjQEs4N7iHARoUB
         BJci/+j8/pkHjVVu2bgJm9+7JYuoZmQXiT2pfJqwKeyNwwHrf8a89UEvBn5aBi3aR7Ur
         /6lw==
X-Gm-Message-State: APjAAAWByDjrsbXtqeRuTXdlmvxsq2nJ19WSkuG60TBhKn64deoJPpeb
        U2qPAC80+fGGGipEMic0dJhVLQ==
X-Google-Smtp-Source: APXvYqyE6JOL4CkL17m8OpVNbigSqpiZyVfokme8qoKLjA4Eav66jqxj/Jm39QFjJRx7gKdhbyUEew==
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr24935605ljk.29.1565781416360;
        Wed, 14 Aug 2019 04:16:56 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id q24sm2004302ljc.72.2019.08.14.04.16.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:16:55 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, pmladek@suse.com, mbenes@suse.cz,
        jikos@kernel.org, jpoimboe@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: livepatch: add missing fragments to config
Date:   Wed, 14 Aug 2019 13:16:51 +0200
Message-Id: <20190814111651.28433-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When generating config with 'make defconfig kselftest-merge' fragment
CONFIG_TEST_LIVEPATCH=m isn't set.

Rework to enable CONFIG_LIVEPATCH and CONFIG_DYNAMIC_DEBUG as well.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/livepatch/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
index 0dd7700464a8..ad23100cb27c 100644
--- a/tools/testing/selftests/livepatch/config
+++ b/tools/testing/selftests/livepatch/config
@@ -1 +1,3 @@
+CONFIG_LIVEPATCH=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_TEST_LIVEPATCH=m
-- 
2.20.1

