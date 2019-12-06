Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9583C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA2121835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiaLVM8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFQ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:57:28 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44549 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfLFQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:28 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so128900qvg.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hycUEsK4+AHVYJBhD0DGv1lWVDhbwtIkRIrkRMdi4BI=;
        b=NiaLVM8pj5F89CXXsG58cxHyab7XSzCbczynY/FlweyL/djwzUeygdt83U7DaCAzvq
         MOKOitUyeiMLikGNQsLtCsmqK+CGHGdxBUYU3GnEGKnKqAAtDPn0oDIF496f8luJ7/jh
         BHNGuDIsZqsscFzSzdVWpPaUa8alT+EOM5GfuizfqDpmWG1AnUWZIBtl4OgNC4M9gli1
         xbZj6Ko9L8oUMnZRqTQjdF2uWsAejcR388w0+yz0+rUSffeJK381CA4WyK3tJ9MoOJ8H
         4TXujn3psfQGeAHbZnw5LvacFS0EuH5QWsRPVfYwN8clAqUYkBWvQSjw7XwO/FklJtK8
         lSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hycUEsK4+AHVYJBhD0DGv1lWVDhbwtIkRIrkRMdi4BI=;
        b=scQjBhZ42bmhNtS9h32baq/4G0ktb4QnRzjE8XSZ21B+NEU5QpQuVpo595Ttg7T8Ur
         tTClcUmvlWfbYeepTkShcEobOBelNp3LfcS/1GaJKKLRNYxKMe5DLovnUqJQr29UkYf4
         3EKRlSvsHNyEiobcwkJGIZBdjN3mTD1jQwG7zlUD6xZ1CZ49b2GMQFxZabW2gn32nOEr
         Slobo0wfVlSgEWpnGirgS/huzp/ysBm479kP6+VXgPpUf98HJGyttFtXNTD90rl/nZZN
         ZrycQXZcVr4O7qi05dpCIeo2B/8PkdC+9yaTHyKjzCOcQdXWsSwbEITegF9zrVKsVguV
         jMJw==
X-Gm-Message-State: APjAAAWOdsZfBGAUkMDj5CFnqloctdHVq+8HcRpnGxP4tgX8uMDfcJ4h
        CfUHjnch/9wGy/bh9wrLHA==
X-Google-Smtp-Source: APXvYqwS2f1rlovdXZdUhVqcJSj/ga8/tfwsj5HN90Zk7owEcD2MN2xASO3o+M4HqoZeSWQixU+Bng==
X-Received: by 2002:a0c:e9cf:: with SMTP id q15mr13408287qvo.137.1575651447514;
        Fri, 06 Dec 2019 08:57:27 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y28sm6531373qtk.65.2019.12.06.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:57:27 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Adjust the padding size for KASLR
Date:   Fri,  6 Dec 2019 11:57:03 -0500
Message-Id: <20191206165707.20806-1-msys.mizuma@gmail.com>
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

Changelog:
    v6: - Add documents to top of calc_direct_mapping_size() to
          explain why the size of direct mapping area is configured
          as boot_params.max_addr (0004 patch).
        - Add Acked-by from Baoquan (0004 patch).

Masayoshi Mizuma (4):
  x86/boot: Wrap up the SRAT traversing code into subtable_parse()
  x86/boot: Add max_addr field in struct boot_params
  x86/boot: Get the max address from SRAT
  x86/mm/KASLR: Adjust the padding size for the direct mapping.

 Documentation/x86/zero-page.rst       |  4 ++
 arch/x86/boot/compressed/acpi.c       | 42 +++++++++++++++---
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 63 ++++++++++++++++++++-------
 4 files changed, 88 insertions(+), 23 deletions(-)

-- 
2.20.1

