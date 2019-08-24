Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A2233A0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8H53a2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfHXBfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 21:35:03 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53609 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHXBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:34:59 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so7693009pfy.20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jaLMQno2Ebqgr4Mv8vNWz/EEBwUpKviBFEGImDCb0Hs=;
        b=f8H53a2tmaRVR+1PJzJmfieaxzNc93W/5OvfTk/11u92tAINu1c6dz5memScfayl9C
         /tOrEOoGpLi/C5p9pT0zjbFqBXJ1yt4gWwTFok7LGc1a1E6deXwepr7PJ/AAN8LubPTb
         rL06b+afh8wx2tiEm5oZHM3SyD+jwulLnT2rmJryn3phHAQdr7ngX4D1v3Vnj0dX7bT+
         YiVLX9AQacwGS12YvebGUhnHjSDGGKgFIHvblEL5gh3CDBw/CFbz1nQAj38SKMd85db+
         AP8UcIz6dua15nLdCZfgfFXdwzTpJMsXZZnjUFxYXmZ6se3sUARfroFkhlHMrLpMAjkb
         098w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jaLMQno2Ebqgr4Mv8vNWz/EEBwUpKviBFEGImDCb0Hs=;
        b=EyxjkrK2+8755PZ63F40b4dbvm/1l2bCJY7PX2E9WxViHspTHUBTVOFJaAjmvTyIuv
         7QVw5pTfv9UYTmXuaeTwL9zt1rc4tJsHF6oNsbuCTuOMnIamplZEHI+Fe+kFvC9dAIFC
         uGu8n/9gIA2lzU4ikCV+9urcqFnExPjU9yUmWefBn+abd97yyRfR/yRfKgVVgrAy1IOH
         E4t9BHZquIb2zY4nsk2K7dvk/lH1wx2EICm7pcOP7rtKwYyvT7aZsDDYIDCnmyhZaauq
         wjAJKfgKJepwrO5t5U8MRwj1CfQrgTkMTnogRfKZqtlHNrKxRmcg0BdsjawsFvNmqP6E
         rsmA==
X-Gm-Message-State: APjAAAXryG+0Zy9hQ9ijPhlsOSrNaWTi6pPqyLTgy/Qr5Iy5hyQIXMji
        Wafgcok8fcoGV/Wbm9FzdgA6jLPCQX/9b9o1ZySlCw==
X-Google-Smtp-Source: APXvYqwwY0z16/Y5LFe1Kr5SFliVwpKhegFAUuIw0n+JTAXCBngAGiksy37d5bPtQpg+dxcki1Cv+Q34b9f8TsIeql59jA==
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr6412981pgr.188.1566610497783;
 Fri, 23 Aug 2019 18:34:57 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:34:15 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

kunit_try_catch_throw is a function added in the following patch in this
series; it allows KUnit, a unit testing framework for the kernel, to
bail out of a broken test. As a consequence, it is a new __noreturn
function that objtool thinks is broken (as seen above). So fix this
warning by adding kunit_try_catch_throw to objtool's noreturn list.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 176f2f084060..0c8e17f946cd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -145,6 +145,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
-- 
2.23.0.187.g17f5b7556c-goog

