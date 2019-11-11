Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09896C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD3A214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497681;
	bh=6VIKjkADuQVWzy7sSUCb36dA36xQEKAE3RYlBg5BnCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgzlaUn+5dUfB81rvlwsJhyZMo8CMrrPzykh0lVXjYijnd7pObJVU+nn6QhYULCwv
	 sU3j5A+rvXsnqQM++2Dx7wOw2iiuS6P4Bbfh92fhxpVej0kTZq4FWB8HXS2EJ4iZCb
	 9Urngimni5ZGaexx2dOcPE7q4WpzROeWG5U/96oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfKKSlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfKKSlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:41:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1296F21E6F;
        Mon, 11 Nov 2019 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497676;
        bh=6VIKjkADuQVWzy7sSUCb36dA36xQEKAE3RYlBg5BnCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt9oUWPAJJAjQeePrJJ3lOPXwT80z2v0OVJgKrexL9k+kmweT9JE4MNA36aCEF+QG
         zR1vKDMIV/0Zg6r0aEESvLiVkIZ9AWYl6AEbM1InvHUGK4Yez6gNQ8tfdfYSlqe1h7
         HHVppEF93HAGM5zdOmzKLU3xxRF0+PzItE2VALc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 024/125] tools: gpio: Use !building_out_of_srctree to determine srctree
Date:   Mon, 11 Nov 2019 19:27:43 +0100
Message-Id: <20191111181443.791947996@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

commit 4a6a6f5c4aeedb72db871d60bfcca89835f317aa upstream.

make TARGETS=gpio kselftest fails with:

Makefile:23: tools/build/Makefile.include: No such file or directory

When the gpio tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/gpio Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=gpio kselftest" build failure.

Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/gpio/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -3,7 +3,11 @@ include ../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
-ifeq ($(srctree),)
+# This will work when gpio is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif


