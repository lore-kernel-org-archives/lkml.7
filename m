Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC24206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="KKuKBEov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfCZVWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:22:45 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:33382 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbfCZVWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:22:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A8C8941297;
        Tue, 26 Mar 2019 22:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1553635363; x=1555449764; bh=gSqUx19cRTa3ayxvz3T
        WeMmZhf0qOI4s+zH+WFepwJs=; b=KKuKBEov5f/NZXnzrqinpzjsHzl816cZnsZ
        uzjvCjGSnu0uoSaAFDsCVnVaFAIbwLoDuNizmrEfukr7+hEzkU+03GL5nOKib62T
        1mFKEP8GXeWI0aG2J7KQvD1aScaQV/5kZs4rFCqsW2d8fOB6i3/qMR/z27QAmrsN
        NWwL6KPdkotSvs4zUKx3TC1oGm6c2nB4f3SjnRztbrlD2HAkYhC/B/MWq17LVlWP
        Rft6SVPWWsdr0+mTa9K4wbAYYasPU/FbpWcyxfRLSeavZkJ2wC3bEM+bToJ3rZKi
        EVPZFDleriJPGhLG0/OS3hrlXKB6i7aeqTid1NSdeCAbCrg80AonKqX6QX9PwEuH
        hOVBYv0y6VnV6dhF+pd+5CwZEWkDdgYtbbT8z5sUPzEoPelwFJMPedDSYobIerE0
        mrrpgTZ3CI/oOfIZBX9Avo9D3UgOnOzsf6RkCFcq4kXmELne6dEJhRwLZnrxHH9e
        wewgEvxB4dlifq0b0vwQuQmo15D6N4hK4zgtU+owGPD4OqkLyk5H4Su64CPH6qjb
        T/qiawW1iIVs81gN5CMC7ufecsGG/8nMs/XLRMzJfWLhYfs1ZXYWJazBykH4UNpb
        kZXXsloholIGm5anxjjhXfqSRODaoSCQ8DJkGrMVQScZ+vAvyU5aF6e9u2enHt6w
        7NAzkIDo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id igd8Aw2GjbU7; Tue, 26 Mar 2019 22:22:43 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 0D4C74125E;
        Tue, 26 Mar 2019 22:22:43 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id D85D92702;
        Tue, 26 Mar 2019 22:22:42 +0100 (CET)
From:   Michael Stefaniuc <mstefani@mykolab.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] scripts: coccinelle: Fix description of badty.cocci
Date:   Tue, 26 Mar 2019 22:22:00 +0100
Message-Id: <20190326212200.21168-1-mstefani@mykolab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary was copy and pasted from array_size.cocci.

Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>
---
 scripts/coccinelle/misc/badty.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
index 481cf301ccfc..08470362199c 100644
--- a/scripts/coccinelle/misc/badty.cocci
+++ b/scripts/coccinelle/misc/badty.cocci
@@ -1,4 +1,4 @@
-/// Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
+/// Correct the size argument to alloc functions
 ///
 //# This makes an effort to find cases where the argument to sizeof is wrong
 //# in memory allocation functions by checking the type of the allocated memory
-- 
2.20.1

