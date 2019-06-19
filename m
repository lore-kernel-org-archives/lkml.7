Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA85BC31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A652084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sLcyIg8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfFSGn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:43:57 -0400
Received: from ozlabs.org ([203.11.71.1]:39619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFSGn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:43:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TFlr62Qnz9s7h;
        Wed, 19 Jun 2019 16:43:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560926633;
        bh=OroIS/BOV+/JRUDrnqf77oCtopeU+0jOa9qNRyj+JRI=;
        h=Date:From:To:Cc:Subject:From;
        b=sLcyIg8QVUItx9Wd+SQq4sxfARM4GgoHo3/xrFwdMuDXHFuBCYmMjudbSbuJFI4lJ
         3hV9a6GLcOq+Ljt2YwMu31x8YReHOPjEXvxy6fRt3l70WyqBR2Cy/6XS60yRUOHml1
         Yjx8Ymi51rtrdtkP9+Fihe55jBMCrpm9al9lvy9nDfgMauTm+BfGSw3KVt1ysILYwI
         4Ak4rlVsBb6/Y1jG0aALPD6ghxzAI4rsIO5IfNKm0Keq8caK2hvHm/XG1fOvuBhvIz
         +bi/oaP7LFz1o+zsY/5kgf8c3MpUiUphixRH3rF+CQAXXofKMXIugRpCoGn5J2FpgO
         DwHug077Sv7FA==
Date:   Wed, 19 Jun 2019 16:43:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20190619164351.6c3f83be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZTQyCq+/4dt3iCRDQZP+uWE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZTQyCq+/4dt3iCRDQZP+uWE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from usr/include/linux/usbdevice_fs.hdrtest.c:1:
./usr/include/linux/usbdevice_fs.h:88:2: error: unknown type name 'u8'
  u8 num_ports;  /* Number of ports the device is connected */
  ^~
./usr/include/linux/usbdevice_fs.h:92:2: error: unknown type name 'u8'
  u8 ports[7];  /* List of ports on the way from the root  */
  ^~

Caused by commit

  6d101f24f1dd ("USB: add usbfs ioctl to retrieve the connection parameters=
")

Presumably exposed by commit

  b91976b7c0e3 ("kbuild: compile-test UAPI headers to ensure they are self-=
contained")

from the kbuild tree.

I have added this patch for now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 19 Jun 2019 16:36:16 +1000
Subject: [PATCH] USB: fix types in uapi include

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/uapi/linux/usbdevice_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbdevi=
ce_fs.h
index 4b267fe3776e..78efe870c2b7 100644
--- a/include/uapi/linux/usbdevice_fs.h
+++ b/include/uapi/linux/usbdevice_fs.h
@@ -85,11 +85,11 @@ struct usbdevfs_conninfo_ex {
 				/* kernel, the device is connected to.     */
 	__u32 devnum;           /* Device address on the bus.              */
 	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
-	u8 num_ports;		/* Number of ports the device is connected */
+	__u8 num_ports;		/* Number of ports the device is connected */
 				/* to on the way to the root hub. It may   */
 				/* be bigger than size of 'ports' array so */
 				/* userspace can detect overflows.         */
-	u8 ports[7];		/* List of ports on the way from the root  */
+	__u8 ports[7];		/* List of ports on the way from the root  */
 				/* hub to the device. Current limit in     */
 				/* USB specification is 7 tiers (root hub, */
 				/* 5 intermediate hubs, device), which     */
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ZTQyCq+/4dt3iCRDQZP+uWE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0J2acACgkQAVBC80lX
0GyO/Qf/ftfJ6Y3zJCClMg63T2PFhDrRIVYvod82t0s1JAJv6h/Hpgi5ChWt8FS5
wsTkfBKO5oRDfc7GHOtApKnafN7a6TgS1a7LxfGQ5TGtqXD/iNBETJnP+mpnEEnn
DCUP+aEJe6c/NlCpXgJ1iBSeKnxLMwgiEO3hEe0ExS6LQj8tBWIJyOLxOg31NRYY
ibBhYjdeGUBNn5KpJakXFHUXMZz7wW0leWlvArfENo6nqHhBaDnyKRNpozf0NZ+Y
6IElpe4YnztuDJNz6Tj5ueXg/wkIhj859vPBzjAk8XEvP6TZvPdrA0YRFVuGu+C+
dbfcN+lgvQFjzy2jcA1rGu5mpceqIA==
=iNAj
-----END PGP SIGNATURE-----

--Sig_/ZTQyCq+/4dt3iCRDQZP+uWE--
