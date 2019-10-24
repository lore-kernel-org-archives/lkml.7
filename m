Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9492CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409789AbfJXPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:53:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42414 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409778AbfJXPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:53:48 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFrlTK009596
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:53:47 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFrgIA020134
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:53:47 -0400
Received: by mail-qt1-f197.google.com with SMTP id 44so18982451qtu.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Xhl3yPOVTS2L2RYtPzBM49DHpAh9fTsOmofvxnsaE1A=;
        b=hnW0x2e8bv1L9L/fg8wgcS0MgoMcsdU6WjA+F6aTyTt5FSpnfAqE5IRa+JcIp4QLTK
         alV1ST8AveNPNNyXGN/JZNyPWZt+qrm0YdDlp51TQCREaElw4K/fgVrqUCb4kOh2FTuf
         Pn4Hx7pSG3hjyX/q30Y2PLetgR2cCaHLSnm+lmw0yY1iCZAG4yNYqBs7W6GIccJSO6tz
         SO3lB18JMMezfqWR9MlrzzB+A/FrZ8uHviOeZ3FFGbn2wbmRRAg8LioDvrJmi5huQo8s
         UXZZVUXGifBuPECDnwLw9Uawa9S3dkH3ZY+DQW60RFV9eD+Z2OWhGS3sL6LyyYbAj3jq
         fuww==
X-Gm-Message-State: APjAAAVGvgNlAgBghkGfJt2aCCxYE0SHwgMkQRyiX2XvEf2mQx1iwRWn
        Ol/S/pcBFtHElxGLDQmIx9CHNb2PlZ3t9FT6dvbfDYVi4oL3yixvSmbyoNKXYcNJTODGULg7Eml
        ugAdzV0oGoXPYOv2LRem6De2JU/6owrTgCtE=
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14451068qkh.259.1571932421701;
        Thu, 24 Oct 2019 08:53:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUv24uQguHXg4C03DgpvZQ5tzq4FGlK1SUvQChOMriwm2Q3/z3HIw7lT52ZNonLIB5QOV5vg==
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14451045qkh.259.1571932421394;
        Thu, 24 Oct 2019 08:53:41 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:53:40 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] staging: exfat: Clean up return codes
Date:   Thu, 24 Oct 2019 11:53:11 -0400
Message-Id: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code had its own non-standard FFS_FOO return codes. Go through
and convert them all the kernel standard -EFOO codes.

Valdis Kletnieks (15):
  staging: exfat: Clean up return codes - FFS_FULL
  staging: exfat: Clean up return codes - FFS_NOTFOUND
  staging: exfat: Clean up return codes - FFS_DIRBUSY
  staging: exfat: Clean up return codes - FFS_PERMISSIONERR
  staging: exfat: Clean up return codes - FFS_NAMETOOLONG
  staging: exfat: Clean up return codes - FFS_FILEEXIST
  staging: exfat: Clean up return codes - FFS_INVALIDPATH
  staging: exfat: Clean up return code - FFS_MEMORYERR
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS

 drivers/staging/exfat/exfat.h        |  24 +--
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 ++++++++++----------
 drivers/staging/exfat/exfat_super.c  | 269 ++++++++++++++-------------
 5 files changed, 249 insertions(+), 268 deletions(-)

-- 
2.23.0

