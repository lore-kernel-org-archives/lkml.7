Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1721744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HyR8Bdo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfL2RWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:22:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfL2RWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:22:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so17213431pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=d2ZCOXk6pOuLZ4uX0KmFIbD6q4XT8KzNcuufQdURRQw=;
        b=HyR8Bdo6jGIDQMwbuh/d960hidl00ggcit9R+GdoUC7sCFuZn4d0N/bqmU5Qb6yjL6
         9UiOvJH387CsLCBCQ2tTppi5Q4vhNbFgIAIXEo889sr+yw8lrOvRRAl4gIvuHTyXx4sP
         s4Aas7Wk5ioEfpXR0txmfcigTT0OAh+vgPBiSe+cG5nBG9ckLiY/WhLdD33eVnOB3exk
         1krypmpTg2an+ag88yNu6ZBZU2r4QyJd9IvWOa8N3EnI6CyHDyDQ87Hze9G+JwFvzvkw
         JrsGmNz9nIeKX8zpT28lMSe9/2cHcdq6Cra7Yg8LuEdMD3bLPJgZw5n0lVJO7UUhr/Cv
         luCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=d2ZCOXk6pOuLZ4uX0KmFIbD6q4XT8KzNcuufQdURRQw=;
        b=QFtQ4IKNsZhU1cWkKTsEkTM4pN1PLXS4BIu2ZWiat1rZWh3gQ/VKq+jb0i9usyhA9n
         FVIGRDgoBAIbF1fmITxOSsS2BvL9fpqFXMqvlUsqeb5Rz4w4YGr1j9bw9WlQtrxViLUj
         qFeJdbErOOIK89XHtmJLA+mY+Ch8mKJqEyrfvTYFfpvbmYqDelHar6KdeSyBQKEuBKoC
         RJNGpg4m16pMdMfuWS1bOdZX4n04K1axyFcl40riu5RdC/GiTb1KTL2pb4Ss8T6IDKMK
         GPs6OZz3xmkskJu5coAgrAmYxojujebtXpqAzoO7xWvwhn3zCIUSQpZnoLlp9VIJSMmF
         cKrA==
X-Gm-Message-State: APjAAAVWJUmTlDShH4Wu4ol+VoYaEqseMii02WVhmyRf9WyZFagibnTt
        8D4kFgkwRTw05/HvdLm89VA5+g==
X-Google-Smtp-Source: APXvYqxS9B4VPY19ezhDkronqK9tX2Dc3/dG7ZtNqjBtPXUiLRViaQeqCJ3xDgjeHrXpbyuW4w4gjw==
X-Received: by 2002:a63:1110:: with SMTP id g16mr45710067pgl.84.1577640151958;
        Sun, 29 Dec 2019 09:22:31 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j10sm21907911pjb.14.2019.12.29.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 09:22:31 -0800 (PST)
Date:   Sun, 29 Dec 2019 09:22:29 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc4
Message-ID: <alpine.DEB.2.21.9999.1912290921260.204131@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc4

for you to fetch changes up to 1833e327a5ea1d1f356fbf6ded0760c9ff4b0594:

  riscv: export flush_icache_all to modules (2019-12-27 21:51:01 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc4

One important fix for RISC-V:

- Redirect any incoming syscall with an ID less than -1 to
  sys_ni_syscall, rather than allowing them to fall through into the
  syscall handler.

and two minor build fixes:

- Export __asm_copy_{from,to}_user() from where they are defined.
  This fixes a build error triggered by some randconfigs.

- Export flush_icache_all().  I'd resisted this before, since
  historically we didn't want modules to be able to flush the I$
  directly; but apparently everyone else is doing it now.

----------------------------------------------------------------
David Abdurachmanov (1):
      riscv: reject invalid syscalls below -1

Luc Van Oostenryck (1):
      riscv: fix compile failure with EXPORT_SYMBOL() & !MMU

Olof Johansson (1):
      riscv: export flush_icache_all to modules

 arch/riscv/kernel/entry.S       | 1 +
 arch/riscv/kernel/riscv_ksyms.c | 3 ---
 arch/riscv/lib/uaccess.S        | 4 ++++
 arch/riscv/mm/cacheflush.c      | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)


Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6896332	2329908	 313920	9540160	 919240	vmlinux.rv64.orig
6896379	2329908	 313920	9540207	 91926f	vmlinux.rv64.patched
6656967	1939072	 257576	8853615	 87186f	vmlinux.rv32.orig
6656994	1939072	 257576	8853642	 87188a	vmlinux.rv32.patched
1171666	 353368	 130024	1655058	 194112	vmlinux.nommu_virt.orig
1171674	 353368	 130024	1655066	 19411a	vmlinux.nommu_virt.patched
