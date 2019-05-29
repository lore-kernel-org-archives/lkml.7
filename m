Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A026C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BEE24305
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171411;
	bh=QLzDFgMIQ8r1GZmn2cqT3yCBkjro2vAsn1Q1ncZrY60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YSEW7y0eOtEoulzTDrGBDTRX4DPW3HXEwWX8IOjGKd38NhTnaVqpid1mng/3SEQLY
	 W9Lxu59H3l4eH/UKj9psTFbngKtuiRrrbVIueWwFWIqXFcfEYOGK/h7RcGn5xVA9eh
	 p6KipLcL3id2FocJx4PGa9hSp053Sdl1vZe0GJTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfE2XJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xdMf4hb49NfuLIvwvlurkRXqs+h2lkzb21P6JrueUX8=; b=RmafWUK6coqVpisPg0JiTm7cP5
        yFpfgV3Zqpf3K/rk+6cVxdpxJXze/oxJhrPF8w9d81JSjdSgCb/nDJrmh0Xyq6K+JgJ9RDiGekm+l
        UPkmBQ6DNrI6EzE6hY9tV7WTPuftWggExOxib1cnc7SG0mdLXGn0k1tW2kaAGfecOQy63qiX30h6u
        iY8dMcWFm8eYsP9/yuwMrTNFoHEtxnq7wVOGbmtpnHrgqONq5zD0rWtgAVVZCsdPPvmlwVL4HcLs+
        5cWctPe08alhG9LyS4kyQtUxsWIw6PxgYteaK4BO1H975FedghjACq3Ok6Bv5UvZ2xIa++Vu1PKgA
        cEbwxJWg==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lG-GM; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007TN-IG; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/10] scripts/sphinx-pre-install: make activate hint smarter
Date:   Wed, 29 May 2019 20:09:24 -0300
Message-Id: <6126c0d83d8526afa930093c5cdeb49dedbd53d2.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that multiple Sphinx virtualenvs are installed
on a given kernel tree. Change the logic to get the latest
version of those, as this is probably what the user wants.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 8c2d1bcf2e02..11239eb29695 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use strict;
 
-# Copyright (c) 2017 Mauro Carvalho Chehab <mchehab@kernel.org>
+# Copyright (c) 2017-2019 Mauro Carvalho Chehab <mchehab@kernel.org>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
@@ -15,6 +15,7 @@ use strict;
 
 my $conf = "Documentation/conf.py";
 my $requirement_file = "Documentation/sphinx/requirements.txt";
+my $virtenv_prefix = "sphinx_";
 
 #
 # Static vars
@@ -28,7 +29,8 @@ my $need_symlink = 0;
 my $need_sphinx = 0;
 my $rec_sphinx_upgrade = 0;
 my $install = "";
-my $virtenv_dir = "sphinx_";
+my $virtenv_dir = "";
+my $min_version;
 
 #
 # Command line arguments
@@ -229,7 +231,6 @@ sub get_sphinx_fname()
 
 sub check_sphinx()
 {
-	my $min_version;
 	my $rec_version;
 	my $cur_version;
 
@@ -255,7 +256,7 @@ sub check_sphinx()
 
 	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
 
-	$virtenv_dir .= $rec_version;
+	$virtenv_dir = $virtenv_prefix . $rec_version;
 
 	my $sphinx = get_sphinx_fname();
 	return if ($sphinx eq "");
@@ -612,18 +613,23 @@ sub check_needs()
 		       which("sphinx-build-3");
 	}
 	if ($need_sphinx || $rec_sphinx_upgrade) {
-		my $activate = "$virtenv_dir/bin/activate";
-		if (-e "$ENV{'PWD'}/$activate") {
+		my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
+                my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
+
+                @activates = sort {$b cmp $a} @activates;
+
+		if (scalar @activates > 0 && $activates[0] ge $min_activate) {
 			printf "\nNeed to activate virtualenv with:\n";
-			printf "\t. $activate\n";
+			printf "\t. $activates[0]\n";
 		} else {
+			my $rec_activate = "$virtenv_dir/bin/activate";
 			my $virtualenv = findprog("virtualenv-3");
 			$virtualenv = findprog("virtualenv-3.5") if (!$virtualenv);
 			$virtualenv = findprog("virtualenv") if (!$virtualenv);
 			$virtualenv = "virtualenv" if (!$virtualenv);
 
 			printf "\t$virtualenv $virtenv_dir\n";
-			printf "\t. $activate\n";
+			printf "\t. $rec_activate\n";
 			printf "\tpip install -r $requirement_file\n";
 
 			$need++ if (!$rec_sphinx_upgrade);
-- 
2.21.0

