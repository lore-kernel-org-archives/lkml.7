Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1858C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC75D21D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Alfuq4xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437145AbfITXUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:20:30 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55192 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437095AbfITXUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:20:24 -0400
Received: by mail-qk1-f202.google.com with SMTP id v143so9987375qka.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=Alfuq4xKcjyE/lvI9+hnlObqPY31tSqFtCXmQsJDgKBbZcMDdLd/Xe7IG+dh2opFqi
         NkyEiOKdCjZbdWPC1fBNLUcaNtEJgBGm/C9KYrpwSGMN9kJJghCA0tF/hzhbo3QAqnOy
         G1qrxWya38IKA9aT9DrUpNHS8ofpmZs1hUked/PR+nRiVaU1VfXljtUe111C/R7on8zn
         6GrH2up+ee3CPMMeu4c4xDYF5+vRDtfCDix7aXc4nXc5AUTjcX3VMvg69w2RWR9+CCLb
         ZYb5QuoRRzIn5CjL5tKk6cztEmTrCtopo7An4Qopbv5QmyKSNuCyNb6EPWl43WB8ctZa
         XW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=ZSz7VPCDSZUWBp8MqnJzsi7FFeqqjZx9afAjRWpkuqJGKo3XlL5RfKQ9gWciFIPj+B
         t0LW9cExV3wGDhnEK9yImDrkGwh0JjEDDmh4ABmiApUWkdd3uDlNbvJCM6aNrQ0Bebtw
         lG01REerQw/a0GPzI0law3g7wgT5I+oQTAzaYH4qK3aoGivlfxQ0CGlvRcG04J22qesQ
         YCI58gtxmgMXXoBZvlkGOObVmyFwsug3mhLtqjXzq3l51/MqTF9o+v8R9mHvuX7D3U42
         Hb+mny1vRZhg2foZ4Ow7e418HyCYagHe8GdLduUsOxEJQuCLWBsUa4itg48LEFAnA3v1
         2Szw==
X-Gm-Message-State: APjAAAU+/933RPfz5LRVCSiU5WlWInfNQ9r7uOnl5mXx74mcTL/b1o7k
        apSS1+vWqgxcbTgJT+1O2vSMzqG0h3iJzvSAF0j+8g==
X-Google-Smtp-Source: APXvYqwe7HUQbxjHZ88C3/yd7hKPs7v0fuapQiwWc6yF6cIi7fKh2+NHXnkd9elywqPPfmZXvk//qq7AcofxgzfIeJsK2w==
X-Received: by 2002:ac8:7502:: with SMTP id u2mr5779140qtq.216.1569021623093;
 Fri, 20 Sep 2019 16:20:23 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:20 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 16/19] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..e3d0d184ae4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8802,6 +8802,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	lib/kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0.351.gc4317032e6-goog

