Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7767C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B504A214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239624;
	bh=vGxDO+FoaJPYXaV2ARZ1fE7BJ10MpE1i8/SaFFZzGKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpAG6CdmIxG4ss8L3Jn0O0l2noWIZX+4ZQRteXhfZzIN4nrOvPCU9GqF1SGDX1nLS
	 BAtJeMSBBB3mvsnaJCA1CiDMylYTpw4yR503hnIkMGHX9UPCavCUyp2QUKCtNAoe8n
	 3fP5n6h2ZovkqBN8HfFhhgACC9qUygo0JgPY4umQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbfKHTAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389517AbfKHTAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581372087E;
        Fri,  8 Nov 2019 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239609;
        bh=vGxDO+FoaJPYXaV2ARZ1fE7BJ10MpE1i8/SaFFZzGKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqfKPlWb+WjICpTL+jX6lNYrRxrBpZdqVQFo4Un1ambepbg5cADaZuqTwQyei6A38
         vHp9ZXoH9TiCwPVgMKNPu/w7a/iNrOUt1lntobT5zQZd9tao+o7FsQXPe2h7tlezLE
         YNPcdaJ3+aatQ9OGaQhGLhKbfz6/6b86VKgT6ps0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 54/62] platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to critclk_systems DMI table
Date:   Fri,  8 Nov 2019 19:50:42 +0100
Message-Id: <20191108174757.433923274@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit ad0d315b4d4e7138f43acf03308192ec00e9614d upstream.

The SIMATIC IPC227E uses the PMC clock for on-board components and gets
stuck during boot if the clock is disabled. Therefore, add this device
to the critical systems list.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/pmc_atom.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -475,6 +475,13 @@ static const struct dmi_system_id critcl
 			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
 		},
 	},
+	{
+		.ident = "SIMATIC IPC227E",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 


