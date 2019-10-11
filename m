Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E807222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FpZNBcf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfJKBYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:24:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfJKBYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so8523070wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxhZK5mLPkB4P+JsQjChjKuzP0+Y9hyNug6oCR0WhY8=;
        b=FpZNBcf8/Ob2oRfgZL/inGiYXQ9iuqISsnqTrYCp+9nXnVgdkGhGla1oqYm8OaGxu9
         Iu4+fH7/cksgoD877FqBfm9rwUJXXLBhweghYHAaVRFYYdBZ5jou/69h0VooUi8vImT4
         9kU98ZPm/NpeKq0RCaXG6sIzTUel0pHL6bWdfDD1zstkca8bobN2j2z/kUP59ajtuJqQ
         7KMJKnUxwtFwFpRkpezWfVS4zVX1hPf86RwztvZQ3UBbNmbFgsoJ8u2SrQbYfZw0oIM1
         R7ovi9IFw8kY9BKvmRy3cjTR+a4NtqrXaqwSPNfQuQ5qEidvID8yN7Xpl2w+iqZ8Lqvy
         cEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxhZK5mLPkB4P+JsQjChjKuzP0+Y9hyNug6oCR0WhY8=;
        b=JqcgGz+gc1OwJ4D3TXmHyNz34uJV+Vig5tnU5T80jO6yPErSM35PfyWFTRCmCNqJmz
         T/d49J8Dg17qE73bhJcWu8ueiRMzgpzfBrhZZyanqb3sCiw2q8BJex18MwvX7FE8pQ3R
         kbNTOJ8gFLdmgohdui2jMSJ/0pD8EJtYMK2Nd51eklcccsKVH2ma1HION0f5KYmUCXWT
         +yaKbUBVjWTCzJQ4bI8JHVZ+Lq/RdgEltMLJDCbIqpt/J5Pvq6Z1h/uImItISow1fk1h
         W1Fa98plCDPK7CWkYkruasywEn5TjxDuYtBp6He4l33C2/ebl+ReEz8ybOIdmJnCZYSX
         l3Kw==
X-Gm-Message-State: APjAAAU0YO9cyR6VwK73lN25tRqF5sHaC9N/DO+uJdFueH+Ow2XJmxDU
        +e7j0ZMgCRgWeylLWZKdofkUYF9SRHk=
X-Google-Smtp-Source: APXvYqxNiRonDLEOULKhcOK3EYPRvmis4eE1923WsOwj26J6fyXxmwQqxKLDQJ7FdmIdOPhHoSNl3g==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr1036257wmc.8.1570757052616;
        Thu, 10 Oct 2019 18:24:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:12 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv7 18/33] lib/vdso: Add unlikely() hint into vdso_read_begin()
Date:   Fri, 11 Oct 2019 02:23:26 +0100
Message-Id: <20191011012341.846266-19-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Place the branch with no concurrent write before contended case.

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):
        | before    | after
-----------------------------------
        | 150252214 | 153242367
        | 150301112 | 153324800
        | 150392773 | 153125401
        | 150373957 | 153399355
        | 150303157 | 153489417
        | 150365237 | 153494270
-----------------------------------
avg     | 150331408 | 153345935
diff %  | 2	    | 0
-----------------------------------
stdev % | 0.3	    | 0.1

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/vdso/helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 01641dbb68ef..9a2af9fca45e 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -10,7 +10,7 @@ static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
 
-	while ((seq = READ_ONCE(vd->seq)) & 1)
+	while (unlikely((seq = READ_ONCE(vd->seq)) & 1))
 		cpu_relax();
 
 	smp_rmb();
-- 
2.23.0

