Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4051CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A303321872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632950AbfJYQWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:22:41 -0400
Received: from shell.v3.sk ([90.176.6.54]:52639 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632806AbfJYQWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:22:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 479D150D84;
        Fri, 25 Oct 2019 18:22:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SprZ62ia76MX; Fri, 25 Oct 2019 18:22:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 718F650D85;
        Fri, 25 Oct 2019 18:22:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TJsZmonhdrVG; Fri, 25 Oct 2019 18:22:31 +0200 (CEST)
Received: from belphegor.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CB79B50D84;
        Fri, 25 Oct 2019 18:22:30 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] iscsi_ibft: Don't limits Targets and NICs to two
Date:   Fri, 25 Oct 2019 18:22:25 +0200
Message-Id: <20191025162225.139691-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to iSCSI Boot Firmware Table Version 1.03 [1], the length of
the control table is ">=3D 18", where the optional expansion structure
pointer follow the mandatory ones. This allows for more than two NICs
and Targets.

[1] ftp://ftp.software.ibm.com/systems/support/bladecenter/iscsi_boot_fir=
mware_table_v1.03.pdf

Let's enforce the minimum length of the control structure instead
instead of limiting it to the smallest allowed size.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/firmware/iscsi_ibft.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.=
c
index 7e12cbdf957cc..fa8bca6910050 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -104,6 +104,7 @@ struct ibft_control {
 	u16 tgt0_off;
 	u16 nic1_off;
 	u16 tgt1_off;
+	u16 expansion[0];
 } __attribute__((__packed__));
=20
 struct ibft_initiator {
@@ -235,7 +236,7 @@ static int ibft_verify_hdr(char *t, struct ibft_hdr *=
hdr, int id, int length)
 				"found %d instead!\n", t, id, hdr->id);
 		return -ENODEV;
 	}
-	if (hdr->length !=3D length) {
+	if (length && hdr->length !=3D length) {
 		printk(KERN_ERR "iBFT error: We expected the %s " \
 				"field header.length to have %d but " \
 				"found %d instead!\n", t, length, hdr->length);
@@ -749,11 +750,11 @@ static int __init ibft_register_kobjects(struct acp=
i_table_ibft *header)
 	control =3D (void *)header + sizeof(*header);
 	end =3D (void *)control + control->hdr.length;
 	eot_offset =3D (void *)header + header->header.length - (void *)control=
;
-	rc =3D ibft_verify_hdr("control", (struct ibft_hdr *)control, id_contro=
l,
-			     sizeof(*control));
+	rc =3D ibft_verify_hdr("control", (struct ibft_hdr *)control, id_contro=
l, 0);
=20
 	/* iBFT table safety checking */
 	rc |=3D ((control->hdr.index) ? -ENODEV : 0);
+	rc |=3D ((control->hdr.length < sizeof(*control)) ? -ENODEV : 0);
 	if (rc) {
 		printk(KERN_ERR "iBFT error: Control header is invalid!\n");
 		return rc;
--=20
2.23.0

