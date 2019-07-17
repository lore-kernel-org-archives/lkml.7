Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ECCC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6B9217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqrR9xFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfGQB4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:56:18 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38763 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfGQB4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:16 -0400
Received: by mail-qt1-f202.google.com with SMTP id r58so19920021qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
        b=tqrR9xFTwORg1QSrmBsFleKT9JOo0mWeTxGW4Cfwc/bY+SbwKbWZtnZC5uqvLPXSy0
         fFTbFyRnOTfxluTh2q6BMZP1q+PSU3GiYh3dcvTTUMWsTDnE6XZgVauYWvDh+EbTKMPB
         KOgoPOnY6LBnwW9fDpo4DT805XeLouwSR15jHAff7jT0L9EmtILO0Z0eY1r1rCV8Q2i5
         O5GViNSp0p+IvC97BTusPHUJbhRwBbnLV8q2bc7TmAONmWtyLpSkhVrAreIyO5wcuztq
         zhOnGzS12A0sd7xlto/kMnwO3Xxh5zXw/gRGmyzq7nhT8lD3eB9n4tJ+8f/lrXrHJcfq
         mv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
        b=CLnNMIygeB2kOHsa+n/MH+cFbBfOGnFKmoTo8TgmKP4rN0vMrAGzLJ+RUaki9uwKsZ
         QbC7kcv/14xGMRL5yX4G8okQiTmPS/dHKtbj1q/sw0Da1zSAFgITjoaKpujjNz5y4DDq
         IVLIA4UrnDavle9YkXlBHubA+beDZaupB785lMxjqlETWoqcSjKEGqyfu+VanV8sK94e
         RH1keE84ZYDcvHed5BDM1J9Tlxer7Mw+XlrsxIRj7pJbSHtDtncqLdwuzQUASU/nUpUk
         w8mLnCG3qoXWMT21CAEWnyi6h9JvVcunr7nSThAVcYE+MciySRvFRo32/lCL3y2gW8S7
         8CWQ==
X-Gm-Message-State: APjAAAWvWbRmcEG9KKaYuh9Gjzux2ZXvJAva4rBh+CktHu49LrC4mzqU
        3AfkZdZFOmT35Z8h1AgW5TLWOiDdlFv9lUG78nJ+Tw==
X-Google-Smtp-Source: APXvYqy/TbQinVkJuiRr7In6NyYeP8GT0mPKVABGBjQoi+qfrDV3qI73/LYe4gjXEi7BN46B71HCJBM5Bwy+83T+EO8gPQ==
X-Received: by 2002:aed:37a1:: with SMTP id j30mr25579345qtb.367.1563328575182;
 Tue, 16 Jul 2019 18:56:15 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:33 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
index 172f991957269..98db5fe85c797 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.22.0.510.g264f2c817a-goog

