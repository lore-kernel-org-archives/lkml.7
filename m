Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ADC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98F42087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566245219;
	bh=ZYmsC1+PrwJ8pe3+YBYd/tAexDYdZE1nJA8jBYFnPTk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ShZPOgS78Ly1sanuwikUdHRzAdGzILPOG+p17NSpAGHMmCLmDIwb4Eta175y20ETT
	 JONoBKG4SYrGjzWbiMLXcVs2669ZkYsHy7USVdP3H0kzgGRskNPKJz/CBeZDQo+CiU
	 ZMxMxipNXbePLUu0q9iDokpkQyzIQngKckimmG68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfHSUG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:06:59 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:40084 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:06:57 -0400
Received: by mail-wm1-f99.google.com with SMTP id v19so614946wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgIxKoIsQoXNZe/y1pySQAz1KVR8mwuWigj8Pby/9nU=;
        b=NHG6epF1IAyH2r+GsLMCE+tp5j9K2MsCAfNX5i6JYqDtOwdrJALGOF/Hkg/YcFOiQ0
         ZEyxWtGQa/qgR4ncsK9WM8FPOfW5Bqph3ez5gqAxfsnhFkklLtMw+vUB0evopaEkezm7
         DT/CSOJHLpSrNPSBZ57XDG2kN69XBZJqj6fT3xjkcFG/4EqS9bhDKEZ3ZMrMez6ysiT8
         r7uZ2WIzvcPS1gHw5vybwGikxPJoByY9iOufhXnTSASqPWWuggQR2YrkWMJyTJHGIAJG
         dSqG2aAgSNpvsvZTG16Tk2QPAjo8VYsqxFnRo1C5RHklA4PeG7sWDBU3aloFWEXrFKRw
         pk+A==
X-Gm-Message-State: APjAAAW7VhOrwVYvSkzrAhMW0prgR/u6KZPPPePGMJcm28ejUFRsJG5T
        +uv7T3TuaRh2v9vD7+Xn9QMNPmNn8hNlfslD/ZQzB1yyhadjuS1fo15hkd0AKCq9qg==
X-Google-Smtp-Source: APXvYqywrL6kptN8K+Gh1ua8PZU6yjRQ8ykndVKgTUhOsgCWLbNDn/Ia1WWslE9Xc+ZE91GohtwDiMUGGysA
X-Received: by 2002:a1c:c1c1:: with SMTP id r184mr22036371wmf.9.1566245215772;
        Mon, 19 Aug 2019 13:06:55 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id z7sm248136wrl.24.2019.08.19.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:06:55 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hznvb-0006eC-Hd; Mon, 19 Aug 2019 20:06:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 85D6F274314C; Mon, 19 Aug 2019 21:06:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] merge_config.sh: Check error codes from make
Date:   Mon, 19 Aug 2019 21:06:50 +0100
Message-Id: <20190819200650.18156-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we execute make after merging the configurations we ignore any
errors it produces causing whatever is running merge_config.sh to be
unaware of any failures.  This issue was noticed by Guillaume Tucker
while looking at problems with testing of clang only builds in KernelCI
which caused Kbuild to be unable to find a working host compiler.

This implementation was suggested by Yamada-san.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 scripts/kconfig/merge_config.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index d924c51d28b7..bec246719aea 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -13,12 +13,12 @@
 #  Copyright (c) 2009-2010 Wind River Systems, Inc.
 #  Copyright 2011 Linaro
 
+set -e
+
 clean_up() {
 	rm -f $TMP_FILE
 	rm -f $MERGE_FILE
-	exit
 }
-trap clean_up HUP INT TERM
 
 usage() {
 	echo "Usage: $0 [OPTIONS] [CONFIG [...]]"
@@ -110,6 +110,9 @@ TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
 MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
 
 echo "Using $INITFILE as base"
+
+trap clean_up EXIT
+
 cat $INITFILE > $TMP_FILE
 
 # Merge files, printing warnings on overridden values
@@ -155,7 +158,6 @@ if [ "$RUNMAKE" = "false" ]; then
 	echo "#"
 	echo "# merged configuration written to $KCONFIG_CONFIG (needs make)"
 	echo "#"
-	clean_up
 	exit
 fi
 
@@ -185,5 +187,3 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
 		echo ""
 	fi
 done
-
-clean_up
-- 
2.20.1

