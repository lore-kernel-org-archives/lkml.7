Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C70C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0828521743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGk0SE+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGQB4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:56:44 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39914 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfGQB4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:39 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so18715017qkn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jufAXaUURqTtvupks8boLXlDljriz0DHAMYuxhv6lic=;
        b=SGk0SE+L0ONJ56JV62STa9/73PYbsMRLW7f3+sjS9iJ06qvWnhKAtPAg9l1uLlJK2P
         j23MvuN/hdx6eNk0Sw24qNfxCfn572jDv0EOSpRkZDWR4kEOHhl0BL3CXfcXHolgVP8Y
         I0QBEb0fa7yqs7iHaQAuKiMhKWpMSPX7ku0rjDABrRO+wUSLFRjLLBuadRCtcHjn/fVS
         d9POs/tsM8//KlPtDm+hJmS0QJviJ86TTfbAqAmhuexuVugvnGbdgFAgkMG18GzeyJBi
         nhytU3u4UnQO1Bs6YNcSJksIEIqe1P7GjbzOxMsGI9bmzOUJlJ+8zoepM3HtUlGyoVoG
         e9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jufAXaUURqTtvupks8boLXlDljriz0DHAMYuxhv6lic=;
        b=uCZ3t7VwqOBnWHc75O/7WGRsDSvYJtFyi1l2VJwtaBn8PYwySeWMs6I+wClBpcP14p
         cg2OGyDewRF5Ow6ZfHoiMyZ3Vd9bKYVoXJMC75bHozkPhA1a8czj3Ciohk588jaXZ4iI
         K9XbEoTN5ZPmuWG365nEd/kxdh1hxNnyrThFTXlUiv01KJuoF3fvQ8oDy8MztCJcy1Vy
         Eel83fFwjDcalce2wFLYuWhIJ+VaXxiSXVnxAbNWmkEeCYtdmNN6LcZaTOfS32vo6bq+
         dJAf6X5hEOUKxL9cDV5hhXWeKKVDGB27T7jmcj9R7gdvN0d6/hMvkUQPjnmS60GEJ1Xl
         NmFg==
X-Gm-Message-State: APjAAAVtxFJVYTvDfekTFcw+wdzwFHNoAkBR+5lPs2u/AX3mDtMXB+nu
        40xZuV78dob+hHL3Djsn5kf4Wg/SUglctZ0UTWmdYA==
X-Google-Smtp-Source: APXvYqzMYSoKc7xy2zJctW+VOk0X97W340OJGhZY9UWnWNDnmNnsODShc63XRgstRbuwVOYMn4U5hlDDzHSxHNwbM/EuvA==
X-Received: by 2002:a0c:983b:: with SMTP id c56mr27362503qvd.131.1563328597854;
 Tue, 16 Jul 2019 18:56:37 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:41 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
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
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012c..48d04d180a988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8599,6 +8599,17 @@ S:	Maintained
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
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.510.g264f2c817a-goog

