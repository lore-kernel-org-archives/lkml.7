Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2240C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679521019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364763;
	bh=PsHTU8Erd+vtKNKmSlyXDC3LQk8ZNGmFsW4B4wWBAAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqLgIsbQrk4qn/sfCnhxnMu8839IQtb9Ss7HBA6D5TI+2RPv9o6GuNF6ePId03ygA
	 Mi4CN9PAHMaRWkHjivhddImxQf2FdYKXCvfGpd15Drz0B2EDQfwGY4nxMGQI76Ojyk
	 8ObtmirRVeo7hAIu/anBkjYpZD+5ewslPw326VcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfFLSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:39:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfFLSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ia8axAJLdhpvWbY463d2N4OqOe3tarfo78y8xKsRdDk=; b=MGkMPnTPyXkRY6twOdBTpM95AK
        atC11iqkQiK7jzklb4O7eO/YEH9Squi3GiapGq2UPVBexhJYa8ntyOZN7N6No3/dUrwlHHi+sKIuB
        IWrFQxFr0DLA4+WrZ2PDY6tkQdLVCErbk1kQIzelqc3Z2akSfpTUCYS9FS80A5vGkJikmuhkgW/rc
        1jmN3GfQgdGcglaGkQFbRuAM2PK3oJG2P9WdFJBaRspYJSRIYCsLkqnMf0+stFWKI1xz2o5ExBTP5
        JG/pX5Rm+6wkBiyFaEofOhghKmEQZ06V3iQGVqB5MpHszXTtGbOHr5QjZezQRUCcw0ApaVHXvyETV
        uk9ZhJ8g==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88t-0006Yc-HS; Wed, 12 Jun 2019 18:38:40 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002C3-HU; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v1 28/31] docs: mtd: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:31 -0300
Message-Id: <48a18176002552ab249cd744e5aaa3c1355b1993.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the mtd documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

It should be noticed that Sphinx doesn't handle very well
URLs with dots in the middle. Thankfully, internally, the '.'
char is translated to %2E, so we can jus use %2E instead of
dots, and this will work fine on both text and processed files.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/mtd/index.rst                   |  12 +
 .../mtd/{intel-spi.txt => intel-spi.rst}      |  46 +-
 .../mtd/{nand_ecc.txt => nand_ecc.rst}        | 481 ++++++++++--------
 .../mtd/{spi-nor.txt => spi-nor.rst}          |   7 +-
 drivers/mtd/nand/raw/nand_ecc.c               |   2 +-
 5 files changed, 306 insertions(+), 242 deletions(-)
 create mode 100644 Documentation/mtd/index.rst
 rename Documentation/mtd/{intel-spi.txt => intel-spi.rst} (71%)
 rename Documentation/mtd/{nand_ecc.txt => nand_ecc.rst} (67%)
 rename Documentation/mtd/{spi-nor.txt => spi-nor.rst} (94%)

diff --git a/Documentation/mtd/index.rst b/Documentation/mtd/index.rst
new file mode 100644
index 000000000000..4fdae418ac97
--- /dev/null
+++ b/Documentation/mtd/index.rst
@@ -0,0 +1,12 @@
+:orphan:
+
+==============================
+Memory Technology Device (MTD)
+==============================
+
+.. toctree::
+   :maxdepth: 1
+
+   intel-spi
+   nand_ecc
+   spi-nor
diff --git a/Documentation/mtd/intel-spi.txt b/Documentation/mtd/intel-spi.rst
similarity index 71%
rename from Documentation/mtd/intel-spi.txt
rename to Documentation/mtd/intel-spi.rst
index bc357729c2cb..0e6d9cd5388d 100644
--- a/Documentation/mtd/intel-spi.txt
+++ b/Documentation/mtd/intel-spi.rst
@@ -1,5 +1,6 @@
+==============================
 Upgrading BIOS using intel-spi
-------------------------------
+==============================
 
 Many Intel CPUs like Baytrail and Braswell include SPI serial flash host
 controller which is used to hold BIOS and other platform specific data.
@@ -36,45 +37,45 @@ Linux.
     module parameter to modprobe).
 
  4) Once the board is up and running again, find the right MTD partition
-    (it is named as "BIOS"):
+    (it is named as "BIOS")::
 
-    # cat /proc/mtd
-    dev:    size   erasesize  name
-    mtd0: 00800000 00001000 "BIOS"
+	# cat /proc/mtd
+	dev:    size   erasesize  name
+	mtd0: 00800000 00001000 "BIOS"
 
     So here it will be /dev/mtd0 but it may vary.
 
- 5) Make backup of the existing image first:
+ 5) Make backup of the existing image first::
 
-    # dd if=/dev/mtd0ro of=bios.bak
-    16384+0 records in
-    16384+0 records out
-    8388608 bytes (8.4 MB) copied, 10.0269 s, 837 kB/s
+	# dd if=/dev/mtd0ro of=bios.bak
+	16384+0 records in
+	16384+0 records out
+	8388608 bytes (8.4 MB) copied, 10.0269 s, 837 kB/s
 
- 6) Verify the backup
+ 6) Verify the backup:
 
-    # sha1sum /dev/mtd0ro bios.bak
-    fdbb011920572ca6c991377c4b418a0502668b73  /dev/mtd0ro
-    fdbb011920572ca6c991377c4b418a0502668b73  bios.bak
+	# sha1sum /dev/mtd0ro bios.bak
+	fdbb011920572ca6c991377c4b418a0502668b73  /dev/mtd0ro
+	fdbb011920572ca6c991377c4b418a0502668b73  bios.bak
 
     The SHA1 sums must match. Otherwise do not continue any further!
 
  7) Erase the SPI serial flash. After this step, do not reboot the
-    board! Otherwise it will not start anymore.
+    board! Otherwise it will not start anymore::
 
-    # flash_erase /dev/mtd0 0 0
-    Erasing 4 Kibyte @ 7ff000 -- 100 % complete
+	# flash_erase /dev/mtd0 0 0
+	Erasing 4 Kibyte @ 7ff000 -- 100 % complete
 
  8) Once completed without errors you can write the new BIOS image:
 
     # dd if=MNW2MAX1.X64.0092.R01.1605221712.bin of=/dev/mtd0
 
  9) Verify that the new content of the SPI serial flash matches the new
-    BIOS image:
+    BIOS image::
 
-    # sha1sum /dev/mtd0ro MNW2MAX1.X64.0092.R01.1605221712.bin
-    9b4df9e4be2057fceec3a5529ec3d950836c87a2  /dev/mtd0ro
-    9b4df9e4be2057fceec3a5529ec3d950836c87a2 MNW2MAX1.X64.0092.R01.1605221712.bin
+	# sha1sum /dev/mtd0ro MNW2MAX1.X64.0092.R01.1605221712.bin
+	9b4df9e4be2057fceec3a5529ec3d950836c87a2  /dev/mtd0ro
+	9b4df9e4be2057fceec3a5529ec3d950836c87a2 MNW2MAX1.X64.0092.R01.1605221712.bin
 
     The SHA1 sums should match.
 
@@ -84,5 +85,6 @@ Linux.
 References
 ----------
 
-[1] https://firmware.intel.com/sites/default/files/MinnowBoard.MAX_.X64.92.R01.zip
+[1] https://firmware.intel.com/sites/default/files/MinnowBoard%2EMAX_%2EX64%2E92%2ER01%2Ezip
+
 [2] http://www.linux-mtd.infradead.org/
diff --git a/Documentation/mtd/nand_ecc.txt b/Documentation/mtd/nand_ecc.rst
similarity index 67%
rename from Documentation/mtd/nand_ecc.txt
rename to Documentation/mtd/nand_ecc.rst
index f8c3284bf6a7..e8d3c53a5056 100644
--- a/Documentation/mtd/nand_ecc.txt
+++ b/Documentation/mtd/nand_ecc.rst
@@ -1,3 +1,7 @@
+==========================
+NAND Error-correction Code
+==========================
+
 Introduction
 ============
 
@@ -37,63 +41,79 @@ sometimes also referred to as xor. In C the operator for xor is ^
 Back to ecc.
 Let's give a small figure:
 
+=========  ==== ==== ==== ==== ==== ==== ==== ====   === === === === ====
 byte   0:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp0 rp2 rp4 ... rp14
 byte   1:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp1 rp2 rp4 ... rp14
 byte   2:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp0 rp3 rp4 ... rp14
 byte   3:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp1 rp3 rp4 ... rp14
 byte   4:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp0 rp2 rp5 ... rp14
-....
+...
 byte 254:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp0 rp3 rp5 ... rp15
 byte 255:  bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0   rp1 rp3 rp5 ... rp15
            cp1  cp0  cp1  cp0  cp1  cp0  cp1  cp0
            cp3  cp3  cp2  cp2  cp3  cp3  cp2  cp2
            cp5  cp5  cp5  cp5  cp4  cp4  cp4  cp4
+=========  ==== ==== ==== ==== ==== ==== ==== ====   === === === === ====
 
 This figure represents a sector of 256 bytes.
 cp is my abbreviation for column parity, rp for row parity.
 
 Let's start to explain column parity.
-cp0 is the parity that belongs to all bit0, bit2, bit4, bit6.
-so the sum of all bit0, bit2, bit4 and bit6 values + cp0 itself is even.
+
+- cp0 is the parity that belongs to all bit0, bit2, bit4, bit6.
+
+  so the sum of all bit0, bit2, bit4 and bit6 values + cp0 itself is even.
+
 Similarly cp1 is the sum of all bit1, bit3, bit5 and bit7.
-cp2 is the parity over bit0, bit1, bit4 and bit5
-cp3 is the parity over bit2, bit3, bit6 and bit7.
-cp4 is the parity over bit0, bit1, bit2 and bit3.
-cp5 is the parity over bit4, bit5, bit6 and bit7.
+
+- cp2 is the parity over bit0, bit1, bit4 and bit5
+- cp3 is the parity over bit2, bit3, bit6 and bit7.
+- cp4 is the parity over bit0, bit1, bit2 and bit3.
+- cp5 is the parity over bit4, bit5, bit6 and bit7.
+
 Note that each of cp0 .. cp5 is exactly one bit.
 
 Row parity actually works almost the same.
-rp0 is the parity of all even bytes (0, 2, 4, 6, ... 252, 254)
-rp1 is the parity of all odd bytes (1, 3, 5, 7, ..., 253, 255)
-rp2 is the parity of all bytes 0, 1, 4, 5, 8, 9, ...
-(so handle two bytes, then skip 2 bytes).
-rp3 is covers the half rp2 does not cover (bytes 2, 3, 6, 7, 10, 11, ...)
-for rp4 the rule is cover 4 bytes, skip 4 bytes, cover 4 bytes, skip 4 etc.
-so rp4 calculates parity over bytes 0, 1, 2, 3, 8, 9, 10, 11, 16, ...)
-and rp5 covers the other half, so bytes 4, 5, 6, 7, 12, 13, 14, 15, 20, ..
+
+- rp0 is the parity of all even bytes (0, 2, 4, 6, ... 252, 254)
+- rp1 is the parity of all odd bytes (1, 3, 5, 7, ..., 253, 255)
+- rp2 is the parity of all bytes 0, 1, 4, 5, 8, 9, ...
+  (so handle two bytes, then skip 2 bytes).
+- rp3 is covers the half rp2 does not cover (bytes 2, 3, 6, 7, 10, 11, ...)
+- for rp4 the rule is cover 4 bytes, skip 4 bytes, cover 4 bytes, skip 4 etc.
+
+  so rp4 calculates parity over bytes 0, 1, 2, 3, 8, 9, 10, 11, 16, ...)
+- and rp5 covers the other half, so bytes 4, 5, 6, 7, 12, 13, 14, 15, 20, ..
+
 The story now becomes quite boring. I guess you get the idea.
-rp6 covers 8 bytes then skips 8 etc
-rp7 skips 8 bytes then covers 8 etc
-rp8 covers 16 bytes then skips 16 etc
-rp9 skips 16 bytes then covers 16 etc
-rp10 covers 32 bytes then skips 32 etc
-rp11 skips 32 bytes then covers 32 etc
-rp12 covers 64 bytes then skips 64 etc
-rp13 skips 64 bytes then covers 64 etc
-rp14 covers 128 bytes then skips 128
-rp15 skips 128 bytes then covers 128
+
+- rp6 covers 8 bytes then skips 8 etc
+- rp7 skips 8 bytes then covers 8 etc
+- rp8 covers 16 bytes then skips 16 etc
+- rp9 skips 16 bytes then covers 16 etc
+- rp10 covers 32 bytes then skips 32 etc
+- rp11 skips 32 bytes then covers 32 etc
+- rp12 covers 64 bytes then skips 64 etc
+- rp13 skips 64 bytes then covers 64 etc
+- rp14 covers 128 bytes then skips 128
+- rp15 skips 128 bytes then covers 128
 
 In the end the parity bits are grouped together in three bytes as
 follows:
+
+=====  ===== ===== ===== ===== ===== ===== ===== =====
 ECC    Bit 7 Bit 6 Bit 5 Bit 4 Bit 3 Bit 2 Bit 1 Bit 0
+=====  ===== ===== ===== ===== ===== ===== ===== =====
 ECC 0   rp07  rp06  rp05  rp04  rp03  rp02  rp01  rp00
 ECC 1   rp15  rp14  rp13  rp12  rp11  rp10  rp09  rp08
 ECC 2   cp5   cp4   cp3   cp2   cp1   cp0      1     1
+=====  ===== ===== ===== ===== ===== ===== ===== =====
 
 I detected after writing this that ST application note AN1823
 (http://www.st.com/stonline/) gives a much
 nicer picture.(but they use line parity as term where I use row parity)
 Oh well, I'm graphically challenged, so suffer with me for a moment :-)
+
 And I could not reuse the ST picture anyway for copyright reasons.
 
 
@@ -101,9 +121,10 @@ Attempt 0
 =========
 
 Implementing the parity calculation is pretty simple.
-In C pseudocode:
-for (i = 0; i < 256; i++)
-{
+In C pseudocode::
+
+  for (i = 0; i < 256; i++)
+  {
     if (i & 0x01)
        rp1 = bit7 ^ bit6 ^ bit5 ^ bit4 ^ bit3 ^ bit2 ^ bit1 ^ bit0 ^ rp1;
     else
@@ -142,7 +163,7 @@ for (i = 0; i < 256; i++)
     cp3 = bit7 ^ bit6 ^ bit3 ^ bit2 ^ cp3
     cp4 = bit3 ^ bit2 ^ bit1 ^ bit0 ^ cp4
     cp5 = bit7 ^ bit6 ^ bit5 ^ bit4 ^ cp5
-}
+  }
 
 
 Analysis 0
@@ -167,82 +188,84 @@ This leads to:
 Attempt 1
 =========
 
-const char parity[256] = {
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0
-};
+::
 
-void ecc1(const unsigned char *buf, unsigned char *code)
-{
-    int i;
-    const unsigned char *bp = buf;
-    unsigned char cur;
-    unsigned char rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
-    unsigned char rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15;
-    unsigned char par;
+  const char parity[256] = {
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
+      0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0
+  };
 
-    par = 0;
-    rp0 = 0; rp1 = 0; rp2 = 0; rp3 = 0;
-    rp4 = 0; rp5 = 0; rp6 = 0; rp7 = 0;
-    rp8 = 0; rp9 = 0; rp10 = 0; rp11 = 0;
-    rp12 = 0; rp13 = 0; rp14 = 0; rp15 = 0;
+  void ecc1(const unsigned char *buf, unsigned char *code)
+  {
+      int i;
+      const unsigned char *bp = buf;
+      unsigned char cur;
+      unsigned char rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
+      unsigned char rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15;
+      unsigned char par;
 
-    for (i = 0; i < 256; i++)
-    {
-        cur = *bp++;
-        par ^= cur;
-        if (i & 0x01) rp1 ^= cur; else rp0 ^= cur;
-        if (i & 0x02) rp3 ^= cur; else rp2 ^= cur;
-        if (i & 0x04) rp5 ^= cur; else rp4 ^= cur;
-        if (i & 0x08) rp7 ^= cur; else rp6 ^= cur;
-        if (i & 0x10) rp9 ^= cur; else rp8 ^= cur;
-        if (i & 0x20) rp11 ^= cur; else rp10 ^= cur;
-        if (i & 0x40) rp13 ^= cur; else rp12 ^= cur;
-        if (i & 0x80) rp15 ^= cur; else rp14 ^= cur;
-    }
-    code[0] =
-        (parity[rp7] << 7) |
-        (parity[rp6] << 6) |
-        (parity[rp5] << 5) |
-        (parity[rp4] << 4) |
-        (parity[rp3] << 3) |
-        (parity[rp2] << 2) |
-        (parity[rp1] << 1) |
-        (parity[rp0]);
-    code[1] =
-        (parity[rp15] << 7) |
-        (parity[rp14] << 6) |
-        (parity[rp13] << 5) |
-        (parity[rp12] << 4) |
-        (parity[rp11] << 3) |
-        (parity[rp10] << 2) |
-        (parity[rp9]  << 1) |
-        (parity[rp8]);
-    code[2] =
-        (parity[par & 0xf0] << 7) |
-        (parity[par & 0x0f] << 6) |
-        (parity[par & 0xcc] << 5) |
-        (parity[par & 0x33] << 4) |
-        (parity[par & 0xaa] << 3) |
-        (parity[par & 0x55] << 2);
-    code[0] = ~code[0];
-    code[1] = ~code[1];
-    code[2] = ~code[2];
-}
+      par = 0;
+      rp0 = 0; rp1 = 0; rp2 = 0; rp3 = 0;
+      rp4 = 0; rp5 = 0; rp6 = 0; rp7 = 0;
+      rp8 = 0; rp9 = 0; rp10 = 0; rp11 = 0;
+      rp12 = 0; rp13 = 0; rp14 = 0; rp15 = 0;
+
+      for (i = 0; i < 256; i++)
+      {
+          cur = *bp++;
+          par ^= cur;
+          if (i & 0x01) rp1 ^= cur; else rp0 ^= cur;
+          if (i & 0x02) rp3 ^= cur; else rp2 ^= cur;
+          if (i & 0x04) rp5 ^= cur; else rp4 ^= cur;
+          if (i & 0x08) rp7 ^= cur; else rp6 ^= cur;
+          if (i & 0x10) rp9 ^= cur; else rp8 ^= cur;
+          if (i & 0x20) rp11 ^= cur; else rp10 ^= cur;
+          if (i & 0x40) rp13 ^= cur; else rp12 ^= cur;
+          if (i & 0x80) rp15 ^= cur; else rp14 ^= cur;
+      }
+      code[0] =
+          (parity[rp7] << 7) |
+          (parity[rp6] << 6) |
+          (parity[rp5] << 5) |
+          (parity[rp4] << 4) |
+          (parity[rp3] << 3) |
+          (parity[rp2] << 2) |
+          (parity[rp1] << 1) |
+          (parity[rp0]);
+      code[1] =
+          (parity[rp15] << 7) |
+          (parity[rp14] << 6) |
+          (parity[rp13] << 5) |
+          (parity[rp12] << 4) |
+          (parity[rp11] << 3) |
+          (parity[rp10] << 2) |
+          (parity[rp9]  << 1) |
+          (parity[rp8]);
+      code[2] =
+          (parity[par & 0xf0] << 7) |
+          (parity[par & 0x0f] << 6) |
+          (parity[par & 0xcc] << 5) |
+          (parity[par & 0x33] << 4) |
+          (parity[par & 0xaa] << 3) |
+          (parity[par & 0x55] << 2);
+      code[0] = ~code[0];
+      code[1] = ~code[1];
+      code[2] = ~code[2];
+  }
 
 Still pretty straightforward. The last three invert statements are there to
 give a checksum of 0xff 0xff 0xff for an empty flash. In an empty flash
@@ -293,88 +316,90 @@ Let's give it a try...
 Attempt 2
 =========
 
-extern const char parity[256];
+::
 
-void ecc2(const unsigned char *buf, unsigned char *code)
-{
-    int i;
-    const unsigned long *bp = (unsigned long *)buf;
-    unsigned long cur;
-    unsigned long rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
-    unsigned long rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15;
-    unsigned long par;
+  extern const char parity[256];
 
-    par = 0;
-    rp0 = 0; rp1 = 0; rp2 = 0; rp3 = 0;
-    rp4 = 0; rp5 = 0; rp6 = 0; rp7 = 0;
-    rp8 = 0; rp9 = 0; rp10 = 0; rp11 = 0;
-    rp12 = 0; rp13 = 0; rp14 = 0; rp15 = 0;
+  void ecc2(const unsigned char *buf, unsigned char *code)
+  {
+      int i;
+      const unsigned long *bp = (unsigned long *)buf;
+      unsigned long cur;
+      unsigned long rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
+      unsigned long rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15;
+      unsigned long par;
 
-    for (i = 0; i < 64; i++)
-    {
-        cur = *bp++;
-        par ^= cur;
-        if (i & 0x01) rp5 ^= cur; else rp4 ^= cur;
-        if (i & 0x02) rp7 ^= cur; else rp6 ^= cur;
-        if (i & 0x04) rp9 ^= cur; else rp8 ^= cur;
-        if (i & 0x08) rp11 ^= cur; else rp10 ^= cur;
-        if (i & 0x10) rp13 ^= cur; else rp12 ^= cur;
-        if (i & 0x20) rp15 ^= cur; else rp14 ^= cur;
-    }
-    /*
-       we need to adapt the code generation for the fact that rp vars are now
-       long; also the column parity calculation needs to be changed.
-       we'll bring rp4 to 15 back to single byte entities by shifting and
-       xoring
-    */
-    rp4 ^= (rp4 >> 16); rp4 ^= (rp4 >> 8); rp4 &= 0xff;
-    rp5 ^= (rp5 >> 16); rp5 ^= (rp5 >> 8); rp5 &= 0xff;
-    rp6 ^= (rp6 >> 16); rp6 ^= (rp6 >> 8); rp6 &= 0xff;
-    rp7 ^= (rp7 >> 16); rp7 ^= (rp7 >> 8); rp7 &= 0xff;
-    rp8 ^= (rp8 >> 16); rp8 ^= (rp8 >> 8); rp8 &= 0xff;
-    rp9 ^= (rp9 >> 16); rp9 ^= (rp9 >> 8); rp9 &= 0xff;
-    rp10 ^= (rp10 >> 16); rp10 ^= (rp10 >> 8); rp10 &= 0xff;
-    rp11 ^= (rp11 >> 16); rp11 ^= (rp11 >> 8); rp11 &= 0xff;
-    rp12 ^= (rp12 >> 16); rp12 ^= (rp12 >> 8); rp12 &= 0xff;
-    rp13 ^= (rp13 >> 16); rp13 ^= (rp13 >> 8); rp13 &= 0xff;
-    rp14 ^= (rp14 >> 16); rp14 ^= (rp14 >> 8); rp14 &= 0xff;
-    rp15 ^= (rp15 >> 16); rp15 ^= (rp15 >> 8); rp15 &= 0xff;
-    rp3 = (par >> 16); rp3 ^= (rp3 >> 8); rp3 &= 0xff;
-    rp2 = par & 0xffff; rp2 ^= (rp2 >> 8); rp2 &= 0xff;
-    par ^= (par >> 16);
-    rp1 = (par >> 8); rp1 &= 0xff;
-    rp0 = (par & 0xff);
-    par ^= (par >> 8); par &= 0xff;
+      par = 0;
+      rp0 = 0; rp1 = 0; rp2 = 0; rp3 = 0;
+      rp4 = 0; rp5 = 0; rp6 = 0; rp7 = 0;
+      rp8 = 0; rp9 = 0; rp10 = 0; rp11 = 0;
+      rp12 = 0; rp13 = 0; rp14 = 0; rp15 = 0;
 
-    code[0] =
-        (parity[rp7] << 7) |
-        (parity[rp6] << 6) |
-        (parity[rp5] << 5) |
-        (parity[rp4] << 4) |
-        (parity[rp3] << 3) |
-        (parity[rp2] << 2) |
-        (parity[rp1] << 1) |
-        (parity[rp0]);
-    code[1] =
-        (parity[rp15] << 7) |
-        (parity[rp14] << 6) |
-        (parity[rp13] << 5) |
-        (parity[rp12] << 4) |
-        (parity[rp11] << 3) |
-        (parity[rp10] << 2) |
-        (parity[rp9]  << 1) |
-        (parity[rp8]);
-    code[2] =
-        (parity[par & 0xf0] << 7) |
-        (parity[par & 0x0f] << 6) |
-        (parity[par & 0xcc] << 5) |
-        (parity[par & 0x33] << 4) |
-        (parity[par & 0xaa] << 3) |
-        (parity[par & 0x55] << 2);
-    code[0] = ~code[0];
-    code[1] = ~code[1];
-    code[2] = ~code[2];
-}
+      for (i = 0; i < 64; i++)
+      {
+          cur = *bp++;
+          par ^= cur;
+          if (i & 0x01) rp5 ^= cur; else rp4 ^= cur;
+          if (i & 0x02) rp7 ^= cur; else rp6 ^= cur;
+          if (i & 0x04) rp9 ^= cur; else rp8 ^= cur;
+          if (i & 0x08) rp11 ^= cur; else rp10 ^= cur;
+          if (i & 0x10) rp13 ^= cur; else rp12 ^= cur;
+          if (i & 0x20) rp15 ^= cur; else rp14 ^= cur;
+      }
+      /*
+         we need to adapt the code generation for the fact that rp vars are now
+         long; also the column parity calculation needs to be changed.
+         we'll bring rp4 to 15 back to single byte entities by shifting and
+         xoring
+      */
+      rp4 ^= (rp4 >> 16); rp4 ^= (rp4 >> 8); rp4 &= 0xff;
+      rp5 ^= (rp5 >> 16); rp5 ^= (rp5 >> 8); rp5 &= 0xff;
+      rp6 ^= (rp6 >> 16); rp6 ^= (rp6 >> 8); rp6 &= 0xff;
+      rp7 ^= (rp7 >> 16); rp7 ^= (rp7 >> 8); rp7 &= 0xff;
+      rp8 ^= (rp8 >> 16); rp8 ^= (rp8 >> 8); rp8 &= 0xff;
+      rp9 ^= (rp9 >> 16); rp9 ^= (rp9 >> 8); rp9 &= 0xff;
+      rp10 ^= (rp10 >> 16); rp10 ^= (rp10 >> 8); rp10 &= 0xff;
+      rp11 ^= (rp11 >> 16); rp11 ^= (rp11 >> 8); rp11 &= 0xff;
+      rp12 ^= (rp12 >> 16); rp12 ^= (rp12 >> 8); rp12 &= 0xff;
+      rp13 ^= (rp13 >> 16); rp13 ^= (rp13 >> 8); rp13 &= 0xff;
+      rp14 ^= (rp14 >> 16); rp14 ^= (rp14 >> 8); rp14 &= 0xff;
+      rp15 ^= (rp15 >> 16); rp15 ^= (rp15 >> 8); rp15 &= 0xff;
+      rp3 = (par >> 16); rp3 ^= (rp3 >> 8); rp3 &= 0xff;
+      rp2 = par & 0xffff; rp2 ^= (rp2 >> 8); rp2 &= 0xff;
+      par ^= (par >> 16);
+      rp1 = (par >> 8); rp1 &= 0xff;
+      rp0 = (par & 0xff);
+      par ^= (par >> 8); par &= 0xff;
+
+      code[0] =
+          (parity[rp7] << 7) |
+          (parity[rp6] << 6) |
+          (parity[rp5] << 5) |
+          (parity[rp4] << 4) |
+          (parity[rp3] << 3) |
+          (parity[rp2] << 2) |
+          (parity[rp1] << 1) |
+          (parity[rp0]);
+      code[1] =
+          (parity[rp15] << 7) |
+          (parity[rp14] << 6) |
+          (parity[rp13] << 5) |
+          (parity[rp12] << 4) |
+          (parity[rp11] << 3) |
+          (parity[rp10] << 2) |
+          (parity[rp9]  << 1) |
+          (parity[rp8]);
+      code[2] =
+          (parity[par & 0xf0] << 7) |
+          (parity[par & 0x0f] << 6) |
+          (parity[par & 0xcc] << 5) |
+          (parity[par & 0x33] << 4) |
+          (parity[par & 0xaa] << 3) |
+          (parity[par & 0x55] << 2);
+      code[0] = ~code[0];
+      code[1] = ~code[1];
+      code[2] = ~code[2];
+  }
 
 The parity array is not shown any more. Note also that for these
 examples I kinda deviated from my regular programming style by allowing
@@ -403,28 +428,32 @@ lookups
 Attempt 3
 =========
 
-Odd replaced:
-        if (i & 0x01) rp5 ^= cur; else rp4 ^= cur;
-        if (i & 0x02) rp7 ^= cur; else rp6 ^= cur;
-        if (i & 0x04) rp9 ^= cur; else rp8 ^= cur;
-        if (i & 0x08) rp11 ^= cur; else rp10 ^= cur;
-        if (i & 0x10) rp13 ^= cur; else rp12 ^= cur;
-        if (i & 0x20) rp15 ^= cur; else rp14 ^= cur;
-with
-        if (i & 0x01) rp5 ^= cur;
-        if (i & 0x02) rp7 ^= cur;
-        if (i & 0x04) rp9 ^= cur;
-        if (i & 0x08) rp11 ^= cur;
-        if (i & 0x10) rp13 ^= cur;
-        if (i & 0x20) rp15 ^= cur;
+Odd replaced::
 
-        and outside the loop added:
-        rp4  = par ^ rp5;
-        rp6  = par ^ rp7;
-        rp8  = par ^ rp9;
-        rp10  = par ^ rp11;
-        rp12  = par ^ rp13;
-        rp14  = par ^ rp15;
+          if (i & 0x01) rp5 ^= cur; else rp4 ^= cur;
+          if (i & 0x02) rp7 ^= cur; else rp6 ^= cur;
+          if (i & 0x04) rp9 ^= cur; else rp8 ^= cur;
+          if (i & 0x08) rp11 ^= cur; else rp10 ^= cur;
+          if (i & 0x10) rp13 ^= cur; else rp12 ^= cur;
+          if (i & 0x20) rp15 ^= cur; else rp14 ^= cur;
+
+with::
+
+          if (i & 0x01) rp5 ^= cur;
+          if (i & 0x02) rp7 ^= cur;
+          if (i & 0x04) rp9 ^= cur;
+          if (i & 0x08) rp11 ^= cur;
+          if (i & 0x10) rp13 ^= cur;
+          if (i & 0x20) rp15 ^= cur;
+
+and outside the loop added::
+
+          rp4  = par ^ rp5;
+          rp6  = par ^ rp7;
+          rp8  = par ^ rp9;
+          rp10  = par ^ rp11;
+          rp12  = par ^ rp13;
+          rp14  = par ^ rp15;
 
 And after that the code takes about 30% more time, although the number of
 statements is reduced. This is also reflected in the assembly code.
@@ -448,7 +477,7 @@ Attempt 4
 =========
 
 Unrolled the loop 1, 2, 3 and 4 times.
-For 4 the code starts with:
+For 4 the code starts with::
 
     for (i = 0; i < 4; i++)
     {
@@ -471,8 +500,11 @@ Analysis 4
 ==========
 
 Unrolling once gains about 15%
+
 Unrolling twice keeps the gain at about 15%
+
 Unrolling three times gives a gain of 30% compared to attempt 2.
+
 Unrolling four times gives a marginal improvement compared to unrolling
 three times.
 
@@ -492,8 +524,10 @@ Attempt 5
 
 Effectively so all odd digit rp assignments in the loop were removed.
 This included the else clause of the if statements.
-Of course after the loop we need to correct things by adding code like:
+Of course after the loop we need to correct things by adding code like::
+
     rp5 = par ^ rp4;
+
 Also the initial assignments (rp5 = 0; etc) could be removed.
 Along the line I also removed the initialisation of rp0/1/2/3.
 
@@ -513,7 +547,7 @@ statement. Time for yet another version!
 Attempt 6
 =========
 
-THe code within the for loop was changed to:
+THe code within the for loop was changed to::
 
     for (i = 0; i < 4; i++)
     {
@@ -564,13 +598,17 @@ million iterations in order not to lose too much accuracy. This one
 definitely seemed to be the jackpot!
 
 There is a little bit more room for improvement though. There are three
-places with statements:
-rp4 ^= cur; rp6 ^= cur;
+places with statements::
+
+	rp4 ^= cur; rp6 ^= cur;
+
 It seems more efficient to also maintain a variable rp4_6 in the while
 loop; This eliminates 3 statements per loop. Of course after the loop we
-need to correct by adding:
-    rp4 ^= rp4_6;
-    rp6 ^= rp4_6
+need to correct by adding::
+
+	rp4 ^= rp4_6;
+	rp6 ^= rp4_6
+
 Furthermore there are 4 sequential assignments to rp8. This can be
 encoded slightly more efficiently by saving tmppar before those 4 lines
 and later do rp8 = rp8 ^ tmppar ^ notrp8;
@@ -582,7 +620,7 @@ Time for a new test!
 Attempt 7
 =========
 
-The new code now looks like:
+The new code now looks like::
 
     for (i = 0; i < 4; i++)
     {
@@ -644,9 +682,12 @@ Although it seems that the code within the loop cannot be optimised
 further there is still room to optimize the generation of the ecc codes.
 We can simply calculate the total parity. If this is 0 then rp4 = rp5
 etc. If the parity is 1, then rp4 = !rp5;
+
 But if rp4 = rp5 we do not need rp5 etc. We can just write the even bits
-in the result byte and then do something like
+in the result byte and then do something like::
+
     code[0] |= (code[0] << 1);
+
 Lets test this.
 
 
@@ -657,11 +698,13 @@ Changed the code but again this slightly degrades performance. Tried all
 kind of other things, like having dedicated parity arrays to avoid the
 shift after parity[rp7] << 7; No gain.
 Change the lookup using the parity array by using shift operators (e.g.
-replace parity[rp7] << 7 with:
-rp7 ^= (rp7 << 4);
-rp7 ^= (rp7 << 2);
-rp7 ^= (rp7 << 1);
-rp7 &= 0x80;
+replace parity[rp7] << 7 with::
+
+	rp7 ^= (rp7 << 4);
+	rp7 ^= (rp7 << 2);
+	rp7 ^= (rp7 << 1);
+	rp7 &= 0x80;
+
 No gain.
 
 The only marginal change was inverting the parity bits, so we can remove
@@ -683,13 +726,16 @@ Correcting errors
 
 For correcting errors I again used the ST application note as a starter,
 but I also peeked at the existing code.
+
 The algorithm itself is pretty straightforward. Just xor the given and
 the calculated ecc. If all bytes are 0 there is no problem. If 11 bits
 are 1 we have one correctable bit error. If there is 1 bit 1, we have an
 error in the given ecc code.
+
 It proved to be fastest to do some table lookups. Performance gain
 introduced by this is about a factor 2 on my system when a repair had to
 be done, and 1% or so if no repair had to be done.
+
 Code size increased from 330 bytes to 686 bytes for this function.
 (gcc 4.2, -O3)
 
@@ -700,8 +746,10 @@ Conclusion
 The gain when calculating the ecc is tremendous. Om my development hardware
 a speedup of a factor of 18 for ecc calculation was achieved. On a test on an
 embedded system with a MIPS core a factor 7 was obtained.
+
 On a test with a Linksys NSLU2 (ARMv5TE processor) the speedup was a factor
 5 (big endian mode, gcc 4.1.2, -O3)
+
 For correction not much gain could be obtained (as bitflips are rare). Then
 again there are also much less cycles spent there.
 
@@ -711,4 +759,5 @@ out of it with an assembler program, but due to pipeline behaviour etc
 this is very tricky (at least for intel hw).
 
 Author: Frans Meulenbroeks
+
 Copyright (C) 2008 Koninklijke Philips Electronics NV.
diff --git a/Documentation/mtd/spi-nor.txt b/Documentation/mtd/spi-nor.rst
similarity index 94%
rename from Documentation/mtd/spi-nor.txt
rename to Documentation/mtd/spi-nor.rst
index da1fbff5a24c..f5333e3bf486 100644
--- a/Documentation/mtd/spi-nor.txt
+++ b/Documentation/mtd/spi-nor.rst
@@ -1,5 +1,6 @@
-                          SPI NOR framework
-               ============================================
+=================
+SPI NOR framework
+=================
 
 Part I - Why do we need this framework?
 ---------------------------------------
@@ -23,7 +24,7 @@ This framework just adds a new layer between the MTD and the SPI bus driver.
 With this new layer, the SPI NOR controller driver does not depend on the
 m25p80 code anymore.
 
-   Before this framework, the layer is like:
+Before this framework, the layer is like::
 
                    MTD
          ------------------------
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 223fbd8052b3..f6a7808db818 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -11,7 +11,7 @@
  *   Thomas Gleixner (tglx@linutronix.de)
  *
  * Information on how this algorithm works and how it was developed
- * can be found in Documentation/mtd/nand_ecc.txt
+ * can be found in Documentation/mtd/nand_ecc.rst
  */
 
 #include <linux/types.h>
-- 
2.21.0

