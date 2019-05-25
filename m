Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C6C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0A020862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmrZoFU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfEYSjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:39:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37381 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfEYSjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:39:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so7239617pff.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G4GlleH9fxMhjcthE7FSBFxsK14/aioCkHxKmQ1GoWo=;
        b=SmrZoFU3JXlSTjL830JK+3fwuymzEKZWrhLramRB7UeWbZPqlDwwdJbeeolKkBsBeI
         IKce0t1ciiS4n0d2Uu/Mxt1VUwWPHU0XqtDREeZ+FgXkK+t+QLrVsO3TYDO+yORFZ+Kl
         Cs2uXxtdTcimMcMChANXItHx9rNeV6XQLEqVp48A8o+xfKbN14szjQGWzXYF+N00u728
         BjUY7ll5E8dDsl7LpA/R78tQhcLIs2m37mDetbCkhPm5s6oFC7aJH6Ouo2fg8br4ocfs
         ufjaHDrIY9EocXzeU0yyhIurOcVwR3Ojf6qMlcDc2+w4fQMTFtM8s2CkBxpOtz3Vtv+8
         ru4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4GlleH9fxMhjcthE7FSBFxsK14/aioCkHxKmQ1GoWo=;
        b=In8aQMYnnnnk1d0efe0gr62+TKZ4i1oZjSOJQAzZTHL1kci+DVEgbTx6WcNMQrCdap
         96DUqUrylPZKsvV4j67j4Lloma+1dO5lhiO0sD7+7pXGTshqG2ocPPiB8/P6l6ytnu9O
         0WkGp730cJVeNlBzKT82d5ePrY9vNZOryYUdtIh+TznxHeE8PsEmY8qLfHX+rcfXQREp
         QFtnzvT/o1cc/NIGiMbscZ3Kspg0S2dA8/oiUmHe4nR0/z6LzH+4oEvhZWVTkA01bcrh
         YiQe8MLstOAhHGhSddQ0PJXrr7f72G9u/T84S1jqZQWvjO0HppiCmDU3kb/7qYmzfFur
         3ZDA==
X-Gm-Message-State: APjAAAV2ITOq9RcC7kPqczFAlxx2hK9tTF0d0REgUf1nkw1DOSoct+au
        MnqJu+OkHMkWT25dqrh4JBA=
X-Google-Smtp-Source: APXvYqzPYCIPwF1KvGPv1PnBYWnAc40S/NjlpIDDfPadMbQXC6G8Enz2FxtplG70Z1Zv3hrXsEzfuw==
X-Received: by 2002:a63:2b92:: with SMTP id r140mr26598879pgr.363.1558809571091;
        Sat, 25 May 2019 11:39:31 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b16sm6406173pfd.12.2019.05.25.11.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:39:30 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] alarmtimer: fix kerneldoc comment for alarmtimer_suspend
Date:   Sat, 25 May 2019 14:39:25 -0400
Message-Id: <20190525183925.18963-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/alarmtimer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0519a8805aab..57518efc3810 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -233,7 +233,6 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 /**
  * alarmtimer_suspend - Suspend time callback
  * @dev: unused
- * @state: unused
  *
  * When we are going into suspend, we look through the bases
  * to see which is the soonest timer to expire. We then
-- 
2.17.0

