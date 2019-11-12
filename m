Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6927F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKLCNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:13:00 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48424 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726965AbfKLCM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:12:59 -0500
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2CwoW012069
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:12:58 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2Cr8g020667
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:12:58 -0500
Received: by mail-qv1-f71.google.com with SMTP id bz8so5467129qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=polEwBDR8XXLARzNp+HkpzWHOByZmMxX1iuAZdjZWhc=;
        b=mWJm0IPFxqt3IvDxGIvn+hiTVmKcE7ary1cTeDnWJG6ZFSH1CPNYuOfb0eJbGkxVDV
         fre0Zg4pl5g/RoRtA9V3nchjzrVPLZAh1zbGnSrhTa+XJUdkuEy6JCh4QDnqtgdqnRa3
         NVIHAcJ7ixpDDmOwFd0lOgOvFp2d4BnxwC8FvcCgqIMRGqUlGXrA0F6SQgPvg2v9Zql6
         AZqoYSX/6YBV0lnnZYMFV3/gScVo0vAkpIpSE/z03GsTd9J/tOgiSgnHXmJg/goKum5/
         mG6s7qrNtq777/h0UaDa2/H9W34j+CNZUJXoKpWsob4pdIwFm7TYYQcOU3A3nmHHbJ94
         q1bQ==
X-Gm-Message-State: APjAAAUYDKB+iHnqR/Rp6rQgt3RGLnEnvnf2KOtXqTElARuYqrzj/002
        of8lVSyrs8NuYRRJQqlY2eSD9vunGHCnnhllhWU1XxjIvvORqKi2EKar9b8nm1qphfriyJXHbRD
        5AKTIMw8sQn7W5OljgONcPNCIlJQ9xU+jtOc=
X-Received: by 2002:a05:620a:896:: with SMTP id b22mr12855087qka.386.1573524773447;
        Mon, 11 Nov 2019 18:12:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwy3ab3YXg8NLEvbLnXy2wX6Wbxx2azYGpPT3/n2YbPGjWD4sfMc09fWFB7AQ+6oEC2HKezhQ==
X-Received: by 2002:a05:620a:896:: with SMTP id b22mr12855078qka.386.1573524773159;
        Mon, 11 Nov 2019 18:12:53 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id v54sm9150233qtc.77.2019.11.11.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:12:51 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH v3 0/9] staging: exfat: Clean up return codes
Date:   Mon, 11 Nov 2019 21:12:42 -0500
Message-Id: <20191112021242.42412-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the oddball return codes with Linux-standard values

Changes since v2:

Fixed the git miscue that left one patch fragment in the wrong commit
Dropped the patch that added EFSCORRUPTED to errno.h because that method
won't work on some architectures.
Rebased to today's staging-next tree.

Valdis Kletnieks (9):
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS
  staging: exfat: Collapse redundant return code translations
  staging: exfat: Correct return code

 drivers/staging/exfat/exfat.h        |  16 +-
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 +++++++++---------
 drivers/staging/exfat/exfat_super.c  | 293 +++++++++++----------------
 5 files changed, 229 insertions(+), 304 deletions(-)

-- 
2.24.0

