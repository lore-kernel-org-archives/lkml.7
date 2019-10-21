Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFC2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CdeNerRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfJUUjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:39:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:35775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUUjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571690311;
        bh=unC+1ijMGoEqcIPC3fGxRtO5GlwL39BCXuya1+SeGFA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=CdeNerRlsFgscBoJxqRPI1uQgpKxrdTBi14IlkkBQfL94X3Xy8TbYPZYR5uZnXAQh
         WHHAqwFAcSXDyq7gX5lcrv/2Wj0claOTuWKRMrCiKBuZyRLdRcOsfA8/uzbCzFZQFR
         zn58hff0jagZpN6mc4FzMLaZOzr8gm8B+w/Lu4FM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.162.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1iZw7L0OKu-00Uslw; Mon, 21
 Oct 2019 22:38:31 +0200
Date:   Mon, 21 Oct 2019 22:38:29 +0200
From:   Helge Deller <deller@gmx.de>
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] kexec: Fix pointer-to-int-cast warnings
Message-ID: <20191021203829.GA22375@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:/51vtI9nDEGVncHNoLxrPHcmWCXGlNG1rbvuE8WBp5HTJZYXa68
 mmn1PRLBKW6ZGut2L4+jWFbs14ud/hErioFtcYuJvRe4NizzsGM2/TyuGZoO3zeku8TRQnF
 0oGjjJaftgxyU206B5WVXeoD2Mw+pBUVY3qq2lgzw95J0dNfCW+ABGQlFDjluXjeN0+vYGl
 ZBkV8qlfAy7oLj81iuu+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:omr0u6W6YOs=:nEB/oDTRKF1UwYZ2pSbZL3
 hNOwn3ZgNLzQgA2tzAZ5sxrF0f2ew4Rh0TeJdXGUsJ/gBgQGL0/7xmZ6khyBtc6zt011wP2Lt
 Dga1LJQwT0YBCp5uxROBT1/LaL3FuvlEJcfrGkfpKvNSpLG9JeljXSuqL2tQUlvysOkrDvBnb
 6qrAuX/5ewlAmFShpxHSAj6gBuXWhXrJak5E+1Qt5ReVSf1bdCH3fnL1RtJcYeV5XKoQV651k
 aPxMHHEP+85aPmLotMD1etoCK6NOEFAD+nvNWJv2P6tBEcdfSUhl6FwJT5aU5E3ZXegGDR+f6
 MN3tQnOGmKvGGkVbgq3Id+5zQ9qzMJ/WP7f1doIi8zclvgEXZ5tBEm1pZsf7qH2lsdcmUraF5
 UwCkW9YMU9K7AhdXUhvfG4VxVu9CmRLpeNB+1/1nkVKNy7vH7pBTUyhUh+xt6byd1XgcmN57t
 hE033UAQ/LI0dkQeEnI5xt9S5H8J0tcFfL3X8+X3+k+SVLUFH6Fkkj81F+1hS3mHtAAAgbZ31
 LYTDsRn795alyb4QIn6JbdK5kB8phk9oZg4p/W84dYr+ETuvEmlynYVqxyPhIi7rSaofqJHMU
 jM05IFPtKb0S6roOstEJJWecVaWYaOVu3sz/StB4ayMFFzshHqL/EtE2Zjd9J7QOD7Uck8Lrl
 OPoyEtpRGK9z1b5QO1eMZq+jat0DHU/Nx6nxDi2GpIFjXdO7If1bXIIr96f/B8zdorQ+S6evK
 3cIUh3zAVGc8RbTAjmBwmtbUjVvLy1e2JQ65qHiAzKrxrfUgmA8b34mhU5aD6NsWnoBoNGk+p
 GbtIbXuR+zQmaBSaZs1/6dFhdYS7X8FYOFQcBD/o9s0Z9pZrI4Ck5fAS1dGVqpLUmTW/2MR6g
 7VIJGqaTnbZxwZgW/TDtdDn6FUD2n/LPWiJcteqDpyY/P4wsoz5eEMiILiuI1WpgPCX+4E9yi
 kpT7e8GqgEKQkhwYpHtTyvLfSxh1S2/yoXvpXJVyekgieCPrZwB5Y/52yp0G+iUSM+zjR/WCg
 bR6WTFXXBoxBospUfHgyJ4NU2iKQmvhwafIC+isbN+02kMlRdQQQqbYjF5OQX0t8OjV+L+LDi
 rE0ULaT1U3ui8fMlAUD4LmlTdS3pNKXKGNBw6+mJleq/LwjaEiKifKmzB/gtZhyNJTrVeRdsE
 bSp7NJHDq2R5UcbNWrboekW95eUBTcBtBAKz2d3+l8pVP1rSvSJhsixpqdKjJwPsBzk4b+Xs9
 RXQjd0RIcYnlOb+/8EltuhBROKZkJ0juRku/t9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two pointer-to-int-cast warnings when compiling for the 32-bit parisc
platform:

kernel/kexec_file.c: In function =E2=80=98crash_prepare_elf64_headers=E2=
=80=99:
kernel/kexec_file.c:1307:19: warning: cast from pointer to integer of diff=
erent size [-Wpointer-to-int-cast]
  phdr->p_vaddr =3D (Elf64_Addr)_text;
                  ^
kernel/kexec_file.c:1324:19: warning: cast from pointer to integer of diff=
erent size [-Wpointer-to-int-cast]
  phdr->p_vaddr =3D (unsigned long long) __va(mstart);
                  ^

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 79f252af7dee..74b7652fc993 100644
=2D-- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1304,7 +1304,7 @@ int crash_prepare_elf64_headers(struct crash_mem *me=
m, int kernel_map,
 	if (kernel_map) {
 		phdr->p_type =3D PT_LOAD;
 		phdr->p_flags =3D PF_R|PF_W|PF_X;
-		phdr->p_vaddr =3D (Elf64_Addr)_text;
+		phdr->p_vaddr =3D (unsigned long) _text;
 		phdr->p_filesz =3D phdr->p_memsz =3D _end - _text;
 		phdr->p_offset =3D phdr->p_paddr =3D __pa_symbol(_text);
 		ehdr->e_phnum++;
@@ -1321,7 +1321,7 @@ int crash_prepare_elf64_headers(struct crash_mem *me=
m, int kernel_map,
 		phdr->p_offset  =3D mstart;

 		phdr->p_paddr =3D mstart;
-		phdr->p_vaddr =3D (unsigned long long) __va(mstart);
+		phdr->p_vaddr =3D (unsigned long) __va(mstart);
 		phdr->p_filesz =3D phdr->p_memsz =3D mend - mstart + 1;
 		phdr->p_align =3D 0;
 		ehdr->e_phnum++;
