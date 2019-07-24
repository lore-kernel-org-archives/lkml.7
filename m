Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B449C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE922387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSS6z2pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfGXLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:41:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38294 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfGXLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:41:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so20828376pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vUoAw9IYsxFSDNG2uruyjPHm6XhF4oDBz80MmGH0I+c=;
        b=oSS6z2pRqF5Ym3nqGS3x+om5IJIatfw2MYM+Z4wz63R3A3pKCb0+cfpjjn/S08EJ+G
         9ZFkJiQucJ9voR50uVSL4HUbiM23BPgL4Sa8cqixGTdIcMpDAaFl2ytXRhr9ESTcSb3E
         lcpb+5CxerBqXenXrR943zrp6J2vC8YhUaRIKZ9BQBHtYluJNxAMvZNprsmVbS//gWLo
         jGsOOuCEcTfkmbecwN3ADDjh3hsxW1OaQ3mCiwYeOSZS8aYII/POfoSnAUMep1H/h0h6
         THFPzi6BwrNaiK767akFUdWhBqT/6O1mDoT7T0U6Hxrrk+7qc5uQoSsx0DYyG6QQKJ2i
         /kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vUoAw9IYsxFSDNG2uruyjPHm6XhF4oDBz80MmGH0I+c=;
        b=VQcvuiPm1ql8M4NJX/YmeGEX+z7mSkLEuy64NED/xKM6PiWF25K4WctH48cqFCjFyl
         f5vzM4502Hji/aR4FUc2K9Z9OcVYIlMQm0SNA/r/tYC5YHm1/NMH/yL2gXrbKHY6b+1x
         wFJd4D01nXYdcU0vXt9T6pXT1StiYJhtjhiVmIeIF08AMnP4kFiY3aE8gI7SIguqYUAo
         RATGSslhohhes0cXnNpGCFogfiDYHPaQ5GJFHRfhH8k96NrnAe/0BTweRTydKUoukHgr
         YVeu5pDTcqw84Y/E+0jmJ+Z8mk77bzsmEMEJ4jDFrna//3+5dBKUC3DA11tvvReHeoFq
         xvAw==
X-Gm-Message-State: APjAAAXa1JNp7nnVE71TxcJyH1O/Y89jWwLn2KNm5XeGVZm8OKFRcOeV
        KhkopO5lG7RNHPyOF/rp3ow=
X-Google-Smtp-Source: APXvYqxfrWQEe5JThmMch91J5yQRowYBVSY6S4IZZQAYyTJ6Dy1JLZ0Er7W6o+H7JETocCb0dOJkqQ==
X-Received: by 2002:a17:90a:8c92:: with SMTP id b18mr85654749pjo.97.1563968490088;
        Wed, 24 Jul 2019 04:41:30 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id a16sm49348659pfd.68.2019.07.24.04.41.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 04:41:29 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v2 0/3] sgi-gru: get_user_page changes
Date:   Wed, 24 Jul 2019 17:11:13 +0530
Message-Id: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of the patch series with a few non-functional changes.
Changes are described in the individual changelog.

This patch series incorporates a few changes in the get_user_page usage
of sgi-gru.

The main change is the first patch, which is a trivial one line change to
convert put_page to put_user_page to enable tracking of get_user_pages.

The second patch removes an uneccessary ifdef of CONFIG_HUGETLB.

The third patch adds __get_user_pages_fast in atomic_pte_lookup to retrive
a physical user page in an atomic context instead of manually walking up
the page tables like the current code does. This patch should be subject to
more review from the gup people.

drivers/misc/sgi-gru/* builds after this patch series. But I do not have the
hardware to verify these changes.

The first patch implements gup tracking in the current code. This is to be tested
as to check whether gup tracking works properly. Currently, in the upstream kernels
put_user_page simply calls put_page. But that is to change in the future.
Any suggestions as to how to test this code?

The implementation of gup tracking is in:
https://github.com/johnhubbard/linux/tree/gup_dma_core

We could test it by applying the first patch to the above tree and test it.

More details are in the individual changelogs.
Bharath Vedartham (3):
  sgi-gru: Convert put_page() to get_user_page*()
  sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
  sgi-gru: Use __get_user_pages_fast in atomic_pte_lookup

 drivers/misc/sgi-gru/grufault.c | 73 ++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

-- 
2.7.4

