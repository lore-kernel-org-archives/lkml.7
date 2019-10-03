Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B199207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118409;
	bh=WnnVwo0vVu77Z5Zp+V5yFZGva1AVLUgAKB4IXhlJmYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFGliTZhKDdWlMZG5a5lbysNjxEPEzaAD6L5k2wrCS/1vkOPHa3La0E8ZFELuT99W
	 G29i9PaBT4uxZXIwk30lVMj4kVS7AAj+iiDUV5CGlJjwgDwQ1dWUrctwsm2Fd0rAsu
	 b9vm6M+1MidoPd/hLel2mkamT35C6ouo476RVGFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfJCQAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbfJCQAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:00:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C916721848;
        Thu,  3 Oct 2019 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118405;
        bh=WnnVwo0vVu77Z5Zp+V5yFZGva1AVLUgAKB4IXhlJmYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6RY2DLD3s/kdlTw96/CvaJEd2kpAuyYPWCo5pjQ+bVB7T9dR2qKqH9oxf84dkCSH
         QXI4GKZ5ATZI+T9QWI8vix6PmdZ+BI9A5MJt5/9f0Zs5gH2srLOJRF8sIKEHr3xvK3
         swwaJiZrpufEJe8jREc3frZqGArYNU15vmPCN/qQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Salvaterra <rsalvaterra@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.4 84/99] media: sn9c20x: Add MSI MS-1039 laptop to flip_dmi_table
Date:   Thu,  3 Oct 2019 17:53:47 +0200
Message-Id: <20191003154337.063405867@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 7e0bb5828311f811309bed5749528ca04992af2f upstream.

Like a bunch of other MSI laptops the MS-1039 uses a 0c45:627b
SN9C201 + OV7660 webcam which is mounted upside down.

Add it to the sn9c20x flip_dmi_table to deal with this.

Cc: stable@vger.kernel.org
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/gspca/sn9c20x.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/media/usb/gspca/sn9c20x.c
+++ b/drivers/media/usb/gspca/sn9c20x.c
@@ -139,6 +139,13 @@ static const struct dmi_system_id flip_d
 		}
 	},
 	{
+		.ident = "MSI MS-1039",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INT'L CO.,LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MS-1039"),
+		}
+	},
+	{
 		.ident = "MSI MS-1632",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "MSI"),


