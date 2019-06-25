Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8778A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogc+rYMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFYU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:27:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46108 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:27:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so13552705lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0YDqvR98EjwNxyu4huLL3dsPvsKLYn4gdNkZG2oBOJs=;
        b=ogc+rYMA9sdqu9wSpp67RZ+Lj/mZ8Za7GmnoAmifPddTMTPznHlqTWRXxOSIh2hrbf
         rgHK9WvEXU4z1dSYPcm9UVJ7/GCISvrI1yYKNdeJF5LC6UkAwwCTve6aKweG6zD6g6ab
         75bC/zD8yeBlSOGg0GFPTx1lyvDcfhMkwsaCMkvpfgJMLv/p4JnSElcxyzR5NH5Dfrvq
         WzdTDN89NzXPDXz0CLIQHD0dkAEgaum1ymPsXFsH98xGEcdzZJr41VYDRgig6ZOMYyb/
         c3DLt28dh3CpqwUsPcJVVsGBIP87UA8vhN5TtjoScLG+XIIQN8aLoTMCxXD3nR9vBG8w
         Uicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YDqvR98EjwNxyu4huLL3dsPvsKLYn4gdNkZG2oBOJs=;
        b=kOUzWqtMaLMZ2SqoooYjl5ygu5dMhKbmjJYaDEX6eUOz7Tg4u4UjwTUXH2sGH/mRUX
         tvysY0ejzp5DS3nNhvQUHiC/azGZdZHeFFhzzF9/0yDP7JM9to5+WxF/AJV0I4gHrcdh
         lhHfUI4Iaxk/uR7VyQ9ok0nRiRcxsucEcx/GY+jkECcwdtKAcDCph1qAeGi9WwNyIVkG
         B3klKG18NI1dQ8WON4HcvjaK5Pw/nhFrXg3aejrGYCcSwpOfeYf4WWYrsfY5QJWPgfNt
         fnMNBXWZJRsLlimFXlh8BBE4xjS5ZXsU4HOK6PQ0zH61SA0eocTI2HPTbe9bzKKWhd08
         weaA==
X-Gm-Message-State: APjAAAUvxDtWLxYM9aVBcWPta2ylL2Y6iHo1VlDccjJtCgMcXsZmL35X
        PuAf+pEVhN/FiNff/Al4iHBhmADvNFE=
X-Google-Smtp-Source: APXvYqzcMVnRXL4XO+yihowQtHyEaB/cdp9lUKVcAvdS1owjAyn8/YfQPThVzOdDdvjE3MgEOOP03w==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr383567lfh.15.1561494424398;
        Tue, 25 Jun 2019 13:27:04 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id y10sm2070362lfb.28.2019.06.25.13.27.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:27:03 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, netdev@vger.kernel.org
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next] libbpf: fix max() type mismatch for 32bit
Date:   Tue, 25 Jun 2019 23:27:00 +0300
Message-Id: <20190625202700.28030-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes build error for 32bit caused by type mismatch
size_t/unsigned long.

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

