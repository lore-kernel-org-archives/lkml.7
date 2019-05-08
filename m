Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929CC04AAE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC06E2054F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKm3LvgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfEHM1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:27:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55961 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfEHM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:27:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so3020293wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDQ8wo7LSRbmJNgIl+vTa1VKHLpvECx9WRAVOnLyGvc=;
        b=KKm3LvgXg99KnAHK4f3uKDhHPaOnGsKzCqMKo1ReZPieUQyuNeKGPhlKa6aUWIaMaK
         0aSHM5/My6SHEKQ6toi+K5pOLomMbNATGgnYH3Q3+L75yc0CK5VTqzdWbkK+JeMI/WSE
         OA7uMKBjb8Jsj8+mNdnjE6KWFJyHmF0unWzjbG8wQXDMVusmaMLuT3gO3ulFBOdrq2D2
         jTHndfXBJJNM+3vS4noEOXWTIZXUzB9E85OMqapIbIZTbua5nCBWZxql7sh7XIl9DelD
         Sh2HkizLZhUsg6QofmvGdghntUZkR9buGn0/xruUPMNA8cIS+CChCnggqkA9fYLT4P/7
         aVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDQ8wo7LSRbmJNgIl+vTa1VKHLpvECx9WRAVOnLyGvc=;
        b=kO5egYy2HpYZ4ShxjOhdoJwoOsFcKz/9BsKvpzCHalEcgJeREjkqqcM4tcMx9KciAZ
         pOWiJQp5+07hv8BJ+wEqRwHjMq32Nf06dnyuwiKnDIUblfE9DK7g+YNVMlpUPT0ZqZKS
         LIgIVdlL2lPPeFWPx9VdflEM7fKVAysdXlJODZA9Ne5dS6nz1aHvRqh1/AWhXRbmto2p
         6UsnPHx9SCFxZDlhSX/hNFxpfMNTjcSu+jcq9VqJFeuCNeLme/dD5Rb38XwCQtZoMbNj
         tiLqLw5PUuXs2cWFjbG36H65LmgRSVti2RlAVcPDasap6w3urk4D5xSZNWzB1QUYpZJV
         oVow==
X-Gm-Message-State: APjAAAUImMDKXs5FtSdFs779/lt4HKaipN3vrEiiyldniBXBQBBERXoe
        xbBIci+XLibyLYhOT0tkEEY=
X-Google-Smtp-Source: APXvYqwPrQMsCogYYXNRwetejJQujOSVrxfx9or2pNfBuZK2pXIHWdrAjns5WHe7I9g/9C4loQGjWA==
X-Received: by 2002:a1c:96ca:: with SMTP id y193mr2632799wmd.133.1557318457184;
        Wed, 08 May 2019 05:27:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id s124sm3217737wmf.42.2019.05.08.05.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:27:36 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] checkpatch: fix minor typo and mixed space+tab in indentation
Date:   Wed,  8 May 2019 14:27:20 +0200
Message-Id: <20190508122721.7513-3-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of "concatenation".
Don't use tab after space in indentation.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a247183b65c..373ad345f732 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4546,7 +4546,7 @@ sub process {
 					    ($op eq '>' &&
 					     $ca =~ /<\S+\@\S+$/))
 					{
-					    	$ok = 1;
+						$ok = 1;
 					}
 
 					# for asm volatile statements
@@ -4881,7 +4881,7 @@ sub process {
 			# conditional.
 			substr($s, 0, length($c), '');
 			$s =~ s/\n.*//g;
-			$s =~ s/$;//g; 	# Remove any comments
+			$s =~ s/$;//g;	# Remove any comments
 			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
 			    $c !~ /}\s*while\s*/)
 			{
@@ -4920,7 +4920,7 @@ sub process {
 # if and else should not have general statements after it
 		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/) {
 			my $s = $1;
-			$s =~ s/$;//g; 	# Remove any comments
+			$s =~ s/$;//g;	# Remove any comments
 			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
 				ERROR("TRAILING_STATEMENTS",
 				      "trailing statements should be on next line\n" . $herecurr);
@@ -5095,7 +5095,7 @@ sub process {
 			{
 			}
 
-			# Flatten any obvious string concatentation.
+			# Flatten any obvious string concatenation.
 			while ($dstat =~ s/($String)\s*$Ident/$1/ ||
 			       $dstat =~ s/$Ident\s*($String)/$1/)
 			{
-- 
2.21.0

