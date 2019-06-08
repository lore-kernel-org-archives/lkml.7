Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 02:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497E9208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559959970;
	bh=KsshRzfUjRf8NPLbJqIGbVGjeL9yE4+ynerqefj3pNE=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=IhnkkVe5KiACL7V9SnwnN4SYotNyYCmgsECC2Bw/tmk9yp6e0xJdgEHc94gM7YnE4
	 TMJJV0VsI2RMZW+iNxbmcA4F8cJ5zu9po3G2twcG/nihaX+tMdEnUOJTFkQMOdUOLm
	 d0weqccdzXA7Fhr1fhv9f1z2bnmOeKTK8LUwBGBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFHCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 22:11:09 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:55556 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFHCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 22:11:08 -0400
Received: by mail-it1-f173.google.com with SMTP id i21so5517924ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=SvnI0124RQyG3mZdpITe2RKpNEsDCUsmCfQu//JUzcY=;
        b=X09+drmRRIGFjuEz2GoZ5RiiSac8xIMyegzJZbLbA4yEx6SaI+WwsWCNvrkboqmVO5
         /3OKP6FqiuR27MeClWl3Hnlp9d8sGh+bYsQvvFD8ZWBAGrq/SIq74L4BZc5rVua/GBE2
         X2wo7BqzVQtAuLSgvtG91e0xPHf+yZs/xHARM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=SvnI0124RQyG3mZdpITe2RKpNEsDCUsmCfQu//JUzcY=;
        b=PR/e0n9sASE//SLjfkWGq4wrq5Ikr2+jXyyxEYl/fuSgXZl03RQJ5whnfGlHnTDOI/
         YFRcWTNgCJBHbGis6VK18Pn0ibNafdWdxhdH1epfGj2ssN/cnhlbZhGhj6gQNAdUe1Ky
         5hFyVusNcaB12yXRGqDlOecL3zJUQU7efgkU21YoANyJS8ZqZqWD/GB3cG3Oy8AW7bwO
         kdLXG3xCr5r6BO6HygJvLCS26DcO9f23oZm87hQkkKpSuqc674NDc+DaMuhBshUZQi5x
         N8Ma4NtSobNXbf3KCDvC2OMpkQX1zgA9p3wYa+SWqSWbZn4Ss+dN7bCEztb1dNBf9xbZ
         3Kwg==
X-Gm-Message-State: APjAAAXFayVQSK1BmYYpCZkhrO2VDdw6cPtglpU/0mfS9FiAZXoS99EK
        ENqw/RYNF4lfJ3xwaXgbM1gj5g==
X-Google-Smtp-Source: APXvYqyvNxcDeEsIA5sWyry2m2CfkiS2/C5q6ZoBbN4kth6uYuymFdU5J9mFZl1P9fa7C82Zrr2Cww==
X-Received: by 2002:a24:d147:: with SMTP id w68mr6591208itg.176.1559959867659;
        Fri, 07 Jun 2019 19:11:07 -0700 (PDT)
Received: from [10.11.17.215] ([97.107.68.205])
        by smtp.gmail.com with ESMTPSA id z202sm1979011itb.2.2019.06.07.19.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 19:11:06 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     skhan@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest second fixes update for Linux 5.2-rc4
Message-ID: <f97f7947-db3b-07dd-157d-78ab9840a4dc@linuxfoundation.org>
Date:   Fri, 7 Jun 2019 20:11:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C8926D04930EEB99C63E8D8F"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C8926D04930EEB99C63E8D8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following second Kselftest fixes update for
Linux 5.2 rc4.

This Kselftest second fixes update for Linux 5.2-rc4 consists of a
single fix for vm test build failure regression when it is built by
itself.

I found this while I was sanity checking the first fixes update for
Linux 5.2. Would like to get this into rc4.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32:

   selftests: vm: install test_vmalloc.sh for run_vmtests (2019-05-30 
08:32:57 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc4-2

for you to fetch changes up to e2e88325f4bcaea51f454723971f7b5ee0e1aa80:

   selftests: vm: Fix test build failure when built by itself 
(2019-06-05 16:05:40 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc4-2

This Kselftest second fixes update for Linux 5.2-rc4 consists of a single
fix for vm test build failure regression when it is built by itself.

----------------------------------------------------------------
Shuah Khan (1):
       selftests: vm: Fix test build failure when built by itself

  tools/testing/selftests/vm/Makefile | 4 ----
  1 file changed, 4 deletions(-)
----------------------------------------------------------------

--------------C8926D04930EEB99C63E8D8F
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc4-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc4-2.diff"

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 05306c58ff9f..9534dc2bc929 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-ifndef OUTPUT
-  OUTPUT := $(shell pwd)
-endif
-
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
 TEST_GEN_FILES = compaction_test

--------------C8926D04930EEB99C63E8D8F--
