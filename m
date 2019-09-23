Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13903C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D857D2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgX9grwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439242AbfIWJDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:03:44 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45481 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439104AbfIWJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:03:41 -0400
Received: by mail-pl1-f202.google.com with SMTP id c14so8221500plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=rgX9grwiH8698p8amnuLifl7FZpq0+HsIW+0F3DXrlfkC7hvnW46Ds1dX88Fg9hSwV
         1CpJGOYUJBrjisEw5rqXpm3twNK1EZkuUgTfzB4KelLLXmr2JYYAHDOzuLGGWfHk7Z8B
         JukbRj9cEH1VNXUV2BH75LBiPrL88f2OIldCwVVv9PXYQB8Mh1H2PYQsGyEqrGW6yt3l
         o1ZPJiLdbfP0Q1oObZ7+sD006GeglE2yLpEK1RuiUofJqAUpCu4mmj4kPJgozXX3SNra
         Y4OiNS/W8YHGVSNkDaF/i1OwHqdAhgUjePXoLxq4xZ9ltcdwITJG+eaLjBbhoU7NgIoX
         mhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=ALHiWNKYZhPuzQz12xdWcoWTThkPFK/0L1G9BcNyZsijAlxXH4l3ER3nGklzJ05cHH
         rZwnYj6fPRkV4wBMxB2ClsoaqEFQMZb1KG7NrO4Ddb/1GOuPuJsSQM3QQHVd5uMNM+Fv
         xe9+rbOPuHZqXV0cwKzX3YB9nL6kTY5PAqEvfw3vSuqf1/ICZYR2jJhCJhqU/elzv1Ti
         d6Pfq+d7kOAshWPhIRReqNWthjL4zFIdVZtIayizi4quLne0IatloV1wc7rKlPzPE4py
         HBDFZzBa6CxW9XmAD5EJCOEC26jrH0cPAqQnMinLiumfmOG6rKa5nXWQlk/3uhQeeesE
         HarA==
X-Gm-Message-State: APjAAAUzQoj6RG2OY2LJ9ZpQFqRlrpXPGw8Bofwpz4nRbstseom+FUnj
        y3vNnRFo8a/rKiPfarDMB872q1elgsCk9FL144lEkQ==
X-Google-Smtp-Source: APXvYqxqbxTM5zGysUsGLrdt947Z5uprDPBuh1gcM9vTCBbii7SkiL91ZoHhXT0gUyKmK6pYMUz1UttJuY4q8vNzQE5tfw==
X-Received: by 2002:a63:221f:: with SMTP id i31mr28978881pgi.251.1569229418788;
 Mon, 23 Sep 2019 02:03:38 -0700 (PDT)
Date:   Mon, 23 Sep 2019 02:02:46 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 16/19] MAINTAINERS: add entry for KUnit the unit testing framework
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

