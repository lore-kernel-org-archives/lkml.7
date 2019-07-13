Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F5C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F3620830
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563018802;
	bh=yo0fpe53lTSVUSUfCCBqvEoLN/F30wiRkOyCxYTUHNA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GpcLdzGJIoR3oPldq79+xYfn9DDr9N3GEgZ/UJlAhi/ve/lXg4nGFlJIinLLbTVJE
	 z8oco7ukPWiXTkOlFqZFPkmw5lfKMinJ8Qp9Vm4ZLfBLrcp7kqOSUCgy3TlLcEtpgE
	 l0tto0o9ZHTYBcRHWqaKSflqkiFfw1bIs60SudNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfGMLxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfGMLxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LzOyEr1Ny2JAYClBzrrrts+SqH5tDtJ4DDhzxaujHkw=; b=R5Of6EyEW/DGcceMnnaKAERF0
        26hwrfljUB/6/sCF8YujxCSKCLG1hNM32LbBVtmWPLDAwF9Mq3S7QWX3O6Vvgk1CQnffjmsTA6YAS
        2fl2afNuglEcnahE7oGQUnFKGlJ/OtocHOpmDejiXGHEqJxHy5sG4iAqlX6leZaRqr9HwAQiGALWj
        X3YlgmgHbBwQVbd0tIpbJaIAJqIpW+1PhiQ0gcxqeNp26j+W6GVasx/X9de6rj5HRYTWmzhEeHFVW
        kPRL377/Y323KCdl6s02apct/18aaqdZ4OayhIzJ4sf+IETFgpv0+S+aEETMFrBGBnjSPA+EPLnQN
        xIH6fgm6A==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmGad-0004Y9-VR; Sat, 13 Jul 2019 11:53:19 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmGab-0001ZC-RX; Sat, 13 Jul 2019 08:53:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Sat, 13 Jul 2019 08:53:17 -0300
Message-Id: <bd1bfef9b85c995e70a4ee5cd65f054010936d6c.1563018793.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing parenthesis at the script, with causes it to
fail to detect non-Fedora releases (e. g. RHEL/CentOS).

Tested with Centos 7.6.1810.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index cbe3d2bb659d..c3e36b867be7 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -376,7 +376,7 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
-	if (! $system_release =~ /Fedora/) {
+	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
 	}
 
-- 
2.21.0

