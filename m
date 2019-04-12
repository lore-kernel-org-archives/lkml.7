Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA12171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCGPDuwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfDLMli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:41:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43874 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:41:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id w3so8186911edu.10;
        Fri, 12 Apr 2019 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p52kOXmhLGjtcvgfeEttPUaATcwSZrXTsAytCT5CZmQ=;
        b=pCGPDuwptJ2I02bpn583M+2mWoR5p0Bj85+dt6yO2eDZOc2c/27NsCieV1RbsVbZvW
         nVJYVpslVlrX0nAYFVH3fdkbIcnMppAEccBOoEGqF1Tgt0svQ81d2WhZGh4Xmb6cir04
         YPnd4UYYwzzSF+ulH6Br046oszVKcxRdPL6D1/RuHvVNFz0H/7kG+L9k/UmMsSDBdJ5P
         YtCoiCWwt1T7QdO08F1kCl4YbRUfK2rwzhW5fwXn6ESPVJBs0v+lZsQLPyNgrvC4argd
         J86y00mn+9Peg8g9stLaHchC/QIVQxwaSttRn/Cc70cPiL/DQkLNixvs8Eji3nLVlnes
         mJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=p52kOXmhLGjtcvgfeEttPUaATcwSZrXTsAytCT5CZmQ=;
        b=koItXI+E1KgqPxixBBO/AUTLmmUbai309t61JrD8k+drAIqOt/Lks8jIvBlI3UJB3q
         TXdYBwbIICQYMjKf0ZNKpPwZoAVku1Tq+o4V91Kj2f++Yo8pQfeeWv1ImkBvsJ3m9t4W
         b/sLzqBzqFtHE0e2a7JvzM7dBLllesL8/IAhtW+7KbE4W+VNupP9rEDccMitIa/Z9gwP
         o1QMUsgT8C9F6NBDlYmVOWHxq3jAWtCK8a2YGl6crzD0MHEs+pIMllZLvk2RUXF9ozTq
         hZd0YozSeLt3Y9UDuzClmiB5c7GAC+p9PYWa/v/bMRFbojhWoBjEan7U2nnyqJOgriPr
         VbHA==
X-Gm-Message-State: APjAAAWotH0qJLtaGl9dF3q52EREnjpGNx1qAut51MvKv0F2AAj+Qt7O
        aCHyB+bDwP0Z8CgeSCND5LRE47Kstvc=
X-Google-Smtp-Source: APXvYqy8sjC0pySVqST7XNDKMLX0gEt6WWTT7FPfQkJZs5ct+8oiU+fWgZVyPH/VqQum+yD2fJfGfA==
X-Received: by 2002:a50:cb0a:: with SMTP id g10mr19987032edi.41.1555072894261;
        Fri, 12 Apr 2019 05:41:34 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id b3sm5070487ejp.80.2019.04.12.05.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:41:33 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf v2] tools: bpftool: fix infinite loop in map create
Date:   Fri, 12 Apr 2019 14:40:50 +0200
Message-Id: <20190412124050.32120-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

"bpftool map create" has an infinite loop on "while (argc)". The error
case is missing.

Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
$ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
(infinite loop, taking all the CPU)
^C

After the patch:
$ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
Error: unknown arg hash

Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes in v2:
- Explain the cause of the bug in commitmsg
- Add the "fixes" line in the commitmsg (Jakub's review)
- Rebase on the bpf tree

v1 was initially based on bpf-next and submitted on
https://marc.info/?l=linux-kernel&m=155310327709613&w=2
---
 tools/bpf/bpftool/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 05b029b934a6..1ccc38718458 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
 				return -1;
 			}
 			NEXT_ARG();
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
 		}
 	}
 
-- 
2.20.1

