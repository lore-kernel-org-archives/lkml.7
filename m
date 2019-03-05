Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71719C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B620645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfCESIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:39 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:20553 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730883AbfCESId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:33 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id E7/C0-19701-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsVy8IPnUV2p3XU
  xBnNualpMffiEzeLblQ4mi8u75rBZfH6/n9WBxWPnrLvsHptWdbJ5TJ/zn9Hj8ya5AJYo1sy8
  pPyKBNaM/tcrWQp28lesffWcuYHxOk8XIxeHkMA6Ronv794xdzFyAjkVEu/+/mYEsXkFHCTu3
  7jMCmKzCRhKzHvzHijOwcEioCLx/2omSFhYwFvi9N5zYOUiAh4Srds3MIPMZBboY5TYfP4CG8
  QcQYmTM5+wgNjMAhISB1+8YAaZIySgJbH8WCRIWELAXmL6+6tgYQkBfYnGY7EQYUOJ77O+sUD
  Y5hK3Vz9gncDIPwvJ0FlIhi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKRraGmia2RkqpdYpZuo
  l1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRGMQpBYce7mA8tzz9EKMkB5OSKG/nrroYIb6k/
  JTKjMTijPii0pzU4kOMMhwcShK8DiA5waLU9NSKtMwcYDzBpCU4eJREeMtB0rzFBYm5xZnpEK
  lTjLocB78/nMssxJKXn5cqJc57aidQkQBIUUZpHtwIWGxfYpSVEuZlZGBgEOIpSC3KzSxBlX/
  FKM7BqCTMWw2yiiczrwRu0yugI5iAjvh8uRrkiJJEhJRUA+NkwTPrXgQ57wrUzKmMmzJBQOBl
  v56BEGNxwV5m8dQ5ySe+KDPcutLp/I99z9SyFKP5icbfutdt6+navnLNVf1lh3V+ysd2ec63i
  TN508woYHyg54rOsWkHuibape5nSZru7rJqd2Pu9m9nLpzYrXHlyJZN4n6J7JevdLCWLzg8bZ
  W2HMffrVxKLMUZiYZazEXFiQBfdrc16AIAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30107 invoked from network); 5 Mar 2019 18:08:26 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:26 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:25 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 27A933FB37; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 5 Mar 2019 17:59:57 +0000
Subject: [PATCH 00/13] Fix backtrace warnings from bad notifier chain calls
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cirrus Patches <patches@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 05/03/2019 17:23:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

This patch-set fixes a WARN_ON_ONCE() backtrace call caused by not
locking the mutex from the function call regulator_notifier_call_chain().
It does this for thirteen regulator drivers by adding a mutex lock
surrounding the notifier calls.

This missing mutex lock has been around for a while, but the API I have
used used here to fix it (i.e. regulator_lock()/regulator_unlock()) has
only been in the kernel since v4.18. Therefore as this fix stands, the
patches do not port back very far in kernel history.

Regards,
Steve


Steve Twiss (13):
  regulator: da9055: Fix notifier mutex lock warning
  regulator: da9062: Fix notifier mutex lock warning
  regulator: da9063: Fix notifier mutex lock warning
  regulator: da9211: Fix notifier mutex lock warning
  regulator: lp8755: Fix notifier mutex lock warning
  regulator: ltc3589: Fix notifier mutex lock warning
  regulator: ltc3676: Fix notifier mutex lock warning
  regulator: pv88060: Fix notifier mutex lock warning
  regulator: pv88080: Fix notifier mutex lock warning
  regulator: pv88090: Fix notifier mutex lock warning
  regulator: wm831x: Fix notifier mutex lock warning
  regulator: wm831x isink: Fix notifier mutex lock warning
  regulator: wm831x ldo: Fix notifier mutex lock warning

 drivers/regulator/da9055-regulator.c  |  2 ++
 drivers/regulator/da9062-regulator.c  |  2 ++
 drivers/regulator/da9063-regulator.c  |  5 ++++-
 drivers/regulator/da9211-regulator.c  |  4 ++++
 drivers/regulator/lp8755.c            | 15 ++++++++++++---
 drivers/regulator/ltc3589.c           | 10 ++++++++--
 drivers/regulator/ltc3676.c           | 10 ++++++++--
 drivers/regulator/pv88060-regulator.c |  4 ++++
 drivers/regulator/pv88080-regulator.c |  4 ++++
 drivers/regulator/pv88090-regulator.c |  4 ++++
 drivers/regulator/wm831x-dcdc.c       |  4 ++++
 drivers/regulator/wm831x-isink.c      |  2 ++
 drivers/regulator/wm831x-ldo.c        |  2 ++
 13 files changed, 60 insertions(+), 8 deletions(-)

-- 
1.9.3

