Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A47F2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567681303;
	bh=kmwjHPFU1JbSFrNJzH99A3LUKqJd2p+4I7VkSc68g0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvJHyYslf9Zb315EGF30WHRkYS0UMQt/AClRfUOjMn7Lk/m4osLKVAkol//B2RbLi
	 2NkHP9dmnR4d7YOk1kg7saAFvpYSRR3R3U9BFBHtFYhbhfwXkzu9/EH1udr4rFsARU
	 bamzlpe4GUa6E+6Cuiy3+arcIt1PuCCfUFkWY3bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfIELBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:01:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbfIELBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Es/zISrtwllZAcTDfnj7OAQJAy+Bnf95m2mw7+BsncA=; b=d5bEaDa3VutuNsrUO1pWw6Bd8q
        utxDqk1SomwhtO3mKhSkGFfXWtNfsUfasMJAn40C1oxmRQzLmDFdPfThT21htY+tDVECIsRhbyauR
        lWDWrYYbzVnhvWWvEe7KSsju/20qQ+eAqWKoirezRb/0/lfocNMKr9Uid+8uGiAfdQa5lfUmASV6w
        h5l/Yf4W+CTipGXvxael20TpzjZ8MST9bUzXMtiVdB6xuEG668WKZDt+Wq7lQX+cqfb6f3+TNRcuo
        R8OL5+dnvX6lV1M7AVApC8lbLo3peVhl0X+9IUTkC7VZ9czlhn6aJSDeQgRS7sOfdupAIFprtTpU+
        6QyPeDNA==;
Received: from 177.17.137.173.dynamic.adsl.gvt.net.br ([177.17.137.173] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pW8-0003ab-Ux; Thu, 05 Sep 2019 11:01:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.1)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i5pW6-000314-LJ; Thu, 05 Sep 2019 08:01:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH 3/3] tools: intel_pstate_tracer.py: fix SPDX header in the light of PEP-263
Date:   Thu,  5 Sep 2019 08:01:29 -0300
Message-Id: <4c6c3a5a5c3f9ccc5409511f0372008af0706e53.1567681249.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <d1331081c206afb4ba71e07d5b11a67896cbd99f.1567681249.git.mchehab+samsung@kernel.org>
References: <d1331081c206afb4ba71e07d5b11a67896cbd99f.1567681249.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated at PEP-263, the coding tag should be at the first or
second line. On those two scripts, the tag is at the wrong line.

Place it at the right place and use the same kind of line that we're
using on other python scripts that also work fine with emacs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 2d6d342b148f..1009be489f9a 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python
+# -*- coding: utf-8; mode: python -*-
 # SPDX-License-Identifier: GPL-2.0-only
-# -*- coding: utf-8 -*-
 #
 """ This utility can be used to debug and tune the performance of the
 intel_pstate driver. This utility can be used in two ways:
-- 
2.21.0

