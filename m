Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AACC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D1B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDLOC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:02:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:02:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so546071wmi.0;
        Fri, 12 Apr 2019 07:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZibJdltO9BCDeWfLrXtFXPGNcqu9jbZhjkN50Ixx3jQ=;
        b=HlOIyJz5hReFFsS7o0BRGLxFDb8rGQG+vOdbzjYsnoqaUJXm20oC+U62fRywsoDjsx
         G82uxbSAxSUTUzJmaDue/cN4H1+QwmdevmZ4OtBh2aQVzL2NXjDBPlk8UFxoPACNG5aO
         XE9by7ah1F50Wr9ijtWivMMz4wAONH7z/ISl4M3eFh8M9XUWQ0ABtJ2mi8iw8UwOeuih
         fwqprcatU3QyxBCNErwUo1uXaIqW0tmAbQBU6ZQ1G5nV13YyHaoK7Rx2E02mkG95h5Hh
         +CpFc9GDOCk4uR7WKwI+kIZRhV4X86vJP/fHTh+tPah97ZPHz69rVyAbpwE91OYXiLNx
         eflg==
X-Gm-Message-State: APjAAAWvV4Hs6tbqw067EV4pNZ+UusHrAlXeT2T1ya6EoQy/mkP309Es
        OCaNUuCYRJBihwg0TOnxFA==
X-Google-Smtp-Source: APXvYqx1shGqq3EUHkW9PYHLCT98nkHlM5+noTIuASbSAH3bOOMiQQRHfAPa6jM2SnzXMqZJagHZRA==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr11043579wmd.16.1555077771762;
        Fri, 12 Apr 2019 07:02:51 -0700 (PDT)
Received: from box.eng.vmware.com ([146.247.46.5])
        by smtp.gmail.com with ESMTPSA id v184sm15883788wma.6.2019.04.12.07.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:02:51 -0700 (PDT)
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        slavomir.kaslev@gmail.com
Subject: [PATCH 2/2] tee.2: Note EAGAIN can occur when called on nonblocking file descriptors
Date:   Fri, 12 Apr 2019 17:02:47 +0300
Message-Id: <20190412140247.9897-3-kaslevs@vmware.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190412140247.9897-1-kaslevs@vmware.com>
References: <20190412140247.9897-1-kaslevs@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Slavomir Kaslev <kaslevs@vmware.com>
---
 man2/tee.2 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man2/tee.2 b/man2/tee.2
index 7bb0d3a31..03d043b46 100644
--- a/man2/tee.2
+++ b/man2/tee.2
@@ -100,7 +100,9 @@ is set to indicate the error.
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
 was specified in
-.IR flags ,
+.IR flags
+or one of the file descriptors had been marked as nonblocking
+.RB ( O_NONBLOCK ) ,
 and the operation would block.
 .TP
 .B EINVAL
-- 
2.19.1

