Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CDC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B119221902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556123145;
	bh=0fHOn3LPnEzLk+CegReVKLhkXgzbaYl+sxlJBxPqUIY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j6AorzfuGDFPHCBR01yt0k4OV56NeF1Nyuog2gPuJ/9i+8CE8ruHkA006kSE/Cvej
	 eNVsCgEHXdbUu7pbhNGC7e4qMVIrRUmutMiLsp5szPdlJpttX5VDLwZiH6WtVpNnkb
	 sPAMY5ueo4nlQmNf/+ADc6Hf3GZFbcylatb0B4NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfDXQZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:25:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfDXQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nKRPLk1JuXTP2gJdgLMa+pdnLmDfJdy9v3pxOLqRwSM=; b=DYJft/RPGPWfqUn2StdzdHOM6
        rI4b+HMvd06qApKr/I9IR2CMOkTu00LHZvfOvIq/9QiQvYKayULAISUMDvI66cL9VFy8Mep3YGYx6
        L0c2I8Xd1CfwubxoLSaayLnG9C/UkBaoaubRrcUbLHBQAUwjNWsM/FlmY7+5z5zu5vq+Gq+VOztN8
        vm0GmQilwGvCBBmQ22GoHoKJWUVe766oPwQjbwO5MT+FQGEmNMUuCBit6MYU45MMh5iQGRH+HYS5F
        8UfVwsKj4dX/1xRy2fvYRTE4+TY5UOH9LGL1z+OaigHQh+yfa6yQ3VJB2zl/7V0KP/aStbaiSd/aF
        GUq+RP8OA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKiN-0001aS-6t; Wed, 24 Apr 2019 16:25:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hJKiI-0002xA-IK; Wed, 24 Apr 2019 13:25:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] scripts/documentation-file-ref-check: detect broken :doc:`foo`
Date:   Wed, 24 Apr 2019 13:25:33 -0300
Message-Id: <a24b46d49121c4f3d90f55acc20c8efb6b0a9280.1556123129.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we keep migrating documents to ReST, we're starting to see
more of such tags.

Right now, all such tags are pointing to a documentation file,
but regressions may be introduced.

So, add a check for such kind of issues as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index f47ef26754fa..01cf36e3840c 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -30,6 +30,34 @@ print "Finding broken references. This may take a while...  " if ($fix);
 
 my %broken_ref;
 
+my $doc_fix = 0;
+
+open IN, "git grep ':doc:\`' Documentation/|"
+     or die "Failed to run git grep";
+while (<IN>) {
+	next if (!m,^([^:]+):.*\:doc\:\`([^\`]+)\`,);
+
+	my $d = $1;
+	my $doc_ref = $2;
+
+	my $f = $doc_ref;
+
+	$d =~ s,(.*/).*,$1,;
+	$f =~ s,.*\<([^\>]+)\>,$1,;
+
+	$f ="$d$f.rst";
+
+	next if (grep -e, glob("$f"));
+
+	if ($fix && !$doc_fix) {
+		print STDERR "\nWARNING: Currently, can't fix broken :doc:`` fields\n";
+	}
+	$doc_fix++;
+
+	print STDERR "$f: :doc:`$doc_ref`\n";
+}
+close IN;
+
 open IN, "git grep 'Documentation/'|"
      or die "Failed to run git grep";
 while (<IN>) {
@@ -103,6 +131,7 @@ while (<IN>) {
 		}
 	}
 }
+close IN;
 
 exit 0 if (!$fix);
 
-- 
2.20.1

