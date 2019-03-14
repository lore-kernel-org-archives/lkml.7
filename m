Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82504C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8572087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCNLNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:13:55 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:47294 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfCNLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:13:54 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id nnDr1z00Q3XaVaC01nDrl2; Thu, 14 Mar 2019 12:13:52 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h4OJ5-0000uj-FC; Thu, 14 Mar 2019 12:13:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h4OJ5-0002Df-CQ; Thu, 14 Mar 2019 12:13:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Marineau <mike@marineau.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] base: Disable CONFIG_UEVENT_HELPER by default
Date:   Thu, 14 Mar 2019 12:13:50 +0100
Message-Id: <20190314111350.8490-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7934779a69f1184f ("Driver-Core: disable /sbin/hotplug by
default"), the help text for the /sbin/hotplug fork-bomb says
"This should not be used today [...] creates a high system load, or
[...] out-of-memory situations during bootup".  The rationale for this
was that no recent mainstream system used this anymore (in 2010!).

A few years later, the complete uevent helper support was made optional
in commit 86d56134f1b67d0c ("kobject: Make support for uevent_helper
optional.").  However, if was still left enabled by default, to support
ancient userland.

Time passed by, and nothing should use this anymore, so it can be
disabled by default.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 3e63a900b330e9b4..cf29115f055b8a1a 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -3,7 +3,6 @@ menu "Generic Driver Options"
 
 config UEVENT_HELPER
 	bool "Support for uevent helper"
-	default y
 	help
 	  The uevent helper program is forked by the kernel for
 	  every uevent.
-- 
2.17.1

