Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FFFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470CE216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rY7AczG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfHFX3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:29:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39533 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:29:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so86406600qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaN7rKwbfKjoIgnB/iuhSOxVfS16dMa4sqOfbzb5FXs=;
        b=rY7AczG1FCwGJsA+DlEFYA6NqwEvVQrAZ1R2msA3DPc+6J0zkUJCdfAGdmzfpvgpYx
         3K0WQn8pzzLbfVba0bwpFoyacvzCz8SIJrJL6qvatJBN92kmfjTg8hFDeiNh3cT9AwFj
         5DMhh8RQafKaePDtQqOwRZcCS52tMeCFOlPqu+s4+cS78mZLbcsq/upAwi7jLzzpDMjY
         ZVmlBV8tQanVRg3+YJd/LnbSKwtByr3UedZShGBzkfXL8W6Vcgc5ZIgFb0hRxy+TpBVW
         WbwJ8C+YRQMP/AJU7oI9137oxa9HBO8Ug1gDuPNlLNxCSfIJ3g6USFsjbNRqI6ldTlZP
         qXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaN7rKwbfKjoIgnB/iuhSOxVfS16dMa4sqOfbzb5FXs=;
        b=mcuTdGeFRg7nFl53HfA7z7cgVLmFbiUhe2a+JZXyfrHf+aD6FSyWkP5dH9c1d7XEXD
         XbL/hYBaXB9zY03hDL+DLuP3xqeZrQzzzBVlyQARBCIBvr/yN3/WH2YkwRVg3q35kbp8
         kGO+d7L/Dz1uPBc8mDwIyNn5Shi9RUwqzvI+jUKR34zRSvzgjbUWztMmnlWn8tbRt9bE
         3ryv1mxwUpz+6VuWU2z5uSBSqcXtid8mGTZk77uHRCZJdKrNehIAo9a3b6ySQEFjaI0n
         QxV05ntkHi/CrZTIDGxh9EJjLDNBu1dJqt8PLHiiwPe8rZg+aReXc9Np4wsrLYRvZCCX
         MDnA==
X-Gm-Message-State: APjAAAX5AgJ+jhoX2B5Y86f6SSN4/10O8P1PwH/564UBbJ5wUOXDqx9t
        n4VJ8YF5MwlSRPDz91ORyHUkXQ==
X-Google-Smtp-Source: APXvYqzHOhtFD51Ozqo9rIyIvLLP2B00cgCyhC/zh6NbzIA1hqylvEi7fHYtd61G6LqbU8Y0DsBhfQ==
X-Received: by 2002:ac8:25c2:: with SMTP id f2mr5575755qtf.164.1565134172515;
        Tue, 06 Aug 2019 16:29:32 -0700 (PDT)
Received: from ovpn-120-159.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r17sm40257691qtf.26.2019.08.06.16.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 16:29:31 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jgg@ziepe.ca, linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Date:   Tue,  6 Aug 2019 19:29:17 -0400
Message-Id: <20190806232917.881-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A compiler throws a warning on an arm64 system since the
commit 9849a5697d3d ("arch, mm: convert all architectures to use
5level-fixup.h"),

mm/kasan/init.c: In function 'kasan_free_p4d':
mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
[-Wunused-but-set-variable]
 p4d_t *p4d;
        ^~~

because p4d_none() in "5level-fixup.h" is compiled away while it is a
static inline function in "pgtable-nopud.h". However, if converted
p4d_none() to a static inline there, powerpc would be unhappy as it
reads those in assembler language in
"arch/powerpc/include/asm/book3s/64/pgtable.h", so it needs to skip
assembly include for the static inline C function. While at it,
converted a few similar functions to be consistent with the ones in
"pgtable-nopud.h".

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Convert them to static inline functions.

 include/asm-generic/5level-fixup.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index bb6cb347018c..f6947da70d71 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -19,9 +19,24 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
-#define p4d_bad(p4d)			0
-#define p4d_present(p4d)		1
+
+#ifndef __ASSEMBLY__
+static inline int p4d_none(p4d_t p4d)
+{
+	return 0;
+}
+
+static inline int p4d_bad(p4d_t p4d)
+{
+	return 0;
+}
+
+static inline int p4d_present(p4d_t p4d)
+{
+	return 1;
+}
+#endif
+
 #define p4d_ERROR(p4d)			do { } while (0)
 #define p4d_clear(p4d)			pgd_clear(p4d)
 #define p4d_val(p4d)			pgd_val(p4d)
-- 
2.20.1 (Apple Git-117)

