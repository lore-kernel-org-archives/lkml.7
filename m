Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D5C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC532083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0MwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF0MwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245805946"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:51:58 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/9] intel_th: Updates for v5.3
Date:   Thu, 27 Jun 2019 15:51:43 +0300
Message-Id: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

There are the updates for the Intel TH driver that I have for the next
cycle. These are multi-window mode buffer management changes, mainly to
add support for software trace sinks.

One patch at the top is a dependency, from a pull request I sent last week
with fixes for v5.2 [1].

Individual patches are in follow-up emails, a signed tag is also pushed
out and available at the URL below. Please consider pulling or applying.
Thanks!

[1] https://marc.info/?l=linux-kernel&m=156113401304637

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-for-greg-20190627

for you to fetch changes up to 4fe4659624b7cf6fa7c2197eb5588f1be1123e17:

  intel_th: msu: Preserve pre-existing buffer configuration (2019-06-27 15:21:25 +0300)

----------------------------------------------------------------
intel_th: Updates for v5.3

These are:
  * Support for software trace sinks / buffer drivers
  * Various reworks in buffer management code

----------------------------------------------------------------
Alexander Shishkin (8):
      intel_th: msu: Support multipage blocks
      intel_th: msu: Split sgt array and pointer in multiwindow mode
      intel_th: msu: Start read iterator from a non-empty window
      intel_th: msu: Introduce buffer driver interface
      intel_th: msu: Prevent freeing buffers while locked windows exist
      intel_th: msu: Get rid of the window size limit
      intel_th: msu-sink: An example msu buffer driver
      intel_th: msu: Preserve pre-existing buffer configuration

Shaokun Zhang (1):
      intel_th: msu: Fix unused variable warning on arm64 platform

 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |   3 +-
 MAINTAINERS                                        |   1 +
 drivers/hwtracing/intel_th/Makefile                |   3 +
 drivers/hwtracing/intel_th/msu-sink.c              | 127 +++++
 drivers/hwtracing/intel_th/msu.c                   | 609 +++++++++++++++++----
 drivers/hwtracing/intel_th/msu.h                   |  23 +-
 include/linux/intel_th.h                           |  67 +++
 7 files changed, 710 insertions(+), 123 deletions(-)
 create mode 100644 drivers/hwtracing/intel_th/msu-sink.c
 create mode 100644 include/linux/intel_th.h

-- 
2.20.1

