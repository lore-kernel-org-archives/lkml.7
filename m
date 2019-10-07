Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B7ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7FA206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfJGPeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:34:00 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:57724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727947AbfJGPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:33:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 582B5180A8452;
        Mon,  7 Oct 2019 15:33:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pigs13_3fa3fecc87e3d
X-Filterd-Recvd-Size: 2029
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 15:33:57 +0000 (UTC)
Message-ID: <5ce6f9131327fd2e12d7a0e20a55f588448de090.camel@perches.com>
Subject: [PATCH] checkpatch: Improve ignoring CamelCase SI style variants
 like mA
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jules Irenge <jbi.octave@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 07 Oct 2019 08:33:56 -0700
In-Reply-To: <20191006190726.GB237538@kroah.com>
References: <20191006184903.12089-1-jbi.octave@gmail.com>
         <20191006190726.GB237538@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore all upper-case variants before and after SI units like
mA, mV and uV so uses like RANGE_mA do not emit a CAMELCASE message.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..edd20f7fa83c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5044,8 +5044,9 @@ sub process {
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
-#Ignore SI style variants like nS, mV and dB (ie: max_uV, regulator_min_uA_show)
-			    $var !~ /^(?:[a-z_]*?)_?[a-z][A-Z](?:_[a-z_]+)?$/ &&
+#Ignore SI style variants like nS, mV and dB
+#(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
+			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
 				while ($var =~ m{($Ident)}g) {


