Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2980C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB3B21852
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZnW3WMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfHLSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:25:31 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:42368 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfHLSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:25:30 -0400
Received: by mail-yb1-f201.google.com with SMTP id c133so6088000ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
        b=nZnW3WMQCz05l6ICEKDk76hmQbTheMtNmdq6JZ/QeZtYLtrZAiLqFFk1eMlHLSI2Od
         tokkC6/x0TWcLVC526+YvItwTB3ptDoHYp4j+cKEDqvfWUkOE8rrgMYMDQMcytdEnpVK
         Javjy9SQgBLtDD2dU2xplDFS+oxT0Ga2sX3Ril4r8MutRMQa14VuakHxFBNsWNrIAS4h
         DIRtjGVGWR9OjKG7snnTFLDSjqbzGtpfYXGEzsQCXJHzRILzFeuxO2G2H0dY4nW8xd59
         l8IM2CEN0WEFxIOai8A1vQcyPfIG9qh+YILDCG39P1E9EDx0psdbHXaGAxoXDAVQ1+6l
         UrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
        b=W+xq+K3JYBjpP9rVtCb5pzP/0+h8yCiH0ZjRrDKA35t9f1hRi/F995DJpaw6B7V7cQ
         en3Z4aO+uH96uE68OdKlFZplYePuRS8dN5vdl8UjjOctbOOXXg30z9FaSqyWRH0xbLq0
         F7xil70bOp8roI7+B/2RcvUhfa9ExDGwl0AEY59d2KkASAEe7ZfyFPzI1SKoYl16lsq4
         qlO5C78+/5Qzg+MhS1MafrIlFNpL42AWCuecRmeK/YTggVOGPqapUR2DnETLwS28ffvo
         8rIjjujEe40rOsZ9nqQIg+FnvBAjuJVp+94rvim7h/bnhoOEQM/menLwBfLt4whcMeiO
         372A==
X-Gm-Message-State: APjAAAVeNBejz7CC4Fl5os/KAJZynHgBX2nKUg3NdT0WmTh14S/BkmmQ
        8Bh8IuwAUguLcUIoXOcT8VMTWr1rTzVF/Y8tHYzDAA==
X-Google-Smtp-Source: APXvYqxpxYTLOV5V1kn9LOQBhsmrb/fq8obCcCZvetERJ23Gxs2qvszs3YbcjsnmIpYv/bSBR6DeRIUcOWhVdcSb2iYi7g==
X-Received: by 2002:a0d:ea06:: with SMTP id t6mr22043435ywe.186.1565634328967;
 Mon, 12 Aug 2019 11:25:28 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:21 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
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
index f0bd77e8a8a2f..0cac78807137b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12965,12 +12965,14 @@ F:	Documentation/filesystems/proc.txt
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
2.23.0.rc1.153.gdeed80330f-goog

