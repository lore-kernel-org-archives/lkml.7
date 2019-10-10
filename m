Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F64C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8ED21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697017;
	bh=AFahc8G12K7WvzeCEERC3mW1Z1th2gs47ouNqmHB0wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TPaxA1M2vOjZoXnTaW8YJpdU2Nn2r4VNNLF/zuQWW+6X6NZ0aEdFjP0jlZhb2sMLb
	 ra22zWZukierHVTE3rvWGvZuCSO4+58TAgJ+6QPnKVULx8wCUl2WRyDohNQkMso6nt
	 L1dmEb7y6ccBXD/U2F04dUDTQ6mbicXYkfoAPcrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfJJInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfJJIna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:43:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19572054F;
        Thu, 10 Oct 2019 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697010;
        bh=AFahc8G12K7WvzeCEERC3mW1Z1th2gs47ouNqmHB0wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc+9X3vQb//tjUPTuy0icNuktk7jqwRz5RGFEFWM381U7MRdoL8bwIB1qYep9RDic
         AHx4vjVOAkm4mHd69ruYZJYoyGIVRgXgcz3MsWpSAMuVsEGD4f0+hBPwCFmkWmzM+o
         EHU7DBZXGr1I4OQzk/xQff3O/emiXNNj7jh5LPRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 127/148] libbpf: fix false uninitialized variable warning
Date:   Thu, 10 Oct 2019 10:36:28 +0200
Message-Id: <20191010083619.688232806@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit aef70a1f44c0b570e6345c02c2d240471859f0a4 ]

Some compilers emit warning for potential uninitialized next_id usage.
The code is correct, but control flow is too complicated for some
compilers to figure this out. Re-initialize next_id to satisfy
compiler.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7065bb5b27525..e1357dbb16c24 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1213,6 +1213,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 				return;
 			}
 
+			next_id = decls->ids[decls->cnt - 1];
 			next_t = btf__type_by_id(d->btf, next_id);
 			multidim = btf_kind_of(next_t) == BTF_KIND_ARRAY;
 			/* we need space if we have named non-pointer */
-- 
2.20.1



