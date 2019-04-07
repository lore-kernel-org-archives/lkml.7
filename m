Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E804DC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47792133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f6HBt+BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDGBNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:13:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46278 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDGBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:13:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so11563840qts.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ToAuCI2UZu0RpD1Nbid/Kfs3hirNsiqiUv3gwCu4cTE=;
        b=f6HBt+BLBmT3vi50EWWf2NGusDfk/FoZDZ/0d4NGtyO2qfFX+h0DgB/bN+1zkYROCA
         BLrOYy4P3ZJ4A+9KLblNjaLL6Sm/LJ/8/Vx96ywQqm5++EY7t/P93lQPtThZHi/s0WE1
         GyyhnjKZOXnuMespn6qsADB/NxQ/HHxpRSOZZTB21G6//PIZVq6cvDhIPVJftmYQZlDZ
         qT9kqX0eW1Yx8iiS8hb8lAHeXTCjDBFRlCf5UlKdTpRQ82NUUReTeUi+yKSbE1OC6aRb
         ELXY2MQr+nWZYvZJJs658WMM4F3jz5NAhamWCHAT/kbWP54shkAXmQ8eEP/OuvQ23XKv
         cyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ToAuCI2UZu0RpD1Nbid/Kfs3hirNsiqiUv3gwCu4cTE=;
        b=mI7g8xdObXlFUiaxI7G3a/wE5XMu1kvx6atkeSFZOvO69EnFFMEOoaR1dEsPdnDCFN
         M6rXxz0EKHBDPRK+bLTl6Ds4YuTGp6b8jRN+u4AsKYOvr/ELAK/eOWRxPhxcKTCirnJj
         AjuMA4ZqoWjcM1DdlDQXv6HssJ8ZElThCwKqz2+bc8WowelIIzAMOHCRTh/qTF02YR4W
         im9dJu9+R1bEI4nu2p4yexwv5IxZR9JQMXVZwGK0gbRRdJ1/6K/R1X3t5L379iIGiRsc
         TlQ5bpOgmzivsld4R8yB1lybxDWhgxfW+6BZSjGbe/tkJ28tyRAYmXPQ9rqL26hT0w11
         WrlA==
X-Gm-Message-State: APjAAAWSXuE8NpRuM7F9tD1mQdTupG4JHS4Ple4BnCouy3kykCljOS8K
        1pWyTi6grsImFfR9+plXVbWX2g==
X-Google-Smtp-Source: APXvYqzj6V6+3hND60M5781OLAf+SiQOm7aIYwBKSQhobgp4jxkRezcIiT3+PeD91RpaY0tktbzylg==
X-Received: by 2002:a0c:ecca:: with SMTP id o10mr17195305qvq.197.1554599596196;
        Sat, 06 Apr 2019 18:13:16 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s43sm16875165qth.47.2019.04.06.18.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 18:13:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Date:   Sat,  6 Apr 2019 21:12:22 -0400
Message-Id: <20190407011222.38963-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
memory") introduced an uninitialized "struct memory_target" that could
cause an incorrect branching.

drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
        if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
        if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
            ^~~~~~
drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
is always true
        if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
to silence this warning
        struct memory_target *target;
                                    ^
                                     = NULL

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/hmat/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index c9b8abcf012c..6653dba3b377 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 					      const unsigned long end)
 {
 	struct acpi_hmat_proximity_domain *p = (void *)header;
-	struct memory_target *target;
+	struct memory_target *target = NULL;
 
 	if (p->header.length != sizeof(*p)) {
 		pr_notice("HMAT: Unexpected address range header length: %d\n",
-- 
2.17.2 (Apple Git-113)

