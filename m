Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE222C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39172072B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hwq1LeVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLQEpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:45:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38265 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLQEpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:45:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so6830059pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 20:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFOKANEwowyMqUieyt/3xc40UqgVgL4V9AjtjYPrU80=;
        b=hwq1LeVPzmXCN5bkDg6sViC8UrSNXBnAr/kOYMwcvKNWqeqHwVfbOCXLAF/kdcTXGc
         YHcBAyZKcQmABsOTmsdjKVpFaNe1A+CguRV9XMPbBZJVdc6dzV/Fbr2kI6Ba0hYKMbum
         3mkxNKFo9JD8pJtyRijXdRPjNC+jYvSTqNl4MmLOspugxR/S9s8d5B5OHRsAksFve+02
         Uc6gUTRRNgqU4MoSXtvs76Kxe7ZDdYVMtlnuPfwlu+4so94y3kmcpl8zvn0qYbAJI1UV
         4LU2dA3crDQAr1vQ+sZtN3fvv9i35adZvQ7UZRIj0FLEg67Nvm8z0XakP0PgRBo/mtwd
         Pp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFOKANEwowyMqUieyt/3xc40UqgVgL4V9AjtjYPrU80=;
        b=E4UHNMukk1VE/nTyND19NUZWVgjKbr/K76BDxoechVO+/+duSA6sa7zPH36/Q6dWJx
         kUppmDVfs/OgtlBt0EkIf5LzkjVLzGQomXpYXZUS4tKXcG07aVpKGu8FAqZgOsp8nZcb
         rDfV1cZzCvc8CD1FOhP0qNz+aPooRC9NE/CdvOL+rH8hQRluJHssATHykFXuJAIPLSQy
         cFqT8dWBme8wJUTeAWnFQ7QyH6NT+XhJsS4KjRzz1bQvWPyAWUG5Ef1IlsAhv4KrguxM
         LbnietQs0rBipeaTe72aly5lXYE206Ga7Am6smTehHeqrfaf4vBX6GKr/Ga0vx/+16xq
         pAUA==
X-Gm-Message-State: APjAAAXuTPE4deR836y2pW+KEHJB9Oo4d4gkrcOBO3jlEaKcQH1LNLLw
        dlblok3vJVv9ec6EYGaJk3LlfA==
X-Google-Smtp-Source: APXvYqy1w0O44FGIbN6ye1YVpK07d95OsREGZToQpWkiZo0HNxUzZTJL/QrtF7b+2ssKObkpqPKZlA==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr23145963pgx.286.1576557912262;
        Mon, 16 Dec 2019 20:45:12 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id h6sm23597091pgq.61.2019.12.16.20.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 20:45:11 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2] clk: declare clk_core_reparent_orphans() inline
Date:   Mon, 16 Dec 2019 20:45:05 -0800
Message-Id: <20191217044505.127574-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191217044146.127200-1-olof@lixom.net>
References: <20191217044146.127200-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent addition exposed a helper that is only used for
CONFIG_OF. Instead of figuring out best place to have it in the order
of various functions, just declare it as explicitly inline, and the
compiler will happily handle it without warning.

(Also fixup of a single stray empty line while I was looking at the code)

Fixes: 66d9506440bb ("clk: walk orphan list on clock provider registration")
Signed-off-by: Olof Johansson <olof@lixom.net>
---

v2: Forgot to amend when I switched from __maybe_unused to inline. Use
either version, your choice.

 drivers/clk/clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae2795b30e060..dc1e6481f6b33 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3277,7 +3277,7 @@ static void clk_core_reparent_orphans_nolock(void)
 	}
 }
 
-static void clk_core_reparent_orphans(void)
+static void __maybe_unused clk_core_reparent_orphans(void)
 {
 	clk_prepare_lock();
 	clk_core_reparent_orphans_nolock();
@@ -3442,7 +3442,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.11.0

