Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73697C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E344206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4bnpjUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfEXWLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:11:24 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45515 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:11:23 -0400
Received: by mail-qk1-f202.google.com with SMTP id u129so7113174qkd.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4Q5cUaijVMs9uX4GEP2w+puXwcUw+16nbge+LaGw4CU=;
        b=b4bnpjUGJZco5KrCCij6qGeyYOpnQ6EUhQ8NUoKI+cX1kacu9DH7wN5foTPfmmlolq
         CKffvVApVb0p0lBfo7jJERWkASHjbxlnBYXsc1PtR0vJegw0eSmIip/MICN4iNIFrpWd
         zksqZqnN/SPT+scsY4GpsLRJA25meeFAPTNp6TEId4VVdiIjGvXnHAmb5Dt5dHJ+YK/e
         ytYy1tez9wddLVeYUnzdaTJ2pVzHydQyQO3q87n4Aesfivbqq+vjiMvGeD6vz3fkFBhl
         QF32zZPK04znjUeYyNN7AB86lKrEzo44CZ30BirMujV2Vfqa33OXCZdDhYKx7Tjd+gV5
         rGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4Q5cUaijVMs9uX4GEP2w+puXwcUw+16nbge+LaGw4CU=;
        b=lob0OBequX/kJ3LgoEMswe13Cj+Poey/a2sC1dc/EOK4mkBVD/sTk5BjCZax/KwJeK
         YjyHNujLmGbWshVxpYC+aXxg1TVXVD5WyHnOAIdT32pnJ15kQrXLEVBZHQIHlMzIZlXq
         PZthUO3dGP+TWwAtIKiyiOnZtWzJD7unagndDpDEXg1d56rIHhDhJVUyQyvULFKI27ON
         fIAxgKMnEkXgKVQ4IPyxlWKC6pUtcoPEWX6o/UrQxYt/HJ99/XhoRdW56F30gZEJJEAW
         sn7WMWERO0hYj8KYTpfG4nLx7ehF1KRCMbRNB5Z+wReh3xpla/7eNR76pnan4ms3oX9o
         6hCA==
X-Gm-Message-State: APjAAAU4p4wPhIvHi6uhaa4YLWjS88rh640yopf111XL4erk1VPwm/aR
        VQ7W78Gca9jDsMNw5kxrTQU6VRWXu+Qx1vPL79E=
X-Google-Smtp-Source: APXvYqyN2T1Tt4iVrldEc4T5BeRw3mZqz6P4z4rMJZeudYUwwKSPXn+uwAEdpeb0INu6bRw6MjERiuCswmzCYQSlZxo=
X-Received: by 2002:ac8:3747:: with SMTP id p7mr35413335qtb.125.1558735882957;
 Fri, 24 May 2019 15:11:22 -0700 (PDT)
Date:   Fri, 24 May 2019 15:11:15 -0700
Message-Id: <20190524221118.177548-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 0/3] fix function type mismatches in syscall wrappers
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix type mismatches in arm64 syscall wrapper
definitions, which trip indirect call checks with Control-Flow
Integrity.

Changes in v3:
- instead of SYSCALL_DEFINE0, just define __arm64_sys_ni_syscall
  with the correct type to avoid unnecessary error injection

Changes in v2:
- more informative commit message for the syscall_fn_t change
- added a patch for fixing sys_ni_syscall

Sami Tolvanen (3):
  arm64: fix syscall_fn_t type
  arm64: use the correct function type in SYSCALL_DEFINE0
  arm64: use the correct function type for __arm64_sys_ni_syscall

 arch/arm64/include/asm/syscall.h         |  2 +-
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
 arch/arm64/kernel/sys.c                  | 14 +++++++++-----
 arch/arm64/kernel/sys32.c                |  7 ++-----
 4 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

