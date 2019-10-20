Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F7CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62842190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfJTSj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 14:39:28 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:52363 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726653AbfJTSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 14:39:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 591E218014B64;
        Sun, 20 Oct 2019 18:39:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twig35_6f59e2b8ec10c
X-Filterd-Recvd-Size: 3854
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 18:39:25 +0000 (UTC)
Message-ID: <85fdb8994408f5a04096fe4e212510733275b54f.camel@perches.com>
Subject: Re: [PATCH] Staging: gasket: apex_driver: fixed a line over 80
 characters coding style issue
From:   Joe Perches <joe@perches.com>
To:     Samuil Ivanov <samuil.ivanovbg@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <error27@gmail.com>
Date:   Sun, 20 Oct 2019 11:39:24 -0700
In-Reply-To: <20191020175001.22105-1-samuil.ivanovbg@gmail.com>
References: <20191020175001.22105-1-samuil.ivanovbg@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dOn Sun, 2019-10-20 at 20:50 +0300, Samuil Ivanov wrote:
> Fixed four lines of code that were over 80 characters long.

Some of the 80 column messages that checkpatch emits should
be ignored.  These are some of them because each of these
lines is a single very long name (48 chars!) identifier.

Perhaps checkpatch should not warn on these

> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
[]
> @@ -263,8 +263,8 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev)
>  	 *    - Enable GCB idle
>  	 */
>  	gasket_read_modify_write_64(gasket_dev, APEX_BAR_INDEX,
> -				    APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
> -				    0x0, 1, 32);
> +			APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
> +			0x0, 1, 32);

Maybe add a checkpatch test for this and allow ignoring
single identifier lines using LONG_LINE_IDENT

---

o Add a couple missing semicolons too.

 scripts/checkpatch.pl | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a85d719df1f4..cdce58be4f66 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,13 +3140,14 @@ sub process {
 #
 # There are a few types of lines that may extend beyond $max_line_length:
 #	logging functions like pr_info that end in a string
-#	lines with a single string
+#	lines with a single string or identifier
 #	#defines that are a single string
 #	lines with an RFC3986 like URL
 #
-# There are 3 different line length message types:
+# There are 4 different line length message types:
 # LONG_LINE_COMMENT	a comment starts before but extends beyond $max_line_length
 # LONG_LINE_STRING	a string starts before but extends beyond $max_line_length
+# LONG_LINE_IDENT	a single identifier starts before but extends beyond $max_line_length
 # LONG_LINE		all other lines longer than $max_line_length
 #
 # if LONG_LINE is ignored, the other 2 types are also ignored
@@ -3183,12 +3184,16 @@ sub process {
 			# a comment starts before $max_line_length
 			} elsif ($line =~ /($;[\s$;]*)$/ &&
 				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
-				$msg_type = "LONG_LINE_COMMENT"
+				$msg_type = "LONG_LINE_COMMENT";
 
 			# a quoted string starts before $max_line_length
 			} elsif ($sline =~ /\s*($String(?:\s*(?:\\|,\s*|\)\s*;\s*))?)$/ &&
 				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
-				$msg_type = "LONG_LINE_STRING"
+				$msg_type = "LONG_LINE_STRING";
+			# a single identifier starts before $max_line_length
+			} elsif ($sline =~ /^.\s*($Ident(?:\\|,\s*|\)\s*;\s*))?$/ &&
+				 length(expand_tabs(substr($line, 1, length($line) - length($1) - 1))) <= $max_line_length) {
+				$msg_type = "LONG_LINE_IDENT";
 			}
 
 			if ($msg_type ne "" &&


