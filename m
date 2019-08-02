Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB6DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C8520880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752278;
	bh=FI1AbKWqa1YCKS4h18fkWOJkMmVId5M0OrgX9gzHDWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CecYRU0IUxtsMN+RI8OpiQFcjO2wj+kxcFctpwnvAQPdjukqAlaVmSfeG0ItOckuK
	 B1E0z6OruL8DtduAwGznOwvu/IrVLeC0imrleKu0wA6Vt0kDoK1xDKNSbPkueucvQt
	 2nO4vGD43MTCaTTY+TKGPb8xPtnOpjPhl3zJ9xus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394210AbfHBNYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389778AbfHBNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3521420880;
        Fri,  2 Aug 2019 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752271;
        bh=FI1AbKWqa1YCKS4h18fkWOJkMmVId5M0OrgX9gzHDWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfe2pd0/cabNnitapLOZQUXLURXl+Sc8a2rMFL9SxY3+q3S1iv9uON13z0z8X4xNu
         4rM1HKJvVugHVVbcJpYBkJc3FZDxFYtBh1UYgYUz/lpRrOPqhSWOB/7jCFJrwi9yyE
         TGj8NgPNuQXl6c8mnHjcThdojxNAPA9I0uQ8EdF4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/30] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Fri,  2 Aug 2019 09:23:57 -0400
Message-Id: <20190802132422.13963-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132422.13963-1-sashal@kernel.org>
References: <20190802132422.13963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit b308467c916aa7acc5069802ab76a9f657434701 ]

There's a missing parenthesis at the script, with causes it to
fail to detect non-Fedora releases (e. g. RHEL/CentOS).

Tested with Centos 7.6.1810.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 067459760a7b0..3524dbc313163 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -301,7 +301,7 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
-	if (! $system_release =~ /Fedora/) {
+	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
 	}
 
-- 
2.20.1

