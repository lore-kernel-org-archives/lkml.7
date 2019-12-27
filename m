Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E5C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8714420828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfL0MVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:21:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:38860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfL0MVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:21:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7DE2B285;
        Fri, 27 Dec 2019 12:21:48 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Rostecki <mrostecki@suse.de>
Subject: [PATCH bpf-next 0/2] bpftool/libbpf: Add probe for large INSN limit
Date:   Fri, 27 Dec 2019 12:06:03 +0100
Message-Id: <20191227110605.1757-1-mrostecki@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements a new BPF feature probe which checks for the
commit c04c0d2b968a ("bpf: increase complexity limit and maximum program
size"), which increases the maximum program size to 1M. It's based on
the similar check in Cilium, althogh Cilium is already aiming to use
bpftool checks and eventually drop all its custom checks.

Examples of outputs:

# bpftool feature probe
[...]
Scanning miscellaneous eBPF features...
Large complexity limit and maximum program size (1M) is available

# bpftool feature probe macros
[...]
/*** eBPF misc features ***/
#define HAVE_HAVE_LARGE_INSN_LIMIT

# bpftool feature probe -j | jq '.["misc"]'
{
  "have_large_insn_limit": true
}

Michal Rostecki (2):
  libbpf: Add probe for large INSN limit
  bpftool: Add misc secion and probe for large INSN limit

 tools/bpf/bpftool/feature.c   | 18 ++++++++++++++++++
 tools/lib/bpf/libbpf.h        |  1 +
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+)

-- 
2.16.4

