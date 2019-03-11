Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20F22075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCKLWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfCKLWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:22:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3B1B307DAAD;
        Mon, 11 Mar 2019 11:22:18 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-37.ams2.redhat.com [10.36.117.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4728A5C579;
        Mon, 11 Mar 2019 11:22:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] intel-lpss-pci-i2c: Fix oops when there is no ACPI fwnode
Date:   Mon, 11 Mar 2019 12:22:14 +0100
Message-Id: <20190311112216.31391-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 11 Mar 2019 11:22:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a patch series fixing an oops when there is no ACPI fwnode
associated with a PCI enumerated LPSS I2C controller:
https://bugzilla.redhat.com/show_bug.cgi?id=1687065

This is fixed by the first patch in this series, which modifies
i2c-designware-platdrv.c to fix this. The fix is enabled conditionally
because otherwise it might break things on platforms where i2c-designware
controllers are enumerated through e.g. devicetree.

The second patch modifies intel-lpss-pci.c to pass the new
"linux,use-dynamic-adapter-nr" devicetree property to activate the fix.

The first patch should be merged first, so that the devicetree prop name
is "stable", then the second patch can be merged independently through the
mfd tree.

Regards,

Hans

