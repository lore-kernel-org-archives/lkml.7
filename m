Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF8C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34EA217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arQQpTGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfGQB4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:56:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34787 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbfGQB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:44 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so13506121pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
        b=arQQpTGJERz+HpGPXFp2jlPN5FrwHz2WQgWAk2OJzhGjTvteOU1VI4pyg3Gluszw+4
         vjWiOIXlN3LE6Wmx+vW8ya52UlgsM6wNwD7n+F3tTlm0oU8wIAFq/wdLYE/uqwXxmQlX
         XH8Q+EuWSZgjc3pc2sIgMXZRv15qqL94qa0UO9XEjvbkfa9x4jqUS6XSlv6anCR5d/Qu
         TojpzGJ8KJngr73CNti9m0kYQQzcoyj/lkheRLPJEVpXYgERpvNTv8Z1n1LTd7t4E729
         ECeSIi3rVf+NrWYm31K34bfHpNTeBSIN8kh5bzP8sJs2A90bieFh3IVp2mMrPJo+7TpA
         I/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
        b=pGAfMxJM87s3u2a5VLEb4/urOmFgZCRq0mjP1nvWfluuqJQbk9CvTdiCdqTZA5UERu
         OUCikG1F99YIO0zlvWfSc7JqDlraJS8lP2x5Wy7vE33FKLD+qg1BJ+QaiiClgO30kDdG
         u+a/bdso1BqTYOn5hRnaT670V3TYK2EAhr6RXbqqQVbxKwr6x8A5LtM06xbgpwXfjfR9
         buAeE72ypPHucKRxSkKbBu8lB+PuWomPmN17sObKSQXUgyna6NT7MmyAcketBTGqoKmB
         GIdJb7nm3i7dJKxlh2JHcgmXZ8e3TLGxgIe+k99r0yDFsmFZIKsEv9j++EojUlpcjXM/
         9NGA==
X-Gm-Message-State: APjAAAXs3YxdNwDZTZSpamLysTv0yD+Un8EBt81yHHZD4s6ItFYMhwyG
        nkT9+Le5itHR75UKVDLhUkEUVsmQG1mU72qhVmoD9w==
X-Google-Smtp-Source: APXvYqwCZQKnuVk17fjP8A6U6bIZkWGFvrucA1ktqKosKL/38OKDiYQRbphN4EY4EbgHhiCugGJd7KJEeLMjHEFzWtBqZg==
X-Received: by 2002:a65:4505:: with SMTP id n5mr34106191pgq.301.1563328603229;
 Tue, 16 Jul 2019 18:56:43 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:43 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
2.22.0.510.g264f2c817a-goog

