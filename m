Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545FB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558623626;
	bh=xJMkwCyY4/2C56CJmLlJPx2roTyR5mzhQpE9uHoRZBc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SI4CPOp59LOPRUuRlNKLT5hE2O+3eDRtiXz+PJdY1ueujP6gIhfjFsE/ztPR8vycV
	 th3UpvvDrxg7+9Zh7mfHzNgWb8jXZSBw864ZWTv9CfHn57bMOUCLUljJq5173LelUX
	 XxrMCVnOWK9XwkzKE49v0zg/rPGbyxVCAb7S6FqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfEWPAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:00:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35057 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfEWPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:00:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id a132so4618320oib.2;
        Thu, 23 May 2019 08:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeElCV+Nxu7+CjCipGaoQ8bPDQ/OvLxQiVOvXHGO8wU=;
        b=akLkGPnb5jcklOwOikBbzeKdN4MhmgNNvcC31lc16knee4JUvBRHr12oVT8QBa++Tw
         LWT7OocUINANzTc/5lbDncqm5NVs5+moYTfGmrPfkyh88SWdc5IlCpGnsvRgaIVYGroU
         ZZPiKz/V6N8sPhS+7P8zCcAt8z2JU76Av4sRvhn+lFacw84/i35XNTKpTNgIN19PIHcz
         Fto8cf7v2hC40aPoXgj9kEQgNDhCi3FBanxjH0UkLLydreBCjMLDH5ngo6ScB77Xpk1V
         hUU5/HmXTnqQlg6MDN8vPUK2sUABAkb4WlIkjlMf9I4WzaPRhV8R4iWEyka7VvaLJCJy
         IYVg==
X-Gm-Message-State: APjAAAX8Eguj6YfFh07OI4aiF+CfTK2d/7KPZ3FIdAdGIy2C/kYPq0sb
        v+61XbT64FBr3RnmMx4Ne4rVE1E=
X-Google-Smtp-Source: APXvYqw+Zx4Tu7B3lsgAaVXYIU6YlWQRJGzzP06SV1533OP9OPc7wxuh08Z0YveCkf05D3ocehL3hw==
X-Received: by 2002:aca:7552:: with SMTP id q79mr3041138oic.85.1558623623408;
        Thu, 23 May 2019 08:00:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f5sm9256735oto.67.2019.05.23.08.00.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 08:00:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2] checkpatch.pl: Update DT vendor prefix check
Date:   Thu, 23 May 2019 10:00:22 -0500
Message-Id: <20190523150022.2747-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
json-schema"), vendor-prefixes.txt has been converted to a DT schema.
Update the checkpatch.pl DT check to extract vendor prefixes from the new
vendor-prefixes.yaml file.

Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: Handle vendor prefixes with '-' using Joe's reworked grep

 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bb28b178d929..342c7c781ba5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3027,7 +3027,7 @@ sub process {
 			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
 
 			my $dt_path = $root . "/Documentation/devicetree/bindings/";
-			my $vp_file = $dt_path . "vendor-prefixes.txt";
+			my $vp_file = $dt_path . "vendor-prefixes.yaml";
 
 			foreach my $compat (@compats) {
 				my $compat2 = $compat;
@@ -3042,7 +3042,7 @@ sub process {
 
 				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
 				my $vendor = $1;
-				`grep -Eq "^$vendor\\b" $vp_file`;
+				`grep -Eq "\\"\\^\Q$vendor\E,\\.\\*\\":" $vp_file`;
 				if ( $? >> 8 ) {
 					WARN("UNDOCUMENTED_DT_STRING",
 					     "DT compatible string vendor \"$vendor\" appears un-documented -- check $vp_file\n" . $herecurr);
-- 
2.20.1

