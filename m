Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01868C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC18A21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESoKyAKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfIHB2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIHB2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so5654470pgj.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjIHZRbAWXTBl2mfnAFwvjXmcOu2FKrrtL70NaJAR18=;
        b=ESoKyAKbjqJTL0j5XpvyNbMaduLKbdBGDe48z0BPjzbGjTtUsxZsYtz335/FzEeisi
         lm5uWhcK8DlF79hkfIpCo3Y0Ohp+DJfZsUh+dxO8Fdx32e5yihv8m14y1KHiXMz9dVnI
         /9cRX0wVMvVcyLbE7XtfhMeYvAFmIr66Yqmsh0Ro15WvK7yvQt4QVYYbMW6Xu+4+ggfy
         qNmhDgO9v9DaDiE9k2bnuvyuacyZyrK1nGE4GRIwFAc7mkCWDg8ikSr5aqbBqL2WTcSS
         zt+cNeBNXWcMc9DDefMEIYS8RGxC9z2GkUPbaF0lTCgj9prUuRMfHR2gOJyQ4JE3LA+f
         zImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjIHZRbAWXTBl2mfnAFwvjXmcOu2FKrrtL70NaJAR18=;
        b=BuR14Sl21oG+hEv8W90hdfnUVMYoYqPrTySsuFv/9mJOu7ABTgakwBnn/CSINOp+wx
         AvM86RKEvKoWuI0e03He3HGztPqovI/PylIoUj8yOecd9DfFAkI0E9AMhgkNLs4PHCGn
         MlqmnfiSgfuZM8ucfoDjDBfXJNtpLrf5bnZZFRNksKE3w9kDS21lKIi/rH9p2beZmPAm
         wSPFZ8Jy2t8MDH76rpAQxV4A//bDRl9YArLh3sFbFzAPv0fU7kcRuHHRq6GDvSwTuYj2
         VllRBemrxYx8c3nSG9Rd5VXbb1P257mqbDfbOpG9aZGxAr76jnnDugpH+B2GYSnoe7YI
         6zRg==
X-Gm-Message-State: APjAAAUKg97xevRtyDQ9Ldz//H1A00qToS1ikgxED2GPv6XnhWaM70v1
        c6Im19TYkcDWxDy5VcldcRk=
X-Google-Smtp-Source: APXvYqxVy7JaQmgbLhnDRnNyLp+f4T0yFRbw+Wq8lrUw5Eclzn5R4AOMtJ18aVwI8Fiw15zMnfWolQ==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr14820107pgv.437.1567906099557;
        Sat, 07 Sep 2019 18:28:19 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 0/8] kconfig/hacking: make 'kernel hacking' menu better structured
Date:   Sun,  8 Sep 2019 09:27:52 +0800
Message-Id: <20190908012800.12979-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a trivial improvment for the layout of 'kernel hacking'
configuration menu. Now we have many items in it which makes takes
a little time to look up them since they are not well structured yet.

Early discussion is here:
https://lkml.org/lkml/2019/9/1/39

Changbin Du (8):
  kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
    Instruments'
  kconfig/hacking: Create submenu for arch special debugging options
  kconfig/hacking: Group kernel data structures debugging together
  kconfig/hacking: Move kernel testing and coverage options to same
    submenu
  kconfig/hacking: Move Oops into 'Lockups and Hangs'
  kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
  kconfig/hacking: Create a submenu for scheduler debugging options
  kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'

 lib/Kconfig.debug | 627 ++++++++++++++++++++++++----------------------
 1 file changed, 324 insertions(+), 303 deletions(-)

-- 
2.20.1

