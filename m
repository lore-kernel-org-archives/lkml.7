Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CC7227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782728;
	bh=zNdlusR2Sv4avD7h8Dyy/P2eJzLsf8rNV+gSpzi0RJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DHVsDN0gcQdug+omQlBSqHm0zZnih4xE6Jxm5pjuIYR2BQmFQ14VcFY6QtGR2CiUQ
	 YQ9cae7fYlEkrZ82dzwLm3ajBrIhETr7akvwvvJp3rM4gKyub6uFt1SAT5c67h2y5L
	 DgcPRL5cS7roQYPVsaU9JpnaWD2Z3FNBNzzDWKTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfLSTMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfLSShW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:37:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B274E24679;
        Thu, 19 Dec 2019 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780642;
        bh=zNdlusR2Sv4avD7h8Dyy/P2eJzLsf8rNV+gSpzi0RJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikpc+S8woOAom0rPWmvXpIH38wu2TV1oJidmRlpv+tvDuam93NXAdiJcfYb9OD3i5
         lH0VtIb2lnxY2Wui0I+WHz83Hp4tLehthwPYVQrGC0tmPKHFnAI77Z07qhiZarAC+j
         JZdnyBEc1qcZpazmpl70d2Zy6Sl6vyCO6EwAVgNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 057/162] Input: goodix - add upside-down quirk for Teclast X89 tablet
Date:   Thu, 19 Dec 2019 19:32:45 +0100
Message-Id: <20191219183211.343179482@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit df5b5e555b356662a5e4a23c6774fdfce8547d54 upstream.

The touchscreen on the Teclast X89 is mounted upside down in relation to
the display orientation (the touchscreen itself is mounted upright, but the
display is mounted upside-down). Add a quirk for this so that we send
coordinates which match the display orientation.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20191202085636.6650-1-hdegoede@redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/goodix.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -69,6 +69,15 @@ static const unsigned long goodix_irq_fl
 static const struct dmi_system_id rotated_screen[] = {
 #if defined(CONFIG_DMI) && defined(CONFIG_X86)
 	{
+		.ident = "Teclast X89",
+		.matches = {
+			/* tPAD is too generic, also match on bios date */
+			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
+			DMI_MATCH(DMI_BIOS_DATE, "12/19/2014"),
+		},
+	},
+	{
 		.ident = "WinBook TW100",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),


