Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992E5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCf3XCWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfENFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:45:59 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47376 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfENFp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:45:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id 93so9917341plf.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VbH5YRFZXncUKHJ08BK/QLvXpcAkrT2bjg0doJXq4Wg=;
        b=OCf3XCWWrg+X1Zfo2KaJsFc8CYMd22l8ZwpB9CroJFTOGYu/0vFhezR4iaTz3kE/3I
         fFp/IuLXCNLvi8L+VRx6kfU3G3XY4NvmC2B9UA+fcbK52mbM47Ly7LjtfuOk6l07r1aw
         7rap3NRlqFMOpBj4U8/6gt0ZxmeHgu+VVL4G8SUAfYBjc+woQRb3nnHSwQ+9kZJCiUQt
         cTYxnNoGEKgBfOjbhfz3gOpWG7YpeM8ZnnTHcHXv+OkS1fJtg5JRoCpiq9Zu3adkDaG8
         r5CO2AuRSUkRtDKGzZGriujyukwMGH26KBv6iBCZjdqXbRKNz+iY3fC3Z80CkCmbNL9k
         fnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VbH5YRFZXncUKHJ08BK/QLvXpcAkrT2bjg0doJXq4Wg=;
        b=s0NV7TBk4aBup5xBgfhctIXZbj9Lqhv8h7kASPu/6NLS5eIsq5XYmLjqGs0KcmY5ti
         xQGW1TD3QsAtkVpNZMli+3Bz9JLMvcGbAZTezcIVSZRixqdgtG50qIM582GA3SR0BWWP
         AnwVnSMOn9DLnRekcSmlbAelSIAeppP0qaBjhpoZSc84iOX5VE/xbDphUYlz81JpYdCL
         jcb1CgIQ6M6Wrl2VXH4jH8x27A45fTZYJyD5ftZzMby9Oo3SCbibk1uiOPJ3671b/Foe
         pkpThgBVzab+xxP0/Hy7NDv6TDPE4eXJGa+HX0eIKIyRQx4VhEn7wvK02f2XN02F2WZr
         +3xw==
X-Gm-Message-State: APjAAAW6x34nodrXi8G/v1w4I+Q4x2n4/o3mk7wv4bi4stR4B6/F+aY6
        CwhmqkAo2uVKflxHAevXZDrF51yh4rB0qK/bRglLzg==
X-Google-Smtp-Source: APXvYqzjyPHISZHTubFgYiNc+UUgch1AmojyVKkhg7WJQC/48paQal1w/wN9VXCtsmHigQZU/YpJ2B4lN0a4vVc5IsORIQ==
X-Received: by 2002:a63:4852:: with SMTP id x18mr22462430pgk.14.1557812758075;
 Mon, 13 May 2019 22:45:58 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:42 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the noreturn list
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

Reported-by: kbuild test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 479196aeb4096..be431d4557fe5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -166,6 +166,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.21.0.1020.gf2820cf01a-goog

