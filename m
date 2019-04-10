Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62846C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3180920854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpXvL2K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfDJQQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:16:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43683 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfDJQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:16:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so1755685pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x2KYJib3dOzOX8W30eA/GdsrFGJ1QDL/O1I+P3kYlwg=;
        b=XpXvL2K4TmeTB6apty/+7j6PaDGjBWukrD4XgOwH9jLi+UosDmIFjrCJSyhUPwI24r
         t9Qz8BPGmRFt3uOj8lrdM/YocFw48FOg9wQe5zN745/WR4lqDEAOREOVv818ht6yOHhw
         oaMsZGMubKVo6KkCHERJnTkhBjwwymhVBTj/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x2KYJib3dOzOX8W30eA/GdsrFGJ1QDL/O1I+P3kYlwg=;
        b=m4RHfReY2LGtRgQFowIBK6W3RhWqZHAP1+1tZKmlA9VK3wHE6rvYj48r9JVCO3jOaB
         d35KqQm/tt6nfqMKhJHNsu2apqbTV+tXG00jzMnyF2rA2cNr0Eg7ZlI1Fm4SNVsfTVNk
         aDmHdQ9/nfj/5E45q7vMQ35gpRfQoc4LS/tARv1wh+qUhgvSCxBQBWP4CISLkqyUDUw9
         WuRBrjMrE9mxV19+BVK+sZ4JFhcFsmvQ1O3FkIUZ0Q28Z5UUVYHYoA1TeJwN5k2fa+qU
         vz2kdsRlnFQj7OVaN+UAK4XbPwRNUhXCsisv7anI6DQjyWPZST7Mis06Cx5n91KyyV3N
         I8wA==
X-Gm-Message-State: APjAAAUj2BHBB8I0PtzgcRtmfcddeHpMmk1H6R5Cv/lZlsNOkglDTpjH
        vAyoiq2SsT6L4ABHwEvhBu3rbQ==
X-Google-Smtp-Source: APXvYqxV7u4z3SP7rQZaoXm6DgmvlM21aDP/eOO6IxVz6Xq3ILyC5OTxhjHS1EiCzLNEbjzmkf0D4Q==
X-Received: by 2002:a65:6389:: with SMTP id h9mr42126678pgv.398.1554912979563;
        Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a12sm41025812pgq.21.2019.04.10.09.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:16:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 0/3] Kconfig: Refactor memory initialization hardening
Date:   Wed, 10 Apr 2019 09:16:09 -0700
Message-Id: <20190410161612.18545-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a proposed alternative for the memory initialization series,
which refactoring the existing gcc plugins into a separate Kconfig
file and collects all the related options together with some more
language to describe their differences. The last patch adds the
Clang auto init option, as done by Alexander Potapenko.

Since there isn't really a good way to "select" with dependencies,
I've left out CONFIG_INIT_ALL_MEMORY for the moment...

-Kees

Kees Cook (3):
  Kconfig: Create "kernel hardening" config area
  kbuild: Move stackleak config to Kconfig.hardening
  kbuild: Implement Clang's stack initialization

 Makefile                    |   5 ++
 scripts/gcc-plugins/Kconfig | 121 +-------------------------
 security/Kconfig            |   2 +
 security/Kconfig.hardening  | 165 ++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 118 deletions(-)
 create mode 100644 security/Kconfig.hardening

-- 
2.17.1

