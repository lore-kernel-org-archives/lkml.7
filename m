Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA6A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfCYV1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:44 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:54002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbfCYV1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DCDB718224D76;
        Mon, 25 Mar 2019 21:27:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side74_25a34a12c0135
X-Filterd-Recvd-Size: 3905
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:38 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Bad file pattern in MAINTAINERS section 'NOKIA N900 POWER SUPPLY DRIVERS'
Date:   Mon, 25 Mar 2019 14:27:37 -0700
Message-Id: <20190325212737.27322-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	11011	NOKIA N900 POWER SUPPLY DRIVERS
	11012	R:	Pali Rohár <pali.rohar@gmail.com>
	11013	F:	include/linux/power/bq2415x_charger.h
	11014	F:	include/linux/power/bq27xxx_battery.h
-->	11015	F:	include/linux/power/isp1704_charger.h
	11016	F:	drivers/power/supply/bq2415x_charger.c
	11017	F:	drivers/power/supply/bq27xxx_battery.c
	11018	F:	drivers/power/supply/bq27xxx_battery_i2c.c
	11019	F:	drivers/power/supply/isp1704_charger.c
	11020	F:	drivers/power/supply/rx51_battery.c

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'include/linux/power/isp1704_charger.h':

commit 2a6afddb6656aefbc6e8d6ef1f95749895ae2945
Author: Pali Rohár <pali.rohar@gmail.com>
Date:   Sun Mar 29 15:35:54 2015 +0200

    MAINTAINERS: Add me as maintainer of Nokia N900 power supply drivers
    
    I'm author of two of those drivers (bq2415x and rx51) and I added
    more patches for other twos. Also I fished (proper) open source
    power management software for Nokia N900 and those kernel drivers
    are part of it.
    
    Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
    Signed-off-by: Sebastian Reichel <sre@kernel.org>

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'include/linux/power/isp1704_charger.h':

commit f5d782d46aa5d4dd369e6560ce5227136b58926f
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Thu Dec 13 02:38:58 2018 +0100

    power: supply: isp1704: switch to gpiod API
    
    This migrates isp1704 driver from old GPIO API to new descriptor
    based GPIO API and drops useless platform data as a side-effect.
    
    Migration is simple, since all mainline users are DT based and
    DT API does not change. Out of tree users of the platform data
    need to migrate to gpiod_lookup_table as described here:
    
    Documentation/driver-api/gpio/board.rst
    
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

 drivers/power/supply/isp1704_charger.c | 60 +++++++---------------------------
 include/linux/power/isp1704_charger.h  | 30 -----------------
 2 files changed, 12 insertions(+), 78 deletions(-)
