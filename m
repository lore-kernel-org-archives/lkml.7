Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4845C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9921D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118712;
	bh=xBpfMQ1Eq3OJ2ixrlXrMutYkd74/bwwC4ng88BVlL0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVoSDHLJLyXBXa5HPmAmtTmK2C6rVmkYco2/cIxZwm3294GaNNB+wm/5GYc3I/97i
	 I2cAYVTrA1jY+VBupeUspeM5MnML8w0vFxL/SlH0jS6ebVpgx1ZinVgOcOqHWTWlVc
	 5brTawqkHTeC/qVApaytNLhGlN7cTkXVWrttLEiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfJCQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730745AbfJCQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:05:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CEC207FF;
        Thu,  3 Oct 2019 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118707;
        bh=xBpfMQ1Eq3OJ2ixrlXrMutYkd74/bwwC4ng88BVlL0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzQnW3ptFabRGvxV01kinD8m9DjJfN/Tyopq/toqO9HoWvarI62fRebl9QSBy9ucb
         EW0Z9sv8gNi3lbBUozDV39ubTnPK4O2VtMVTmZrL4tGf3+IIU1N+rMYYMubaC4SbT1
         DKj7thewCmhbcVOsM2d/StfCa0WKFTmCysW0KVbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Salvaterra <rsalvaterra@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 108/129] media: sn9c20x: Add MSI MS-1039 laptop to flip_dmi_table
Date:   Thu,  3 Oct 2019 17:53:51 +0200
Message-Id: <20191003154408.762157209@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
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
@@ -138,6 +138,13 @@ static const struct dmi_system_id flip_d
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


