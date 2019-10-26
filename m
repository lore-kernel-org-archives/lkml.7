Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E12CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223721655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBTyUjfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJZTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:55:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46684 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfJZTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:55:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so3227690plr.13;
        Sat, 26 Oct 2019 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MkzEl1t+VJR5731togH5vyJCMp2aTYclRaMcZX4VR7E=;
        b=UBTyUjfFK287qETQ4VMBRVH6vXR7FWahDWc5pkpEDGYFHXyiunLExsxXWD5H4wLZN5
         xwe5VbomkdfWyW5U58W18HuqWavutsdsw5Z8jhpuwQZ6czGxKq1UlsSv2g8ljEW4wc2g
         uV40v5ajElxcpLLO5CGcY+kP2WRAFviU7OL0dIZhHeqPNl3qNY93C0VTXfTyoWLXv7bo
         WDxzDAKaDTEFD9lfFmdawcHvsPBW6csqBxJMsGZ2jjKn9lpfC4G4+L1iCkBWrHbkH10Z
         NoL16ONLqTOyC/QLU14asB0KxieoT8Nx+xpqQiMQ+WFyg5499KL3PhoLiY8Q+1dLMaSI
         QOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MkzEl1t+VJR5731togH5vyJCMp2aTYclRaMcZX4VR7E=;
        b=pf036SUD8ipqdSuYKnX8z7tQA06hnyg3aZOCZGWTa0UBwVkgpaIsfP1nEUwkZLthCX
         YBZr2zwjUMfY37VnAeA2i4tqQnO86Ey0LUY/nuBAjFXgsN6UIPyoWb3MAcvkeiVa7I+e
         vjceRbHmu07fHO0QBtD6WsLA6iRn5A7/fSwmk8R1z0zVa72TKI734NdHi4Wldhi0FsAw
         182l76qlO10wCqgzRmgDLIL3qMRLsZlGIZoY1FwtFVUp1sEaiGC6CGY34hT5K6irb7Wk
         API9eE4jZtnf0dbns9Xi0F1LjMWwRukbbMQ4rQtSdJ0xwQagWKKwemkis1uADflfM4o/
         j7iA==
X-Gm-Message-State: APjAAAUmH5QX+V9Ns9RdE4+Ke/KrSfPTjrq2VvWeuLJ3+dtqOyruvuEk
        q+Ppf7xDd45KXad/VdTCYlk=
X-Google-Smtp-Source: APXvYqxyJ468qOGZECo7TokvLMGUdvPKsmcOplGcvbCIhCpRij+550PPQaNMoZxjKAG7lyZ06JTcDg==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr11043039plb.184.1572119757257;
        Sat, 26 Oct 2019 12:55:57 -0700 (PDT)
Received: from aap-ubuntu (c-73-202-31-227.hsd1.ca.comcast.net. [73.202.31.227])
        by smtp.gmail.com with ESMTPSA id d14sm7513407pfh.36.2019.10.26.12.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Oct 2019 12:55:56 -0700 (PDT)
Date:   Sat, 26 Oct 2019 12:55:54 -0700
From:   Andre Azevedo <andre.azevedo@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andre Azevedo <andre.azevedo@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] Documentation/scheduler: fix links in sched-stats
Message-ID: <20191026195554.GA30903@aap-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rain.com domain recently moved to pdxhosts.com, making the scheduler
documentation point to broken links. Fix the links in the scheduler
documentation.

CC: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Signed-off-by: Andre Azevedo <andre.azevedo@gmail.com>
---
 Documentation/scheduler/sched-stats.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 0cb0aa714545..dd9b99a025f7 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -28,7 +28,7 @@ of these will need to start with a baseline observation and then calculate
 the change in the counters at each subsequent observation.  A perl script
 which does this for many of the fields is available at
 
-    http://eaglet.rain.com/rick/linux/schedstat/
+    http://eaglet.pdxhosts.com/rick/linux/schedstat/
 
 Note that any such script will necessarily be version-specific, as the main
 reason to change versions is changes in the output format.  For those wishing
@@ -164,4 +164,4 @@ report on how well a particular process or set of processes is faring
 under the scheduler's policies.  A simple version of such a program is
 available at
 
-    http://eaglet.rain.com/rick/linux/schedstat/v12/latency.c
+    http://eaglet.pdxhosts.com/rick/linux/schedstat/v12/latency.c
-- 
2.17.1

