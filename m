Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7393C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A168421787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK1WvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:51:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1WvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:51:02 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 7a1bba6277687c37; Thu, 28 Nov 2019 23:51:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ACPI: PM: s2idle: Fix possible suspend lock-up
Date:   Thu, 28 Nov 2019 23:42:09 +0100
Message-ID: <2787005.CsmIKtZlk9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The first patch in this series is a fix for a suspend-to-idle issues introduced
in 5.4 (see its changelog for details).

The second one is more of an optimization, although some systems may need it
too (depending on how fragile their platform firmware is).

Kenneth,

This series is roughly equivalent to the patch at

https://lore.kernel.org/linux-pm/CAJZ5v0h1Ro75++4xuCznkx6GNYd+G5NpMGP96z1jdh=dm9uZbw@mail.gmail.com/T/#m11ca9a14efe4e5193bbda69767595a5fb7bd5479

The main difference is that it flushes system_wq before ec_query_wq, but that
should not really matter if the issue you saw in 5.4 is the one described
in the changelog of patch [1/2].

Please test this series and let me know if it works for you too.

In case it does work, it would be good to know if patch [1/2] is sufficient to
fix the suspend problem at least with ec_no_wakeup == 0 (it may not be
sufficient with ec_no_wakeup == 1).

Thanks!



