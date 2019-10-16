Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC5FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E221928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262909;
	bh=6kvh2ljFqUDYi5wwuIe97TZ/HrGcR9V7uAH6Lgc/6cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+QXBheN0+HsauWuzicljVAlIufErSKLuTKpMStUiEa0G5+7zGWISws6EnV5cOZiz
	 YxOSt/W8eY69bzc2zLrLVenSb+eaxrM/9Sf86bM0gXDK+fTgqnr7RriI4IYAj21FPt
	 znGPe13lnURyF99NIt02Q49D00OLD7fs6jwHwbRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbfJPVzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395146AbfJPVzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:04 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37CD21D7A;
        Wed, 16 Oct 2019 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262904;
        bh=6kvh2ljFqUDYi5wwuIe97TZ/HrGcR9V7uAH6Lgc/6cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mafp7UBviZpeyLRW93IGrpSr8je++0AEtPs8z0f0cOIcxp1NSH9DGeKDjRk7RePMe
         LFChMKaaKQwTzLFOSV5Kdg52yBAOX2bVdmNAtFRBlYShdbGgCwLBmxY6snZ/Iu86vX
         OcceGXeme1Dd/HKu9Qax8OE4kz+Yv8CsxYgVb/vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5630ca7c3b2be5c9da5e@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 64/92] USB: microtek: fix info-leak at probe
Date:   Wed, 16 Oct 2019 14:50:37 -0700
Message-Id: <20191016214841.239423777@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 177238c3d47d54b2ed8f0da7a4290db492f4a057 upstream.

Add missing bulk-in endpoint sanity check to prevent uninitialised stack
data from being reported to the system log and used as endpoint
addresses.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reported-by: syzbot+5630ca7c3b2be5c9da5e@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20191003070931.17009-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/image/microtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -724,6 +724,10 @@ static int mts_usb_probe(struct usb_inte
 
 	}
 
+	if (ep_in_current != &ep_in_set[2]) {
+		MTS_WARNING("couldn't find two input bulk endpoints. Bailing out.\n");
+		return -ENODEV;
+	}
 
 	if ( ep_out == -1 ) {
 		MTS_WARNING( "couldn't find an output bulk endpoint. Bailing out.\n" );


