Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D1C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C321773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBKWk1tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfDWTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:49:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46693 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:49:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so5786232pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JqAaK9I/spSaCaSg32F1HZpvpilgyAJuQuVGnfyCAUk=;
        b=JBKWk1tRiUbt/drJcZZK+fxAj/IFkPWCj8FaR1MO9kt0dOXEQzv6257cr/0W9JMMdu
         JgYJExvus7KrzfCeodCF129yTnA+C3n/iSQbYhzEwqaSTvTwg1EzYTxsTpUy2LGhWOPs
         zjEq/6qOTqLP9VHwdInOLb80Q8vNTRH8aWKis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JqAaK9I/spSaCaSg32F1HZpvpilgyAJuQuVGnfyCAUk=;
        b=nj8nQoIKTDAAuf45rRHR1vEDrRlY4G6luJbroW2/SXwSnS2tQotrS2r40fierLnFh6
         qCCNalJ1onrIE28N5RQsfT3LmdKMjQnx8jTpccCOveFnhacSoMZFL/TiYlOVsheUxzr6
         Fh+hi4sKBXR95J+IX5aB2NYxZsreH3sfwiuYtoQefbU5OLPDQpdo52lphEEhebJ/lMZF
         oMmIvdc2rPAeWPx5b1KGy7KAlo1GErRhN6xEf2rApjaTSZYPWf6A3b+PhS5MUNOTJTiV
         wArSoGfljtOQy1CIZqHq29f2wOXRLlyMfvmW8ljJh6M3H5EibqSxd1XmS6RI6anSJgop
         owGw==
X-Gm-Message-State: APjAAAVxZq7rii74vm2Uk5VDJ4P7A46RB+cEUYliAUhJ4t+K/f4tM97a
        Qi42yqfXqv4EvO9ZShbY6GtMEw==
X-Google-Smtp-Source: APXvYqyHP29unDWinUcnH+Ag9bS8LYObT2ApmXeIFunfZPXS4hb87Bbahe9vbDP2ng987BuDqNPVDg==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr27909874pll.60.1556048970907;
        Tue, 23 Apr 2019 12:49:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 17sm30947814pfw.65.2019.04.23.12.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 12:49:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Refactor memory initialization hardening
Date:   Tue, 23 Apr 2019 12:49:22 -0700
Message-Id: <20190423194925.32151-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the stack memory initialization configs in order to
keep things together when adding Clang stack initialization, and in
preparation for future heap memory initialization configs.

I intend to carry this in the gcc-plugins tree, but I'd really like
to get Acks from Masahiro (Kconfig changes, Makefile change), and
from James (adding the new Kconfig.hardening to security/Kconfig).

Thanks!

-Kees

v3:
- clean up menu/if with a merged "depends on" (masahiro)
- add CONFIG_COMPILE_TEST defaults (masahiro)

v2:
- add plugin menu (masahiro)
- adjust patch subject prefixes (masahiro)
- drop redundent "depends" (masahiro)
- fixed early use of CC_HAS_AUTO_VAR_INIT (masahiro)
- dropped default-enabled for STACK_INIT_ALL (masahiro)


Kees Cook (3):
  security: Create "kernel hardening" config area
  security: Move stackleak config to Kconfig.hardening
  security: Implement Clang's stack initialization

 Makefile                    |   5 ++
 scripts/gcc-plugins/Kconfig | 126 ++-------------------------
 security/Kconfig            |   2 +
 security/Kconfig.hardening  | 164 ++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 120 deletions(-)
 create mode 100644 security/Kconfig.hardening

-- 
2.17.1

