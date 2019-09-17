Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF321881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568760495;
	bh=35RZ9Cv1UOzb7vK/07nVlzsIyVImXIyZawe4lILEDA4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n4BREtVMhmqObxJgREU76/TlkN+AnkmqY9llHYoq7l4xSatMdzuQvVdfsX9ZZW63x
	 gBI/xmvxxKlzZrkP8k87sNI80QbewZTxqLscoWj9aKygdrNzLgv7mPsJQjSAMoru+w
	 rSYmNvJlSvkbyB6IHmCTbyWXxBRVokr2iTz82PRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfIQWsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:48:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33496 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIQWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:48:14 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so11676195ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vl9Mu2mGZECf6RHSCn8ZprGBhzvSeBHJYZHrpw6VkxM=;
        b=JQ1J+Njk4VPnJzxe2KL2pPrc0haxqF+9BtRtAW1dbV2+vgupUMQW/xUeV1i1xz7mwa
         N3JjErsy0GS1umbjlAquYkYAwweVmkEuF3pBVfzJbotxP2tgEm8fh1ssSCleQ1BhUo//
         yTOmY+WXE8yrMJZJtq46UAvsLG/K3PnEruJGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vl9Mu2mGZECf6RHSCn8ZprGBhzvSeBHJYZHrpw6VkxM=;
        b=WE3dh5bhk2br58HUzAU3NuPFk4fyrJPt1fz/dMopLFNaE2j0Nrk8Ugf/PCPJL0ivb8
         lh+wN+dHnlz+XqxIKbumzth8eyPQeEZ01hggsLC5SulCsMnoYxV0sh+li0A90yKS1M/Y
         pfCG+RAShRO8Ic41hdSMxSkDiqJ7t74Nrwntn+veciUKZX3RvnToPL9J/XI0jeUJZcUG
         dCDL9z2tvbz3saMol8NvVa4qrEX1bNAqUldLX+XuenVERtTznHmLK3+Fbz4vzwf5bKg3
         WBnZYEjW5RSmd/CJr2xnBkeE/I7/SqtgyeWDPcVyJ5VNV86fOH6Tzpbh6i1t2aI5bzfh
         O46g==
X-Gm-Message-State: APjAAAXqVibwjNV4MTXKHtY+CPKexnJlCMa2Jpsj8oITIqLWyGUyvOx/
        I/hSnz66z3dFP5NRRCHLfImNDw==
X-Google-Smtp-Source: APXvYqwMLJcUixVtz9xYtBcUvpQimv23yZUDCsB/BJcMIPGA7v6r33wjK0uyyvnjE9fX6EdlrrglCQ==
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr1553483ion.77.1568760493464;
        Tue, 17 Sep 2019 15:48:13 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y17sm3129163ioa.52.2019.09.17.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 15:48:12 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab+samsung@kernel.org, corbet@lwn.net, rppt@linux.ibm.com,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        bhelgaas@google.com, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/sphinx-pre-install: add how to exit virtualenv usage message
Date:   Tue, 17 Sep 2019 16:48:05 -0600
Message-Id: <20190917224805.2762-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usage message on how to exit the virtualenv after documentation
work is done.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 scripts/sphinx-pre-install | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 3b638c0e1a4f..932547791e3c 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -645,6 +645,12 @@ sub check_distros()
 # Common dependencies
 #
 
+sub deactivate_help()
+{
+	printf "\tWhen work is done exit the virtualenv:\n";
+	printf "\tdeactivate\n";
+}
+
 sub check_needs()
 {
 	# Check for needed programs/tools
@@ -686,6 +692,7 @@ sub check_needs()
 		if ($need_sphinx && scalar @activates > 0 && $activates[0] ge $min_activate) {
 			printf "\nNeed to activate a compatible Sphinx version on virtualenv with:\n";
 			printf "\t. $activates[0]\n";
+			deactivate_help();
 			exit (1);
 		} else {
 			my $rec_activate = "$virtenv_dir/bin/activate";
@@ -697,6 +704,7 @@ sub check_needs()
 			printf "\t$virtualenv $virtenv_dir\n";
 			printf "\t. $rec_activate\n";
 			printf "\tpip install -r $requirement_file\n";
+			deactivate_help();
 
 			$need++ if (!$rec_sphinx_upgrade);
 		}
-- 
2.20.1

