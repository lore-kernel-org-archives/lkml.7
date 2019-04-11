Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F3020850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEWG5Ord"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:01:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfDKSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:01:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so3804303pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LnXY2JQ+AvT2TeKIyUF3DHjJXBSRjqaNrPZu85aDqX4=;
        b=DEWG5OrdS7RnpwpCQdS8YfVJrZd6LZ/hLP5o2cAEJFMNg77rhhRSIF99CALXU0t4Nw
         b61UA/0mK5HXbDxjxt7jndpUYbmVs1gGAk/DbGgrivMNtpbgX6uuvLvpnp4m/5ro2mol
         lW4mnnZ2qu9RJ5/EAW4wqLEAhFw4CNdzaeq8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LnXY2JQ+AvT2TeKIyUF3DHjJXBSRjqaNrPZu85aDqX4=;
        b=SrKKreRwwbZ1SgHYJEEAiHFhlEH+Z0d0Nd6LaFV2M2wTEY/GIjT2n5q6g5HyRvGAjA
         aiN76dtUN24zU57oNveJxL3mDOlIdi2XuFPwxN7INQdjqKeO4lnJFQ3Y5wZoelSKJrL7
         HA1Mn8sS9/8kkwXr6zT10U2OAdI62cOJ8K+sv1oExUS5M+YEL4S/i6geAVI5tDnCCKAH
         zJA22LhUkcAHmGwGJPFf2eMnfEL64BlIJeOqlPXKInTP1xm2jECkQdHFqXS55aIZFyY4
         dfKa9N8JkOTFMLhe9vtYgLCa4CEp6F3ykLV4Lhhizl6Yo/34r//gmkKzDcuuP+AK4JVI
         U55w==
X-Gm-Message-State: APjAAAUOToaanGuhg0NVgAYwrjeIVHo48mWEinPRlYOuH6WCKd/b3ebN
        YvsoBCfv7e+CTsj33tCsSHRPMw==
X-Google-Smtp-Source: APXvYqzlUv4V4sPs10niFMNU7nfZb2ZRwYswecBl5RhG/CFnIB5027ab+KFPG1dObeIJ7ZNBKSFhmQ==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr44965807pgd.357.1555005686261;
        Thu, 11 Apr 2019 11:01:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v12sm52331660pfe.148.2019.04.11.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 11:01:25 -0700 (PDT)
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
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Refactor memory initialization hardening
Date:   Thu, 11 Apr 2019 11:01:14 -0700
Message-Id: <20190411180117.27704-1-keescook@chromium.org>
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

I intend to carry this in the gcc-plugins tree, but I'd really like
to get Acks from Masahiro (Kconfig changes, Makefile change), and
from James (adding the new Kconfig.hardening to security/Kconfig).

Thanks!

-Kees

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
 scripts/gcc-plugins/Kconfig | 125 ++-------------------------
 security/Kconfig            |   2 +
 security/Kconfig.hardening  | 163 ++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 118 deletions(-)
 create mode 100644 security/Kconfig.hardening

-- 
2.17.1

