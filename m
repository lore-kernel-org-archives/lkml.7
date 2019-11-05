Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE1EC010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024AA206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/OkFdHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfKELbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:31:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbfKELbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:31:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so2603956pgm.6;
        Tue, 05 Nov 2019 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwF3TkZ+Irk0cDmzgRg74Kjpz+v5el3ux8qouzIihhU=;
        b=A/OkFdHHcT5a5oTGH5ijdLTaiBtFJtkbDraC7yPyg9HA/o7NydYeLC2soJ1B37fJ5R
         abS4AfxC7q7Oc92hx8OEnN/ETgojP1MQlVNiy48mCrPUQhs/BCYbFiXQy5SBFH0AarcQ
         nlapq9Tc939BUQ0+44I/awdrbPWt63giaajpTc/hfC6ch9/wVEjc+879JwKNkop0fc3E
         zXFLevYcJAWR8bpm6KFCWCCqnqThfjxfH//3v6G9doSoNSllmRIwcltFeB13aUiCXyK8
         JwAbCLu4/0a71N+tE6G5leOncs0mQWpMZHYpP4W3pUMETTQXKno08K+DCLD05M6myaTN
         HhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwF3TkZ+Irk0cDmzgRg74Kjpz+v5el3ux8qouzIihhU=;
        b=SnTWQwxdQ9AFplsrBOXGd8Oxv28ImDnlC7ppp2YvQLeDKpfgRr04rpdKIvlHOWYMGU
         DBbaEdvTdDLE4rNIsGaLE4OO+gje3LtXxtPE4KcUZkAnk//3Rhkw9QM1bUX2hjRl21FS
         rANse7tbdfV6dF2/EU4UG9HDFeQa6X7K2JZUoZzu0A0KKVnFEbCO1foFf7EMhT09bUC4
         6eaGJ9K9z11WjrxlfRGGyhxZXliyRH6x48wFPB6yg7/7wXUzpFgbDsPpygX0iUhSFb6y
         CtaYbwAXF8kibK/U4W1k+54lmJvxq33a3MoUFuP0VEvbTEXF44z/740kw4K1gIJYOzd5
         CwaQ==
X-Gm-Message-State: APjAAAW1gSWQRUS+6lv8+vgvO5IijBtX75vwQ2AIeeH9sMrCx19GfDzs
        a26dSsPo1H1sde2nyNWlhg4=
X-Google-Smtp-Source: APXvYqzPGTUDK9yCTFgCZx5tmECl8d19pAJhWETuoztbiJIx+MVBHySS4SQr6PghGlgJI31S4SBxEw==
X-Received: by 2002:a17:90a:19dc:: with SMTP id 28mr6152590pjj.32.1572953511994;
        Tue, 05 Nov 2019 03:31:51 -0800 (PST)
Received: from Gentoo.localdomain ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id 12sm14678943pfp.79.2019.11.05.03.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 03:31:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.kapshuk@gmail.com
Cc:     rdunlap@infradead.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts: ver_linux:add flex, bison and yacc to the checklist
Date:   Tue,  5 Nov 2019 17:01:00 +0530
Message-Id: <20191105113100.521-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add three ulities explicitly to the checklist,namely
flex,bison and yacc.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/ver_linux | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 810e608baa24..397497cf9430 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -32,6 +32,9 @@ BEGIN {
 	printversion("PPP", version("pppd --version"))
 	printversion("Isdn4k-utils", version("isdnctrl"))
 	printversion("Nfs-utils", version("showmount --version"))
+	printversion("Bison", version("bison --version"))
+	printversion("Flex", version("flex --version"))
+	printversion("Yacc", version("yacc --version"))

 	while (getline <"/proc/self/maps" > 0) {
 		if (/libc.*\.so$/) {
--
2.23.0

