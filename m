Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E32186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCTP6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:58:30 -0400
Received: from mx1.emlix.com ([188.40.240.192]:39302 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCTP6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:58:30 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 2F58560974;
        Wed, 20 Mar 2019 16:58:27 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] objtool: query pkg-config for libelf location
Date:   Wed, 20 Mar 2019 16:58:26 +0100
Message-ID: <13510794.yptIvAPcpm@devpool35>
Organization: emlix GmbH
In-Reply-To: <13279932.E8cnC9vheV@devpool35>
References: <3381642.TeJ1gWjbju@devpool35> <20190320153701.7wym7btpjshdujpz@treble> <13279932.E8cnC9vheV@devpool35>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart194142787.bmJb0Oii2C"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart194142787.bmJb0Oii2C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

If it is not in the default location compilation would fail at several poin=
ts.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
Changes in v2:
  -also hide stderr when querying cflags
  -use ":=3D" assignment as in other places in that file

 Makefile               | 4 +++-
 tools/objtool/Makefile | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 99c0530489ef..32caf30e0d79 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -950,9 +950,11 @@ mod_sign_cmd =3D true
 endif
 export mod_sign_cmd
=20
+HOST_LIBELF_LIBS =3D $(shell pkg-config libelf --libs 2>/dev/null || echo =
=2Dlelf)
+
 ifdef CONFIG_STACK_VALIDATION
   has_libelf :=3D $(call try-run,\
=2D		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
+		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,=
1,0)
   ifeq ($(has_libelf),1)
     objtool_target :=3D tools/objtool FORCE
   else
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..53f8be0f4a1f 100644
=2D-- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,14 +25,17 @@ LIBSUBCMD		=3D $(LIBSUBCMD_OUTPUT)libsubcmd.a
 OBJTOOL    :=3D $(OUTPUT)objtool
 OBJTOOL_IN :=3D $(OBJTOOL)-in.o
=20
+LIBELF_FLAGS :=3D $(shell pkg-config libelf --cflags 2>/dev/null)
+LIBELF_LIBS  :=3D $(shell pkg-config libelf --libs 2>/dev/null || echo -le=
lf)
+
 all: $(OBJTOOL)
=20
 INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS :=3D $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-=
packed
=2DCFLAGS   +=3D -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
=2DLDFLAGS  +=3D -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+CFLAGS   +=3D -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LI=
BELF_FLAGS)
+LDFLAGS  +=3D $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
=20
 # Allow old libelf to be used:
 elfshdr :=3D $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -=
x c -E - | grep elf_getshdr)
=2D-=20
2.21.0

=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart194142787.bmJb0Oii2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXJJjIgAKCRCr5FH7Xu2t
/NZ7BACpB60Da6TrDmonXevR/QLyiB2e4aXkrxudE7zI5BDguxJQGeUj+F/NEJSJ
CVs/QBu7oXqzk//gY5Z/dakN1ugRscaXOkgjPigrtpGEdrNSaaSWsJfFnBwQy35m
3aobqr8gOre7au3lFu+Znli0sgUPTf81eCm4qlA52TeClh105g==
=0t79
-----END PGP SIGNATURE-----

--nextPart194142787.bmJb0Oii2C--



