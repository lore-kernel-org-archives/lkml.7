Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682E4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3503E21883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfH1EPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:15:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56930 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfH1EPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:15:24 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7S4FNiO024818
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:15:23 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7S4FIF8018600
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:15:23 -0400
Received: by mail-qk1-f197.google.com with SMTP id b143so1274730qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 21:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=C1tVOc9JlNuqStjt7rac1k1sHpPpAIQ2idezW3zvU9g=;
        b=UxcCwwltn18hdA5mUbV2fcyZkEr7EFRl9HPUCkUe8zvAq3gpxyYJtc6WTaOuyYcHfH
         RSezfcdVwa6QxgMzOtl2TzVy+gf0ah9WUYTyTJvzrYwEVmO0mAhLFwVS/fXmFE5vv+XS
         E3P4VtKp6TuS3fGec7sMtwSVL4PTw7AhpZiPnY0OWJxHn2XhWDIkvB3vUl62Wbs7mi2c
         MVBHpFlsJsEfdbF5lAqjBG4Pp8pBJwX/uooiqlrnVyruWG8rh8sAfEnp6YQMKi4AhpoO
         QPBW7sMiUbcUjU53GKs/lu3t+uVXw+1OEoSrEIxqFcuMhh/fFwx3HxSl0nIONgpnNIAB
         SgYw==
X-Gm-Message-State: APjAAAXW40Ga1NzYY7KUuSFdQEcdLA84QotX4B4sT0cSgoZCnEepxR/k
        VGaSgPnsp3bm/ynVyxkhKpTXQBMosBsPkcyZqGubKV6nVD/hyROS+mnBZPuoUJHROs/gocFtBpr
        jrWF5OmOqlHuGSNU4yHaPGsrA8sTNEoLibeM=
X-Received: by 2002:ac8:3378:: with SMTP id u53mr2280158qta.318.1566965718024;
        Tue, 27 Aug 2019 21:15:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRkz2PFlL9Zlp8DaQ/junlRTw1mO3B3fdHVz39I5TleNOQuI/Slz3iagy/QL7NAOdOF7tSwg==
X-Received: by 2002:ac8:3378:: with SMTP id u53mr2280136qta.318.1566965717698;
        Tue, 27 Aug 2019 21:15:17 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id c5sm611901qtc.90.2019.08.27.21.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 21:15:16 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: next-20190826 - objtool fails to build.
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1566965715_1612P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Aug 2019 00:15:15 -0400
Message-ID: <133250.1566965715@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1566965715_1612P
Content-Type: text/plain; charset=us-ascii

OK.  I'm mystified.  next-20190806 built fine.  -0818 and -0826 died a
glorious death indeed.  All 3 were build using the same Fedora Rawhide 9.1.1
compiler (installed on July 30). 'git log -- tools/objtool' comes up empty.

Local hack-around was to remove the -Werror from tools/objtool/Makefile

Am particularly mystified by the errors on lines 808/809 - the same compiler that
was happy with the same code in next-0806 is now upset.  The others could possibly
be a stray typedef in an include someplace, but those two errors have me stumped.

For that matter, I'm not even seeing how -Wsign-compare was even getting set, given
a command 'make' and not W=1 or W=2....

(cue twilight zone theme)

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  HOSTCC   /usr/src/linux-next/tools/objtool/fixdep.o
  HOSTLD   /usr/src/linux-next/tools/objtool/fixdep-in.o
  LINK     /usr/src/linux-next/tools/objtool/fixdep
  CC       /usr/src/linux-next/tools/objtool/exec-cmd.o
  CC       /usr/src/linux-next/tools/objtool/help.o
  CC       /usr/src/linux-next/tools/objtool/pager.o
  CC       /usr/src/linux-next/tools/objtool/parse-options.o
  CC       /usr/src/linux-next/tools/objtool/run-command.o
  CC       /usr/src/linux-next/tools/objtool/sigchain.o
  CC       /usr/src/linux-next/tools/objtool/subcmd-config.o
  LD       /usr/src/linux-next/tools/objtool/libsubcmd-in.o
  AR       /usr/src/linux-next/tools/objtool/libsubcmd.a
  CC       /usr/src/linux-next/tools/objtool/builtin-check.o
  CC       /usr/src/linux-next/tools/objtool/builtin-orc.o
  CC       /usr/src/linux-next/tools/objtool/check.o
check.c: In function '__dead_end_function':
check.c:158:17: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
  158 |   for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
      |                 ^
check.c: In function 'add_dead_ends':
check.c:330:25: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
  330 |   else if (rela->addend == rela->sym->sec->len) {
      |                         ^~
check.c:372:25: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
  372 |   else if (rela->addend == rela->sym->sec->len) {
      |                         ^~
check.c: In function 'add_jump_destinations':
check.c:560:36: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'int' [-Wsign-compare]
  560 |   if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
      |                                    ^~
check.c: In function 'handle_jump_alt':
check.c:808:49: warning: unused parameter 'file' [-Wunused-parameter]
  808 | static int handle_jump_alt(struct objtool_file *file,
      |                            ~~~~~~~~~~~~~~~~~~~~~^~~~
check.c:809:27: warning: unused parameter 'special_alt' [-Wunused-parameter]
  809 |       struct special_alt *special_alt,
      |       ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
check.c: In function 'add_jump_table':
check.c:925:20: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
  925 |       rela->addend == pfunc->offset)
      |                    ^~
check.c: In function 'read_unwind_hints':
check.c:1187:16: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
 1187 |  for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
      |                ^
  CC       /usr/src/linux-next/tools/objtool/orc_gen.o
  CC       /usr/src/linux-next/tools/objtool/orc_dump.o
orc_dump.c: In function 'orc_dump':
orc_dump.c:104:16: warning: comparison of integer expressions of different signedness: 'int' and 'size_t' {aka 'long unsigned int'} [-Wsign-compare]
  104 |  for (i = 0; i < nr_sections; i++) {
      |                ^
  CC       /usr/src/linux-next/tools/objtool/elf.o
elf.c: In function 'find_section_by_index':
elf.c:41:16: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
   41 |   if (sec->idx == idx)
      |                ^~
elf.c: In function 'read_sections':
elf.c:148:16: warning: comparison of integer expressions of different signedness: 'int' and 'size_t' {aka 'long unsigned int'} [-Wsign-compare]
  148 |  for (i = 0; i < sections_nr; i++) {
      |                ^
elf.c: In function 'read_relas':
elf.c:370:17: warning: comparison of integer expressions of different signedness: 'int' and 'Elf64_Xword' {aka 'long unsigned int'} [-Wsign-compare]
  370 |   for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
      |                 ^
  CC       /usr/src/linux-next/tools/objtool/special.o
special.c: In function 'get_alt_entry':
special.c:71:38: warning: unused parameter 'elf' [-Wunused-parameter]
   71 | static int get_alt_entry(struct elf *elf, struct special_entry *entry,
      |                          ~~~~~~~~~~~~^~~
special.c: In function 'special_get_alts':
special.c:182:21: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
  182 |   for (idx = 0; idx < nr_entries; idx++) {
      |                     ^
  CC       /usr/src/linux-next/tools/objtool/objtool.o
  CC       /usr/src/linux-next/tools/objtool/libstring.o
  CC       /usr/src/linux-next/tools/objtool/libctype.o
  CC       /usr/src/linux-next/tools/objtool/str_error_r.o
  LD       /usr/src/linux-next/tools/objtool/objtool-in.o
  LINK     /usr/src/linux-next/tools/objtool/objtool


--==_Exmh_1566965715_1612P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWX/0gdmEQWDXROgAQLzkQ//asZUcBfY2dfprEo5t+xs6YBLJPqfwXUD
wRNvBSlHqnLO5SQy3nu1vJSArDi3DBNJfKMeZHcnO8Qo3AR1nxx4lWfTRHqYPUsS
d/PUn68WZuXq9VJTjj6zLTx+zp7Ib8vmNsnZLgPsRsolGBgamYc8+J2kmyZQzYqi
0Md7bU2jk26bC1yrMA7BBcLaOxkUvfURCs+NCsY/USajGyGJ2ymTcDIJg7BoAmuy
6FC5lfve9Jjr5PLy6BAWE2W5bInx6UeZ84eF1g4YBQiD70TIDpOs2vOc6zT3JetN
hTl7THa1grzmPmoFFscGYoujb7CVJSw+xZwL4W2PuJzImPuruipqQIWcX0U6fYs3
0l/j2cjhaVYhdyYPYUpcjT4qvUnbationoHLWcWauZ4g+V/BS/s6TH5GrFOstQcy
OIi/ZbwdI1VyOd5kxNO1SDFuWEttxITCyJMALqAmeIPrreDb2hDP73A8aR3zB2sD
JbZpMKwhsmDfvB0ZGxX1qZpIpBNNDoZdu7/oOmuK4iD/2+Ig4mTs08NO67lfswfY
BmcTdslAltY/wSfb/MJKFNSUHeD5jg1F96FwFiy1HD1qbApEzb0AhAlVv4G8OIGw
DL8YrVhQNluREs3XZ49U8s79DEmZZNjVDDfo4IV8NJRxyBkbBgfSm4fJz/jOwtLo
aDs0nYr/2tY=
=HcRI
-----END PGP SIGNATURE-----

--==_Exmh_1566965715_1612P--
