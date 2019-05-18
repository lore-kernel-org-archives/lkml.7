Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A60C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A9218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfERAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:46:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfERAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:46:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id c77so6908130wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 17:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVHOEkVV9mlfbXiBNiOTGc9iVLu9GHw8uX4Flvc6nzM=;
        b=LKlEixSAyElDInJLoMe3o1DgF5qdTGR4OlgrItWpu/qB/AW5hdoCwL2t74LuSWovwp
         yD04fEbbd/EkVhcDu9dMa+vQVrxuMCZJYnlOc+C5z0iveOcLKIWef5flYVA04JlqymLy
         5o7TZ5fZRId2b7FpxIWjmkNY3irryD2Kd6biQqHbLb2vE73e/7oDMG5sG+jsj3eBN2er
         nKUcvqQlWlrojSPr9Add28osguEM43AYRO1WvZZdD8BsE7J1j+31qfyP17mbDy5bnMbR
         rKcje551qV0c/od8mV4GrqljaifJVkfPkFbF6HquUG0cxktnv60Dm2GYKGJu73OZAeil
         q6Jg==
X-Gm-Message-State: APjAAAVO3z5uyhUw9R96eLjsLiRH5qneTstl1amp2Ik2MsF1LlTMKf/u
        x0ZjTXlXmkXMtnpC1so0XlkkDg==
X-Google-Smtp-Source: APXvYqz9dVgMCVBct1AsG2RXTM2TI8XXuNWqSFcJ7VB0m1uiNeGfnNjK+La84/2whwbjh7SsBSR/0Q==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4206756wmc.130.1558140415076;
        Fri, 17 May 2019 17:46:55 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id b12sm12189924wmg.27.2019.05.17.17.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 17:46:54 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 2/5] libbpf: add missing typedef
Date:   Sat, 18 May 2019 02:46:36 +0200
Message-Id: <20190518004639.20648-2-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518004639.20648-1-mcroce@redhat.com>
References: <20190518004639.20648-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync tools/include/linux/types.h with the UAPI one to fix this build error:

make -C samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=samples/bpf/../../ O=
  HOSTCC  samples/bpf/sock_example
In file included from samples/bpf/sock_example.c:27:
/usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
  102 |  __sum16 check;
      |  ^~~~~~~
make[2]: *** [scripts/Makefile.host:92: samples/bpf/sock_example] Error 1
make[1]: *** [Makefile:1763: samples/bpf/] Error 2

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 tools/include/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 154eb4e3ca7c..5266dbfee945 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -58,6 +58,9 @@ typedef __u32 __bitwise __be32;
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
+typedef __u16 __bitwise __sum16;
+typedef __u32 __bitwise __wsum;
+
 typedef struct {
 	int counter;
 } atomic_t;
-- 
2.21.0

