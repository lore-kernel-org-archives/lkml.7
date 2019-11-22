Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33692070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M4P4SSri";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="H4tln2Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKVKGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:06:51 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:59618
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfKVKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574417210;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=lX0v2XY0noOshpJ5mHv1R7wlE0zYdmLyaeKbrAftS3k=;
        b=M4P4SSrixb44AudnsYYRDwuYOEe+bBe7No7L93CHWm2Fv3AMPDRX/HEUmLZgovRH
        ClDj6vhxOAo7zzGfr7yMQVTVBbIvbns0P1jyv0x5+nWGF2F5D3jFXYAAB+R7AK+Vqov
        /kDJZKgUrm3LQa9v2B+fHPnT4xeHwjPtT5/QrwkA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574417210;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=lX0v2XY0noOshpJ5mHv1R7wlE0zYdmLyaeKbrAftS3k=;
        b=H4tln2QjpriGiMsBYqMbN8NjdGmRfTkQtb8t5K1wa9eB9y81fkgqxM5kg0SXtWEJ
        4CO+h/58PIqnzSjlIStfs1Xt6ZvZLTLyQhRiAKyQyUYcUWpX6tJKxBzDXyI7SHK3/Xt
        0fSeYGxAEqnkNkznDoXKYcZKn20sJOKLO6QTp8po=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C8CCC447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [RESEND PATCH V4 0/4] Add TIOCM Signals support for RPMSG char devices
Date:   Fri, 22 Nov 2019 10:06:50 +0000
Message-ID: <0101016e92941bcc-36d9920e-39c3-49b0-87fc-74ff3d4203e4-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.11.22-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glink transport support signals to exchange state notification between
local and remote side clients. Adding support to send/receive the signal
command and notify the clients through callback and POLL notification.

Changes since v3:
- Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
- Update the rpmsg_get_signals function header

Changes since v2:
- Modify the rpmsg_get_signals function prototype

Changes since v1:
- Split the patches as per functional areas like core, char, glink
- Add set, clear mask for TIOCMSET
- Merge the char signal callback and POLLPRI patches

Arun Kumar Neelakantam (4):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
  rpmsg: char: Add signal callback and POLLPRI support

 drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  74 +++++++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |   5 ++
 include/linux/rpmsg.h             |  26 ++++++++
 5 files changed, 269 insertions(+), 3 deletions(-)

-- 
1.9.1

