Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51906C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223AA216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DiGQj/UC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lVROsomG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFZS7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:59:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfFZS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:59:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 730B360256; Wed, 26 Jun 2019 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561575593;
        bh=8WgmiRB1fwqFJ3XjC6N9Q04m667OxWcKK9L96wS4Tsk=;
        h=From:To:Cc:Subject:Date:From;
        b=DiGQj/UCkPmZa72HQzDxW4zNutbh5CkGyKYgjGrx21p7af4nxtho4B4A/ZKpYBV8F
         WlgCcZIiMsT/MQ2+crA5LLgoFe2mbaPLJMh3YGhNpLCiKiqJiKMCvOYspTAk6ppU8o
         K1fZ+h5n83zqLshZJH6P+zo/bWqdn4kEacfaBffk=
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 068EF60256;
        Wed, 26 Jun 2019 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561575592;
        bh=8WgmiRB1fwqFJ3XjC6N9Q04m667OxWcKK9L96wS4Tsk=;
        h=From:To:Cc:Subject:Date:From;
        b=lVROsomG7J5KhvmiaQqdVdDRFW7mH6K987cKEcd1d5bHXrc5xj0UQZjFlgPkzwq5Q
         UKG8tPaqsSdcEUAXecDp8aEBRuqQGWqm1gv52oEyT1klSqMqTruUH8CUCYYQNX4ob+
         b9N8VxS9AB49FVVpdDafTXmexFiCMKIGiG6BYShE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 068EF60256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv4 0/1] coresight: Do not default to CPU0 for missing CPU phandle
Date:   Thu, 27 Jun 2019 00:29:29 +0530
Message-Id: <cover.1561575087.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of missing CPU phandle, the affinity is set default to
CPU0 which is not a correct assumption. Fix this in coresight
platform to set affinity to invalid and abort the probe in drivers.
Also update the dt-bindings accordingly.

v4:
 * Fix return for !CONFIG_ACPI and !CONFIG_OF.

v3:
 * Addressed review comments from Suzuki and updated
   acpi_coresight_get_cpu.
 * Removed patch 2 which had invalid check for online
   cpus.

v2:
 * Addressed review comments from Suzuki and Mathieu.
 * Allows the probe of etm and cpu-debug to abort earlier
   in case of unavailability of respective cpus.

Sai Prakash Ranjan (1):
  coresight: Do not default to CPU0 for missing CPU phandle

 .../bindings/arm/coresight-cpu-debug.txt      |  4 ++--
 .../devicetree/bindings/arm/coresight.txt     |  8 +++++---
 .../hwtracing/coresight/coresight-cpu-debug.c |  3 +++
 drivers/hwtracing/coresight/coresight-etm3x.c |  3 +++
 drivers/hwtracing/coresight/coresight-etm4x.c |  3 +++
 .../hwtracing/coresight/coresight-platform.c  | 20 +++++++++----------
 6 files changed, 26 insertions(+), 15 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

