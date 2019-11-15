Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F58E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBz9HlXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKOOuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:50:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39389 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:50:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id t8so11064001qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K3gZuaX72+1R2YBKWM0XR/k39YkPNf3E8LIgGu5FJuc=;
        b=PBz9HlXPcfyc723unGRGy53EYrXDu5sl8wtwgcM1SDoj8HBR7wWC08IYQV6YTIrzv1
         meuPonDIPUxqZL95KskO4RuW9vRFtij5xoFuegZ365R5bfvdTMHw6QQSRXUREo8DRJMn
         PPCqyoLj3iY46msN24Yz/3VN0SiTtJjpID4zrRL9CiBWvXZRm6M0fVBwZnf8yGtP230z
         4BRYfvyfqd3v7qJSp2GQ7LOL2+bjWgeA936EPTPWTxys7R0hUccemNwort2Ev5suxpdn
         vguMJNZNSRo+om+U53NEkS4KepzNzSR5DpqL1iSxfoiyaoGOmbolt+ULaKkiXsz0E8kG
         R53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K3gZuaX72+1R2YBKWM0XR/k39YkPNf3E8LIgGu5FJuc=;
        b=hIcwZFqL0UEc4Hv9f5wBpJN/uowC/7lEFihVjGxNQoKv/vUb7HyZx9hiXf5fT+2fta
         PTpI0+8wZrVXr4RDRfQEwLdXH9J105dOgh3xjJnlykmatNw/FmLdHN9UsXVZQ7EjQc+8
         ZqyGw45E3CkQ0hHHsgje5kLbBu2yFUBG6TD+mREkD8tYOZIrkJ7459pvxLXrzLVURnLS
         ihJThNuCroOYv4oXoNYHfEbJkxhBvD0M+DnBI83jjE8lX/QW6iUjTfrxyJ/9pPbSvkEg
         iOc7znQEB9BcIJgsiALNgZTDe9yDSyTfLl8JC9zOK8SVJYWGNS4SCSeo7Frg/oA8/wLL
         vA6g==
X-Gm-Message-State: APjAAAVGIPAC6BgoFDGupujZjY7aDCAiCkOjd0XlT5aHMmZpVP9QtUav
        vV0kbv5kiGjsw+j1E9UA6w==
X-Google-Smtp-Source: APXvYqxw6WGxQpzvH3aaeN404vMOx2HdG4B0xhEdByQilDd+nvt0+apD/ZO1rRsGGyRcr0jXO6NwyA==
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr14134847qti.134.1573829407686;
        Fri, 15 Nov 2019 06:50:07 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l124sm4329317qkf.122.2019.11.15.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:50:07 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Adjust the padding size for KASLR
Date:   Fri, 15 Nov 2019 09:49:13 -0500
Message-Id: <20191115144917.28469-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system sometimes crashes while memory hot-adding on KASLR
enabled system. The crash happens because the regions pointed by
kaslr_regions[].base are overwritten by the hot-added memory.

It happens because of the padding size for kaslr_regions[].base isn't
enough for the system whose physical memory layout has huge space for
memory hotplug. kaslr_regions[].base points "actual installed
memory size + padding" or higher address. So, if the "actual + padding"
is lower address than the maximum memory address, which means the memory
address reachable by memory hot-add, kaslr_regions[].base is destroyed by
the overwritten.

  address
    ^
    |------- maximum memory address (Hotplug)
    |                                    ^
    |------- kaslr_regions[0].base       | Hotadd-able region
    |     ^                              |
    |     | padding                      |
    |     V                              V
    |------- actual memory address (Installed on boot)
    |

Fix it by getting the maximum memory address from SRAT and store
the value in boot_param, then set the padding size while KASLR
initializing if the default padding size isn't enough.

Masayoshi Mizuma (4):
  x86/boot: Wrap up the SRAT traversing code into subtable_parse()
  x86/boot: Add max_addr field in struct boot_params
  x86/boot: Get the max address from SRAT
  x86/mm/KASLR: Adjust the padding size for the direct mapping.

 Documentation/x86/zero-page.rst       |  4 ++
 arch/x86/boot/compressed/acpi.c       | 42 ++++++++++++++++----
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 57 ++++++++++++++++++++-------
 4 files changed, 82 insertions(+), 23 deletions(-)

-- 
2.20.1

