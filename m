Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4F20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="h4jUR38z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfCRCym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:54:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42749 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfCRCym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:54:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so7476749pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBM298OWC/68hXsVvB3v7cOIuhlltKJxNV3Q7t/RT9I=;
        b=h4jUR38zQU3gMnsCKMPWhSi2NBiIxJgknEgXDGKuF0z2LFBMjDEr2gCNWKYdLif+QG
         36VYwpt1TriQgA10rSoKJUVsPcl8kBLaxE9jLMzcyM56VIlVh1mBAU99nZbytReWevFl
         DfGEz0sfBo2nk1/D1IFLHB30dW7Ku9AUz069FwihgAsgcyo+JoPm2r0/Wx3WjQBVcMYa
         eySnL29jNzhWxvIRIAnwFSwJyuZwtK+VO46vWbxLMIL05xrE/05GDkbHo8ac0bkJUhTH
         hq1YbjOTd1YXMZwxyA8d0yeQ5cxuKFuu0qwxsX34nmsKZ4wXBmvaYLgutqhraLa0N964
         45NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBM298OWC/68hXsVvB3v7cOIuhlltKJxNV3Q7t/RT9I=;
        b=mPCB+fOGyyPgaInUGsn032Sqdd8MM02n9l2NxdHadRI7xjZmf1bYG7DzTYSnegkEoC
         MW+bgIwjoLFaFchsj9zqX8EJYOF2dfB15IGES5GiWEMVdK7eDK7/KohgRXMq9iBnsMHb
         x/tjNnBpf9E/MLUWcqFjdvlHhCcpKcstUL6JBJoPY0RZCtZiJOWW9S14bICH+27XM15B
         j4Ps0M2/Y0o4tqKX1TVhsxe1ZtUoYm9dKViIaUcSapHDsx1in3jYcNnnK8l6gBhfbkqS
         bOpCRQxxavTOFrfK+1qYE1+7BkqPGrX5ruvV59U7DOOnCoiw6uGV3FtpsCncTBFPZKl2
         vEOQ==
X-Gm-Message-State: APjAAAUEDK6B4jgTppbmK3TI4dLXIy++2FiDNatZEJjgvIR/fRLfKo8b
        CvejMOuXQmfuoeGVqJnC0fn5vg==
X-Google-Smtp-Source: APXvYqzf7gap0V7iHRZx5jyM9zzl9X8dCF4sf1O6S+tR9MXuMShu8amDIdCX5Vrd5Y3rt4lLd2CA4A==
X-Received: by 2002:a65:6119:: with SMTP id z25mr3720620pgu.402.1552877681051;
        Sun, 17 Mar 2019 19:54:41 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i126sm13672955pfc.101.2019.03.17.19.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 19:54:40 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        Tri Vo <trong@android.com>
Subject: [PATCH v4 0/3] gcov: add Clang support
Date:   Sun, 17 Mar 2019 19:54:08 -0700
Message-Id: <20190318025411.98014-1-trong@android.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Clang support for gcov.

Patch 1 refactors existing code in preparation for Clang support.
Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
Patch 3 updates documentation.

Greg Hackmann (2):
  gcov: Clang: move common GCC code into gcc_base.c
  gcov: Clang support

Tri Vo (1):
  gcov: docs: add a note on GCC vs Clang differences

 Documentation/dev-tools/gcov.rst |  18 +-
 kernel/gcov/Kconfig              |   3 +-
 kernel/gcov/Makefile             |   5 +-
 kernel/gcov/base.c               |  86 +----
 kernel/gcov/clang.c              | 586 +++++++++++++++++++++++++++++++
 kernel/gcov/gcc_3_4.c            |  12 +
 kernel/gcov/gcc_4_7.c            |  12 +
 kernel/gcov/gcc_base.c           |  86 +++++
 kernel/gcov/gcov.h               |   5 +
 9 files changed, 723 insertions(+), 90 deletions(-)
 create mode 100644 kernel/gcov/clang.c
 create mode 100644 kernel/gcov/gcc_base.c

v2:
- Reorganized config dependencies, as per Masahiro.

v3:
- Squashed patches 2-4 of v2, as per Nick, Masahiro, and Peter.
Addressed comments by Peter:
- Moved __gcov_exit() to gcc_base.c
- Added missing header to gcc_base.c
- Removed unnecessary boundary checks in gcov_info_add().
- Changed counters' allocation to use vmalloc().
- Added check for failed allocation of filename.
- Changed list_for_each_entry_safe to list_for_each_entry when traversing
  without modifying.
- Updated Documentation/dev-tools/gcov.rst

v4:
Made following changes to pass kernel module test cases suggested by Peter:
- Generic code in base.c unlinks gcov_info data sets while iterating over
  the gcov_info list. Changed Clang's gcov_info_unlink() to preserve next
  and prev links of the unlinked gcov_info instance.
- Attributing a given gcov_info to a module is done differently in Clang vs
  GCC. Generic code in base.c needs to do this. So added
  gcov_info_within_module() interface to gcov.h to abstract away the
  difference.
- Clang provides checksums for each function. These checksums are used to
  determine whether the source files of the compiled kernel module have
  been modified. Changed gcov_info_is_compatible() to account for
  function-level checksums.
Addressed comments by Peter:
- Removed unnecessary #define, if-clause, empty line.
- Amended commit message to note documentation was adjusted to account for
  the removal of config symbol CONFIG_GCOV_FORMAT_AUTODETECT.

--
2.21.0.225.g810b269d1ac-goog

