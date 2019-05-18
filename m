Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C4AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8224A2189E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7A8qobf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfERAcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:32:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43972 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfERAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:32:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so13040241edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=21+2kRHbXDaLjV7tdvFUSeidu2A7rBd5BsNq3PIKanY=;
        b=V7A8qobfQY/1yjKbVieC56kv3x8sgBJ6aDKcPEOW6aMeEg62NmMxmK8+oXeVHB8eHI
         JgfKhjU1AZcI0+jIjiTFJs9B5C3JvBD9XmYG6mpkZA1uI7UZti8taQC92qV2w7tPzJgj
         W61k2MYxOaJ9Gcu2mdZ6z2lERBpJCC+RPLTGn0mr1YfQTv8PJHun+Nv7jZnf52l+Lz23
         M3I/OiIKX46X2rziLXQkQm3AHG3Cp6mfTWLkKIXEYqrPu2KQASrg0/IHaUX16XQvkOVC
         n83ENHn/Qs7Y1jIbpvv1y9tpJUVdwriaCC/X/6VovAA5HyjxudsZr1zLpj1yCCgaub4E
         UrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=21+2kRHbXDaLjV7tdvFUSeidu2A7rBd5BsNq3PIKanY=;
        b=HGW1cOFPR/gbPONRVvl6dGv//FYb5FGEADagEEdGrBiwQ8vfgTqOWNg//DBU4nfasD
         k/Y+oZYYWzgCCo06ZYpYEFeixU59fzbPAMNh2FbktR2p7CbvH5cYIW6Dr4s2ckUrNkd0
         3jODavuNvWbRVnRa+hnrtPtIKDlHO2y2IudnJDz3vSnFg/r3dRQVJbRPaYmASNB2+cqh
         52senILrF1j0dZBbNhHWqzAuwOGhszHTr1yDFwA3ZsAK+QH3gFFhwDE25YZOQZSNyTvy
         goxVrtFXl2JIepCGqmSvBO+KmiNQStD0+EJq+ArqxrtDmakgX0fyaZjrepEu56t6eCSh
         HNnQ==
X-Gm-Message-State: APjAAAWfr8f0SHc1jJ4j5Vgl5AV5UcF3lP5aKRgMxc4DAYNKfAPawGbr
        1La3OSf43SAX38muDjqn/uU=
X-Google-Smtp-Source: APXvYqy06z1aaTx7iMHbN6n68ilt5yOF3/dxmiORdWw1LKU+bqJ14ZXLd3U5ZrS4D7s5mRPVYx8dDQ==
X-Received: by 2002:a50:a935:: with SMTP id l50mr59909553edc.198.1558139523673;
        Fri, 17 May 2019 17:32:03 -0700 (PDT)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id j55sm3407297ede.27.2019.05.17.17.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 17:32:02 -0700 (PDT)
Date:   Sat, 18 May 2019 02:32:00 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Improve diagnostic on "Inconsistent kallsyms data"
Message-ID: <20190518003200.rbzvcolxi7g4dc6q@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  linking kallsyms into the kernel occasionally triggers edge conditions
of the linker heuristic and results in inconsistent System.map generation.

This patch adds a first-aid analysis of such inconsistency in form of
unified diff between the two generated symbol maps, where every symbol's
address is replaced by the offset from the previous symbol.

Becomes then trivial to spot symbols reordering without incurring in
the noise of other symbols shifting, as shown below.

$ make
...
  LD      vmlinux.o
  MODPOST vmlinux.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  KSYM    .tmp_kallsyms3.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
Inconsistent kallsyms data
Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
---- .tmp_System.map.relative   2019-05-18 02:13:19.197282498 +0200
++++ System.map.relative        2019-05-18 02:13:16.817219696 +0200
@@ -7,10 +7,10 @@
 0000000000013cf78 A __rela_size
 0000000000012da88 A __pecoff_data_rawsize
 0000000000004e600 A __pecoff_data_size
-000000000004b7000 A __efistub_stext_offset
+000000000004a7000 A __efistub_stext_offset
 000000000001719d8 A __rela_offset
 0000000000026b628 A _kernel_size_le_lo32
-0ffff00000f4b3000 t __efistub__text
+0ffff00000f4c3000 t __efistub__text
 00000000000000000 t _head
 00000000000000000 T _text
 00000000000000040 t pe_header
@@ -28619,10 +28619,10 @@
 00000000000000008 r bus_spec.64271
 00000000000000008 r str_spec.64272
 00000000000000008 R kallsyms_offsets
-00000000000019bd0 R kallsyms_relative_base
+00000000000019bc8 R kallsyms_relative_base
 00000000000000008 R kallsyms_num_syms
 00000000000000008 R kallsyms_names
-0000000000004c468 R kallsyms_markers
+0000000000004c460 R kallsyms_markers
 000000000000001a0 R kallsyms_token_table
 00000000000000368 R kallsyms_token_index
 000000000000838c8 R __start_ro_after_init
@@ -43349,9 +43349,9 @@
 00000000000000000 R __start___modver
 00000000000000000 R __stop___param
 00000000000000008 r __modver_attr
-00000000000000008 R __stop___modver
-00000000000000ff0 R __end_rodata
+00000000000000008 R __end_rodata
 00000000000000000 R __start___ex_table
+00000000000000000 R __stop___modver
 00000000000001c78 R __start_notes
 00000000000000000 R __stop___ex_table
 00000000000000024 r _note_54
@@ -43359,11 +43359,11 @@
 0000000000000034c T idmap_pg_dir
 00000000000003000 T tramp_pg_dir
 00000000000001000 T swapper_pg_dir
-00000000000001000 T swapper_pg_end
-0000000000000f000 T __init_begin
+00000000000001000 T __init_begin
 00000000000000000 T __inittext_begin
 00000000000000000 T _sinittext
 00000000000000000 T stext
+00000000000000000 T swapper_pg_end
 00000000000000020 t preserve_boot_args
 00000000000000020 t __create_page_tables
 000000000000002e4 t __primary_switched
...

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 scripts/link-vmlinux.sh |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

Index: b/scripts/link-vmlinux.sh
===================================================================
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -124,6 +124,25 @@ kallsyms()
 mksysmap()
 {
 	${CONFIG_SHELL} "${srctree}/scripts/mksysmap" ${1} ${2}
+
+	local KSYM_ADDR
+	local KSYM_ADDR_SIZE
+	local KSYM_ADDR_PREV
+	local KSYM_REMAINDER
+
+	# Replace the symbol's address with the offset from the previous
+	# so that in case of "Inconsistent kallsyms data" it's easier
+	# to spot symbols moving around
+	while read KSYM_ADDR KSYM_REMAINDER; do
+		if [ -z "${KSYM_ADDR_PREV}" ]; then
+			KSYM_ADDR_SIZE=`echo ${KSYM_ADDR} | wc -c`
+			KSYM_ADDR_PREV=${KSYM_ADDR}
+		fi
+		printf "%0${KSYM_ADDR_SIZE}x "                     \
+		       $(( 0x${KSYM_ADDR} - 0x${KSYM_ADDR_PREV} ))
+		echo ${KSYM_REMAINDER}
+		KSYM_ADDR_PREV=${KSYM_ADDR}
+	done <${2} >${2}.relative
 }
 
 sortextable()
@@ -134,10 +153,10 @@ sortextable()
 # Delete output files in case of error
 cleanup()
 {
-	rm -f .tmp_System.map
+	rm -f .tmp_System.map*
 	rm -f .tmp_kallsyms*
 	rm -f .tmp_vmlinux*
-	rm -f System.map
+	rm -f System.map*
 	rm -f vmlinux
 	rm -f vmlinux.o
 }
@@ -240,7 +259,6 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 		kallsyms_vmlinux=.tmp_vmlinux3
 
 		vmlinux_link .tmp_kallsyms2.o .tmp_vmlinux3
-
 		kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
 	fi
 fi
@@ -262,7 +280,8 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 
 	if ! cmp -s System.map .tmp_System.map; then
 		echo >&2 Inconsistent kallsyms data
-		echo >&2 Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
+		echo >&2 Try \"make KALLSYMS_EXTRA_PASS=1\" as a workaround
+		diff -u .tmp_System.map.relative System.map.relative
 		exit 1
 	fi
 fi
