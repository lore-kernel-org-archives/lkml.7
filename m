Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85587C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D94F2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051459;
	bh=vGi+i7EHrFCtmVdfdPVO5jNnFiXOrMR/g3uBVULNhLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNmJeCEpbldPC0sZkUxN11ikZmc/2wuC0H9sZ+o1pNDC6Yny5DM86axhFhZYDbyX2
	 GJVcTr1HVpW2nyHnh5AdURJUMfj5D28jTKoCfdJnabZRGRtvqEcXq5ysYtTuu4oKBq
	 g13+fp850ZaaJZaP8RJCcvJZ3cQHiNi4L6L7EsPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfFTRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:24:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=586q93trGkcGISVFlxTu0MYtP/Zjkyx9dVxOsh9CY3I=; b=HvXDP2bzaC9H2iftsZKuOSiOO0
        dCcmrjehgibvlvWR2SQVybSQa1RkxRfNxp4LnpIMG2PApfnSFZbqxxslFU6gN/EbyEfum7Y6UZuZU
        Q1NJ7A6KUo7L8ffz+/bmAEvgQqWKqZTLf2qBNIWWM5SF7y68bft8jENFGsx7zxXMh8TJe5yMACVZE
        BgysKCDiK0oT/CE5/misbHNdIlb2mOGtQMwOCHaE1DrXpFpYywaG+fHVsi6O4DsEEvLynvApuBAyt
        YjmN5pKnXpejO7zVbkAInAZ1tvjvuMceMfg3zhPVaQPCwjonis0OYl2Acm9MGlrTt6YGByAG/Y/ok
        JF7fnqCw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rt-Dj; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000DO-R5; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 12/22] scripts/get_abi.pl: add a validate command
Date:   Thu, 20 Jun 2019 14:23:04 -0300
Message-Id: <d4c24e9ceb8f2f9bbabf663a7fa1caf365f286e2.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, we just want the parser to retrieve all symbols from
ABI, in order to check for parsing errors. So, add a new
"validate" command.

While here, update the man/help pages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c5038a0a7313..774e9b809ead 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -25,7 +25,7 @@ pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
 
 my ($cmd, $arg) = @ARGV;
 
-pod2usage(2) if ($cmd ne "search" && $cmd ne "rest");
+pod2usage(2) if ($cmd ne "search" && $cmd ne "rest" && $cmd ne "validate");
 pod2usage(2) if ($cmd eq "search" && !$arg);
 
 require Data::Dumper if ($debug);
@@ -82,7 +82,7 @@ sub parse_abi {
 			my $sep = $2;
 			my $content = $3;
 
-			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
+			if (!($new_tag =~ m/(what|where|date|kernelversion|contact|description|users)/)) {
 				if ($tag eq "description") {
 					# New "tag" is actually part of
 					# description. Don't consider it a tag
@@ -368,7 +368,7 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 #
 if ($cmd eq "rest") {
 	output_rest;
-} else {
+} elsif ($cmd eq "search") {
 	search_symbols;
 }
 
@@ -381,7 +381,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--man] [--help] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -389,7 +389,9 @@ Where <COMMAND> can be:
 
 B<search> [SEARCH_REGEX] - search for [SEARCH_REGEX] inside ABI
 
-B<rest>   - output the ABI in ReST markup language
+B<rest>                  - output the ABI in ReST markup language
+
+B<validate>              - validate the ABI contents
 
 =back
 
@@ -451,11 +453,11 @@ $ scripts/get_abi.pl rest --dir Documentation/ABI/obsolete
 
 =head1 BUGS
 
-Report bugs to Mauro Carvalho Chehab <mchehab@s-opensource.com>
+Report bugs to Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
 
 =head1 COPYRIGHT
 
-Copyright (c) 2016-2017 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
+Copyright (c) 2016-2019 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
 
 License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
 
-- 
2.21.0

