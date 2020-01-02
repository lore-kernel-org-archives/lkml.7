Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06835C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C676824649
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003358;
	bh=iXszqpez7cW5kFoYt1EbqfL7aHPMczCqNvmErBzKnmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08mkglQ8UsneT9lSsNtb+9XP+3wuz3dKeutDuw7ltQrB4JSw/jGDL+QAXTjNOCpZk
	 Mp7eeQHUs2wnp/E2jtcog5lInTcqNafkUde6Qziv2bZemfZ3Qaz4+F2XEBo2hXgLaD
	 3cMlzhBgklWb4L9qhmeLUISwgyAoutCS2W1Nes0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgABWP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbgABWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:15:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D3A22314;
        Thu,  2 Jan 2020 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003354;
        bh=iXszqpez7cW5kFoYt1EbqfL7aHPMczCqNvmErBzKnmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQYU04NmP1W1/OP+jdOnsjyAvNjo6tSrlMOgGPwLs/QApSB6Vu39auacipxd65uef
         TCDCXdJ91Cv8/A9+opMREZxJ7RmxpMlTmzqgjRlqml8NrB4a70TaL9h+TMHhRFikRo
         kB2d9Pju9oiWxDiAj0xoTKcsxAu3FYshUht6QFHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 126/191] selftests: vm: add fragment CONFIG_TEST_VMALLOC
Date:   Thu,  2 Jan 2020 23:06:48 +0100
Message-Id: <20200102215843.267990228@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 746dd4012d215b53152f0001a48856e41ea31730 ]

When running test_vmalloc.sh smoke the following print out states that
the fragment is missing.

 # ./test_vmalloc.sh: You must have the following enabled in your kernel:
 # CONFIG_TEST_VMALLOC=m

Rework to add the fragment 'CONFIG_TEST_VMALLOC=m' to the config file.

Link: http://lkml.kernel.org/r/20190916095217.19665-1-anders.roxell@linaro.org
Fixes: a05ef00c9790 ("selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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



