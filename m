Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF6C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E1218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FOT6Xd0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCNVtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:49:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33383 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCNVs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:48:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id x9so4345049qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R07u5PMAtEqJ4n0ZpRT11CGSzmXWRh5bYhsMopnK+pw=;
        b=FOT6Xd0x/fkezE5hgpcd1utWlgralYJufRguBUibbEQEo07fzk8ZY1sZ4ZwS0efX+X
         MLfYwKLXkP0j9jVr08bvHJNhkbFwWd+Hc7WdwdwydtBVnJlZvk3O7FnLzugM2exCGtoD
         vhPZIzrBcO93Vjv4XFZgy9cxZUjBw3uGxCkyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R07u5PMAtEqJ4n0ZpRT11CGSzmXWRh5bYhsMopnK+pw=;
        b=XARsJMBLvK1kFbVtTdQ5fBbTxOjNpKN893so1iuMUPJmUkPEGKJ3GxXPpBZpOfHRYs
         FRjfBHMGLB7tPGISgPThlSEd65RUBj370nfARz2bRTsHiIac80D6pyUMftcr/wSmGFVA
         Aj0Bo8XDXn+WSq+dSnSy5rzTIbNbGdK/nc11ubxTZEp9pXilX8MoLtZg5L3Gka14oZ13
         orlXxKh8Ji6akyG5r+9wZ1SQr2aOVM3mqJ928rdDeQeJm4EVgfTPa+eGTiRzpvvv2azS
         FZsy1TWNPHsVfTWiJhX29r12L60AmHRvBy1UNnGNDzBtS7EDd+CA1iWkIhEDOpSGTR+r
         DS/w==
X-Gm-Message-State: APjAAAXflE0zIBzC6ltXzh4tlL6DjpnNFHLhgGz/JNFVgNd3ztKC/5H0
        HkTLFYOKsanlVu9/zTjKQF6P/JwH484=
X-Google-Smtp-Source: APXvYqwUR/6kJRQuB1DACGZpOWUAVhFSqYk8luZIxWo5LLt1PXgiPlMquSGzYzxYO3Z5hKRCvUEZkw==
X-Received: by 2002:a37:50d5:: with SMTP id e204mr428340qkb.26.1552600138133;
        Thu, 14 Mar 2019 14:48:58 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id o19sm96827qkl.65.2019.03.14.14.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:48:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 1/2] fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Thu, 14 Mar 2019 17:48:43 -0400
Message-Id: <20190314214844.207430-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190314214844.207430-1-joel@joelfernandes.org>
References: <20190314214844.207430-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/fcntl.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index fce4f4c2b3bd..e01e2c075b5b 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -1525,6 +1525,21 @@ Furthermore, if there are any asynchronous I/O operations
 .RB ( io_submit (2))
 pending on the file,
 all outstanding writes will be discarded.
+.TP
+.BR F_SEAL_FUTURE_WRITE
+If this seal is set, the contents of the file can be modified only from
+existing writeable mappings that were created prior to the seal being set.
+Any attempt to create a new writeable mapping on the memfd via
+.BR mmap (2)
+will fail with
+.BR EPERM.
+Also any attempts to write to the memfd via
+.BR write (2)
+will fail with
+.BR EPERM.
+This is useful in situations where existing writable mapped regions need to be
+kept intact while preventing any future writes. For example, to share a
+read-only memory buffer to other processes that only the sender can write to.
 .\"
 .SS File read/write hints
 Write lifetime hints can be used to inform the kernel about the relative
-- 
2.21.0.360.g471c308f928-goog

