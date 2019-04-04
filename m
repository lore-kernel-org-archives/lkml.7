Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC032177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvSnv8W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfDDWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:10:46 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:44728 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbfDDWKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:10:39 -0400
Received: by mail-vs1-f74.google.com with SMTP id z206so808314vsz.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PlzXyMbJNrRWSbkuwhbneGrr9P9EprhI9Q0eYW9lo6E=;
        b=qvSnv8W3pLMl5k16AFypS2Tw71YYL5YgncQV+TXHNjt4XTrEaof27DNSomOjljBRFY
         7CFZpaiGsTgsyuYxvZM3hPNaFcO9xcLav10IifjVrBHTCA5wqJo0PXIpKGl3cQSB9pBd
         QOvV7D7zfYcHUPMrYV9tDQkw1neM1HI/FpOjprYDYi5EiQMBUsB7qBCLb19vPOBOd/j8
         ZbmlGq5Us2LvYPsotDaQHHmPY5uHSWf9ZILWF+i+rL+2pjKFm0oGANUerE5oLGdepEc6
         WOJzlU8ZZQfhnQbhxEDhmCagtcqSN7De9N5X2U5MwY9UGtuK0n27gHqjehot0lG3/Z5Z
         gUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PlzXyMbJNrRWSbkuwhbneGrr9P9EprhI9Q0eYW9lo6E=;
        b=HbNJ7WXnYTzaCZisSzVmb0Fb2cdtzCwQuLmjuQCl0S1RkjSLUJhr93GYE0An3UTLGj
         B0BL1R0e1AsIaMDIBLe8MNfrxZs4kGfBoM2o7RNCiFLt/HsURQPkkYjWjP2w4SbIUiS5
         3akyzyw9Gb1h1j2FyhDzGRZLZS8t8gRxW1hYDEfq7bKDYnCvSLP27HsChXvV+GL7qhxn
         TwLj+6jv05mg2LoP8ZzCwuVJfRL5EoVGCrVlufHoWRdUGsmUX24RFPr5kSYN3l6c4qPq
         LWVMRAMN4kiWyayjxQ+ENK0r5uLem9C3DYQox8w1jyj9fJBHJ3CLEYHWYUi2dbXbnQ5a
         MWjg==
X-Gm-Message-State: APjAAAV13TVSk6XjXXGYiG6zNgUjOPYDKpBfZqn/XX1MNYTpk58r0zO0
        vqI5Oemqyw2hpxvh/c6wgy1RagWjQHjrGU/tw4J9JQ==
X-Google-Smtp-Source: APXvYqyepuUtLkj9JS9GllgzCIv9BhTUWjpEjqYwbaks96LMgza8AxqIXFbOpzPRXwAndnmOs0AZLAzYON/qHXrryJofEA==
X-Received: by 2002:ab0:2983:: with SMTP id u3mr1063922uap.8.1554415838575;
 Thu, 04 Apr 2019 15:10:38 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:06:50 -0700
In-Reply-To: <20190404220652.19765-1-brendanhiggins@google.com>
Message-Id: <20190404220652.19765-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v1 15/17] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f299..fc2cedbd9b43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8448,6 +8448,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0.392.gf8f6787159e-goog

