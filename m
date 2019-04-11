Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5832146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbMbQTMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDKQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:48:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39645 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:48:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so8278496wrn.6;
        Thu, 11 Apr 2019 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FZQ8crmtlaPPXo76pVH1lA+WSJO+pVgCU+rZsfDOSpE=;
        b=UbMbQTMrGEDYnXRSnI8y+sujh4c1N8nF0UhbaJfDrykJW8GX1QrC/ZywENsHA9TEWN
         pWn3VWbkmgqnGgfOnxdvqgKjtGywdx4I6lKRtXstSIj3Vd+poGG/EqJ9acO0xDgnG/0x
         eHMCp7UZUPyqBr1YBmwcBsO4OTLh6L0tx2vQIzzqmVX2G+107cxH/eHH1o9CtGeR4G4V
         5ToLIgyrzxaM20Hf6XTyB8Xz4OCnp55qG6fR+/WHG+2v99qcpSWjmHQ6mgxIdVc8GnHi
         J4KZPENAe3knjuxnrA1tUyRfaMfwlfTGmXBIejim/k4K5+PpjU0cOebfSl1sHZWwOdka
         NDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FZQ8crmtlaPPXo76pVH1lA+WSJO+pVgCU+rZsfDOSpE=;
        b=gr0nFcYkLbj7890rGly1hXWMN9zWZsLu9R7BWzQumXMSjAweoWvsCJbohJaicH6jPn
         7O5SBNs4+gFkkRebqzuZKP/vSOT4tEz0OI3TTnGyYr++5ZNsqBAq4C15ky1uOTmVu0y7
         U1qXGm+bCLvcLyOmcCH3sNO2jh+Avy6Ms8JDGK+sE1Lt9x8QjA6YtAwe7KFf35Zix7Zl
         81WMbh3xQK8czEQaYPfiA/vBWmqQ4LZyiGxLhRpIjExti2nj61zG1HaLiR3J/X0P2094
         yc+6By8OsQkCNGB10JjnuTGAwrSSe8lHPGRmqRNt3ZQDlp4viJznooZ9cASCbtvKuYeR
         L/Nw==
X-Gm-Message-State: APjAAAXccDk8PyBVGUhqJeQtlg6QMqu9FPdntnaWWEKBnRaghwe/zpBp
        66sdIeoG/fjkB2ypFcKzGN9p6c0g
X-Google-Smtp-Source: APXvYqzIoH+OEdhlMa9nUUQvTc12rlRbJ+kNQ04F6bp/cz0a6V31f6JsKH854MgKU+eFRL3UtjY45g==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr32749660wrs.220.1555001309889;
        Thu, 11 Apr 2019 09:48:29 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm46386134wrs.17.2019.04.11.09.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:48:29 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 0/3] kvm: selftests fixes and a new smm_test
Date:   Thu, 11 Apr 2019 18:48:25 +0200
Message-Id: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the remaining issue in smm_test was in the test itself.
Here is the result...

Paolo

Paolo Bonzini (2):
  selftests: kvm/evmcs_test: complete I/O before migrating guest state
  selftests: kvm: fix for compilers that do not support -no-pie

Vitaly Kuznetsov (1):
  selftests: kvm: add a selftest for SMM

 tools/testing/selftests/kvm/Makefile               |   9 +-
 .../selftests/kvm/include/x86_64/processor.h       |  27 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c         |   5 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  20 ++-
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |   5 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c      | 157 +++++++++++++++++++++
 tools/testing/selftests/kvm/x86_64/state_test.c    |  15 +-
 7 files changed, 215 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/smm_test.c

-- 
1.8.3.1

