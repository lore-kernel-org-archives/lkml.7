Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0C321874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbfHHKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:03:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:25684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbfHHKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 03:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="179792908"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2019 03:02:10 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/3] serial: lantiq: Update driver to support new SoC
Date:   Thu,  8 Aug 2019 18:02:05 +0800
Message-Id: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new Intel Atom based Lightning Mountain(LGM) network processor SoC
which reuses Lantiq ASC serial controller IP. This patch series updates the
driver design and code to add support for LGM SoC as well.

These patches are baselined upon Linux 5.3-rc2 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Patch 1 modifies devicetree compatible string to a use explicit string instead
of a fixed macro because this patch series adds support for multiple SoCs.

Patch 2 modifies driver design to support dynamic assignment of IRQ resources
& ISRs based on devicetree node compatible entries. This is because new LGM SoC
supports single IRQ for all tx/rx/err interrupts while older SoCs support three
separate IRQs for tx/rx/err interrupts.

Patch 3 adds LGM SoC specific IRQ/ISR support.

v2:
* Address review concerns.
* Separate dt binding document from this patch series. Will try to push it
  separately by first converting existing txt file to YAML and then add new
  properties.
* Omit resending one patch in this series which is already reviewed & added
  to tty-next.


Rahul Tanwar (3):
  serial: lantiq: Use proper DT compatible string
  serial: lantiq: Make IRQ & ISR assignment dynamic
  serial: lantiq: Add support for Lightning Mountain SoC

 drivers/tty/serial/lantiq.c | 214 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 46 deletions(-)

-- 
2.11.0

