Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6217ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1C9218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b82CPx+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfJIUnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:43:01 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34767 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbfJIUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:44 -0400
Received: by mail-lj1-f180.google.com with SMTP id j19so3921592lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=b82CPx+fPly56w9MPycjqjk9NJFrcqTUC+lMTY5z15BMRw4pELbH/XPZ+RJefWuxPY
         Ve+lIxc6pQd+2yDHo9zcMjT2RLJUqoXNChE9oUJ1xBcEkkjBJsESNa9GWmIK6Li9Rbkw
         2gsZITjElYlpNfxDj0t7SIHmbzIKhfrXgQQ0eutD4pIHkl55qf+nSBf/bZYmQNvZSkgO
         bLliGWmkU+bpjvxPedusjcxCZqk6Z8tNN3fiXpA9lu1SC9hixLlHu7am+/BzaOY0OlQc
         nx3uyOZj9pepIabNtCEHnzksYGri285CEa6jAL/ZaogaUkfB9TcjD1KrdFRk5hVdInNL
         Q7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=Qb6DyYxqfqK14IPhvXt19tahb9ijPNOd1QNnA8Gi8NZ73wwpHDUHl7pGoAqnJjZ9zc
         JfXKQyIJMJ7Zzdgiz2C3CMwwNHqQ00etJSRmyyMayaGtQ6nWcJmTX4XIzOK9DqsNrv5h
         LF0Vu/WA35XTClyYHHoB0jwuV75JGHtYc7yaTzb1W5SgiPRhe2b21c7nsNXRSlyVmqm/
         f588BbuYvGbnQojNyJ/Vea3BwyH8g9f6W/S6P47F+mvCucMUNNL9nBQWQ+kX4+jgYUL8
         HPBk/XQXljRSlDlt3uYqVUCgk9gemoxxVqyFSaf3XX6Eq8H9Pu890tu3aZCxS7J7+M7T
         pEXw==
X-Gm-Message-State: APjAAAXeiDDAt30Kkhbo0Bk+x2dAtrp73cBnLcEuRrc/wIPIid6Di5Hj
        0FrqNECI9LFToOi2k6eA3OYYYg==
X-Google-Smtp-Source: APXvYqz9ZmT3mmRmWoZneEqLxJDx7rmmR3dC+5Tb7MVDbitwoik3uWhRkcyt0PDRQ6WmBWMTwbR9xA==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr3623227ljc.120.1570653702474;
        Wed, 09 Oct 2019 13:41:42 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 02/15] samples/bpf: fix cookie_uid_helper_example obj build
Date:   Wed,  9 Oct 2019 23:41:21 +0300
Message-Id: <20191009204134.26960-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't list userspace "cookie_uid_helper_example" object in list for
bpf objects.

'always' target is used for listing bpf programs, but
'cookie_uid_helper_example.o' is a user space ELF file, and covered
by rule `per_socket_stats_example`, so shouldn't be in 'always'.
Let us remove `always += cookie_uid_helper_example.o`, which avoids
breaking cross compilation due to mismatched includes.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4f61725b1d86..045fa43842e6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -145,7 +145,6 @@ always += sampleip_kern.o
 always += lwt_len_hist_kern.o
 always += xdp_tx_iptunnel_kern.o
 always += test_map_in_map_kern.o
-always += cookie_uid_helper_example.o
 always += tcp_synrto_kern.o
 always += tcp_rwnd_kern.o
 always += tcp_bufs_kern.o
-- 
2.17.1

