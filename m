Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C0AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D706C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwIaGN1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfFZKim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:38:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44239 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfFZKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:38:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so828236ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7/7ThqJsHZEC1k6/iKremUj3hn4/MicnKE4/aT1gNsA=;
        b=jwIaGN1WLQvvoZpKTt5omB84aC8rELXROrOqHTju1pFE/gX3muJ+LvqaoL8c2seXb/
         vegxwJh3qQD8GK50OyLjQOu4/kkWbzlPkvEQmLBZU1Y+eEDjNKsIg785Ld/Q/ONf4sN3
         yyzJWMZeOqe9JKH+t76WHopIaSweZ6sJuNq8vZNPeuFnKkIEHPKDBzeDMqr6jOjw2R3Y
         FXs5yQ9UdU463EB3n5hJFH/Kke6R6KK38+DFpNJ/MJU1ArsCYdYXorNDBP3poUP/o/HH
         AlNFR7BbFfgyAgaEETNNRA5/ED9Yaz58fYEQrH7M4E1uSFr3HUdDV9nV+ynJy/cYsPxX
         x40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/7ThqJsHZEC1k6/iKremUj3hn4/MicnKE4/aT1gNsA=;
        b=XH8+f6SVysVLWLHKfBD+cMbErCQmGjA6BpW51jy91rTgbA3K+FEc2QFIUMaLDtt1ZQ
         WeCP44qTy+FUaE0Wef21/G/cXJiPePkPvMic7gl1TFz5CE6+WpjLzutVfCr40xa4im0Y
         31UoRABv5X2fuY2sI4lj0NYHFuLgmJ6sIY4SRRAmExhw/J+hUZ2znpqIRlUFkgO/crXy
         bYXhFr6TtVYVfYEM4e4TyASk66z7+XGkIPJ/YRcgk4VQKNDmeCvIXGYvjSN2obznNtCA
         hDatz8fka4FqnFsoEVuhmB7NU5QgQTo2KLL5c/Xrzd5DFBhOWlZPEzhC2pvpTtCFzHSu
         5hqg==
X-Gm-Message-State: APjAAAXzcBdCCxqzuP0YH2Y/UZDtNRyXTo9jpEKVnJB297i1QWvp1jVO
        TvXJ12zHf7xCJB2NEFCAnG8xug==
X-Google-Smtp-Source: APXvYqzIqruQr8skHJ7Cy/6zMhRHvz6kDHzz29lP7IOisG1D63w3LH9uBcrRddtDh9BzphIUEDvbYg==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr2317536ljc.81.1561545520323;
        Wed, 26 Jun 2019 03:38:40 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 80sm2372230lfz.56.2019.06.26.03.38.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:38:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, netdev@vger.kernel.org
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 bpf-next] libbpf: fix max() type mismatch for 32bit
Date:   Wed, 26 Jun 2019 13:38:37 +0300
Message-Id: <20190626103837.6455-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes build error for 32bit caused by type mismatch
size_t/unsigned long.

Fixes: bf82927125dd ("libbpf: refactor map initialization")
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68f45a96769f..5186b7710430 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -778,7 +778,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 	if (obj->nr_maps < obj->maps_cap)
 		return &obj->maps[obj->nr_maps++];
 
-	new_cap = max(4ul, obj->maps_cap * 3 / 2);
+	new_cap = max((size_t)4, obj->maps_cap * 3 / 2);
 	new_maps = realloc(obj->maps, new_cap * sizeof(*obj->maps));
 	if (!new_maps) {
 		pr_warning("alloc maps for object failed\n");
-- 
2.17.1

