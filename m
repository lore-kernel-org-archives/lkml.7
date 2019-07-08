Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC7C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76F21783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g1j6LoPa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RlxX3GiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfGHTAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:00:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731441AbfGHTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:00:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FFCD60FE9; Mon,  8 Jul 2019 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562612453;
        bh=3cZ120rfFscLjFKv5nknwSkEb05XjN6zsQhL+0Uk7mA=;
        h=From:To:Cc:Subject:Date:From;
        b=g1j6LoPaI/+wTOsEw8t+ilntBs99VUFNL2oAqVgkWMt7JpF/I6zD4AusUlN+gbTIN
         KhIxdl59ekJSr0ovtRKdFugLystTw/kd7nrVGV8R3ZBHh0CeNToUU3E2WnXHeBLywI
         On01R9Eygl+8egTxC+YzUsCatNy0mC1kglBnJ6Nw=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7647C60E3F;
        Mon,  8 Jul 2019 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562612452;
        bh=3cZ120rfFscLjFKv5nknwSkEb05XjN6zsQhL+0Uk7mA=;
        h=From:To:Cc:Subject:Date:From;
        b=RlxX3GiGklNIZkgVbwds5vGc/pv3hVX+zqgSNP+HNfsm24k64LSUODh3aC3fMWjJL
         X0hcGZee8Nkg+jE3I1wgIg51HApyOTNFneQmhTD8a5DQnMbqfk4jLyPETtxuDtki4E
         Q9prYAIIOOnhj6gIaNiBYZLNVn2siZMldjiyVJXw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7647C60E3F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 0/3] iommu/arm-smmu: Split pagetable support
Date:   Mon,  8 Jul 2019 13:00:44 -0600
Message-Id: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(RESEND because I fat fingered a email address and I didn't want everybody to
get a bunch of SMTP errors)

This series implements split pagetable support for arm-smmu-v2 devices. You have
seen this code before as part of [1] but I split it apart from the other
features to make it easier to review / merge.

This series adds a new format type to io-pgtable-arm to enable TTBR0 and
TTBR1. Because of the way that the registers are mixed up it makes the most
sense to enable them together instead of trying to create two different
pagetables and merge them together later in the arm-smmu drive.

This will be used later by the drm/msm driver to enable split pagetables
as part of the effort to implement per-context pagetables [2].

Thanks,
Jordan

[1] https://patchwork.freedesktop.org/series/57441/
[2] https://patchwork.freedesktop.org/patch/307616/?series=57441&rev=3


Jordan Crouse (3):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/io-pgtable-arm: Add support for AARCH64 split pagetables
  iommu/arm-smmu: Add support for DOMAIN_ATTR_SPLIT_TABLES

 drivers/iommu/arm-smmu.c       |  16 ++-
 drivers/iommu/io-pgtable-arm.c | 261 +++++++++++++++++++++++++++++++++++++----
 drivers/iommu/io-pgtable.c     |   1 +
 include/linux/io-pgtable.h     |   2 +
 include/linux/iommu.h          |   1 +
 5 files changed, 256 insertions(+), 25 deletions(-)

-- 
2.7.4

