Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E23C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589FD20879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB5pkOeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfEXHzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:55:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42570 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfEXHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:55:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so13077711eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7ue/ep41Vyg8fSLSDglj3sGoiM9LEN1HNpkcUicUI6U=;
        b=JB5pkOeJMcdznnxHA7EyvlDBD8kuWGGxJzJIm6zBQCA95i7RQfE9ZLDn22tH7/SMcx
         Vjnz8tYhz5v94YKCxoVnrFflGYBMgg0nvsFN34BzF9h7CzAfMI/2ZENpkKZqDOnhnQSP
         2CsgEEVbKks4nsSj2EoWh/+np6xjXWKvimIzqqs52FYxkBdnBQzOF3Ym1IFaoOXSipkx
         6EEoVeAp7QcSk8XWZgzoRo/8roAdwxxUQDrR99bcuyLQsOl7ybIKfXRYisoeetI5kXh3
         vkdfkg2QHppvCqg8UKta4LeMk5nnaeFtH0kySTiw9D6aVrqEBhADcK7J32vZllUWBkOV
         edXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7ue/ep41Vyg8fSLSDglj3sGoiM9LEN1HNpkcUicUI6U=;
        b=Eug/Zpn8dglKsbBvefx7lBlefHENWNJLoRfLRwNfmvhaCT7Rz56jgdtgXI8F0OQpqy
         08+Of16R2UUTa1OVjB1DXY2TeaCoTZlO3L6kGbKZT8HFhcGe+1cg/9gTHM9x/2Q9nysT
         EbsJoiwi5DpZgk5QlLeFQLOSCZgCxmouinQgP5XVrJ2t5pYmRV92dFomBjxC5KSAQxYB
         vW6qzodQiqJ8Iq9W8MdrSodox56WeQ11he9frBLru63eBMgm3tIqa5V31DTGb/aHfBUo
         UE90smg9IjMlQj/w7GvlE8K2g/RpvAdPMSKKEv6JxQIbpr0T3j5GDxQDrqG8xSZ8I7c0
         eLoA==
X-Gm-Message-State: APjAAAUDw7w480Tf8xuHx0WlMB+tFhhensRX4K8pnQCUnXAvXLyooUrZ
        p65I+pz0CMsBpiGyVIyyKdLX3QhOHPg=
X-Google-Smtp-Source: APXvYqz1UnNTT09S7Mh9LIct+PSyk6liaJmvkuICdGvhtmTkodYJoKMaVr9QJoedK81C6Blu4915lA==
X-Received: by 2002:a17:906:704d:: with SMTP id r13mr19015110ejj.295.1558684536014;
        Fri, 24 May 2019 00:55:36 -0700 (PDT)
Received: from dumbo ([83.137.6.243])
        by smtp.gmail.com with ESMTPSA id e33sm538060edd.53.2019.05.24.00.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 00:55:35 -0700 (PDT)
Date:   Fri, 24 May 2019 09:55:32 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] Improve diagnosis when "Inconsistent kallsyms data"
 happens
Message-ID: <20190524075532.zzya47562tgejgn4@dumbo>
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
  SYSMAP  .tmp_System.map.relative
  SYSMAP  System.map.relative
Inconsistent kallsyms data
Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
----- .tmp_System.map.relative   2019-05-24 09:43:45.249819728 +0200
+++++ System.map.relative        2019-05-24 09:43:42.196968172 +0200
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
...


Changes in v2:
 - *.relative files are generated by a separate function and only when
   needed, this saves time and does not leave unused files around in
   case of successful build


Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 scripts/link-vmlinux.sh |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

Index: b/scripts/link-vmlinux.sh
===================================================================
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -126,6 +126,28 @@ mksysmap()
 	${CONFIG_SHELL} "${srctree}/scripts/mksysmap" ${1} ${2}
 }
 
+# Replace the symbol's address with the offset from the previous so
+# that in case of "Inconsistent kallsyms data" it's easier to spot
+# symbols moving around
+mksysmap_relative()
+{
+	local addr
+	local addr_size
+	local addr_prev
+	local remainder
+
+	info SYSMAP ${2}
+	while read addr remainder; do
+		if [ -z "${addr_prev}" ]; then
+			addr_size=`echo ${addr} | wc -c`
+			addr_prev=${addr}
+		fi
+		printf "%0${addr_size}x " $(( 0x${addr} - 0x${addr_prev} ))
+		echo ${remainder}
+		addr_prev=${addr}
+	done <${1} >${2}
+}
+
 sortextable()
 {
 	${objtree}/scripts/sortextable ${1}
@@ -134,10 +156,10 @@ sortextable()
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
@@ -261,8 +283,13 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 	mksysmap ${kallsyms_vmlinux} .tmp_System.map
 
 	if ! cmp -s System.map .tmp_System.map; then
+		mksysmap_relative .tmp_System.map .tmp_System.map.relative
+		mksysmap_relative System.map System.map.relative
+
 		echo >&2 Inconsistent kallsyms data
-		echo >&2 Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
+		echo >&2 Try \"make KALLSYMS_EXTRA_PASS=1\" as a workaround
+		diff >&2 -u .tmp_System.map.relative System.map.relative
+
 		exit 1
 	fi
 fi
