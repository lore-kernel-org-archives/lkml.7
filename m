Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120936;
	bh=7qNIu5zgGAAtXgzPcQJ3wYLhrF26mDQPfCCJ1WqB8EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UI8+7GkacIrPT2YIrcoH7gI4P9dyzETEXY6fvkOEqmTpFhJ7mgzdBR7JnZf4FYwyQ
	 Ieji5/j/JWJ2hpCzmhS9WaqVnRr4O2uY0dAjQBVDcjY8Tibeiv66ujAgI1EfCSSbEd
	 oBY8slyD6gKFgJ99nVmkx+yT+EJcPH5hTzFGf/WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCTW2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:28:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46078 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfCTW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id j128so3315034ywg.12;
        Wed, 20 Mar 2019 15:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xNmYnQsl8UJtiV0CU/tgLUrv0vvHpQBBgA3eiMC6KQ=;
        b=VZyIhzg/vL7xRCsLheE8ezlNVmYdhnoRtp/zpMun8NOvCiC3/IYUi7P/lVY9KiG3CM
         aTT5GR7c/J12w9xVRmTTEeYQ46k8oq2yeFnJDoMtM5JV8tkShQfFZ41jcMLde2Yvzl37
         +WZ5MMc7F0xsyXwaqivYi9mzpZJddkEtxy2Wdj5P5ZM6QnJthUpppm8Zx7pbj+Bk1iDE
         FtEecxkgGXuZAHtJ22/iLLylMhOLQgufvP/sju0+KvA3XeIEsvDhAIul+5cG5pN8khsJ
         NT3joBqauU5c3d2W/wps7QWxDAGxDkzEjzHljYFg/MRyXrFxVhCE2APHPR/ywmjerRgS
         lmbw==
X-Gm-Message-State: APjAAAVJSLjE9xK7ykIR1IU/FoiD/FpH/6BsMKDbuCJlpRVX0pfxxeQI
        Xwv/iUj25HIG4ooeOWttYeI=
X-Google-Smtp-Source: APXvYqyK/6Ghd74kvYhCkKGbDwRh2ZfNdWJRPzBbtXfcu+i+DL6vWjisPUBWHmWGp/QQGjsTN0zCtA==
X-Received: by 2002:a25:dd8:: with SMTP id 207mr291070ybn.379.1553120929839;
        Wed, 20 Mar 2019 15:28:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p17sm1067949ywg.27.2019.03.20.15.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:49 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/6] test_sysctl: load module before testing for it
Date:   Wed, 20 Mar 2019 22:28:27 +0000
Message-Id: <20190320222831.8243-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the test script checks for the existance of the
sysctl test module's directory path prior to loading it.
We must first try to load the module prior to checking for
that path. This fixes the order for the load / test.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 87df7e52a97a..e0c8404da6b0 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -823,8 +823,8 @@ function parse_args()
 test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
-test_modprobe
 load_req_mod
+test_modprobe
 
 trap "test_finish" EXIT
 
-- 
2.18.0

