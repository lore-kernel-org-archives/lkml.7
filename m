Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A218C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507C1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCLKPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:15:23 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58084 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbfCLKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:15:23 -0400
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CAFLe6001379
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:15:21 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CAFGck014488
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:15:21 -0400
Received: by mail-qk1-f198.google.com with SMTP id y6so1759432qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=jYRtTMZgSBw9FUyn4prufrcg0hkKiZX0s0AfG0KXxRM=;
        b=cnEQYOO0JQXdqqyFvwRrhvplDIw0bKYtDywJfNv/oR4ie97gss3WkDSpr2ej2Ar4JK
         VDF1YwX2ZQ1korUv6u3s92i06d3u/8odOEuA++tN7slewmnlAOYNBD0rfR4oiy6JfKTK
         k9z5WGqYSKEBCZLaYHPb6r0SFWF0Isg+CxeEIwc9h7WtWm9DCKFA240SsveaTeB3M/aT
         OAadu8fMs3IqWHuGLZaFTCV5N3VlGeNU/BsaivCYK/WaZn228mOYYuRjviXrImDWURnb
         /Xxbz+cb6ALsS1StzRDc4zlMg2N54tu+P2+6sJNLE4R4nVn33QQDImEZsbQQJVFQnSlZ
         UOww==
X-Gm-Message-State: APjAAAXUKWUmGcmQX4/jH0ygdvv0mwwqTvWYctsCj8hzWiIjPJ5gupct
        BflGMM4h3yUpCoCY8OM4ISqkbELHcNS51yyk1WmHglMmjCqwdF4Eb06FCbQum6kYeqGrMJw1rvR
        rYefarqqzFWpuVlMi3LGmoobF0v67QW8UNuE=
X-Received: by 2002:ac8:7642:: with SMTP id i2mr13786994qtr.287.1552385716667;
        Tue, 12 Mar 2019 03:15:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfQC6SvSZeau3BCCodesw24EDQyVHaFSPuXLcRCb4q97Piiaa3CvOEvm68BKbfwaxIbzaQNQ==
X-Received: by 2002:ac8:7642:: with SMTP id i2mr13786985qtr.287.1552385716464;
        Tue, 12 Mar 2019 03:15:16 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id l34sm5718424qtc.44.2019.03.12.03.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 03:15:15 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/handle.c - fix up kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 06:15:14 -0400
Message-ID: <11153.1552385714@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      fs/fhandle.o
fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'

Fix apparent typo in the kerneldoc

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 0ee727485615..01263ffbc4c0 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -246,7 +246,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
  * sys_open_by_handle_at: Open the file handle
  * @mountdirfd: directory file descriptor
  * @handle: file handle to be opened
- * @flag: open flags.
+ * @flags: open flags.
  *
  * @mountdirfd indicate the directory file descriptor
  * of the mount point. file handle is decoded relative

