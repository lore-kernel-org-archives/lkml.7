Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1201DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89C0206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="nvhFwnDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfCDQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:58:01 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:51197 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfCDQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GW7/I+1ooMEHxbcRBe6rOsQfqs8GoPoLWmKDIsnnTrg=; b=nvhFwnDjGU10k+UibDzIqftVM3
        kA+ZXAed9jDKK8PwVg3agj8hJHRZlbK5QfycHXeLIhAlgu9fRN+lC0OLCvmkG3WXOsvXzaSabynRu
        QZidLM0EMKQKU6MsjyDxht0gwEte6Fcz/JhqlNJEMbFsUcbc9TGTLJDiSbs6y6nURZpEvlNJaqcRw
        XiSK9QCZX3xBTXFMSGsawHIppxINSBvsCtVbMqJOzFWSkeOjgDc62Zk9xsShWOSboj1zJNgH0+JmC
        lsq+fTOKbe20Pg6928/cO5i8bV8qHT9L8VBBudXlks0tn0iDrDbKNM5cKzt68lCchYNgU4nTKYDti
        eENFr2ww==;
Received: from [10.7.4.141] (port=59860 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h0quO-000JP0-KN; Mon, 04 Mar 2019 19:57:44 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date:   Mon,  4 Mar 2019 19:57:31 +0300
Message-Id: <20190304165732.24043-3-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 2/3] Makefile: kselftest: use KCONFIG_CONFIG
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the config file is reassigned through the KCONFIG_CONFIG
makeflag/envvar, this rule still attempts to use the wrong, possibly
nonexistent file.
Let's fix that.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d5713e7b1e50..4d8760166a47 100644
--- a/Makefile
+++ b/Makefile
@@ -1199,9 +1199,9 @@ kselftest-clean:
 
 PHONY += kselftest-merge
 kselftest-merge:
-	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
+	$(if $(wildcard $(objtree)/$(KCONFIG_CONFIG)),, $(error No $(KCONFIG_CONFIG) exists, config your kernel first!))
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m $(objtree)/.config \
+		-m $(objtree)/$(KCONFIG_CONFIG) \
 		$(srctree)/tools/testing/selftests/*/config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
-- 
2.20.1

