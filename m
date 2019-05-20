Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC124C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DCF2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363689;
	bh=xvZyNhvo6Jgw1uph+W5aV18O32BizwXJqW0bfvcWlkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sGIrF41XnBRYaDBk9nUpZ0F85Le8UKtDnNvhOLRFd3wefar+reBP5JntRqm2J7na6
	 d+UsnEnhpRB33qYrHp1+v9t+O9m4y+63JkObFXQHwzSZ9JK+o3LvYAFoA6O8nE5gyF
	 UFW3pgsR+4LSrXoNc2c+P/jA2xjxPnua2N/YL7t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392052AbfETOsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:48:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392039AbfETOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wCq8wzGw72uiJf8YTianNOUvn6pWVH3JtoQXOBTmG7c=; b=FTdUUi6US5io3tehvZ/qMPV9k0
        2jnrKVQ10B+Shcib5Abid93ileqN+BAlNb2aDjH7zQICH2G9tqZFA02p6opdnv1XDd+eyjbHmNWIC
        onj7Ho7EZ/jkdEjwd+nvz8b1jVZI98jVpFEH1o67iZ7wG6p8OvrMvpovDKWW8CJvo5jgOXBo1vBwj
        UUJiQZ/KMRf8Bvr/QYEbWnFedy+UmbZxqPd/XAU7YRvz1+En97lqmW0QRdiyiFm/L1IIf1FE+/KG6
        Jt1+THuk0NrwnCszZkzZfeU+74lRQeVMBuyoQJHytT7RYvC9fkM/7mnBSDBKdz00juYs1sEchIaYa
        DVEwbnwQ==;
Received: from [179.176.119.151] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSja6-0000Kz-St; Mon, 20 May 2019 14:48:02 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZp-00010i-K2; Mon, 20 May 2019 11:47:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/10] scripts/documentation-file-ref-check: exclude false-positives
Date:   Mon, 20 May 2019 11:47:31 -0300
Message-Id: <1ac15234e6799a73c78bf747a43624f6b6acae80.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
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

