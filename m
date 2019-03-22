Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78395C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E1218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258239;
	bh=uQt+9REIb75CfM0EcSbrZr113zN4GsixisXoz8Toq+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qdZ2btuDxMLIOpUK+LAJ4OocQaYJQooULZtcrrDPvwCXpcffeyCoVu+jgBlA9uIN
	 uidqxBC3NpsoddHMv1kGm8oDaezc83oYYlyInUTX6/SsuU8+f0wgtAn20J9Lar5iiG
	 xmG/LutkF1ijbk7HQRj3UAfuYIkq0Q3iBA0U/vxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfCVMKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388793AbfCVMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81A620830;
        Fri, 22 Mar 2019 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256603;
        bh=uQt+9REIb75CfM0EcSbrZr113zN4GsixisXoz8Toq+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIx1X5boIGI7TgKoJVxnXq251kduL1SaEDQm7kivIYt3+vZr0IvimSA+R3u9Z/zaD
         bXThBQYvIeqF8uNOeEu1ROTzKgqWUDVD1tvZ8Xw5sTqhFf/FN5yV8n4rjNg40EEwhh
         pv6BzJNiippXj9frosTMRp/PJyehVyUXQVRiKn1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.19 239/280] cpcap-charger: generate events for userspace
Date:   Fri, 22 Mar 2019 12:16:32 +0100
Message-Id: <20190322111339.027073449@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Machek <pavel@ucw.cz>

commit fd10606f93a149a9f3d37574e5385b083b4a7b32 upstream.

The driver doesn't generate uevents on charger connect/disconnect.
This leads to UPower not detecting when AC is on or off... and that is
bad.

Reported by Arthur D. on github (
https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
Merlijn Wajer for suggesting a fix.

Cc: stable@kernel.org
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/cpcap-charger.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -458,6 +458,7 @@ static void cpcap_usb_detect(struct work
 			goto out_err;
 	}
 
+	power_supply_changed(ddata->usb);
 	return;
 
 out_err:


