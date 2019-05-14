Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2970C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7F520578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWFXnp4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfENWTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:19:00 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38258 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfENWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:18:58 -0400
Received: by mail-qt1-f202.google.com with SMTP id o34so704627qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hhxf3AcyDp0eVXaG87rECj9td0IjCbgyx1Cs8/dNg/A=;
        b=DWFXnp4Hv3gxia+unBmllYaYsTdEPeRc/MPliVDfhoKoHkDccBfKjOBBsFdOH4qVF4
         3CGJdM9LtOAktm1DF9ynbnqVLvb//vkXXPW7t/2caqYSYtjHk5Aaij84YmZjLohuJnsj
         duqt01BxicXxTwy4Wq1D8gJEpe7I1Bv/AntHK8CMGKACQmTwcpHMwk+lus/z1YcgauPS
         xb9wQdaOPB2kaJ1qgUx6KyFG2BH9s/HJu2I8bvz46w/Jq1pIQsjadDWuScGCXS8oRyST
         Yp+i+OKpZrGRDaOWBmMoeaAy5+jX8z364mHVYMUrFBoYt9kdi027M6YMfk5pPD9tA2HQ
         MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hhxf3AcyDp0eVXaG87rECj9td0IjCbgyx1Cs8/dNg/A=;
        b=cB2eoHQhinbzgchUwD7lMPsB0GKn3Vy257LDm4DG8PbDkVE1Ju9e0SIkX2t4zwz90i
         XOjQP8qeZwW8OJGee+vSmVi/t2gTeVl8fbQRQovN900R/IFbhsBch5FShb6R33v5rNg/
         XTKp2xVXgZWMAlnBgx25mKI27XJc9uwZWFDoNHc6lUM/E8OZUdmBwlyWnvDl18UrOBVH
         N2Ter+J3mTUvKKBWssDcwt5K7860XjJNOoqJBq/jCLy8UpnT+oSDfN5GLZ5ta/oHIVOH
         vmz33xubHog/sC8C/JohaHolOsNpVBSiHCgYYR/VyJyXr2LLSC/o441b1DG9JEslmzM/
         JvUw==
X-Gm-Message-State: APjAAAUIQkZZBd4Zh/LSlbBZ80wK/uviy/ThI1m28nqboYrnRyYFUAIH
        bbtj8bAnZ50lXnDWrqyHUMc36+bKQWzpyywuvvJlQg==
X-Google-Smtp-Source: APXvYqxBQ+PfPDI2jK3tSl4/2KK9BEIB1HtAeTqt6B2C5YgBbe+P8hDv92BaaZf8SMwpuI/42oh72dMCZGz5UE2CQk++4Q==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr30361437qvf.132.1557872336955;
 Tue, 14 May 2019 15:18:56 -0700 (PDT)
Date:   Tue, 14 May 2019 15:17:01 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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

