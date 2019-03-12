Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39558206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412326;
	bh=A8kJloO2Vg18/Eh2h0hOWLFFyKWfJwrQ2hMPTv0b2Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qzju35d75/UFX/HcgrN479BAFeLnTTEGroesjxXyuYkwx8ToYO4lcJhUgCbHdld2O
	 dUWQopSlhZOdDSMRYAG1Wx7bi4M3ICa8Cbgt3VIpdwGQEm1PogpkXdAfTPMAeyavOe
	 3V2gkoOSts7V67lmnsjP+n+16qWhEcIhjl7ieW6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfCLRip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfCLRQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985A221741;
        Tue, 12 Mar 2019 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410987;
        bh=A8kJloO2Vg18/Eh2h0hOWLFFyKWfJwrQ2hMPTv0b2Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTJdMd6eTM6yB0pKVMvmSpoFPQaC9s/7/4+2qLjZGqvr3iyXKYzhEc0Y+jVkMTAY3
         f9U/bGmdQK+q05yOhP2JzsmMn1oRTRj73pyvFJRFJE0nxWf+qnAXM4KPTJHoEXKZgy
         xuY6KH/Y7NEH2irRF97nm5vpFET0moUgact/Pnc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/135] lib/test_kmod.c: potential double free in error handling
Date:   Tue, 12 Mar 2019 10:08:50 -0700
Message-Id: <20190312170348.823031500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit db7ddeab3ce5d64c9696e70d61f45ea9909cd196 ]

There is a copy and paste bug so we set "config->test_driver" to NULL
twice instead of setting "config->test_fs".  Smatch complains that it
leads to a double free:

  lib/test_kmod.c:840 __kmod_config_init() warn: 'config->test_fs' double freed

Link: http://lkml.kernel.org/r/20190121140011.GA14283@kadam
Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 7abb59ce6613..cf619795a182 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -632,7 +632,7 @@ static void __kmod_config_free(struct test_config *config)
 	config->test_driver = NULL;
 
 	kfree_const(config->test_fs);
-	config->test_driver = NULL;
+	config->test_fs = NULL;
 }
 
 static void kmod_config_free(struct kmod_test_device *test_dev)
-- 
2.19.1



