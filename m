Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB8C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1D2068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKRL6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:58:42 -0500
Received: from shell.v3.sk ([90.176.6.54]:34705 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfKRL6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:58:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 96B8441C73;
        Mon, 18 Nov 2019 12:58:39 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xIsleteVe34I; Mon, 18 Nov 2019 12:58:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7585741C75;
        Mon, 18 Nov 2019 12:58:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hmzXCPXsTbgR; Mon, 18 Nov 2019 12:58:31 +0100 (CET)
Received: from belphegor.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 41DB741C73;
        Mon, 18 Nov 2019 12:58:31 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] iscsi_ibft: Don't limits Targets and NICs to two
Date:   Mon, 18 Nov 2019 12:58:26 +0100
Message-Id: <20191118115826.63959-1-lkundrak@v3.sk>
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
 drivers/firmware/iscsi_ibft.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.=
c
index 7e12cbdf957cc..96758b71a8db8 100644
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
@@ -749,16 +750,16 @@ static int __init ibft_register_kobjects(struct acp=
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
 	}
-	for (ptr =3D &control->initiator_off; ptr < end; ptr +=3D sizeof(u16)) =
{
+	for (ptr =3D &control->initiator_off; ptr + sizeof(u16) <=3D end; ptr +=
=3D sizeof(u16)) {
 		offset =3D *(u16 *)ptr;
 		if (offset && offset < header->header.length &&
 						offset < eot_offset) {
--=20
2.23.0

