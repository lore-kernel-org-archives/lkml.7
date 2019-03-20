Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AD7218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120931;
	bh=Reia7N4HM7q/0RExFRjHYe3A7/t7NQB6D1EsdTVUbD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YrdBbGUkXEicigxWoZqeozucj/64i/QIUD6Mhkr0c2cuQq6WirB5DQXmY6kdfXU7W
	 gDi+tAw2Hum+hLgsKiyIdIN5kYbmKXSHP8AGd0Lte0VVThq98Gvj0xv9LmJQDEV5WF
	 3EYkZB5mlej1CwBct5TOpHi2HuK86pjN3ts0Eufw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCTW2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:28:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44685 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfCTW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:47 -0400
Received: by mail-yw1-f68.google.com with SMTP id c4so3315616ywa.11;
        Wed, 20 Mar 2019 15:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Uoy8NZffLtwCVWkJYoNixcTf+BuPJo1nSiGzd+WLLk=;
        b=HYXZtfIxu3Krjp/OwZozZHWgEQdAIqbLGS3QNDkkHsuZ3lonzgeudzkbi/dTHqKR2x
         +2Xnx03DPyAk3ja069TSEZ3B887LfTG3MuuamCMKHe2oHDvq9E2WAYbUbO6C9Dtk+RJK
         Lzc5vqN0lJTyp/zUhveRmZjb3eT6BfZV0MhIQXAjeU76DtomeB0TT941ZlM3sfo+h83N
         mbrMs7qiDs4edzTLjjCVid2RvpVVYP3Do1bV1RrmnLCmOuz3bG8bRwG1fK1tM8O8zGKU
         0V2AlzXHCLMfTfABFSxQ/2YpucTcT55B5P/auU1BvwfYHJqSRI8QlwhPRQnEMZqx+6Zf
         T/UQ==
X-Gm-Message-State: APjAAAXb5ivhrQbwGH1PgT2Nk32a0lpcR3N++1qsrB4sltaVhp4xUVxy
        ZZ5Sr7sfgrcdkBRxkIfRXbL78eVZZH0=
X-Google-Smtp-Source: APXvYqxk+AZOaDH/Ah5XbLTmukG4DqBUEwZhwi6JjfpO5RGxWEzidqkzkQN/8/pw/36mVekf2YEHUA==
X-Received: by 2002:a5b:9cf:: with SMTP id y15mr358887ybq.324.1553120926743;
        Wed, 20 Mar 2019 15:28:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 207sm1148726yws.38.2019.03.20.15.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:45 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/6] test_sysctl: remove superfluous test_reqs()
Date:   Wed, 20 Mar 2019 22:28:26 +0000
Message-Id: <20190320222831.8243-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already call test_reqs(), no need to call it twice.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 780ce7123374..87df7e52a97a 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -675,8 +675,6 @@ list_tests()
 	echo "0005 x $(get_test_count 0005) - tests proc_douintvec() array"
 }
 
-test_reqs
-
 usage()
 {
 	NUM_TESTS=$(grep -o ' ' <<<"$ALL_TESTS" | grep -c .)
-- 
2.18.0

