Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60818C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E1214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnI2QbGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfJKA26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34299 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfJKA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so8070613lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=mnI2QbGCo1NRiFTjyOBIqf6KabxlSsnPI4hdGenxjeIyJTkSXKVt+0hJS0M5neXKLA
         QBHDyXER/DRHnVa4ubnHrlLClZtvLAtNYFdgQF3rb4NcU4bmKJ0Lz2Ufxthc/b0bJ1+Z
         kW4AWWBQ2OqryumuH+jEK+ydtLRpiEzBtnHnm7tZaq6+hU/ItTonq/Y3xqyD177deZTS
         bDH08drSrEruU6qymWOgxylscRznlSk57CIdPAwhHWK3wTFu0VdkWrvR+s6lEse6B5Go
         1vh0iAFOmgwbO1zArtb6aL2WFaJ1aR6YdgCcd9ExuDq4DEQiXiJOktqlD/av3XyosuSO
         f42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=bg+6E2PyT2WPrrVuDPnmQZRpYayJ7DiNwO6dzltzfW+wl+p81lY0gAJynn1t89EywG
         koUpI8kktWxxfzX595V8fz6FYBoh2wTEYaeztcXr8aNjHAVvSm8ULBnlYn/Qkxh+Ex/1
         JdIVhsavTcS1HUmUPKuR0Fqc9QWzVdC7AoT6hH2hagCI1ADEbniVCsiIe+GlTj+uI5w9
         DsV2s6PMZFvjFZC2CwN8bJOHPTmWO3lT8w+V/yVlGJ2eB+zi4L6VOi5P5cztStLYEZYU
         xzNJYFE7/E0psTNKQOH3UU9wvYr1Drggw6PLfMyQCovoPGhYA6IqHcsOZfeSm2I8FooR
         cULg==
X-Gm-Message-State: APjAAAVz7wy50vbB9cTtB0hQJ5xf76CkV6YkOmTK1MJQYcOOm5Y26h3l
        qIA9ObOkkj6y0BLa1z67vwljyA==
X-Google-Smtp-Source: APXvYqw3xBuKAwJLBbXvSMeq+H2mubLdl9QJO6loIzPi+swWT6qeo8+IJ6UrP2bxsA8AXu9fvQT6DA==
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr7896959ljj.160.1570753718464;
        Thu, 10 Oct 2019 17:28:38 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:37 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 13/15] samples/bpf: provide C/LDFLAGS to libbpf
Date:   Fri, 11 Oct 2019 03:28:06 +0300
Message-Id: <20191011002808.28206-14-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build lib using C/LD flags of target arch, provide them
to libbpf make.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a6c33496e8ca..6b161326ac67 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -248,7 +248,8 @@ clean:
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
+	$(MAKE) -C $(dir $@) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
-- 
2.17.1

