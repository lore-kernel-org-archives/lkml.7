Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E0321907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568853479;
	bh=xf6oHvnvDMCymAipW0BOZ6z0gMDGSuBNCvQcC3Vjw+w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q58KoOaliyaT0EduL/l/CghzovSgdGWep4aHmfoIXTNeuil+CvuRxvVibG2xDoZCF
	 y1DxPszHZi1HYzPV78Iny475CxymfaoKJvGmMtmWBjBGjdahsUaYhVHJsdqGv7taR/
	 DtvIefoOrxsg64Q0OzuQ33145PPNCrbulZpSZfkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfISAh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:37:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33997 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfISAh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:37:58 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so3667177ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+DaHv1N5L7cjUaNo4BqoMLLze5nFoBAWmFi766jffE=;
        b=gpJDDMq8vcpCkqA9IvxUbIQYG4HtuSQfCAoOlQbN164zLjSkqdVPC1vNqjTRkNgAMx
         PvvWo/86eMR6HQbCyjmjNCwS7PYEevRnwu4wP0WKUZXOhfbAp1JwTsLAdweElPvrHbXC
         NO+m8DIb1CiVKyt4GXWjy+6vvLmDhlTGwKGKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+DaHv1N5L7cjUaNo4BqoMLLze5nFoBAWmFi766jffE=;
        b=Xth2KN7/sCx7A8F84NjHN/O9y5yukQBViokatbcCTDO0a+31/a/D7EQ06g1Zy5BxmS
         UauoMq7ibbtGeWqUapiStn/+f1Uq4R+CdNSCSrjlRun5nGhZILOC7zuKk3b19mo+DFiO
         0rO1tAWh5ZYp+IssFg1JplMFOuH9V/nFxWxWV1bDyFvmjGBhuJV877zIngo3cD8XhSsL
         69eqJWy8yBbyeLtcehTeoIYSV5H43ivK8woMiQ0RUK8xQiSlvIB4DQ8UVxNPrZP0lC13
         2dg+V82WEdFhMnk9hNGfuyUAJ8UfSfABgzdVOLudxa6IQzZBV4p23EE1ErOzLTEVtjkP
         7ceA==
X-Gm-Message-State: APjAAAXq7j8sOV/gf3+H9fxRrYuOdtd95jOOxxtGaKU+224MstbhBAQl
        1uqoabCk74PX32IdnHxUXbRqEw==
X-Google-Smtp-Source: APXvYqxB05y7JysJ5X+d8sEWHGfKnTMdtlVD3vr25LuHh5t8CC0azB6TP84Bo1XEzo78I0Wo76CFEQ==
X-Received: by 2002:a02:ab82:: with SMTP id t2mr8217139jan.72.1568853477817;
        Wed, 18 Sep 2019 17:37:57 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q3sm6404587ioi.68.2019.09.18.17.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:37:56 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab+samsung@kernel.org, corbet@lwn.net, rfontana@redhat.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bhelgaas@google.com, rppt@linux.ibm.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/sphinx-pre-install: add how to exit virtualenv usage message
Date:   Wed, 18 Sep 2019 18:37:54 -0600
Message-Id: <20190919003754.4311-1-skhan@linuxfoundation.org>
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
Changes since v1:
Changed the message based on Mauro's review comments.

 scripts/sphinx-pre-install | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 3b638c0e1a4f..013099cd120d 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -645,6 +645,12 @@ sub check_distros()
 # Common dependencies
 #
 
+sub deactivate_help()
+{
+	printf "\tIf you want to exit the virtualenv, you can use:\n";
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

