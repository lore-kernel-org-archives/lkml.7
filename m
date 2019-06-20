Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB384C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0352206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="adDajW9R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="adDajW9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfFTNqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:46:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:46:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E76C36087F; Thu, 20 Jun 2019 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561038358;
        bh=EVLOjBiuHAwvyWvBoM5vLEyeiGbRDiMlF01y77p98+c=;
        h=From:To:Cc:Subject:Date:From;
        b=adDajW9R26ZLq50ZmUogq+7HJkHeDy/6dHCZR8TOCY/j2l2QqNuN3/6IkI5gLUlX4
         gjXjRcHgaaFs1z4KMDvt3HMy4kZHOyEmZmLsLu6jQWmf3rNej36Bk5aXI5xrPLA9f4
         7+AFi2Ez9VqWkcRqQEPztd+QdfsfBeByFNu3YAys=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A54A1602A7;
        Thu, 20 Jun 2019 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561038358;
        bh=EVLOjBiuHAwvyWvBoM5vLEyeiGbRDiMlF01y77p98+c=;
        h=From:To:Cc:Subject:Date:From;
        b=adDajW9R26ZLq50ZmUogq+7HJkHeDy/6dHCZR8TOCY/j2l2QqNuN3/6IkI5gLUlX4
         gjXjRcHgaaFs1z4KMDvt3HMy4kZHOyEmZmLsLu6jQWmf3rNej36Bk5aXI5xrPLA9f4
         7+AFi2Ez9VqWkcRqQEPztd+QdfsfBeByFNu3YAys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A54A1602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/2] coresight: Set affinity to invalid for missing CPU phandle
Date:   Thu, 20 Jun 2019 19:15:45 +0530
Message-Id: <cover.1561037262.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of missing CPU phandle, the affinity is set default to
CPU0 which is not a correct assumption and leads to crashes
in few cases. Fix this by returning -ENODEV in coresight
platform and abort the probe in coresight etm and cpu-debug
drivers.

Sai Prakash Ranjan (2):
  coresight: Set affinity to invalid for missing CPU phandle
  coresight: Abort probe for missing CPU phandle

 drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +++
 drivers/hwtracing/coresight/coresight-etm3x.c     |  3 +++
 drivers/hwtracing/coresight/coresight-etm4x.c     |  3 +++
 drivers/hwtracing/coresight/coresight-platform.c  | 10 ++++++----
 4 files changed, 15 insertions(+), 4 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

