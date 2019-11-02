Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2801FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9D0208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX68/OsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfKBBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:09:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40812 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKBBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:09:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id o49so15386033qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=35lfXKNP4c2jItbhC4v/zSw7uQKT5Ot2fCGqJLJcm2U=;
        b=BX68/OsL2S+F0uc5QaciKM6oiownQVJ3FaAKc48nVqbRfWWJDuiME4X/sn+rFtGM26
         Q4Zs0lB96EjXFzPlT9+dqeeR7sdDK3NMzGUdBE8enEE39oMykGD45Da0LQe35gt+lkJc
         83dbWfy5D2sfleW4EWu75BSDgIlkK//X8/guJtUpq6XKqyQoEWdetFmQR/CObI1ZqePf
         cKjOe0WZ6q7RLBX36J+/2b1GIlyXEmEcEZXiCHhhKkBOw8cJ4vO0043JpdxdqoUYG1BE
         YgFoZrEHBLQjCrT4iQ9mvIE3Gq+0c4S2s3guH7kBa4zSU0nxZAY6ymcCkQTo5Xqp4HwD
         7fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=35lfXKNP4c2jItbhC4v/zSw7uQKT5Ot2fCGqJLJcm2U=;
        b=uaXAeOs1QNydb9AxX2In8v7Vk6IDqx8v8KJkOBht5uwPbnAD/KNZkT5JLwf/SELB66
         tvJtPtJ8R+xGl8hDZnjvoCPNOqYU7ivR0/qo9RdEkfu+g2ad+mElryWJbxxhxTfNXvbY
         o3r7m9nKCKuiIEOC755LX3YXxTdaTAcc0I91sTb5Rqe9/wIkjOQW7u6cJbWKLuLTsXf/
         GPHk8rdI3UIdq4C+GMB21N0BtiahQ06QRURCoifPe1Qgh2wAsIfCTWhLClRKiWnKU/KX
         /2GWESrvmtz6dm87Nndj93w417huAUp6+aLkJ+1jzohc0uijbT6CQROSg336T6ali/6Z
         N/lQ==
X-Gm-Message-State: APjAAAUiXFPptcC7SgIvv6bR7mXEdiVLNn7zeplCT6MmVgSDTcawmyuD
        4PRN4eBQF9K2C+6MKzNxmg==
X-Google-Smtp-Source: APXvYqw57wxqQvsQRk0f9GJ+7ISNbGYmtPafntDEH6GdYe0FRCY9s+sce+DOuOShi8QVz6x8lAEWdg==
X-Received: by 2002:ad4:528d:: with SMTP id v13mr13051033qvr.214.1572656968418;
        Fri, 01 Nov 2019 18:09:28 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i66sm4234340qkb.105.2019.11.01.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:09:27 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Adjust the padding size for KASLR
Date:   Fri,  1 Nov 2019 21:09:07 -0400
Message-Id: <20191102010911.21460-1-msys.mizuma@gmail.com>
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
  x86/mm/KASLR: Adjust the padding size for the direct  mapping.

 Documentation/x86/zero-page.rst       |  4 ++
 arch/x86/boot/compressed/acpi.c       | 35 ++++++++++++---
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 65 ++++++++++++++++++++-------
 4 files changed, 83 insertions(+), 23 deletions(-)

-- 
2.20.1

