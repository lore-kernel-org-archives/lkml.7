Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC06C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993120862
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690578;
	bh=KABP8G34TqP7Zl5QtygGjNflA89Swv81ud7jlVBonyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVLLz0siEmumriC1/WruYrvd9v5jLSIj+AdGMHhmGm5soP/JJZxEjkgIqdIlqh6Ph
	 HXEQHlrVjM+z7x/Ngr8Lt2bUsmVejKb3Hnes9M850ZjwHbCH06ai9FzWEkThdGyqES
	 MIpZiU7guub9P6ZUhftzoCzILRIJtb3UDD/G+2hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFDXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfFDXW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB25420859;
        Tue,  4 Jun 2019 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690575;
        bh=KABP8G34TqP7Zl5QtygGjNflA89Swv81ud7jlVBonyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AG3/dWVLBjnhjyJbrukASpyq5nxumxPoTpIefAHHG2mTXqnPYG8+wLIXqDeeUtJLR
         +Uh72128WD0p3Bwy6mT+ZyLaiWr8zxamjkgW1Kz7lLIQDGfnX1T4gYUDDpXl3zbwc4
         97HJZDIiKOMEcku7ZA42TZenLtS1boIb/RAKKPXE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 26/60] tools/bpftool: move set_max_rlimit() before __bpf_object__open_xattr()
Date:   Tue,  4 Jun 2019 19:21:36 -0400
Message-Id: <20190604232212.6753-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit ac4e0e055fee5751c78bba1fc9ce508a6874d916 ]

For a host which has a lower rlimit for max locked memory (e.g., 64KB),
the following error occurs in one of our production systems:
  # /usr/sbin/bpftool prog load /paragon/pods/52877437/home/mark.o \
    /sys/fs/bpf/paragon_mark_21 type cgroup/skb \
    map idx 0 pinned /sys/fs/bpf/paragon_map_21
  libbpf: Error in bpf_object__probe_name():Operation not permitted(1).
    Couldn't load basic 'r0 = 0' BPF program.
  Error: failed to open object file

The reason is due to low locked memory during bpf_object__probe_name()
which probes whether program name is supported in kernel or not
during __bpf_object__open_xattr().

bpftool program load already tries to relax mlock rlimit before
bpf_object__load(). Let us move set_max_rlimit() before
__bpf_object__open_xattr(), which fixed the issue here.

Fixes: 47eff61777c7 ("bpf, libbpf: introduce bpf_object__probe_caps to test BPF capabilities")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d2be5a06c339..ed8ef5c82256 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -873,6 +873,8 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 	}
 
+	set_max_rlimit();
+
 	obj = __bpf_object__open_xattr(&attr, bpf_flags);
 	if (IS_ERR_OR_NULL(obj)) {
 		p_err("failed to open object file");
@@ -952,8 +954,6 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	set_max_rlimit();
-
 	err = bpf_object__load(obj);
 	if (err) {
 		p_err("failed to load object file");
-- 
2.20.1

