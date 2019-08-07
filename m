Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EDC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8977208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfHGXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:22:43 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34350 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729934AbfHGXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:22:43 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77NMgPT001863
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 19:22:42 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77NMbEx019865
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 19:22:42 -0400
Received: by mail-qt1-f199.google.com with SMTP id e39so83558696qte.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=UNk1qvGbMsnH36vrlaPqG20pRJ089hDQPxCQ+ADKkjk=;
        b=N/i1cBbw3nRWpZSIDSTl5ueSwNLm911kXULtUbKgXYiFsb0YWSkwUKn2o+goqSQU4x
         e33DMXXSTplsAANOkdzJ8pLATgIMAW36lsVg5SeG5khwmAYAgnBA7dTFHp0U5daM8tKS
         r/t+wEacAYspwFsaRywlQ14SfqV/IYen4HBnZ+xLIsNfMtDdfMmbAlr7ypUjnxPZNN+A
         l1Zh44SUmMo4Raw48rgO26BHhMtVVlavNjxWJPrCJEYzEy3Ub3QS5gs7JPo7Qoy2tjK6
         claWMLG0q5DL+L64amUWP5FliGQq23dDV+sB5d2hMZ/14jiqaCIW8Mu66RTzSn5wTLJ9
         Lv+g==
X-Gm-Message-State: APjAAAUof5D5E7RMUE/7Boxhlxv6EYuu2EdD9g/5628P0LGQfoAqQk80
        qPg8haKrkSN8OkQFRHB3B058xmQnvMYT8Oa7dbaQGsX90+pIEn/RCKzWs7I8kJ6CvdoD+KFwkIo
        H/UrcOoAahBcPUgHPCmhVXbEenZ8fZ8jmOHE=
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr10283612qtb.47.1565220157035;
        Wed, 07 Aug 2019 16:22:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaJHDNqmO8W/CMRvdYfu7239KdzjjQ6RdavRjM7SbTfbvj2lIv9ZkKmE9q8G44QWAGA8kpMA==
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr10283601qtb.47.1565220156822;
        Wed, 07 Aug 2019 16:22:36 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id z4sm44729993qtd.60.2019.08.07.16.22.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 16:22:35 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] fs/handle.c - fix up kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 19:22:34 -0400
Message-ID: <8606.1565220154@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, we get some kerneldoc warnings:

  CC      fs/fhandle.o
fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'

Fix the typo that caused it.

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


