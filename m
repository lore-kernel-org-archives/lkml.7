Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53403C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6420836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEpvcY3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLJSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:15:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726771AbfLJSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576001728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ftqvNo8ypX13fdqkDhRy1P9Zlg2BDYcnsvRebm2MCU=;
        b=NEpvcY3ScU/ZGOvfeNBYgFvYwQ+JoyG5Cg7wsrlGkEWTazeYOYijL24pFu1lHpRcRIg5kA
        GRDVJoUBa3vqOqTSrgxbvtWsK7tacppzYT+6hPjJyDdds5yq9xjDAKfCMmRPXfyPQ3Q7Lu
        kRD2xjlMnUVQ8ounsGx0TUdHqIVGphg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-aUYJOLWRP3aZ1w0GTIi_YQ-1; Tue, 10 Dec 2019 13:15:27 -0500
Received: by mail-lf1-f70.google.com with SMTP id t8so1255519lfc.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qaJ0iPUZiPGrRKD6KWzbbPQ9tBJQ6ZNwk2N/6zRMJM=;
        b=av6RQvmg6EQ3ws30j5ourRyvctMKLmw9oca4/4JOCoC9IWle4agXWms25XixPTpygQ
         +m9/6nZFBlaZMME5NUUljn9ApWzhdrp+ARMqhDzQriukrq8/4jpeYGOE74TDbrAirzyj
         OSx72DGyt4sZ9tYbMDG4wsljA/U0SLpg2vZxgC+FHMIEnH08Gv2oi+Spp2DHivYATY1V
         wnRbfibGT1ESLKryuquvJq2Ugluui/VAT2JcaQmVLuGIUf6YMKKZtXL+8N9L8dJpRD4x
         qAKPHhuxtmV0drSx5Z9DrgJY1TcXvbw3Nzsz9NRIQkZQ7MQVlHj209NNEBL1n/5qiOre
         z6fA==
X-Gm-Message-State: APjAAAWwj8UbcauewuxjCu57iKu4qvB3iwkaHSB43uWVJbwEX8k3S0wc
        IzkjysDA8FFij51FIbVHTZsaajL3R8x96MKEilGfLz154PILONGX/Kvd0snFNcrdCOOlqtsIkeD
        2+QIoY75G1Ims44/YQ52zRpJQ
X-Received: by 2002:ac2:4436:: with SMTP id w22mr19862846lfl.185.1576001725607;
        Tue, 10 Dec 2019 10:15:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrZAMkKrVX2Pa/3z0mzalv4YSJ1qSkcLpsPezdGIOVxK4wQI2LAemEsfEq3IDhQEOyoph9fw==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr19862840lfl.185.1576001725439;
        Tue, 10 Dec 2019 10:15:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b63sm1618343lfg.79.2019.12.10.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:15:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE1FA181AC8; Tue, 10 Dec 2019 19:15:23 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
Date:   Tue, 10 Dec 2019 19:14:12 +0100
Message-Id: <20191210181412.151226-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: aUYJOLWRP3aZ1w0GTIi_YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kptr_restrict sysctl is set, the kernel can fail to return
jited_ksyms or jited_prog_insns, but still have positive values in
nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when trying
to dump the program because it only checks the len fields not the actual
pointers to the instructions and ksyms.

Fix this by adding the missing checks.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
v2:
  - The sysctl causing this is kptr_restrict, not bpf_jit_harden; update co=
mmit
    msg to get this right (Martin).

 tools/bpf/bpftool/prog.c          | 2 +-
 tools/bpf/bpftool/xlated_dumper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 4535c863d2cd..2ce9c5ba1934 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -493,7 +493,7 @@ static int do_dump(int argc, char **argv)
=20
 =09info =3D &info_linear->info;
 =09if (mode =3D=3D DUMP_JITED) {
-=09=09if (info->jited_prog_len =3D=3D 0) {
+=09=09if (info->jited_prog_len =3D=3D 0 || !info->jited_prog_insns) {
 =09=09=09p_info("no instructions returned");
 =09=09=09goto err_free;
 =09=09}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_d=
umper.c
index 494d7ae3614d..5b91ee65a080 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -174,7 +174,7 @@ static const char *print_call(void *private_data,
 =09struct kernel_sym *sym;
=20
 =09if (insn->src_reg =3D=3D BPF_PSEUDO_CALL &&
-=09    (__u32) insn->imm < dd->nr_jited_ksyms)
+=09    (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
 =09=09address =3D dd->jited_ksyms[insn->imm];
=20
 =09sym =3D kernel_syms_search(dd, address);
--=20
2.24.0

