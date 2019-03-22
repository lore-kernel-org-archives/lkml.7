Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71C72190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCVP3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:29:34 -0400
Received: from retiisi.org.uk ([95.216.213.190]:37860 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfCVP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:29:34 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id D176C634C7B;
        Fri, 22 Mar 2019 17:27:23 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/5] Device property improvements, add %pfw format specifier
Date:   Fri, 22 Mar 2019 17:29:25 +0200
Message-Id: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set adds functionality into the device property API (counting a
node's parents as well as obtaining its name) in order to support printing
fwnode names using a new conversion specifier "%pfw". The names that are
produced are equivalent to its OF counterpart "%pOF" on OF systems for the
two supported modifiers ("f" and "P").

Printing a node's name is something that's been available on OF for a long
time and if something is converted to device property API (such as the
V4L2 fwnode framework) it always got removed of a nice feature that was
sometimes essential in debugging. With this set, that no longer is the
case.

This set depends on a cleanup set fully releasing the now-deprecated %pf
for other use:

<URL:https://lore.kernel.org/lkml/20190322135350.2btpno7vspvewxvk@paasikivi.fi.intel.com/T/#t>

I was a bit hesitant on how much of this should be covered by the fwnode
ops and how much would be just better to reside in lib/vsprintf.c, but
opted for putting it to the fwnode interface. This keeps it clean and
still rather lean on the fwnode ops side while making it possible to add
other firmware types (although that is unlikely I guess).

Sakari Ailus (5):
  device property: Add functions for accessing node's parents
  device property: Add fwnode_get_name for returning the name of a node
  device property: Add a function to obtain a node's prefix
  lib/vsprintf: Make use of fwnode API to obtain node names and
    separators
  lib/vsprintf: Add %pfw conversion specifier for printing fwnode names

 Documentation/core-api/printk-formats.rst | 24 +++++++++
 drivers/acpi/property.c                   | 46 ++++++++++++++++
 drivers/base/property.c                   | 86 ++++++++++++++++++++++++++---
 drivers/of/property.c                     | 16 ++++++
 include/linux/fwnode.h                    |  4 ++
 include/linux/property.h                  |  5 ++
 lib/vsprintf.c                            | 89 +++++++++++++++++++++++--------
 scripts/checkpatch.pl                     |  2 +-
 8 files changed, 242 insertions(+), 30 deletions(-)

-- 
2.11.0

