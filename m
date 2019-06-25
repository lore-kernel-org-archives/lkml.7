Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C75C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA2D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrGdRYr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfFYOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:11:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44100 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfFYOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:11:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so12712418lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gYuJuPOZBk4Y/I55Xfw4nMllA34HbJMTlhwO9fs6sKE=;
        b=RrGdRYr/3/VMp2ftn6ZpAtSc6E+i+LepBHyiDnqE/7RSQxXYyCk/+3N4RfHuaFPwBu
         tIT+EtcczTiCbyoETK9FM7l3NGlIumcG6DYtRf3yuUjQSV7eqRrigrh+UhqQXjwI/r3U
         bjZLIwU1ZHKJRXRetaNlUJOVk7rWnS43NZ62J+z3IbLnaZBQBMXcMAJ4C+ju6cBs/aTM
         I9q/W4hvLc3xIQrLRpTUM7BNPSTU6K6BwCmHP3JfUAuE48Etj+TfO8o6DoYAAdGyw3v9
         ZsUT2Xxnmc7jwRXmX6+6VY8PJcUE9q5Qg696QWBZkYlRbffGARZ+SgiXI8ceAwTc78bc
         Ouzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gYuJuPOZBk4Y/I55Xfw4nMllA34HbJMTlhwO9fs6sKE=;
        b=eoYz3BygyUmG68L6uJUp7LAz/d1njED/6Qf38QGSzNTLdcqpX3k5cVJFlPbQRAqiG0
         26j3CexrS2WPxwmfFICgxl9pwW02O3F0MS2N7Y3xwDOyXxrkwC56d7OxBhkAIiC3X6nc
         skALwCUxHRV53WHVth4BdDgw9Xa4VT6QUE/CIXu0Ur6DU2GckGOwW5izrPv4CMLqCI8D
         fd1s8MtkQ/yg+ftp2E02qFU70Sekk15BTbHeigTaHD1PQZfYm0PaxtKhJiDRlwRfO6U8
         qazgLrABeEHBsHLT9sDa/kPioY8gWbOOd236uU37XbSdblQknBn2aj2nLP9RDk5l7eCb
         4k/A==
X-Gm-Message-State: APjAAAV+90RxtncUpr70L8vI/o0a9pnOYOFRG3QbJ6dRoTbv1Jq7ha3S
        ZNzpJ293G63Esw2nxUAPmcsaLA==
X-Google-Smtp-Source: APXvYqymCGzBxYFBh6NDuxj2Z0bP9KTLDNIFnB0YdKzFofu+smjIUtjZXqAQj1DCj8d9p2R1wtj91w==
X-Received: by 2002:ac2:4901:: with SMTP id n1mr2442751lfi.153.1561471906859;
        Tue, 25 Jun 2019 07:11:46 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id z12sm1971522lfg.67.2019.06.25.07.11.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:11:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, netdev@vger.kernel.org
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] tools: lib: bpf: libbpf: fix max() type mistmatch for 32bit
Date:   Tue, 25 Jun 2019 17:11:42 +0300
Message-Id: <20190625141142.2378-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes build error for 32bit coused by type mistmatch
size_t/unsigned long.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4259c9f0cfe7..d03016a559e2 100644
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

