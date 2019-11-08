Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C349FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50327214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLIcO37R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfKHFUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:22 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:39924 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKHFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:21 -0500
Received: by mail-pf1-f173.google.com with SMTP id x28so3875874pfo.6;
        Thu, 07 Nov 2019 21:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKTqUgLFNP8L+2pgyNr2mJwmi4tnNe/kzgV9Is+uXFk=;
        b=eLIcO37Rqryh80j1DWgiUO1Z8jSmPor+2XHv08XtdnCM3k7+Mcg5f/LNldagbqiqHA
         lAQrJ8fsazAYpu3uBzcNicGzxRD+X3JGypwI4L6/qnuRmZJI9LIiX5qOeFuvSnKk6Hpx
         iYNWiZaXn58tZQyPJEGwdF4bMZ2g1D8Cia0GdPkjqDqYaNOmp/fjjeUXFKLribS24uNA
         xC+XRLbJ/v9K2UUqRjdrAWVzJX5iQwWQrb1hoUOnosN5JuYSSB6Y2+wYwdgUiAie1T/6
         nC5Yl+TZI0Nn38EVyYznPckjSaE0E48i5ffXeAGX9EojZowiiBUieDcGDyGO3sdryFFx
         M8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TKTqUgLFNP8L+2pgyNr2mJwmi4tnNe/kzgV9Is+uXFk=;
        b=gnGL+2FXL6Jtt2Oxb5MZQib6ddIQXnFliqI9f7o2eSoegMFj/vueVAoZNkMyqpd/99
         jNplEWsXetb19Ivj8z9aEcyfIKZtDJetjafaNU43+CWzo8Hh5+PUlFa3imRqoVregYad
         oWKYJoex8JqdySufondot1MnBQk9fYLdicSISE0lQhipZzZxLzW0JPumo0/kvJMq5rrv
         hw3N+pCPjbIc234GH30oZ0uSJREoKkOq+/g7NDbQa3TMB6IuIUxylzpSFJ57ZYqVOEn+
         zZsDTQp41nzWwW6xOQe5Rla157hj2frKexNpIXY+C/Jrt327Dn1BER9+m4g6cLM6WuTG
         purQ==
X-Gm-Message-State: APjAAAWZiLJiCgvJc8IgnPqJrWj3CO+tcQ7mbeiiX20Glm6/zYwdaTtA
        BWizTwK4cyaaylmy0EnDeGD0PxzW1vyTHw==
X-Google-Smtp-Source: APXvYqzPNTY5lPCqO6tSNj4msuCp/WP/zKPnz+eK+7wPx5hWkEwRs4tQCrIf/zQmmVh8eefJ5bMtGQ==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr9325707pgj.388.1573190420080;
        Thu, 07 Nov 2019 21:20:20 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:19 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 04/11] trace: fsi: Print transfer size unsigned
Date:   Fri,  8 Nov 2019 15:49:38 +1030
Message-Id: <20191108051945.7109-5-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

Due to other bugs I observed a spurious -1 transfer size.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/trace/events/fsi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index 92e5e89e52ed..9832cb8e0eb0 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -26,7 +26,7 @@ TRACE_EVENT(fsi_master_read,
 		__entry->addr = addr;
 		__entry->size = size;
 	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zd]",
+	TP_printk("fsi%d:%02d:%02d %08x[%zu]",
 		__entry->master_idx,
 		__entry->link,
 		__entry->id,
@@ -56,7 +56,7 @@ TRACE_EVENT(fsi_master_write,
 		__entry->data = 0;
 		memcpy(&__entry->data, data, size);
 	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zd] <= {%*ph}",
+	TP_printk("fsi%d:%02d:%02d %08x[%zu] <= {%*ph}",
 		__entry->master_idx,
 		__entry->link,
 		__entry->id,
@@ -93,7 +93,7 @@ TRACE_EVENT(fsi_master_rw_result,
 		if (__entry->write || !__entry->ret)
 			memcpy(&__entry->data, data, size);
 	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zd] %s {%*ph} ret %d",
+	TP_printk("fsi%d:%02d:%02d %08x[%zu] %s {%*ph} ret %d",
 		__entry->master_idx,
 		__entry->link,
 		__entry->id,
-- 
2.24.0.rc1

