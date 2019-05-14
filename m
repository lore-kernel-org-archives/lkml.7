Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69EC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C7320879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn9UIAKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:53:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39059 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:53:59 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so1054578itf.4;
        Tue, 14 May 2019 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Lwqa9ZFhQXDKAu3Uj15SLQg0QAesVShMamzLvwK2C4=;
        b=Kn9UIAKl8gG2e8vdh3xcxIU3PaRVqStcBoQwzkzgPxZp9jY5oHijGtILcybIuXI1U+
         zqVb5HCxGE0+LkVrmU2r4ZLbdiXByIa906ia3OxdLeycUbsUHo21p3Iw77lbcYEEkgTU
         aFu/nkvcdMn2UJgGqZcfpWtNjA4DR3tx4GBMO+o83zIFI/YnL0h8w2WwMP+eXYM/rW/N
         SuYtD7OAxUmmapytCT7Uyx5c21Xv8nrOY7Ym5X0MjpMbmt3AJX4WVj0cMxlQ6tSn8ODH
         GbdF/tyqhEMbaPOzdD4B+T/78Oq8wYReYZ81Li9eryb5qQSbA1+WnI/qQBMOmgqjTRVA
         FLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Lwqa9ZFhQXDKAu3Uj15SLQg0QAesVShMamzLvwK2C4=;
        b=kEVtioGqx6DrNW5nvPbKwhP2bMoExpl06FLnNxikg4lVU94K5NLs391y3Nr1T06/09
         poyj5XACPYmQ+Qgf997lEMlXLcs7bLe2KNV1TiZGM519HLwP7GThRbIzThDF6ZmW+O/Q
         FyIRATe1rSUrfAObBhIBwzqKawAwM/UhmW5rQepGti5MXSp6l6qp5ZL9XsPDCpbsTzwg
         zC1Kg/arXXQJEZbrRdyTmglKYcXNWBTtIXfFw4sRq7xv82u0GDTeHg66KORt0yibjNLk
         wnuMX9IXNkaPUPclazikhmsGJ6bmikkwoiJ/EHtHzTdKvPsZLIB7pbj5j723y3bP1MQy
         kTnA==
X-Gm-Message-State: APjAAAWIDlPXLittkJlw4iV4mzJUW+NRbO1nR3iJgw5CWuBhn+BhJ9LG
        /LmC6nvMrbmrezC+Fz6XZdc=
X-Google-Smtp-Source: APXvYqy5AbrPCIFQiBPFDcj9KQ9QX0leAsqaBR/n+QeVjcD5PnIMK/8xn3+wxC0PAJSOGkmJhIOsmA==
X-Received: by 2002:a24:2855:: with SMTP id h82mr4893228ith.82.1557867238511;
        Tue, 14 May 2019 13:53:58 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d:6f1c:3788:87f4:7fe7])
        by smtp.gmail.com with ESMTPSA id z19sm6229324iol.24.2019.05.14.13.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:53:57 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        yanmin_zhang@linux.intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH v4] tools/perf/util: null-terminate version char array upon error
Date:   Tue, 14 May 2019 16:53:26 -0400
Message-Id: <20190514205326.24287-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fgets fails due to any other error besides end-of-file, the version char array may not even be null-terminated.

Changes from v1-3:
 * close file, then return NULL instead of null-terminating version char array

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa1..6fd877220 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1234,9 +1234,10 @@ static char *get_kernel_version(const char *root_dir)
 	if (!file)
 		return NULL;

-	version[0] = '\0';
 	tmp = fgets(version, sizeof(version), file);
 	fclose(file);
+	if (!tmp)
+		return NULL;

 	name = strstr(version, prefix);
 	if (!name)
--
2.20.1

