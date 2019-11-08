Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB4AFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB2214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU9az6yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfKHFUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKHFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y24so3252887plr.12;
        Thu, 07 Nov 2019 21:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsgxuNQAHTHcIJrS856EvYwzkJI0BrRT1sF+4RZoSHY=;
        b=OU9az6yy3IUp3SiSu45yKUKtY2YuK45CZcO2G32kWBQjcf5VxlZGvBPTr5tLfyiIX7
         SX+Y/CAJ6Lohdx8lZQe4N3YilX9GLn2S+d1xDzm0hZAk1CdbQg6PavJ3rw17DojAGuzU
         JPoCoAmi61dj7AkZEAyNdca0u9PUAqaZFXgTXOI9YdCqPg8h7/PwJizXrFHqgm3TTwG6
         CLnz8oNQidGkSa83vKRcr9fDfsgEjcDAV9u1fpop4FVxcVnW3+MK1uuieMt9IEq2gzAb
         qqtL79/JudvPx+EgvVYIAzx5cHcVtft3C5d4MxtTSOhtPB2p1MFfEJp/wfqLgWBGvpQw
         Pp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IsgxuNQAHTHcIJrS856EvYwzkJI0BrRT1sF+4RZoSHY=;
        b=DIRky/NJG7gIFHJES5NdpYXqVDWvZscifidan2/vgoiGRwSWWYY7hyVi6AZVgnB6qX
         kNuh/oNLCt4I44TivDh3hUrrhkYkhP1gkHLHD5VMvUwTBURQw0bOPsw9L9qUJTmMGg/R
         h7yVFChierF2kNmNqL/rU1PNI8ir62AgqFJssvCko9okslEjtwKvGZ+VhO+3sqSjbbbc
         MI5q/sXUIQ9AWEzRB1SiKbCnr6q1YOXT1StR1kSdtBmufNZKu/D+aKpNE4CVeW22CY9A
         lRuJHobR4uDQHtR8IKLonDaWQ+KtnLqufiMY4oV/cEv+CQJaSasWKD8VteIVAXzvk3k0
         Prfw==
X-Gm-Message-State: APjAAAXXozsHJXo8xTmTWqE3DlkrExnAmCzuVaSvAzznsGe0BCFfilf+
        JT7xpF1NGGPHoOxGZ1/H59w=
X-Google-Smtp-Source: APXvYqz3mckpSnE6ff65rlP5g6npFA0fhlUqDe6bSasd/PfFFnQhvBY+LCB6I6q0nqFNDzgJApwWvQ==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr8201575pls.219.1573190430792;
        Thu, 07 Nov 2019 21:20:30 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:29 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 06/11] fsi: fsi_master_class can be static
Date:   Fri,  8 Nov 2019 15:49:40 +1030
Message-Id: <20191108051945.7109-7-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

There are no users outside of this file.

Fixes: 0604d53d4da8 ("fsi: Add fsi-master class")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e02ebcb0c9e6..8244da8a7241 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1272,7 +1272,7 @@ static struct attribute *master_attrs[] = {
 
 ATTRIBUTE_GROUPS(master);
 
-struct class fsi_master_class = {
+static struct class fsi_master_class = {
 	.name = "fsi-master",
 	.dev_groups = master_groups,
 };
-- 
2.24.0.rc1

