Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AE020679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cnxt4B1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfJMAgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:36:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:48871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfJMAgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570926965;
        bh=Hus0uxEg0+H82T5bgS3JNhSkHrR3egJTX/E9/MTSWQE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Cnxt4B1gZCR6uvuvdpSdJiyQBs45BYOIT3Mey8UD77mBHMKRnyAB1JYtTKRWhr92r
         8n1wsMv6C1bRSe7zqoRbAP0atisxpHw5Hik9Tuw7IKj8PTqr7gnmAM15e/8A0uEwue
         XU7o8EbsW+PiJ9za2zJJKM4Bqi3/km/un4I9UdoI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([212.88.11.189]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M72oH-1iQrz13wcR-008cqs; Sun, 13 Oct 2019 02:36:05 +0200
From:   Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Cc:     Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: Don't use soft retry if slot id > 0
Date:   Sun, 13 Oct 2019 02:33:13 +0200
Message-Id: <20191013003313.3497-1-bernhard.gebetsberger@gmx.at>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uchScNY3SucpZNKqqmONoQkV0fukb20RlmrbYFFgdI+Oyucg9P0
 FHZUT3R24J8u8vspkkfke/Q3QBWx0WMg/GTHlyySP9PSuwToJylBks3BTZAy3/VN2Czq98k
 6uaDTpdEbT5onr4yaiWHsgPrHLCM0Jw7oBR66uN4Npzm2yvs5I6fYf0O9fzbZ+ObEncmcyd
 OQMIZAxBaQJ0BaqVRExJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Dy2TTRnpjg=:OeZOYTq89R6h+ktdlRJ97b
 vl9M7p8XDImE/2bKzsMNjl/oOwsmCgY3HAgJN5KoLySKK++dF8oz1rFJLyQ58NJeh04+RC26q
 M8zHmlN9AQUETAFQ6Fi5wMgBGm6G12d7ouTGJh69tpxikEzlKegWUlbF8CbrD/MzelhcI44Z2
 Fq4avUFOUZaAXH01S+Xn5dBt5L/qneq6Z8LGwouUJf2YSv/EHQ5BjrC3W/u4W+QjrUBP6dWeB
 73L6C0rFNqrN6g+S18qIPlqLCzRHB9BqxdNIx2TR76w9ZK122JSa2RcqRaOxpEj6NKqnsuHN/
 ZT57eJHW9n6KvqOLXMQyg8T/SyLur6FDZaU3Ul6d1gDg9QJNCbesPOCjbguh3Wpa10ZCvUWv8
 C5TSVZaE6NEitKj/6NHgaaXW9jJ0GoaMho1Dn9HOIwQ74ef/r1tyzxNgQVpQ+iKxbnlgBoBJ9
 4rSMfnY+Hg3fFSzsiCV2aPVzzsLB3MJrg/wqMpJL0oGxX140vpEOcQh0Y23NMzZHAq80n7dI8
 gojuf77ulAPKn6EjoC/+bkQNwI+l8ag2Hw/EdQwarnJ1/U42quw5Y0puV5MOxL32i8SDQmrqv
 1jw3TsPMdKXe3+52ZTw5xWepJbD6aeO7LkTEKfiFVZ/XePbu2RNcFRFVGR71LjBsqAAz8skWD
 Rf3CGCpqZ2KTPWmYvmb6Bxu5eltQLcnYFLGD7mGOwhf10bB5dPstbKUqvw3uEnwIVz3sZbAWZ
 m+RCbu/sUQBtHDV12Mnd1AQIZqkBG1EFfdwF8f1CzRZ6w6Yj+chVlZdmTO2bu7xakwKxsECli
 cRayRRk7R/FFTIIdQapIHV/lZEcq7GQ/cNEGk43Pbnngw3CkRFRVssy0U9ERdefeJtBPj61jd
 YP3FDpY0fVZJfqjxCAe6Y73NHZV6VxSJTzEd7Cvk0CpjVV5KSuQpPkUN0+QSDBFbPtK5z57PD
 iT5Vz22de1EUjvThUOPVCP8Ols5wcKIMnYXBa06s2FM1LHKkGbi4rbH6Bq/QwbLYCBFYBTSd6
 meklBpvKWBBiY8wcxYUWCcJs2XSBt9Vh79+7zSzGr7JT7pfP4UYqJLKkUwzqTydiAJnkKoiZM
 6kWicvZbNeiKurfY5/Oq3g2vfEkvfQcGV3mXNUREYZCwhgyBUx3g2HpPSpAadoIeQUjESm+nk
 KLk07OP04oLiWGgZo8znCAsAp/UZtVKbofyANoomGSXx22OJgLKJh1IqldVyjvhkw8i9nx67w
 VINoAU6Y/GaYZhSnYkwu4IL+gzrTlLj8gVjmVnY4tefa1t0UgfcwG9Azydfo=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the xhci specification(chapter 4.6.8.1) soft retry
shouldn't be used if the slot id is higher than 0. Currently some usb
devices break on some systems because soft retry is being used when
there is a transaction error, without checking the slot id.

Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from
transaction errors")

Signed-off-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
=2D--
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85ceb43e3405..5fa06189068d 100644
=2D-- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2270,7 +2270,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhc=
i, struct xhci_td *td,
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
 		if ((ep_ring->err_count++ > MAX_SOFT_RETRY) ||
-		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT)
+		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT || slot_id > 0)
 			break;
 		*status =3D 0;
 		xhci_cleanup_halted_endpoint(xhci, slot_id, ep_index,
=2D-
2.23.0

