Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6020656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuouN4ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfH0UmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:42:01 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33526 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0UmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:42:00 -0400
Received: by mail-pl1-f201.google.com with SMTP id f5so220026plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LJptmiK1btd/bB95w4TiVPIKC2dOAjGnNGL3U/KjokA=;
        b=ZuouN4ZFBETCtERSSVFZ0salbufQVVf0J3cVYgPxhSD9AoPdsTJvQRue6tIyh9GJ8h
         rAWP5LrnzvOTnNSOFrfH2ADODIW5lMqik8Bv+wLrBPnv1nqVdcY2+yaMQkvjVkxkH1y8
         y/qBHf5A3gpeQZEKDqWu4oUgc+KUd5TBmyCv22fG9SsnbNOtFoo0VK7VPtqu2tWLwoOQ
         nt4dERai2jvfo3mQU6NpuN2DzPUYec31msebPLJGDZR6tpxIErKmxC/pfZrCsCaSdcXi
         Wjda+Hw873r10nlb6RduCNd4rgKm5zjJ4gH2aHkYUSxIS+6oZM+gjHtD/ZUHQe8kymOB
         phWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LJptmiK1btd/bB95w4TiVPIKC2dOAjGnNGL3U/KjokA=;
        b=sXSEN1yzwZYrs1zJycK1BOr1iGbpMzMXcExVXUFCfF3uHBtdSCr7QAJV4lTrwNHlZ+
         068vv5FqjeKd2tv4SixHv7rdt/QBgrwxS5SHOWFNeiEJn3vgk5dRxRAIfLtYNGvJhxuY
         gi7SeG87gw/SyJUl3UxxuI+QvNdiAxh2o7h9LeCf74KaSZw5BlEYA/C/uzrLOYfRGloc
         8fEg/KoM1TpzFihk2Jw0+4w33D1gvWmkrlSEEfDGDewdVRnm+y4eW36bpq2UOkB5v9XK
         TpyI/yLhwqBtpgowqbHYbnajA5Urgi+BX4WSOO4orPq+3+AxP45mf1SH665rQ7S7jgm0
         oraQ==
X-Gm-Message-State: APjAAAXl4ZcsAMuSEUx6+kEabwRKk1JTzLudv9Sy3R5tOPzAcnFEsfO2
        vw9bd/B9lkQmZD90vjDiWVLxaLqLh/Y=
X-Google-Smtp-Source: APXvYqxu3WEe3wPUja6mVcmwhx+wmdvvyBml5N7haGyA00rIigiytswt6qtesqDqnWVUqBQWtR6PH/BcxTg=
X-Received: by 2002:a65:6557:: with SMTP id a23mr260111pgw.439.1566938519509;
 Tue, 27 Aug 2019 13:41:59 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:41:48 -0700
Message-Id: <20190827204152.114609-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 0/4] Add binder state and statistics to binderfs
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to access binder state and
statistics is through debugfs. We need a way to
access the same even when debugfs is not mounted.
These patches add a mount option to make this
information available in binderfs without affecting
its presence in debugfs. The following debugfs nodes
will be made available in a binderfs instance when
mounted with the mount option 'stats=global' or 'stats=local'.

 /sys/kernel/debug/binder/failed_transaction_log
 /sys/kernel/debug/binder/proc
 /sys/kernel/debug/binder/state
 /sys/kernel/debug/binder/stats
 /sys/kernel/debug/binder/transaction_log
 /sys/kernel/debug/binder/transactions

Hridya Valsaraju (4):
  binder: add a mount option to show global stats
  binder: Add stats, state and transactions files
  binder: Make transaction_log available in binderfs
  binder: Add binder_proc logging to binderfs

 drivers/android/binder.c          |  87 +++++-----
 drivers/android/binder_internal.h |  84 ++++++++++
 drivers/android/binderfs.c        | 256 ++++++++++++++++++++++++++----
 3 files changed, 355 insertions(+), 72 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

