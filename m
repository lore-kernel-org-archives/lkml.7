Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F49BC606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B5220665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtI4pp7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGIGfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:35:41 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:54082 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfGIGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:35:38 -0400
Received: by mail-vk1-f202.google.com with SMTP id v126so7493523vkv.20
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
        b=mtI4pp7LQ+cFZTh7ol2m1CVrFBewx1Tr/aWCfVl2aenkSg1IeUTYlk6HdJcDVl9V3V
         qVnZm5/t/x2Gb6ReZi2m8DZTmZwO2iCuHQhftas4io72KmTBubu7P5AHRRuPzTtzbHUk
         vDhVlpDpGXMhYDhnt//uJxs2dzo45RkBUi1IjbK6/9WPuyRnq7YWsBQp/82+MaG5On/B
         bp2850T8S0Sa0vYFLBGRkb7fOdx7Rw8cRDFhVg0SOdCTFhey727SPz2DbRtsbn4Alddl
         22XhrfmGEwv1NUR9lNPXJPkGMxadaTLFT1pkHIKy2X+DGjvjaEp4IaeI0b46n7FB7Z0j
         kXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
        b=bOwTWDlGO95UDOL7xEnvw3bSl/y/WnAGoiC3iSwe0TuHR1ESqXnnVz2iE+GgVENNpU
         eySeZpJ3VRenjm7w6wdqn2sd6RaqsOrUbn8cpbztCjFGuwjSH7JHwY/G5My1bHlsTHQf
         KkAl0VQOP7OoYU6auHrpbuhSlOEKXACfNFBrW9CMO/QzM5OR6gXfKqhSkAAnT+hqFvC/
         aOfkn3bAkIao8shMFBbnszL+kUGho+ko73xpNSk0jJLAeiJWglxXfv/dRxpeUX7nco6B
         8H1YfuevS4XeLih+sdAC1l7ma8hJQL6+icvekncI6/P7vMUu/gfUOmN+OaduJTSa+qZL
         RACA==
X-Gm-Message-State: APjAAAUAcuCOgO3L1oPAS6KmEIzRkif/CB6GRIVpEw5QaddZ4cjMS7NS
        zcLuSi8PtfVOJOQ4dpW00y0gK6nL0H21Z//CV9n5Vg==
X-Google-Smtp-Source: APXvYqyW1g9KdJQPX3pyGwybskRq1kFabR+QXx1JMZJMEoqi+vbrQt4/L8S6b2Fnm4tYbGfikHj5lP0KQVa29yIOSMpklA==
X-Received: by 2002:a1f:6045:: with SMTP id u66mr3906864vkb.54.1562654137349;
 Mon, 08 Jul 2019 23:35:37 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:23 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
index 48d04d180a988..f8204c75114da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12721,12 +12721,14 @@ F:	Documentation/filesystems/proc.txt
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
2.22.0.410.gd8fdbe21b5-goog

