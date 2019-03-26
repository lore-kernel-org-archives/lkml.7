Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB99C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D467D206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hd/qJI5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfCZSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:30:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39514 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbfCZS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:16 -0400
Received: by mail-yw1-f73.google.com with SMTP id p1so19966956ywm.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F7gwrLqBhitPmGCH3yDZVQC7NL1DApaJvsgcGKz9XZw=;
        b=hd/qJI5pj21wdEXiN1GwGQHBvVWEtmSPOfLn12fiaFf2w7nNYsYJpe9u8ow9/Re1Kb
         FvKsZkCo/b0GsFfWFuz7eAQFgkAyaD1YtMu/MyusFUzAhdYBGkZWIj1S+E8fN9DnaUae
         L8FwSMa5O7X9SlCg7DEGpzVPkBfeq+h0Wz6MqDxvDPB424xtQc9WmiNTOO+jUGewUNHD
         lpCXH7AOi+wpEp3OI9bXgjF1sBIcv8UIJnzzt+rmTvkH36pdxeTNEvndnDJ1OpSY/cAA
         rOexpy+QRByAQot5nHETdAlDEtaJ3PrSaljT6cRrg+ws0ERdZzfzb5mmKZf2MqHgiBKm
         t7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7gwrLqBhitPmGCH3yDZVQC7NL1DApaJvsgcGKz9XZw=;
        b=qZ+YzzxeOtuJYzPWdqhbmEpQUFKUA4jc//oDXiHlXZW+bUTGEwBJdY8yBCDTx3GXnF
         IQ2/n+dtsgscCQ6rU3uEHJxqCJE3ZkCu1W2QNLWYCUDPIKisbvKdPUUGpaEuubsK/cwM
         f+tpmdEplpcYWm4AiyTkxrtbOFWNbYre0aWv7T0TPl4fRU9SNzg19sVtuL3wBZpvp+yr
         gD2jXVb8c+uh2Nom9b03Ai8CgYtcoV1DTnNwVMG1MduvI9OhgHolWs5UwtY6qtv9jNbp
         QSo3yPdQ+g/VqYxL2bKQKMPPKh6/tSTgpkzjJRgwApA7vsfHHjbXWvtdUgYeItfvznGv
         z8mQ==
X-Gm-Message-State: APjAAAWmmby7P7HTcOaNEwE/BhgKG44JUdM+u/kZ6LFCk6wNHQXvnJd4
        gjYabUxnDWmj8VcSYFAVut+o5vZStKwQ5/v4AelbhQ==
X-Google-Smtp-Source: APXvYqz53lg90CRAmq2n9UPcuRM+Zbwo5prjfkTYkHVgr5i0xCngmc0ofLZBkRfHjvHhL+zyIQ3AzU157vWcCX9jyM6hWw==
X-Received: by 2002:a81:3c90:: with SMTP id j138mr27011505ywa.276.1553624895457;
 Tue, 26 Mar 2019 11:28:15 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:24 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 08/25] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..928b198cfa26 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,8 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation",
+							  LOCKDOWN_INTEGRITY);
 }
 
 /**
-- 
2.21.0.392.gf8f6787159e-goog

