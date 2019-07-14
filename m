Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B8C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0F2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117053;
	bh=sBypuAJi6kEuyyku6OpJYtrbttxjH65kc59FF8PE9Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DreCtB2PDzaYL/yow2e87+x0IH/oZxykSZ37iTfK68qko144owmlAo/ix+PTl+Two
	 1EJMvfB7TFn8qSETCTcTYWLZSfh9tCauaJmgiZCkq63RI51ms7lz/+Hv4CLQpgqLVi
	 OfVThQYrVu79ilhb8o6z0l6nZ3efmvJHpBxdPRCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfGNPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2yqbL/GCB4qt/1ZOmXmAZs70DddLHNZ+/ZNEpgEx/U=; b=FsVGN6Oby94ZVdAmwEOW5NJHmX
        wSGT9S/Ngc7Cu26u0qYTBp1ItI9feJztRlK1e3TZV6gcx0XryoQzJXiHqWwuYyoIyIZuGDXoRrtu4
        Er6XuU1NZrP3WO+Q3PX1stuAdPN6MmeIT/lMBGSeKJ+94kaluEdm0bFhOzLTD2BlA07qWxUNNREwP
        YcU4k1w3JvdoqKeAahJCnGSdzg6yd8P4+7275BDLPzu3r5ncDnhAgDbLMiL2tPq1ohnnBKhY5TzYT
        rKz+zcJQ+Dk94CznKtQZZ8gzJjy+5K+6aoVmUUNMWcGFe5SvNqO/g9XMLdcuy/E28wEcodICO5p3a
        j+bIWJPg==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f4-ED; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007TC-1A; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] scripts/sphinx-pre-install: fix latexmk dependencies
Date:   Sun, 14 Jul 2019 12:10:09 -0300
Message-Id: <8cdc11a350ea524574ef472d082b6339410c27ea.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the package with carries latexmk is different
on two distros:

- On OpenSUSE, latexmk is packaged as "texlive-latexmk-bin"
- On Mageia, latexmk is packaged at "texlive-collection-basic"

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 33efadd6c0b6..8dc13fe95ffe 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -454,6 +454,8 @@ sub give_opensuse_hints()
 		"texlive-zapfding",
 	);
 
+	$map{"latexmk"} = "texlive-latexmk-bin";
+
 	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
 	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
@@ -479,6 +481,8 @@ sub give_mageia_hints()
 		"texlive-fontsextra",
 	);
 
+	$map{"latexmk"} = "texlive-collection-basic";
+
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
-- 
2.21.0

