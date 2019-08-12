Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B62070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCXT4rGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfHLS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:26:05 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36037 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfHLSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:25:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id y7so16012297pgq.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
        b=TCXT4rGGA9pYgeGSCQOuwK+doWXPxrVb0AOPXxXQYGefHSTyEI76rZLOMEBucLYXJP
         Kl/YP3d/wByIytQWP4Kex8kaDH6aXm10JGy9E26rvvCKnc3kWivdZWxW7mVjjPVG1jdc
         B5d8cMNDdAEsb8NTNOmBKDM3Grrx/HJiMeWHQ25J7USIwDfTXkGqGcQUWCu16x4oIewF
         ArXvn7g3xON93c+6BDTa3AZGqLIr2NI17irPbGs2Lcc+bpTd4KtL3QtbRH+aysicvRrL
         s0pHKa7gRu0wDTB4A6uHp4C/kpR0hLfAxfUhmFjy8/5MrJWQJLRtKBIqN2ZlHzPzkuTo
         6woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
        b=KlEaKkuVJz9xQliNnMV0w82jc29RUDOP6F7xKc+7EKiaC2XnAre7y/hXXNmiQYPxst
         y1c0arjhlbatlzkKJs4K61RsNLXPeQPu6hfTwcw8CC7aBLwUxEwbQWBOjrLaEN10CQGf
         Nh2QiEUhn0vKsh1RsnNpQSyoF4ovx1wa6SqYl5taA2y8o2kaw3a7nM6moKH3uL3Hpe6E
         Ezsk3ctgMqGH5PTaMK6a6TVFlrm67YSnCxD0XPSa0V1Ns3KwvFzIZrPb/EV4yu6Y2qpM
         875HVS5hE843tEXoFyvaAAqYfgokTcgtP+xJIWGtG9C8U/q+cRWxllMKXpg7F4mQz+zh
         uhjw==
X-Gm-Message-State: APjAAAWXglmbYW3JN5MHwVHvNyuNoMJ9WAgm3JgCDX77vkJLWo4prgiL
        YhHDfSNA2zAOAbZT7hdrFQAV8FXDFPi51ql6CXO1Xw==
X-Google-Smtp-Source: APXvYqw92Wf36wL6Vq2NvamqmhQfIJvYCMbrqX7shiORRX3/SG4CRBa9Fefpmbw4Gnie+/T7oijkOxElDm0pwXK0Yzhrzw==
X-Received: by 2002:a63:e901:: with SMTP id i1mr30762084pgh.451.1565634300656;
 Mon, 12 Aug 2019 11:25:00 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:11 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
index 176f2f0840609..0c8e17f946cda 100644
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
2.23.0.rc1.153.gdeed80330f-goog

