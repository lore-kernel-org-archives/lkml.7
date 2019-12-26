Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC7C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E48F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvqUoi+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 06:24:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44296 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:24:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so18300295lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BxoupZSMRE2DTDjIRAiiuu/ngeO3LqFT1wbUZB1u1O0=;
        b=cvqUoi+l9KsF8YLPZV8hZQTNVJpOh15qUPLjIe4qqRy18MhAhmbOkfhGmxTQ0XhUnS
         HeYjFCMztgkR4bVZvZ2zoPElaDrF/Qho0ZW0bJwkSl+5BdGCZUV6D2RyZXQyseVswP+K
         2zLwfp1Jz6XA5xfeCBadD3jtmi1a2d1RbWqi9Lzh4vpTjxxCDUi0rPmt6hbO62INfENc
         vZO/bCaLdvCyo+B0+nb1+bJYrs8/yEFG/vjHIbxpu8PvdvQJDZ7a8raWpbGX4qEsfjnW
         GCXT3z12N/W1DK5I+moMeE+becm6Q0u7tPMxa7R5Q9401idpKLHJYlTXseBIDmF1Ny/z
         9DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BxoupZSMRE2DTDjIRAiiuu/ngeO3LqFT1wbUZB1u1O0=;
        b=MB+57QGOoXjg826sp1trxuEugZIsR3b7L89Zns9KyDJPf9ESuvHEw7gPvysQUqvBfa
         GeFyFvvOim659S5vgBva5oOOkhbSQ3vs/jAaoVjHTOHv8vgVZVkwLdNJ2CrEkRLuKhGQ
         zNu7TvCbMGMCa1mrRBKOdrw782qWM3I7KsN5ZAlcG6e2GT0L0G4pGVtmgbWPQd5iYlc+
         /zTt3dJOJEpVWxGk36v7HgCoY8TfrV7zuw4urv3VUZOD3ieJa3dYRNbi/gzK5yryQSNz
         ANXYj5fO1wkWsCP9sZSLgOqP/jyKPO+Q1pmShE1NtHYLhMk+rt3CeVwBhaF08UiLyLBo
         90XQ==
X-Gm-Message-State: APjAAAXieaEwyR5WOSzT45qZdaclkE/M49hVWGY6vw4Vz3MLRbK/O4y/
        y1StL5mBxw23L+6lgZLZmjE=
X-Google-Smtp-Source: APXvYqy/XHFSpSZiHPHa642fbilgs9NkD8T9Xf3MWf/eplr9+K+fNUoZU9viV1eZXP2D63vNKWiVbw==
X-Received: by 2002:ac2:599c:: with SMTP id w28mr26869616lfn.78.1577359472258;
        Thu, 26 Dec 2019 03:24:32 -0800 (PST)
Received: from kbp1-lhp-A00636.cisco.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id a19sm12128205ljb.103.2019.12.26.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 03:24:31 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     openembedded-core@lists.openembedded.org, zhe.he@windriver.com,
        ross.burton@intel.com, andrea.adami@gmail.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Make symbol link to vmlinux.64 in boot directory
Date:   Thu, 26 Dec 2019 13:24:25 +0200
Message-Id: <20191226112427.9759-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mips 64 bit platforms use vmlinux.64 image name
Make a symbol link to vmlinux.64 in arch/mips/boot/
---
 meta/classes/kernel.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta/classes/kernel.bbclass b/meta/classes/kernel.bbclass
index ebcb79a528..750988f4e5 100644
--- a/meta/classes/kernel.bbclass
+++ b/meta/classes/kernel.bbclass
@@ -613,6 +613,9 @@ do_kernel_link_images() {
 	if [ -f ../../../vmlinuz.bin ]; then
 		ln -sf ../../../vmlinuz.bin
 	fi
+	if [ -f ../../../vmlinux.64 ]; then
+		ln -sf ../../../vmlinux.64
+	fi
 }
 addtask kernel_link_images after do_compile before do_strip
 
-- 
2.17.1

