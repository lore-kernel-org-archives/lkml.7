Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D6ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CF520659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBYiWhCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJKGDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:03:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34830 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKGDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:03:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so5427652pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Por79pKV7/zxavztiqV46lugG6MuHRsk2OLPtNOwr00=;
        b=OBYiWhCtNkd2IIOgjtym3d9Naqwmjj78kiNv7xSHnP38ZF2KTdRA9uSR83WWkKRu/J
         31A8Dv/7jc16ipWUxsTijs27RLbJByqq+LJyCpo3WGu41iXrI2ScMOucuvGVg1yAbiSm
         5n9W4L0bD4Z0RuXcZ8Oi/9ei1AwSYGeV2ZprddLzluJbVNxgHYolBzD5JhZl10DWDn+l
         VoIBpL0KsOjPM283XxSY31gGobT+b3w/kMcPYUUap7qifk9E+uKDm+/Z0qpnmCIRNFvH
         tOGoxuI9kJFsiINMatT2KTToI742hnNJs76lJVVVsLiSWTGvcgPIHT7r835+8D2OfDgN
         V0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Por79pKV7/zxavztiqV46lugG6MuHRsk2OLPtNOwr00=;
        b=QfVXUQ37O5K06rF5CdY4UfgbCcEmwtZl2If/ltZLLoeb0uarXLrNcXfespDJc0J0VR
         IofAUVSPYKtjY6Jj96bQdqlrSOZBfJ1wWt0WWKUVbE0Rfd6GGLjK8PPDil9/bvIsDCdD
         A+Eg7Eiva8CKQp0Q5wV12n/Kgg5jlIfZEa+v7lVJAXM51p7HqVgg3AUZro9ufxvk+S5K
         1YH7pA8c3tysXQu3vonA7xsADqUH/hL0Qkpid6Td5GV6Ow7RMTI/+KUZtXunM0RUZhEh
         U2jDJi4wdGQ8EOmBRLD4tDeOMx24h7nk8/JeJRsfHE38GaIdL2VrsRX5MNDm+SYzMUoa
         j4Uw==
X-Gm-Message-State: APjAAAUOpMF/TRvm3psgEut9CJzEkOvX4K56IWZNBAfi2ANvUSCG5oy9
        ZBP3xSV76u3t+9KhTJ14WFE=
X-Google-Smtp-Source: APXvYqyrkXXaI1IB1/DY7cOW+gtU8daBZ7tetl0LvYq0wD2ambmdsFWR89IJElTcRHHMlfOBhof01A==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr15604104pgb.416.1570773779760;
        Thu, 10 Oct 2019 23:02:59 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p11sm9395715pgb.1.2019.10.10.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 23:02:59 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 0/5] Remove declarations of new typedef in
Date:   Fri, 11 Oct 2019 09:02:37 +0300
Message-Id: <cover.1570773209.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes various typedef declarations of new data types
in drivers/staging/octeon/octeon-stubs.h.
The series also changes their old uses with the new declaration
format.

Wambui Karuga (5):
  staging: octeon: remove typedef declaration for cvmx_wqe_t
  staging: octeon: remove typedef declaration for
    cvmx_helper_link_info_t
  staging: octeon: remove typedef declaration for cvmx_fau_reg_32_t
  staging: octeon: remove typedef declartion for
    cvmx_pko_command_word0_t
  staging: octeon: remove typedef declaration for cvmx_fau_op_size_t

 drivers/staging/octeon/ethernet-mdio.c   |  6 +--
 drivers/staging/octeon/ethernet-rgmii.c  |  4 +-
 drivers/staging/octeon/ethernet-rx.c     |  6 +--
 drivers/staging/octeon/ethernet-tx.c     |  4 +-
 drivers/staging/octeon/ethernet.c        |  6 +--
 drivers/staging/octeon/octeon-ethernet.h |  2 +-
 drivers/staging/octeon/octeon-stubs.h    | 56 ++++++++++++------------
 7 files changed, 43 insertions(+), 41 deletions(-)

-- 
2.23.0

