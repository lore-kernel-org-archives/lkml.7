Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75849C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732721871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611972;
	bh=9kyegzZ/xJK+AyviEj4LuYf/JcELxuLlVx3y6daBQLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qo1E6cChC4v524Jp0SfJ6WfwCWEWObRQEOhE6yikMlL/CHwp/kCxxpYpgTBlpUeWi
	 mFjUTQh56Q8xppmKcWQjdwKTUa1UKD5x0BdPXhwQOXELoOWSuA1RD5yhIAXJE53UGh
	 mkpOyZIhWBZMNdEa34v8I1L5WFvTiY1lP2zkucBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbfDRS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391211AbfDRSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EEB206B6;
        Thu, 18 Apr 2019 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610696;
        bh=9kyegzZ/xJK+AyviEj4LuYf/JcELxuLlVx3y6daBQLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAj/iBQnB5+Y4J6ihDKXH024DlB7ZFFh9uPYhuBB7mV8cP3zVZoAPQcRR+c+FUqTi
         2f9djWgMSBMhZj1n77WPtfZ5ml/IERhZ31NRYiaUv0+6QcAe8jGxihHcWCnCtx1Q3l
         1WwzPJuTUO3qvnBJXVPVo/3oHRE4yxtfdFDsetHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ronald=20Tschal=C3=83=C2=A4r?= <ronald@innovation.ch>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 50/92] ACPI / SBS: Fix GPE storm on recent MacBookPros
Date:   Thu, 18 Apr 2019 19:57:08 +0200
Message-Id: <20190418160434.458535362@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ca1721c5bee77105829cbd7baab8ee0eab85b06d ]

On Apple machines, plugging-in or unplugging the power triggers a GPE
for the EC. Since these machines expose an SBS device, this GPE ends
up triggering the acpi_sbs_callback(). This in turn tries to get the
status of the SBS charger. However, on MBP13,* and MBP14,* machines,
performing the smbus-read operation to get the charger's status triggers
the EC's GPE again. The result is an endless re-triggering and handling
of that GPE, consuming significant CPU resources (> 50% in irq).

In the end this is quite similar to commit 3031cddea633 (ACPI / SBS:
Don't assume the existence of an SBS charger), except that on the above
machines a status of all 1's is returned. And like there, we just want
ignore the charger here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198169
Signed-off-by: Ronald TschalÃ¤r <ronald@innovation.ch>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a2428e9462dd..3c092f07d7e3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -441,9 +441,13 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 
 	/*
 	 * The spec requires that bit 4 always be 1. If it's not set, assume
-	 * that the implementation doesn't support an SBS charger
+	 * that the implementation doesn't support an SBS charger.
+	 *
+	 * And on some MacBooks a status of 0xffff is always returned, no
+	 * matter whether the charger is plugged in or not, which is also
+	 * wrong, so ignore the SBS charger for those too.
 	 */
-	if (!((status >> 4) & 0x1))
+	if (!((status >> 4) & 0x1) || status == 0xffff)
 		return -ENODEV;
 
 	sbs->charger_present = (status >> 15) & 0x1;
-- 
2.19.1



