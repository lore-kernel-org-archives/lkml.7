Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803BCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D46D2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFVF9++0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfH3VsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42747 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3VsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so9245186qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AsFuNuPXHxPU1debd4Sg6mOdtNgPuHaXYSxsCnsbb+4=;
        b=gFVF9++0hexcCjd326zgHyxCem+GBTjabZ/1tW+ufKNXHau0zJez0dB8VC37fhJxrm
         +LcizIU0hZ/f0vCxGIqO/kQhbNFIa6YVTtE6bywAEjjxdIGOrCBEoINugeF6A80dQP7w
         WviSQYIY7P9w77VJg2op1icPo1DUiK2rvOzlo5E5nP8ZhvEDqwEL6//S16iBylnXnBMy
         VWlX7vvebER1jRRm2lYoTfcEx7Jy1fwXBWGOeeEMiGjB1LxpICURj4mVZyOjobQtZpAF
         YRN7oih+A5lP7zsyVkbLsUVIAb81ZjTUNJmoOb6k7QuCV6GT+WRccvG5lvzbE3tHbfpE
         ixuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AsFuNuPXHxPU1debd4Sg6mOdtNgPuHaXYSxsCnsbb+4=;
        b=bngAXJ1T+hPtT6CDLk/ALdxHdTHHBPMgH3/IkIMV5YXguG+wM/D7PxhYYI+7YX3BW6
         ZD+qeF8Kb1lHDOk2pRX5ylR3Nd9ZCg1N1kD13YLoaIjb3CF/leApeD3Ke4fnNe/knL8g
         +Jj8gKRSaG1rutbWzkn8UH31kng/Fhwc9uaJQDNrCoo0QEVy/ZeIJB6V4f05l+Va5Qz6
         7f3X+KcFaJ58O3D6jlUBjy9ld4rf7kEPJhWB596Hp5cte4m1gb3LRxyKMVCObi/86k0K
         oiHia/giei/o83rv/tdTztUEnM1u6TWSJbtGfuJ4XzX0bppVaKc+thys4S85aqDdQSyS
         aNww==
X-Gm-Message-State: APjAAAWj4KzQUy9MdqQGZSebz/km5FQiIumrJ/9LsVdXf5w+gvXZiMnw
        WgQ35wRp+AJFGP0vNXYevA==
X-Google-Smtp-Source: APXvYqxF1XqRPjswAOYso/WrJ3wn4elMnrjsPr8/gDInYu1KM1a2es+63vRB0PhV/q4JESOiUhg8Xg==
X-Received: by 2002:ac8:1848:: with SMTP id n8mr17493634qtk.147.1567201679503;
        Fri, 30 Aug 2019 14:47:59 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:47:58 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Adjust the padding size for KASLR
Date:   Fri, 30 Aug 2019 17:47:02 -0400
Message-Id: <20190830214707.1201-1-msys.mizuma@gmail.com>
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

Masayoshi Mizuma (5):
  x86/boot: Wrap up the SRAT traversing code into subtable_parse()
  x86/boot: Add max_addr field in struct boot_params
  x86/boot: Get the max address from SRAT
  x86/mm/KASLR: Cleanup calculation for direct mapping size
  x86/mm/KASLR: Adjust the padding size for the direct mapping.

 Documentation/x86/zero-page.rst       |  4 ++
 arch/x86/boot/compressed/acpi.c       | 33 +++++++++---
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 77 +++++++++++++++++++++------
 4 files changed, 93 insertions(+), 23 deletions(-)

-- 
2.18.1

