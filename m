Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E341C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FECF22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lB/oei63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLKWei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:38 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52381 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfLKWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:34 -0500
Received: by mail-pl1-f201.google.com with SMTP id 62so185510ple.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5AhdXmPKS0JiQuHlniKRJHWxS22JqYuwMDsvrT9JMfs=;
        b=lB/oei63/sAcH89+V93til6fN/6F4X/UcwDCuMEW2z20zvLpRYxp6tbM7sW3X9BZlo
         /QtDi+qmTeJzFlCzIUcXsgjp2JA+qx9E7EvVKpKIHAy+hvQQSdzV5jPGAe0Wa8bmPB3y
         7eweDWffEI1IaCtN/Fp0OtuL6QF+RNRC73BGNLZtoqCuB8LZEHimoYzhFMpIy5kqEYFC
         X5bc13g9GwWLNfQMaZG+MoifnE9u3uLUqdRDboe309tfHmdqzpkbZP8zcnbNIf9waAUo
         qxMp3jfxIub34hDAOim4pcHB1e92YhnZHAYJYSWAQcrmYrwomrFCrwX+8Axu3BN7PXEd
         fvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5AhdXmPKS0JiQuHlniKRJHWxS22JqYuwMDsvrT9JMfs=;
        b=oJmdexzfkglyyPUVNT6p6XiUvAXGrOI1bMHRtzrhjXIg0l2gA7xHS4IcSoDJgHgLsl
         QXKnqIGyqbXLAe0lZG94MP6X6p1sXZ9dY9+nzdASC9wVhMX+3ck+35znEv2XM1JGLPtV
         Hh1ae0zRqdwi7zbt4998qZdw27S2h7/UrHOfGuWHmgwTY0Ju7P+umdCafx8iotLOgp0f
         oZc9jyGCXqophml17OgW6bwmUaSg8o6LPBf4+Ge03jDvosx0rCVrKr6GsrCHuH96hAG1
         KCA6ixRXOOvkaHXT6j5muOFzojnd5folzoeMmyJNbY++R3ktDFR/Z/ZBtuYeBKWtRL5j
         7rZw==
X-Gm-Message-State: APjAAAUCfINL6zsaFJ7uM1PpqcXjGB7/IouG641MMPtp4wVjcgTF1UFL
        9kVqeZUnN6xQm6E4k3RM+WzqPxiaGIOG
X-Google-Smtp-Source: APXvYqzvLtomxTN9fAdNSflYuVsHsM/b3e23KaWeDADeXX0GG4+Yzq5XdJNQgJpdumTdY/7TVwHiMmaC4rnx
X-Received: by 2002:a65:4c06:: with SMTP id u6mr7000062pgq.412.1576103673604;
 Wed, 11 Dec 2019 14:34:33 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:38 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-6-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 05/11] bpf: add generic_batch_ops to lpm_trie map
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

This adds the generic batch ops functionality to bpf lpm_trie.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/lpm_trie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 56e6c75d354d9..92c47b4f03337 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -743,4 +743,8 @@ const struct bpf_map_ops trie_map_ops = {
 	.map_update_elem = trie_update_elem,
 	.map_delete_elem = trie_delete_elem,
 	.map_check_btf = trie_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_lookup_and_delete_batch = generic_map_lookup_and_delete_batch,
+	.map_delete_batch = generic_map_delete_batch,
+	.map_update_batch = generic_map_update_batch,
 };
-- 
2.24.1.735.g03f4e72817-goog

