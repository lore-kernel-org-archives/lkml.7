Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08BB21880
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfEVWGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:06:07 -0400
Received: from mx.allycomm.com ([138.68.30.55]:28566 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfEVWGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:06:07 -0400
Received: from allycomm.com (unknown [IPv6:2601:647:5401:2210::49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id 82C893CB13;
        Wed, 22 May 2019 15:06:05 -0700 (PDT)
From:   Jeff Kletsky <lede@allycomm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild-all@01.org
Subject: [PATCH v4 0/3] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
Date:   Wed, 22 May 2019 15:05:52 -0700
Message-Id: <20190522220555.11626-1-lede@allycomm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses changes in macros and related data structures introduced by
  commit 377e517b5fa5
      mtd: nand: Add max_bad_eraseblocks_per_lun info to memorg

Resolves issue detected by kbuild test robot
  Tue, 21 May 2019 17:28:09 +0800
  Tue, 21 May 2019 18:17:28 +0800

GD5F1GQ4UFxxG data sheet on page 34 of gd5f1gq4xfxxg_v2.4_20190322.pdf
indicates "Minumum number of valid blocks (Nvb)" 1004 out of 1024 total.

Newly introduced "max bad blocks" parameter set to 20 (1024-1020).

Rebased on v5.2-rc1 and confirmed patch applies on master.


Patches 1/3 and 2/3 are the same as in the previous series.

Patch 3/3, mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG,
includes the additional parameter (compared here to v3 of the series):

    SPINAND_INFO("GD5F1GQ4UFxxG", 0xb148,
    -                    NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
    +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
                         NAND_ECCREQ(8, 512),
                         SPINAND_INFO_OP_VARIANTS(&read_cache_variants_f,
                         &write_cache_variants,

R-b of Frieder Schrempf removed from [3/3] as a result this change.

Supersedes series:

mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=108868



Jeff



Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kbuild-all@01.org



