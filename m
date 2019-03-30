Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D4AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5632082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbChXZP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfC3SaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45114 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfC3SaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so4631865ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpAs0Rq9F1GVcM1iEuyCuwPux0eS1gd8j8020bDIIDc=;
        b=HbChXZP+K5+7qNHt9mvM4QQtR091mkUJ1m03fN3KPjqPI/eX+3rCVMRc867vqIGWg9
         uoFLQL0IfjbkzndijxvPpgA0WWWIrz5J+NiLvCpLpBuWRlqs+4ZOg8o1t4bWP/42m+39
         AGC9GzhKmDr7ruYQN5AaDGN6ZsMbfH/SllIWyru4BngAM7WdarQU7uSfS+xmqg9a3prl
         Tna9JSWtBZ5Z5Mb660klWirUDffFGWvhDu12dnhsQ8ulpIUQQmoFXhDfHxiAmCHdtiuV
         2Oq8LM60srI8S2ZCuTuO4kqhUYXMs9cR/BzILvuDHdW/OPUV+IyRbTBnKZ1DQMHPTeea
         rJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpAs0Rq9F1GVcM1iEuyCuwPux0eS1gd8j8020bDIIDc=;
        b=mYpd7MkH/JrHnWARmD9BDs60BhxsKVqGqjznQFx8OBGKlP8YdU4x2NxhZzt+O+Ij2x
         Bc9i+UNFOKbD/Cf/+jgQvqHAdanbd5et1xGiP70gwRPXxUgOZd2oFSi1XmvF1TOKV2oc
         4uLI4VuzjkJaLuUpzNd1MHCUJL6GgLeevs4vIDeOFhqnfe4qBNB4V9OvGqhNFNdG0yj7
         V8GvWXcEVS9jd7d7meuR5jo84TYhOjqK5zs8ILEoxpIoFEU81f+rxtavoKmiKl5acgFY
         DTqO/bzzSzrY8Yy5h17N2d0zQ2kq2ZkRMb+9QMjT7UXcDXn4aCkvPFesbTqktC35N6d7
         P1yA==
X-Gm-Message-State: APjAAAXldp69rpjRSRfpMUhdRkZ9V0QthiEYaZ78gf2hX8cvmIhTYpji
        c4aO+LMnf3DEIRh9MNtwjAXIML/4
X-Google-Smtp-Source: APXvYqznky9VFyumQhsElZYgnrCNEixCqWhIzrszW07ILz8NGuJWAAC2angRZWVQcof0PRskN6V3Zw==
X-Received: by 2002:a2e:8550:: with SMTP id u16mr13728995ljj.11.1553970612796;
        Sat, 30 Mar 2019 11:30:12 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:12 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 4/7] rslib: decode_rs: code cleanup
Date:   Sat, 30 Mar 2019 20:29:44 +0200
Message-Id: <20190330182947.8823-5-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing useful was done after the finish label when count is negative so
return directly instead of jumping to finish.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 22006eaa41e6..78629bbe6590 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -88,8 +88,7 @@
 		/* if syndrome is zero, data[] is a codeword and there are no
 		 * errors to correct. So return data[] unmodified
 		 */
-		count = 0;
-		goto finish;
+		return 0;
 	}
 
  decode:
@@ -202,8 +201,7 @@
 		 * deg(lambda) unequal to number of roots => uncorrectable
 		 * error detected
 		 */
-		count = -EBADMSG;
-		goto finish;
+		return -EBADMSG;
 	}
 	/*
 	 * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
@@ -261,7 +259,6 @@
 		}
 	}
 
-finish:
 	if (eras_pos != NULL) {
 		for (i = 0; i < count; i++)
 			eras_pos[i] = loc[i] - pad;
-- 
2.17.2

