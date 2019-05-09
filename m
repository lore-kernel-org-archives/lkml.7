Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21365C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457D2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkefF3nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfEIVhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40980 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEIVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so891465qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eU7c8zg/cVtutU4cqCjHX3FiCdJS6FGRy03vBM72q4A=;
        b=bkefF3nXXpBOIYOf7TnpyT++cE1+oeabkb4nxdRSbrSVhiwfzyV1s1Yx1KJFR37Q94
         OvKDqxhi1+l1bbmVct8RzXkGgBt1KvR/sWJd0HhqEbEYwPDJeYJgflVqsUw1/tXgmiIb
         MAN3dhQZJ05gF6KiDGEe/xRjQfSUMKsAkqwXdjHK3DwhKqZG3rHo8O0oZPcmd/AdtTqk
         6+4m/lY8+OJDFOX9qM4sIZLIRsAXKpBjKlCITyLAFc0Uun2xn93dSeIDcnIELhzLAs3Y
         yWs73R/RDCIi8idfjMvjV825Om6wmQgnfsjaOnxnJaLw1dytUoEbfdQdStY5ZGvmeGBz
         JwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eU7c8zg/cVtutU4cqCjHX3FiCdJS6FGRy03vBM72q4A=;
        b=LIW3qCX605ymumDqfHvn7bpQtdvkXcnm+2kl9o31grzyFq3IxjyKmXjIaiTfMR5JkX
         MV8uoT4wFjz6aEGZEHuVCf8qRgzQggoY3kh9p4de9dzxRfUpbSdTwOKjee8UJbrbIeq2
         mHG+PHB1LnOcBTdOQzpKDkF6/0N0KRAbG1C/eoc+F6zEqIfuy8tSN2NZoAzTgWoy/iTc
         ezGzDS1fs/V/nVumAOLdOf9HPOHBIcGjd+PUl7QHJuUp9cTlAljtm1c6W39bylCBxMJP
         wLblCCE6ypyr+77JVHin55iNrf2RpGGnwP4It1AxkBDcud/Y3DvAHikUbh4ZxnTaYjlC
         Mp9w==
X-Gm-Message-State: APjAAAWu8bSiO29jJy07pnW+hwD2BiUvDfo45eb5VKw/yVyXzrHSTL0S
        GtuaVwF62TV1q6Eer2X4cJcNcRM=
X-Google-Smtp-Source: APXvYqzdQ3It3DCkkAEkla6lxwZZk11r3VqmwhOSLsx8TlYkgVc7xruZxqx/aaOje3MgLpOt0XukXg==
X-Received: by 2002:ac8:3862:: with SMTP id r31mr6028920qtb.26.1557437832076;
        Thu, 09 May 2019 14:37:12 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:11 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] ktest: introduce _get_grub_index
Date:   Thu,  9 May 2019 17:36:42 -0400
Message-Id: <20190509213647.6276-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Introduce _get_grub_index() to deal with Boot Loader
Specification (BLS) and cleanup.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 275ad8ac8872..43868ee07e17 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1871,6 +1871,43 @@ sub run_scp_mod {
     return run_scp($src, $dst, $cp_scp);
 }
 
+sub _get_grub_index {
+
+    my ($command, $target, $skip) = @_;
+
+    return if (defined($grub_number) && defined($last_grub_menu) &&
+	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
+	       $last_machine eq $machine);
+
+    doprint "Find $reboot_type menu ... ";
+    $grub_number = -1;
+
+    my $ssh_grub = $ssh_exec;
+    $ssh_grub =~ s,\$SSH_COMMAND,$command,g;
+
+    open(IN, "$ssh_grub |")
+	or dodie "unable to execute $command";
+
+    my $found = 0;
+
+    while (<IN>) {
+	if (/$target/) {
+	    $grub_number++;
+	    $found = 1;
+	    last;
+	} elsif (/$skip/) {
+	    $grub_number++;
+	}
+    }
+    close(IN);
+
+    dodie "Could not find '$grub_menu' through $command on $machine"
+	if (!$found);
+    doprint "$grub_number\n";
+    $last_grub_menu = $grub_menu;
+    $last_machine = $machine;
+}
+
 sub get_grub2_index {
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
-- 
2.20.1

