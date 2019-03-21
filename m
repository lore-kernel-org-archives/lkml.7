Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1E521925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194468;
	bh=FT1KrG7Y5gmzJ99Ufx11CRHIWoZqrU1fZ9xmwLiKbGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KSuF+Cxkz9KjefUQE43tCl90L4oaYdfd1MTB5U3repEVlJ3cLqYAH+t76DUC7RFpE
	 rn+htDkmnKWG59ueL2oW168bM4hD3+2khuHDhqrmcFTkqq5auW1m2MjNaKbmmuFvuF
	 d1S265L/7w+AhgPMCrtms96X+qdxSy8xHT8OEamQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfCUSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfCUSyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:25 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9095721917;
        Thu, 21 Mar 2019 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194464;
        bh=FT1KrG7Y5gmzJ99Ufx11CRHIWoZqrU1fZ9xmwLiKbGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gip4mC+xkGYnPnYr6p6ucszJCV3pEmnFbVnmrl8w+gpPaeKv/Z4BNXzXIBFI1P77t
         1paHucKbirT9dDQY0zInvVnL9iJA0z3vkoAPK1kIFMDeb5LtlOWFwMufwGL9cR2KpB
         LbRjTZB7l765PSneDXJNVAqtY5BUZ0RysO+3AKNE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 28/44] bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
Date:   Thu, 21 Mar 2019 15:51:26 -0300
Message-Id: <20190321185142.11441-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patches uses bpf_program__get_prog_info_linear() to simplify the
logic in prog.c do_dump().

Committer testing:

Before:

  # bpftool prog dump xlated id 208 > /tmp/dump.xlated.before
  # bpftool prog dump jited id 208 > /tmp/dump.jited.before
  # bpftool map dump id 107 > /tmp/map.dump.before

After:

  # ~acme/git/perf/tools/bpf/bpftool/bpftool map dump id 107 > /tmp/map.dump.after
  # ~acme/git/perf/tools/bpf/bpftool/bpftool prog dump xlated id 208 > /tmp/dump.xlated.after
  # ~acme/git/perf/tools/bpf/bpftool/bpftool prog dump jited id 208 > /tmp/dump.jited.after
  # diff -u /tmp/dump.xlated.before /tmp/dump.xlated.after
  # diff -u /tmp/dump.jited.before /tmp/dump.jited.after
  # diff -u /tmp/map.dump.before /tmp/map.dump.after
  # ~acme/git/perf/tools/bpf/bpftool/bpftool prog dump xlated id 208
     0: (bf) r6 = r1
     1: (85) call bpf_get_current_pid_tgid#80800
     2: (63) *(u32 *)(r10 -328) = r0
     3: (bf) r2 = r10
     4: (07) r2 += -328
     5: (18) r1 = map[id:107]
     7: (85) call __htab_map_lookup_elem#85680
     8: (15) if r0 == 0x0 goto pc+1
     9: (07) r0 += 56
    10: (b7) r7 = 0
    11: (55) if r0 != 0x0 goto pc+52
    12: (bf) r1 = r10
    13: (07) r1 += -328
    14: (b7) r2 = 64
    15: (bf) r3 = r6
    16: (85) call bpf_probe_read#-46848
    17: (bf) r2 = r10
    18: (07) r2 += -320
    19: (18) r1 = map[id:106]
    21: (07) r1 += 208
    22: (61) r0 = *(u32 *)(r2 +0)
    23: (35) if r0 >= 0x200 goto pc+3
    24: (67) r0 <<= 3
    25: (0f) r0 += r1
    26: (05) goto pc+1
    27: (b7) r0 = 0
    28: (15) if r0 == 0x0 goto pc+35
    29: (71) r1 = *(u8 *)(r0 +0)
    30: (15) if r1 == 0x0 goto pc+33
    31: (b7) r5 = 64
    32: (79) r1 = *(u64 *)(r10 -320)
    33: (15) if r1 == 0x2 goto pc+2
    34: (15) if r1 == 0x101 goto pc+3
    35: (55) if r1 != 0x15 goto pc+19
    36: (79) r3 = *(u64 *)(r6 +16)
    37: (05) goto pc+1
    38: (79) r3 = *(u64 *)(r6 +24)
    39: (15) if r3 == 0x0 goto pc+15
    40: (b7) r1 = 0
    41: (63) *(u32 *)(r10 -260) = r1
    42: (bf) r1 = r10
    43: (07) r1 += -256
    44: (b7) r2 = 256
    45: (85) call bpf_probe_read_str#-46704
    46: (b7) r5 = 328
    47: (63) *(u32 *)(r10 -264) = r0
    48: (bf) r1 = r0
    49: (67) r1 <<= 32
    50: (77) r1 >>= 32
    51: (25) if r1 > 0xff goto pc+3
    52: (07) r0 += 72
    53: (57) r0 &= 255
    54: (bf) r5 = r0
    55: (bf) r4 = r10
    56: (07) r4 += -328
    57: (bf) r1 = r6
    58: (18) r2 = map[id:105]
    60: (18) r3 = 0xffffffff
    62: (85) call bpf_perf_event_output_tp#-45104
    63: (bf) r7 = r0
    64: (bf) r0 = r7
    65: (95) exit
  #

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: kernel-team@fb.com
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-4-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/bpf/bpftool/prog.c | 266 +++++++++------------------------------
 1 file changed, 59 insertions(+), 207 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8ef80d65a474..d2be5a06c339 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -401,41 +401,31 @@ static int do_show(int argc, char **argv)
 
 static int do_dump(int argc, char **argv)
 {
-	unsigned int finfo_rec_size, linfo_rec_size, jited_linfo_rec_size;
-	void *func_info = NULL, *linfo = NULL, *jited_linfo = NULL;
-	unsigned int nr_finfo, nr_linfo = 0, nr_jited_linfo = 0;
+	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_linfo *prog_linfo = NULL;
-	unsigned long *func_ksyms = NULL;
-	struct bpf_prog_info info = {};
-	unsigned int *func_lens = NULL;
+	enum {DUMP_JITED, DUMP_XLATED} mode;
 	const char *disasm_opt = NULL;
-	unsigned int nr_func_ksyms;
-	unsigned int nr_func_lens;
+	struct bpf_prog_info *info;
 	struct dump_data dd = {};
-	__u32 len = sizeof(info);
+	void *func_info = NULL;
 	struct btf *btf = NULL;
-	unsigned int buf_size;
 	char *filepath = NULL;
 	bool opcodes = false;
 	bool visual = false;
 	char func_sig[1024];
 	unsigned char *buf;
 	bool linum = false;
-	__u32 *member_len;
-	__u64 *member_ptr;
+	__u32 member_len;
+	__u64 arrays;
 	ssize_t n;
-	int err;
 	int fd;
 
 	if (is_prefix(*argv, "jited")) {
 		if (disasm_init())
 			return -1;
-
-		member_len = &info.jited_prog_len;
-		member_ptr = &info.jited_prog_insns;
+		mode = DUMP_JITED;
 	} else if (is_prefix(*argv, "xlated")) {
-		member_len = &info.xlated_prog_len;
-		member_ptr = &info.xlated_prog_insns;
+		mode = DUMP_XLATED;
 	} else {
 		p_err("expected 'xlated' or 'jited', got: %s", *argv);
 		return -1;
@@ -474,175 +464,50 @@ static int do_dump(int argc, char **argv)
 		return -1;
 	}
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		return -1;
-	}
-
-	if (!*member_len) {
-		p_info("no instructions returned");
-		close(fd);
-		return 0;
-	}
+	if (mode == DUMP_JITED)
+		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
+	else
+		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
 
-	buf_size = *member_len;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
-	buf = malloc(buf_size);
-	if (!buf) {
-		p_err("mem alloc failed");
-		close(fd);
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	close(fd);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		p_err("can't get prog info: %s", strerror(errno));
 		return -1;
 	}
 
-	nr_func_ksyms = info.nr_jited_ksyms;
-	if (nr_func_ksyms) {
-		func_ksyms = malloc(nr_func_ksyms * sizeof(__u64));
-		if (!func_ksyms) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	nr_func_lens = info.nr_jited_func_lens;
-	if (nr_func_lens) {
-		func_lens = malloc(nr_func_lens * sizeof(__u32));
-		if (!func_lens) {
-			p_err("mem alloc failed");
-			close(fd);
+	info = &info_linear->info;
+	if (mode == DUMP_JITED) {
+		if (info->jited_prog_len == 0) {
+			p_info("no instructions returned");
 			goto err_free;
 		}
-	}
-
-	nr_finfo = info.nr_func_info;
-	finfo_rec_size = info.func_info_rec_size;
-	if (nr_finfo && finfo_rec_size) {
-		func_info = malloc(nr_finfo * finfo_rec_size);
-		if (!func_info) {
-			p_err("mem alloc failed");
-			close(fd);
+		buf = (unsigned char *)(info->jited_prog_insns);
+		member_len = info->jited_prog_len;
+	} else {	/* DUMP_XLATED */
+		if (info->xlated_prog_len == 0) {
+			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			goto err_free;
 		}
+		buf = (unsigned char *)info->xlated_prog_insns;
+		member_len = info->xlated_prog_len;
 	}
 
-	linfo_rec_size = info.line_info_rec_size;
-	if (info.nr_line_info && linfo_rec_size && info.btf_id) {
-		nr_linfo = info.nr_line_info;
-		linfo = malloc(nr_linfo * linfo_rec_size);
-		if (!linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	jited_linfo_rec_size = info.jited_line_info_rec_size;
-	if (info.nr_jited_line_info &&
-	    jited_linfo_rec_size &&
-	    info.nr_jited_ksyms &&
-	    info.nr_jited_func_lens &&
-	    info.btf_id) {
-		nr_jited_linfo = info.nr_jited_line_info;
-		jited_linfo = malloc(nr_jited_linfo * jited_linfo_rec_size);
-		if (!jited_linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	memset(&info, 0, sizeof(info));
-
-	*member_ptr = ptr_to_u64(buf);
-	*member_len = buf_size;
-	info.jited_ksyms = ptr_to_u64(func_ksyms);
-	info.nr_jited_ksyms = nr_func_ksyms;
-	info.jited_func_lens = ptr_to_u64(func_lens);
-	info.nr_jited_func_lens = nr_func_lens;
-	info.nr_func_info = nr_finfo;
-	info.func_info_rec_size = finfo_rec_size;
-	info.func_info = ptr_to_u64(func_info);
-	info.nr_line_info = nr_linfo;
-	info.line_info_rec_size = linfo_rec_size;
-	info.line_info = ptr_to_u64(linfo);
-	info.nr_jited_line_info = nr_jited_linfo;
-	info.jited_line_info_rec_size = jited_linfo_rec_size;
-	info.jited_line_info = ptr_to_u64(jited_linfo);
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	close(fd);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		goto err_free;
-	}
-
-	if (*member_len > buf_size) {
-		p_err("too many instructions returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_ksyms > nr_func_ksyms) {
-		p_err("too many addresses returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_func_lens > nr_func_lens) {
-		p_err("too many values returned");
-		goto err_free;
-	}
-
-	if (info.nr_func_info != nr_finfo) {
-		p_err("incorrect nr_func_info %d vs. expected %d",
-		      info.nr_func_info, nr_finfo);
-		goto err_free;
-	}
-
-	if (info.func_info_rec_size != finfo_rec_size) {
-		p_err("incorrect func_info_rec_size %d vs. expected %d",
-		      info.func_info_rec_size, finfo_rec_size);
-		goto err_free;
-	}
-
-	if (linfo && info.nr_line_info != nr_linfo) {
-		p_err("incorrect nr_line_info %u vs. expected %u",
-		      info.nr_line_info, nr_linfo);
-		goto err_free;
-	}
-
-	if (info.line_info_rec_size != linfo_rec_size) {
-		p_err("incorrect line_info_rec_size %u vs. expected %u",
-		      info.line_info_rec_size, linfo_rec_size);
-		goto err_free;
-	}
-
-	if (jited_linfo && info.nr_jited_line_info != nr_jited_linfo) {
-		p_err("incorrect nr_jited_line_info %u vs. expected %u",
-		      info.nr_jited_line_info, nr_jited_linfo);
-		goto err_free;
-	}
-
-	if (info.jited_line_info_rec_size != jited_linfo_rec_size) {
-		p_err("incorrect jited_line_info_rec_size %u vs. expected %u",
-		      info.jited_line_info_rec_size, jited_linfo_rec_size);
-		goto err_free;
-	}
-
-	if ((member_len == &info.jited_prog_len &&
-	     info.jited_prog_insns == 0) ||
-	    (member_len == &info.xlated_prog_len &&
-	     info.xlated_prog_insns == 0)) {
-		p_err("error retrieving insn dump: kernel.kptr_restrict set?");
-		goto err_free;
-	}
-
-	if (info.btf_id && btf__get_from_id(info.btf_id, &btf)) {
+	if (info->btf_id && btf__get_from_id(info->btf_id, &btf)) {
 		p_err("failed to get btf");
 		goto err_free;
 	}
 
-	if (nr_linfo) {
-		prog_linfo = bpf_prog_linfo__new(&info);
+	func_info = (void *)info->func_info;
+
+	if (info->nr_line_info) {
+		prog_linfo = bpf_prog_linfo__new(info);
 		if (!prog_linfo)
 			p_info("error in processing bpf_line_info.  continue without it.");
 	}
@@ -655,9 +520,9 @@ static int do_dump(int argc, char **argv)
 			goto err_free;
 		}
 
-		n = write(fd, buf, *member_len);
+		n = write(fd, buf, member_len);
 		close(fd);
-		if (n != *member_len) {
+		if (n != member_len) {
 			p_err("error writing output file: %s",
 			      n < 0 ? strerror(errno) : "short write");
 			goto err_free;
@@ -665,19 +530,19 @@ static int do_dump(int argc, char **argv)
 
 		if (json_output)
 			jsonw_null(json_wtr);
-	} else if (member_len == &info.jited_prog_len) {
+	} else if (mode == DUMP_JITED) {
 		const char *name = NULL;
 
-		if (info.ifindex) {
-			name = ifindex_to_bfd_params(info.ifindex,
-						     info.netns_dev,
-						     info.netns_ino,
+		if (info->ifindex) {
+			name = ifindex_to_bfd_params(info->ifindex,
+						     info->netns_dev,
+						     info->netns_ino,
 						     &disasm_opt);
 			if (!name)
 				goto err_free;
 		}
 
-		if (info.nr_jited_func_lens && info.jited_func_lens) {
+		if (info->nr_jited_func_lens && info->jited_func_lens) {
 			struct kernel_sym *sym = NULL;
 			struct bpf_func_info *record;
 			char sym_name[SYM_MAX_NAME];
@@ -685,17 +550,16 @@ static int do_dump(int argc, char **argv)
 			__u64 *ksyms = NULL;
 			__u32 *lens;
 			__u32 i;
-
-			if (info.nr_jited_ksyms) {
+			if (info->nr_jited_ksyms) {
 				kernel_syms_load(&dd);
-				ksyms = (__u64 *) info.jited_ksyms;
+				ksyms = (__u64 *) info->jited_ksyms;
 			}
 
 			if (json_output)
 				jsonw_start_array(json_wtr);
 
-			lens = (__u32 *) info.jited_func_lens;
-			for (i = 0; i < info.nr_jited_func_lens; i++) {
+			lens = (__u32 *) info->jited_func_lens;
+			for (i = 0; i < info->nr_jited_func_lens; i++) {
 				if (ksyms) {
 					sym = kernel_syms_search(&dd, ksyms[i]);
 					if (sym)
@@ -707,7 +571,7 @@ static int do_dump(int argc, char **argv)
 				}
 
 				if (func_info) {
-					record = func_info + i * finfo_rec_size;
+					record = func_info + i * info->func_info_rec_size;
 					btf_dumper_type_only(btf, record->type_id,
 							     func_sig,
 							     sizeof(func_sig));
@@ -744,49 +608,37 @@ static int do_dump(int argc, char **argv)
 			if (json_output)
 				jsonw_end_array(json_wtr);
 		} else {
-			disasm_print_insn(buf, *member_len, opcodes, name,
+			disasm_print_insn(buf, member_len, opcodes, name,
 					  disasm_opt, btf, NULL, 0, 0, false);
 		}
 	} else if (visual) {
 		if (json_output)
 			jsonw_null(json_wtr);
 		else
-			dump_xlated_cfg(buf, *member_len);
+			dump_xlated_cfg(buf, member_len);
 	} else {
 		kernel_syms_load(&dd);
-		dd.nr_jited_ksyms = info.nr_jited_ksyms;
-		dd.jited_ksyms = (__u64 *) info.jited_ksyms;
+		dd.nr_jited_ksyms = info->nr_jited_ksyms;
+		dd.jited_ksyms = (__u64 *) info->jited_ksyms;
 		dd.btf = btf;
 		dd.func_info = func_info;
-		dd.finfo_rec_size = finfo_rec_size;
+		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
 
 		if (json_output)
-			dump_xlated_json(&dd, buf, *member_len, opcodes,
+			dump_xlated_json(&dd, buf, member_len, opcodes,
 					 linum);
 		else
-			dump_xlated_plain(&dd, buf, *member_len, opcodes,
+			dump_xlated_plain(&dd, buf, member_len, opcodes,
 					  linum);
 		kernel_syms_destroy(&dd);
 	}
 
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return 0;
 
 err_free:
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return -1;
 }
 
-- 
2.20.1

