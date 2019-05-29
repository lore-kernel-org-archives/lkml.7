Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B790C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD22430F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171380;
	bh=xvZyNhvo6Jgw1uph+W5aV18O32BizwXJqW0bfvcWlkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUBpO3YHxsDY6LJdftX9VAMiNtiu5/TEjqugYWJRlmXpu4ZenWB9OzFWKgALKmkS5
	 2WtujibIl83M44n3/hwQqW7aD0mOWfd002kLrqfV//WJEflIESKAKg8rURud5KqbnB
	 rP4mgPhzEHKsA6SKcuMe+EqxaNxWzmK82Q108/xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE2XJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wCq8wzGw72uiJf8YTianNOUvn6pWVH3JtoQXOBTmG7c=; b=KZCCgVwN4/7fZXkfXyahTcPfB5
        3vhvf4VTIFFeMlZJwPJfA1oZnu5+f5FuDlqP0g0ygvsdXV94pvM5B8GtuA0wpT3P+TDBhYOAVqhcm
        QEjo0whAHRLFsap3aLw2XaqO8yecfweB28Px+qnx10+yX7H+aTXt5C1pYejj3gyf8EHNirKzwD8IA
        GYQ0cG+IAs1XUgrCatNeRDdkrmakdWI3S/+S0TOh+tlRy9N4EokGZ0s79/r6g7JS8AFpfWdlwvckb
        xrjQrozrcnGrrUZmEuJTqmfAv12NlVc6BN4nSXaAy62c+XdD18O67UAVSB47tYj3zCscfvUOs9qDG
        dUG04c0Q==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lF-GZ; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007Td-Lw; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 06/10] scripts/documentation-file-ref-check: exclude false-positives
Date:   Wed, 29 May 2019 20:09:28 -0300
Message-Id: <cfc75c5e965884d64579e99e2189a94bf3f30ce4.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least two cases where a documentation file was gone
for good, but the text still mentions it:

1) drivers/vhost/vhost.c:
   the reference for Documentation/virtual/lguest/lguest.c is just
   to give credits to the original work that vhost replaced;

2) Documentation/scsi/scsi_mid_low_api.txt:
   It gives credit and mentions the old Documentation/Configure.help
   file that used to be part of Kernel 2.4.x

As we don't want to keep the script to keep pinpoint to those
every time, let's add a logic at the script to allow it to ignore
valid false-positives like the above.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 6b622b88f4cf..05235775cc71 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -8,6 +8,14 @@ use warnings;
 use strict;
 use Getopt::Long qw(:config no_auto_abbrev);
 
+# NOTE: only add things here when the file was gone, but the text wants
+# to mention a past documentation file, for example, to give credits for
+# the original work.
+my %false_positives = (
+	"Documentation/scsi/scsi_mid_low_api.txt" => "Documentation/Configure.help",
+	"drivers/vhost/vhost.c" => "Documentation/virtual/lguest/lguest.c",
+);
+
 my $scriptname = $0;
 $scriptname =~ s,.*/([^/]+/),$1,;
 
@@ -122,6 +130,11 @@ while (<IN>) {
 			next if (grep -e, glob("$path/$ref $path/$fulref"));
 		}
 
+		# Discard known false-positives
+		if (defined($false_positives{$f})) {
+			next if ($false_positives{$f} eq $fulref);
+		}
+
 		if ($fix) {
 			if (!($ref =~ m/(scripts|Kconfig|Kbuild)/)) {
 				$broken_ref{$ref}++;
-- 
2.21.0

