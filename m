Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC9721D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzgTCJo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437174AbfITXUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:20:37 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36365 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437150AbfITXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:20:31 -0400
Received: by mail-pf1-f201.google.com with SMTP id 194so5782042pfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=CzgTCJo8a03qtDkryi8S7GqE3WBkXpTH7h8KPPyCJ/R7yPOdQC+gbMLhhZO+qiGjtk
         54sY/XHjJn4GHW/KCNJea84VmG0gPWw0E7BExnqcKWyg3Kz/ZtYTaMSh+TwGbp9qsgIk
         s7KtsGrN1A86XI0MRInVo2n83P+LNe6ZOMKostCkOJP2PnvWM3cxmYY7Tx+N2B+zejw+
         nTowY3+Pk1lGifYnmfpFWAzDCYnjgqGhu3ohRMdCvw11WlX2ydoXxkQ4zZtinpNk32nk
         /kaVxxucPBvWZLeXCPZndsCjhhXXVaNBJ+OattQtQm5izw7LOib7R5p257wQQqk2kihb
         P5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=uUEli5e4F9qQdZcdaDYneX9h3vUgbHyQYVRFavXxD5LQ/lRBnncq9HnGuF+uawk65x
         cBW+HKBllulzh4geZJXnm1ziQx+18KgW0nI9qAmhGb+3mJBF5bPDjPomLjNM4s4AB9hS
         m77xGijqu8AlO0fBTe9viZF1fFF+SXNks1AuY0Ii2SXUu2VVK5Qyy9YP+cFp0Lf1nj7L
         goeFH/6pjyEr4BgFEL8My+FTuE8W3TqVZ/Bw6pvzqAnez28KCAwmLw6WMS+lGqQDa1E1
         yD0WPqcBRnduYGERYGjWou7fiBZClN2j89dK99cqj5MGoxvPfkFPCIhCBPv19aK2uJ/y
         Ngdg==
X-Gm-Message-State: APjAAAXv7jSFIUO0I5ef+wAqYX9Nw1nn582TsZXonqb1050gJi8mi5U7
        juE6ZXaN+Hsq25FrtlUShgLbAdnVnmg+1bHOS6MrsA==
X-Google-Smtp-Source: APXvYqys3CVY+ZJk3HZQ+2n1DealAsHrwQI2guSNKDoKj0PZfd4ijUtGVuBrwdz736i08AAJsEhXYd5CBLACuWNBY3hfvA==
X-Received: by 2002:a65:608e:: with SMTP id t14mr17679666pgu.373.1569021628859;
 Fri, 20 Sep 2019 16:20:28 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:22 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
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
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section,
and add Iurii as a maintainer.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3d0d184ae4e..6663d4accd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12983,12 +12983,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.23.0.351.gc4317032e6-goog

