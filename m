Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCA3C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E5121927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLUHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 02:10:05 -0500
Received: from [167.172.186.51] ([167.172.186.51]:39792 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfLUHKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 02:10:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9D84DDFCD4;
        Sat, 21 Dec 2019 07:10:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TKdS04iwZrAD; Sat, 21 Dec 2019 07:10:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C8622DFCD3;
        Sat, 21 Dec 2019 07:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iOjmmQTgDlxz; Sat, 21 Dec 2019 07:10:03 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4F22EDFCD0;
        Sat, 21 Dec 2019 07:10:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH] iscsi_ibft: Don't limits Targets and NICs to two
Date:   Sat, 21 Dec 2019 08:09:56 +0100
Message-Id: <20191221070956.268321-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
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
2.24.1

