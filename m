Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA0C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E0021556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jtn/gEWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLKWeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:36 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34796 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfLKWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:29 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so217108pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=32U3png4dzMqFX2eRDO2dCbQbOL/7+0IfZtgOUFBf0A=;
        b=Jtn/gEWQD7EIy6Bjrl5YvoRO959WbqPKaUQlDLnoRDEImaXWJvFLaFqaEeczCp0g9h
         7qyyodzuklWb9l1hpaUI1/sdZZRc7dsnKtExMT64sUgQhCFVbqZrNq3CZ+SNciD/FRA6
         hk+P2/9MSu8NHmKYd5U0kpnfbWAJGHYVCoRPCmCmrifHLSqosXIA31Ys2Y5NGUXN3vqQ
         f89DvdMylPXXnvTdWbhHX85RVDNujkBbCF2JxyC2tNfESxA8XkHtCOyrQQZ98A3U9a4+
         CDOL1MkRE10kDhOJbY05MpuIEGothGjv5rkbv8d+AzZjvXEzkIkn4sr4H73emfkNVN2P
         Z3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=32U3png4dzMqFX2eRDO2dCbQbOL/7+0IfZtgOUFBf0A=;
        b=d71/4WW03cx7voNyAlNJXzMP9HydCTHwyspjZ30dvEBJsLZwbWxy5JVe6s/MUWZc1d
         4eCj70KqBhISSS4eY01j5WVUhxlJ74D3hAO3cHXP9g+XdQwVnRRc6PZmao4KmHgycmVj
         KnEY0dKp7yzjAy+kUr9VsMZXbDXTqNb+2Z9UKB3x78X7CB+40O1IjOWEeZu6QGx3IXrT
         on6nJjRShHYoMgZTyECBgwM/htjzWsfb1J528DpC7oRc2E4MuYsV69Xvi5iH2mZrPri1
         Uz2Uz/lNDgE9Y+SCUsSnHvw8ehLBrawAkGcvWS575xGlGg4FTVVl09AfB4liHZZD3Dsk
         v74w==
X-Gm-Message-State: APjAAAXM3pibU71FeBSPu4jaQ9J5CpojQKG8WWU9KN4mn7BHXTufJDig
        SWPiHx6l5BBeVSCr8qRjaaAP3CQ+gdNh
X-Google-Smtp-Source: APXvYqwY81AwnzuaarejlQK1EoJNAtQ4xSv07K5q/7brfr2nih2yEfDd7UoNKLARUKM2GsTStuOuoB67BlyQ
X-Received: by 2002:a63:647:: with SMTP id 68mr6839227pgg.202.1576103669219;
 Wed, 11 Dec 2019 14:34:29 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:37 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 04/11] bpf: add lookup and updated batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f0d19bbb9211e..95d77770353c9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -503,6 +503,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mmap = array_map_mmap,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.24.1.735.g03f4e72817-goog

