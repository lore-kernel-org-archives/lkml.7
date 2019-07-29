Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C420821655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXJjen3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfG2POE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:14:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36917 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2POE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:14:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so28191950pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VhBroyGxGn/uVVtotJh4SOBVCoW5vZobk9B4v8Ue9c=;
        b=lXJjen3fN3Ee408KHLV8ItbVARbeeRH8QusB5XN/bdyL10ToU0zPjHbw3tviGvtmov
         1+nuJmhnC8aZTaJuHxY8CinSweSTbWgDIBfm9tFwkmciqu3oE358dI5cpLuX6h/Iiwwo
         eMIebB6D0dGyb7ouKfTG+OCtjuJcvsub/TGjZwFGQ8aJJlFgBPGoKfTqSuXoLmEplv2p
         RJcXZz1s2jalkDD4vp2T+ZGURehXZJBl2TIUaxjwSTCimgAiFeii7jIJfiMA9VZKoXRL
         hWJme+SF0QE7L4CYCdA0Ixw9Cq/KdG8qqanqDX0lQnhtyfFcZgmXRF6ZtAolGXao8XD5
         y9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VhBroyGxGn/uVVtotJh4SOBVCoW5vZobk9B4v8Ue9c=;
        b=CpCZjGDxMOFIvwCjI8NSCQ6SDUqF01RjGil98jlhXQbTbIeJNeqWnmvq6k46EWo3mT
         FvPpv7WbHlpC4w/z2K2DOuu84rTBnNTCVoTjK6l3r3GORJR6kg2FDQlBizoMDMRNo/c6
         jdRZu0qnLG/FLMmKm+XGcovvqNy0AputxBN5GG3en/7Sn+f8cgfhne/roCRWbiMb7kaa
         x6WfGAgmEtOI6ixoBnJ47uG/kLtWK3QlltpSRj0LmZgwDpmmc8/8C25lxlko7ONy8atG
         0olvssmk42rV5d61pi4bGFZpdZpGj/6yr0lR57a5TMIvrbBkS1pU14U5dst89o6JW4KZ
         cb+A==
X-Gm-Message-State: APjAAAWQ87Aa4iQiHgmHrfjQuJdkX0URwnI4tcEt0pXy6GARNjhp3oyw
        oadqbHdEp6YrdAUrryL/o+c=
X-Google-Smtp-Source: APXvYqzkKOqzk9ZnxlW7J1CY7+nTn7Zv8asacrJvldoL2+p/rPVCdf0r0PJ9TYacnzPoLzZJvoPeSQ==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr37633718pfo.146.1564413243726;
        Mon, 29 Jul 2019 08:14:03 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i126sm73927399pfb.32.2019.07.29.08.14.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:03 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 02/12] kdb: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:13:59 +0800
Message-Id: <20190729151359.9334-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9ecfa37c7fbf..4567fe998c30 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -830,7 +830,7 @@ static void parse_grep(const char *str)
 	cp++;
 	while (isspace(*cp))
 		cp++;
-	if (strncmp(cp, "grep ", 5)) {
+	if (!str_has_prefix(cp, "grep ")) {
 		kdb_printf("invalid 'pipe', see grephelp\n");
 		return;
 	}
-- 
2.20.1

