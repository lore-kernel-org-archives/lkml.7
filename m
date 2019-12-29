Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057BDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40162253D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641566;
	bh=u9H7d1EB6Cl7G4ftfrANC02XwN66e+Nwp3ptfHOWEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHlV1sUf1FuWgr15roEpilYjNk/ym1qEDXHt9vMgwuh63XXV0b4F/DFnZoeDGVG8n
	 xLGnNKwoPvLGYQslsUqI3+mH9OTMWDc9yID92Q6+0vHEHxgEJfLqS2gL1CeZpNWBMu
	 /iTStnYb1sPovMmFm7HU9sRvz6RpcbQCv/yq9inE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfL2RqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730997AbfL2RqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:46:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A222D207FF;
        Sun, 29 Dec 2019 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641562;
        bh=u9H7d1EB6Cl7G4ftfrANC02XwN66e+Nwp3ptfHOWEq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGk25XE8GYj9MC+W252gaGH0Mb/hnuG1uscf4vnjV3XDuongjI+RbjlvKGtJAA4Vc
         ltW9if7leeNSCjbpCt+1luP904mTV8HxfWaVsPUC2Cg8VHQ78NwlAb2lTXo685MySB
         vxGtKzMmyA74RgPIo8eggHhVCLifyNAT0ogH5Msg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 118/434] libbpf: Fix struct end padding in btf_dump
Date:   Sun, 29 Dec 2019 18:22:51 +0100
Message-Id: <20191229172709.523831060@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit b4099769f3321a8d258a47a8b4b9d278dad28a73 ]

Fix a case where explicit padding at the end of a struct is necessary
due to non-standart alignment requirements of fields (which BTF doesn't
capture explicitly).

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Reported-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20191008231009.2991130-2-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ede55fec3618..87f27e2664c5 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -876,7 +876,6 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	__u16 vlen = btf_vlen(t);
 
 	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
-	align = packed ? 1 : btf_align_of(d->btf, id);
 
 	btf_dump_printf(d, "%s%s%s {",
 			is_struct ? "struct" : "union",
@@ -906,6 +905,13 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 		btf_dump_printf(d, ";");
 	}
 
+	/* pad at the end, if necessary */
+	if (is_struct) {
+		align = packed ? 1 : btf_align_of(d->btf, id);
+		btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
+					  lvl + 1);
+	}
+
 	if (vlen)
 		btf_dump_printf(d, "\n");
 	btf_dump_printf(d, "%s}", pfx(lvl));
-- 
2.20.1



