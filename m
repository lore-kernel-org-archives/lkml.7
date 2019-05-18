Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCBA218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfERAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:46:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54899 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfERAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:46:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so8386299wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 17:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4J/wt/1bRO1VqR+N0Z8RIgw8kt+l268hnuB5sJUEyrg=;
        b=E7CtGROX0dFb56G+StV6rIlvm0O93EJw0QujEWeDBfH0X5B7bsPGJVsVTcx4GDkLKy
         PHI2qQ6G8H5AKJwdRIgKoxAUUB92zU1esxAeoRUslVEjVA9TLpZC/M6bHCcWMON6WeHs
         AFi5zw+paQnGFtVKE8Takmqvekaq5xknplE+1XNni7Z1ydbmvsJ5y4/30EVusKtaa41R
         UPTRA2gMxXzRZc1Q9d/ARyJ1pf3FarVLJlF/7gjJZJJI6weYMXA6KbL41kXjy6FxiDrB
         TVjtjBTmpdz/Je9WjTxxWzucAnp4AlIJhLKFIVyNw6xFkAKidZrJdlBWcvjjY8udGrLb
         Et6g==
X-Gm-Message-State: APjAAAXceWV834Hg1NnnzOeyfSAoTaXPJ3YUPxS2qYv31rfMh1ZOXBkf
        X7LzvROZJBvYSTz20hd9qbomc6x5op4=
X-Google-Smtp-Source: APXvYqzF+1psvAoQ+dDw6U4q+Nc7IUoQS/9RUXg8csMpLyunTejTk8ztforCi8fMevmiVwXj3qTkpA==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr4094317wmg.18.1558140403006;
        Fri, 17 May 2019 17:46:43 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id f2sm11037959wme.12.2019.05.17.17.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 17:46:42 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 1/5] samples/bpf: fix test_lru_dist build
Date:   Sat, 18 May 2019 02:46:35 +0200
Message-Id: <20190518004639.20648-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following error by removing a duplicate struct definition:

samples/bpf/test_lru_dist.c:39:8: error: redefinition of ‘struct list_head’
   39 | struct list_head {
      |        ^~~~~~~~~
In file included from samples/bpf/test_lru_dist.c:9:
./tools/include/linux/types.h:69:8: note: originally defined here
   69 | struct list_head {
      |        ^~~~~~~~~
make[2]: *** [scripts/Makefile.host:92: samples/bpf/test_lru_dist] Error 1
make[1]: *** [Makefile:1763: samples/bpf/] Error 2

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 samples/bpf/test_lru_dist.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
index eec3e2509ce8..f532b894654b 100644
--- a/samples/bpf/test_lru_dist.c
+++ b/samples/bpf/test_lru_dist.c
@@ -36,10 +36,6 @@ static int nr_cpus;
 static unsigned long long *dist_keys;
 static unsigned int dist_key_counts;
 
-struct list_head {
-	struct list_head *next, *prev;
-};
-
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
 	list->next = list;
-- 
2.21.0

