Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76021C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DB72339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfB79yRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHTXVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:21:15 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39063 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfHTXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:21:11 -0400
Received: by mail-pf1-f201.google.com with SMTP id n186so248189pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
        b=GfB79yRsARKNmez787qOELsZmZ3ww5c5KdNG+MLM0ZkalMFVMmzyjPSn7wZeKhOphO
         BJWZzy7YmkXN9/UgkFTtef1jj4+FlXlngojqX89H7vuOPC0dYVsNdB9owDKZLENOO6L5
         mxaSuOLfjrFzQEiAZ9YZ1XMnJWlLFr+j5jaqMZyZSETAJxRVYZ3vcpGhrvvLt0+24Fkg
         GZ+bfBrp0EHb5FcC7VXGQ67bGympCSJmn5xE411lPMKlT0PWqRWUEwUdiREWT5Re1UX4
         RFh+MSnWSjrJ6WwkjZADkd8PAGH3yovb64iBwHH4kCoaMcvhoh9Vu+pgfCSgkklmMJmE
         GyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
        b=knPSbe8Ok8JawlMgjkfk+3O+9zRsSAlzTldtCicBRh6A+BsMvVWbZP2LZc9Fdi1gV1
         tIWa1Um1Y8RcOlAA9C6iFjX/sYkesDZS4K03AGkwz7G4xheGQwaIpo+nRPGWdUAFlX6x
         jLh4a+cIRZ/n/SDQn2V8lR/HR/b1ZHd5X8mOAk/jJPttWBTC7u19ei+CoYhqtVaIphJB
         f0ZynH2A23crld9YgS4xbmXvrb2cTirBLKxsxxMtv8k1mm18hP56h8wDcYCsrgULrx7x
         SIRqbg5zenHsy7rI8yiG9G/1OINqFRYI5HdLdaQC9ohRfTXJz0NnQYltQmWZHAHU92HN
         nH3Q==
X-Gm-Message-State: APjAAAUltmJg5vgBCOtGpj5TmlECoZfMyo15fBXuMrF6maNxbsCKbA2T
        0QtflP8G2zGmmKEzDhfoE1wsL37lhDanmlzTM26Y2A==
X-Google-Smtp-Source: APXvYqwnRfaDdNNQbwqYi1sBE/pq+1Vm1Sa6tTF8ExzVh/t1i5vgUriUWM0c3aCP4jWc1mxnMQ3Gtejv3fCq1fQ0LkUxoA==
X-Received: by 2002:a63:460d:: with SMTP id t13mr26021274pga.205.1566343269803;
 Tue, 20 Aug 2019 16:21:09 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:20:34 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 06/18] kbuild: enable building KUnit
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
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index e10b3ee084d4d..47886dbd6c2a6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "lib/Kconfig"
 source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 23cdf1f413646..3795d0a5d0376 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,6 +1005,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.23.0.rc1.153.gdeed80330f-goog

