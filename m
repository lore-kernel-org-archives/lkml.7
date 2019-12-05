Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1D1C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2420707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfLEMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:23:12 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51894 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbfLEMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:23:12 -0500
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB5CNA2o005391
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 07:23:10 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB5CN5Ak030788
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 07:23:10 -0500
Received: by mail-qt1-f197.google.com with SMTP id h14so2329462qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 04:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=SJTz6nfFGS1JkN4azYE/xxsBuETDiZ5U9y6r6X7LqJw=;
        b=Lyq0AhdkCquqL3o7ZkZnGUiSoVpyJHiFefBRbOlGGN7XMOwoOh4TANflfgDo93Mpc6
         ADLlfbaw0TwFdkXlP8DjvNLnUXcjBTAm9c9pGF/NqQikalbfDldf0ace53ZiAVGAHmOj
         Xvsc3aT5UshJu1HjMrEvSMLg3DKpwfLFWmYFW0qh1XYRE118gHpDOZSsHosvFhrrSX3W
         rJhdL/ufA21p8QgezUNS4c+2umhiFC4FT84JEqcPMRBJCFkAIOBn0O9SukJpMogKoMEr
         BagMciviBTWR7FrF82h9daqJWOgkMmsaCDu9BKFqSQCEFJSmXLPSaTFRUP7NpoXGQ3o3
         1l0w==
X-Gm-Message-State: APjAAAU26Zv/rtg8DDcIXJI/QDhN8i5WZ/ZnV7FNR9cnLctYznBQvCaQ
        EiSMSonap/ppgu3ix2mPrwQaZFs3Q4s9LeoE071QwXurmqTAgaLUyYb+R67bO8n65E1JX57igrH
        EKNI4qrTh0eXxC4I1YH6uPVR0UjHWVm2FOMs=
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr7297723qvo.80.1575548584847;
        Thu, 05 Dec 2019 04:23:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgk8oAYvDbA46BYI57I9SaloPSNPZ2Un2SNHLNzSohQcIWWrSMJAqtuTPWaZTucUrG/RfxJw==
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr7297705qvo.80.1575548584404;
        Thu, 05 Dec 2019 04:23:04 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id a66sm4786531qkb.27.2019.12.05.04.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 04:23:03 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: linux-next 20191204: crash in mm/pagewalk.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1575548582_4281P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 07:23:02 -0500
Message-ID: <4587.1575548582@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1575548582_4281P
Content-Type: text/plain; charset=us-ascii

linux-next 20191204 dies a horrid death on my laptop while booting:

[   12.344975] Write protecting the kernel read-only data: 26624k
[   12.348497] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   12.349701] Freeing unused kernel image (rodata/data gap) memory: 1056K
[   12.349756] BUG: kernel NULL pointer dereference, address: 0000000000000018
[   12.349810] #PF: supervisor read access in kernel mode
[   12.349904] #PF: error_code(0x0000) - not-present page
[   12.349920] PGD 0 P4D 0
[   12.349996] Oops: 0000 [#1] SMP
[   12.350012] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-next-20191204-dirty #703
[   12.350031] Hardware name: TOSHIBA Satellite C55-B/ZBWAA, BIOS 5.00 07/23/2015
[   12.350055] RIP: 0010:__lock_acquire+0x465/0x810
[   12.350132] Code: 00 85 c0 74 10 44 8b 25 79 17 ba 01 45 85 e4 0f 84 c4 30 00 00 45 31 e4 48 83 c4 30 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <49> 81 3e 60 32 0c 9d 41 ba 00 00 00 00 45 0f 45 d7 41 83 fc 01 0f
[   12.350163] RSP: 0018:ffffb2f940053b70 EFLAGS: 00010002
[   12.350179] RAX: ffff8896c7d74040 RBX: 0000000000000000 RCX: 0000000000000000
[   12.350195] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
[   12.350211] RBP: ffffb2f940053bc8 R08: 0000000000000001 R09: 0000000000000000
[   12.350227] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   12.350305] R13: 0000000000000000 R14: 0000000000000018 R15: 0000000000000001
[   12.350323] FS:  0000000000000000(0000) GS:ffff8897f7a00000(0000) knlGS:0000000000000000
[   12.350340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.350355] CR2: 0000000000000018 CR3: 0000000028a24000 CR4: 00000000001006f0
[   12.350370] Call Trace:
[   12.350385]  ? __bfs+0x2c/0x300
[   12.350404]  lock_acquire+0x90/0x170
[   12.350421]  ? walk_pgd_range+0x556/0x7b0
[   12.350441]  _raw_spin_lock+0x31/0x70
[   12.350463]  ? walk_pgd_range+0x556/0x7b0
[   12.350479]  walk_pgd_range+0x556/0x7b0
[   12.350500]  __walk_page_range+0x1a5/0x1c0
[   12.350517]  ? __lock_acquired+0x1f8/0x310
[   12.350534]  walk_page_range_novma+0x72/0xc0
[   12.350553]  ptdump_walk_pgd+0x47/0x80
[   12.350570]  ptdump_walk_pgd_level_core+0xc3/0xf0
[   12.350588]  ? ptdump_walk_pgd_level_debugfs+0x30/0x30
[   12.350683]  ? 0xffffffff9b000000
[   12.350699]  ptdump_walk_pgd_level_checkwx+0x19/0x1b
[   12.350717]  mark_rodata_ro+0xc2/0xc9
[   12.350732]  ? rest_init+0x2c1/0x2eb
[   12.350747]  kernel_init+0x3d/0x105
[   12.350761]  ? rest_init+0x2eb/0x2eb
[   12.350783]  ret_from_fork+0x3a/0x50
[   12.350797] Modules linked in:
[   12.350810] CR2: 0000000000000018
[   12.350822] ---[ end trace 5060898a61f6b985 ]---
[   12.424261] probe of 1-1 returned 1 after 1829 usecs
[   12.453678] calling  sdhci_drv_init+0x0/0x4a @ 1
[   12.527751] RIP: 0010:__lock_acquire+0x465/0x810
[   12.527771] Code: 00 85 c0 74 10 44 8b 25 79 17 ba 01 45 85 e4 0f 84 c4 30 00 00 45 31 e4 48 83 c4 30 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <49> 81 3e 60 32 0c 9d 41 ba 00 00 00 00 45 0f 45 d7 41 83 fc 01 0f
[   12.527792] RSP: 0018:ffffb2f940053b70 EFLAGS: 00010002
[   12.527803] RAX: ffff8896c7d74040 RBX: 0000000000000000 RCX: 0000000000000000
[   12.527814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
[   12.527825] RBP: ffffb2f940053bc8 R08: 0000000000000001 R09: 0000000000000000
[   12.527836] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   12.527846] R13: 0000000000000000 R14: 0000000000000018 R15: 0000000000000001
[   12.527858] FS:  0000000000000000(0000) GS:ffff8897f7a00000(0000) knlGS:0000000000000000
[   12.527879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.527894] CR2: 0000000000000018 CR3: 000000023060a000 CR4: 00000000001006f0
[   12.527911] Kernel panic - not syncing: Fatal exception


--==_Exmh_1575548582_4281P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXej2pQdmEQWDXROgAQK85A//UOIGjyeGX2elEmpKuckbmYzFlQWN1wFB
d6GAvAj3sik9otM+HXT1k0ZUk5VnRsvtne+mRI+RB+6yIwO+pVRAP8gvQXGjEg+N
Ca3GqXS/LoqoXDM7ChH8DpVlEoqzQx9pzPNI7yCxT+YWKpVAr1rPYMm7N4UnK7e0
cCFIAx/xqDGzcqLZtDxsU4Ul1VocMeLeWKhuhwQU7F+H5nZnuI80iM4u59IJULEB
/qY8lYRSuq/V1+1D8KH/aybKIc31OoaYa8URvVeNsLKU1dUY7FYybm+cmbsicvtp
jVTH7jKBGrDpkEOrEevV0Q34r1tyPvuKTaXlMJzNrqhNPnlZaziNloa0FGMGcfyc
DBVNhVjNDXYrHt57yhQemV/R+3nBE5ELDZ7x0JdHcNNUwPAsGRtlSvhvYt25KIHQ
FDilh5hPoZ9oeiifdcP9W1sbA2ePSjjV8nveVURecGQwoKS5Y2h9LU/NRUnH8l3Z
puvIYq2GYLSKdCswXH3dZdIYdGo4DlZDGlv1ezRIrZFW5i57todsN9qUMvi74Zbv
Mm6Gp5hZ+co7KXVXz5bHkrGQgBToTrLdTmMrBzqL7i67MtpOWO6WVtCDYNqtxp1j
Y/clmfuhn53nISwrDuhhifjEA2tL7oNUbn51KMtGoQseH5R8zY4wknK5k8t0Yxr+
0FxQzfK/bpU=
=5CD0
-----END PGP SIGNATURE-----

--==_Exmh_1575548582_4281P--
