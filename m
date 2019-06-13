Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48726C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5421743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMwEtqzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfFMPXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:23:05 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50851 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbfFMMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:33:40 -0400
Received: by mail-qt1-f201.google.com with SMTP id g30so17306230qtm.17
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hR/rel8D4gBiToxcZ/kWhC4zY96wRtLwSvBkxQ4V8Fg=;
        b=vMwEtqzM11ZDYbxg3IuXNuB/bsH8Fggv3MeD3vzVsIqAPesB8sArdWifMXfLgIG4NM
         LKslpGkbYufQ9y2r3lINgugJro+63B7oTJN/g5EikB1ZJGpZvZtAi7Vkud5BnJ8dEm1F
         cFX7OacjFj4EWaBYSbaZ7TpjBs2pMWAXdrP8o9CJuByMAH13OVxImx5HQenwYzhG1jfl
         fWTs2IF7Rd+9scxlHkPTN1IQXTcviFJbrJT9wpG9/PiPivDghlafXY/iCkJ+0dd69EM7
         NXp0sSqLMZ+4yfB1hzsv3yvx8EB/6hQjV2zGZ9QTO90uHzdNxIjxFp0Xh4uzEfNsMxVn
         D6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hR/rel8D4gBiToxcZ/kWhC4zY96wRtLwSvBkxQ4V8Fg=;
        b=Mkg5UdV7qoAqNnwykAXORJmlGd8XgyBifZjdDNXAVWFAsybSEUz+XOxII8s6Ftig8n
         RLZoQCglFewz09RP8+/VslT/hke1Cc6q8sjQl0rYnugShAT1fLEsXu1+o4Bkskl8B/fF
         oPjN200ZUiETaV5Suzb6IaQ6QHzwIy0Dbj04P6O8Z6s+hIs8Du0zY7S244x47ZY/usd/
         I1whHwlKWI5AM4GVmoHdVsM0yOPAznHSvC7a8sMjK36nv6oFVZElEVB/8ifKiKNizhix
         J/UDq3VR1yTTd/vf3ATqXgr5fOnbWk1x7VymkPDFq1UDpH/eElKrYmg6ffnmYdmx3xos
         6xbQ==
X-Gm-Message-State: APjAAAXaSOjBojTJGM1xD9gYjL2O70GTSKj2HWG/bVbIVzue7C1fFADQ
        QgOps9bMTsxbaiIzMz9oSICgGXZGUw==
X-Google-Smtp-Source: APXvYqwDOFO/TXAwxDgGXuhGAv16VtS2A0XMMDggMph3dbT9XaDKtbaa2+7NijtPy2Mna6BI/pjimZ5Cxw==
X-Received: by 2002:a0c:888a:: with SMTP id 10mr3409777qvn.0.1560429218725;
 Thu, 13 Jun 2019 05:33:38 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:30:25 +0200
Message-Id: <20190613123028.179447-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 0/3] Bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous version:
http://lkml.kernel.org/r/20190531150828.157832-1-elver@google.com

* This version only changes lib/test_kasan.c.
* Remaining files are identical to v3.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Use static_cpu_has in uaccess region to avoid instrumentation
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 arch/x86/kernel/signal.c                  |   2 +-
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 lib/test_kasan.c                          |  82 ++++++-
 6 files changed, 383 insertions(+), 157 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

