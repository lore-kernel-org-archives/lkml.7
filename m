Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B2921726
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557873746;
	bh=CEq1uoZkzHjLbzPtgY+DvRqu68ZuVMQJBMyRDj8gLmw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j9pQ48NFgjwOa2BD0halBFI2x6eUTJ8EMKUmmahWLjr27iew+FrGeqi5pLX33i+KR
	 kr/lpmCac/ZHrXmunJ8JVtrmbKjFOV6ocOBTIdvaFT6cdYXF8PphF3wLi4KUCmDpu2
	 qQTg0ptrxuC+uZPaci3TeytmSQa01gYNEocj8A1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfENWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:42:25 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35572 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:42:25 -0400
Received: by mail-it1-f196.google.com with SMTP id u186so1492712ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/+UqoVyOLSQ0y8e5yE4txVnGHYAUO/Sws7YS3mRmnI=;
        b=cZl74vcnzPif//MhMVWyBs4L+OD+iNvZ9PMrJIAd8U6gbRh78KDyX4Ie6vEssxk3qW
         6RnVzdW5rufKwjHPvOu3iE6v4+P5P5nTfBUEoMZ4Xmn3kBzhJ2wz289Sq4IDi5s5ObU0
         N9B21WD5Dse36ePurthR+gIP6Xuf9Gj+rHnME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/+UqoVyOLSQ0y8e5yE4txVnGHYAUO/Sws7YS3mRmnI=;
        b=a/uHICdYUHV+FAsH7YLIUZxcIA9uySAoJFGFEhzw9qw8YGT4wbtYD799FkPR4J7uHP
         TA9STKphdwW4Ct05hK6cWVbBjDYGp89ljkT2qOcHFBZdK8ButSoH9GCBeHAgmXyZYfRp
         I9dJnhix6oIGlKhI8rNNA1jhG3eZD+gpaTubc9R+vqzpz9AO/BznN29ceJ7fzXBlwwF9
         8S0GqDrSPrrn53QaH3BV9G8A33f2xl/Lh472W2TjDPbrV973mdFdP/py+8aW5gRZxKyB
         rVrOvMmoGVKi4elhk7sPsbYwjLd4vQVAYz2173FCzwAGrfZA+L3tlBVyFDOIh1jtiAHI
         8x0A==
X-Gm-Message-State: APjAAAXjU91PNIsWHerI8BmyX+yZFglQ6b0y/64MWxIzqoeQ9ggOtN8a
        suOnhsP7HEWwdFQe6FXs1ddo7+JhgQI=
X-Google-Smtp-Source: APXvYqxHEpysOT+P5y8GAeYLfwQvzn2kRXUmfcK22Ut1cMilZdKlx1zEvZd6eCAoEiOsSheerXzRUw==
X-Received: by 2002:a02:694f:: with SMTP id e76mr25889586jac.111.1557873744534;
        Tue, 14 May 2019 15:42:24 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u134sm213608itb.32.2019.05.14.15.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:42:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: avoid KBUILD_OUTPUT dir cluttering with selftest objects
Date:   Tue, 14 May 2019 16:42:22 -0600
Message-Id: <20190514224222.31310-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make kselftest" or building selftests when KBUILD_OUTPUT
is set, will create selftest objects in the KBUILD_OUTPUT directory.
This could be undesirable especially when user didn't intend to
relocate selftest objects.

Use KBUILD_OUTPUT/kselftest to create selftest objects instead of
cluttering the main directory.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c71a63b923d4..9781ca79794a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -71,6 +71,9 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
+# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# KBUILD_OUTPUT with selftest objects and headers installed
+# by selftests Makefile or lib.mk.
 ifneq ($(KBUILD_SRC),)
 override LDFLAGS =
 endif
@@ -79,7 +82,7 @@ ifneq ($(O),)
 	BUILD := $(O)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)
+		BUILD := $(KBUILD_OUTPUT)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
-- 
2.17.1

