Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26752C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D92053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkUaCWUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfJARhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:37:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54180 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfJARhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:37:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so10756911pfr.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N9RFaaUyKsxWingVv0Hbs7K3osgkOr8SsFI9Tp5Z20k=;
        b=pkUaCWUsUNn5GOGIGsw9ewd3WuO5fY7ACvpKIOrqGyJIGOpRMoiSevDRoraYlU3g1E
         MRQok2xDgzcgI/rR/T5km2Yh4E9uF2eul+yE6YGP9ayIfhNL40yFgBmiJU0Vre7wkx/m
         J8bSPFKjN3JqL5FJ2V7Iqq7fL1qCfDYM6rXNgdNXU5/uekhj5e/DizKb7wzQtZhqvjgP
         +iRdatoeZwIjcN5DI5ClBFP7tc6oCcFI1Pws3TfQ3tBJEvM6iWD3qeWJCoMRUvSj2aqC
         Y1WKkR8aHva576d8/Yuys12+opTnZ4IJSPGffybI3W7ot7aQoZFS0AYOq1b73DtAPkVQ
         f+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9RFaaUyKsxWingVv0Hbs7K3osgkOr8SsFI9Tp5Z20k=;
        b=LAiONaPRqfY+Ik0gJPyVZdwQZ7h26DIo4IaG4IZdN4M2EkvpgL5HuddsydlJ3412Ou
         dv0jojB629O0fd/eON22hY8rs2Z/kdOvddHp0T1tmsfz43zrenQBVKM2hetXZPP11Y7c
         7259JYxfqyeCvWPFbktmRQVguTUbaJUU6hy35cFsETbWW539hhrVFMf8M2xodH2P+QUd
         2Yg1EUbMmFgJ7Yvi4FIoASt6pyGe7O4/AVgQOw02HDX5duXZ8LCenLHRkO/bXtccVWgd
         frmDDBULVG29WNRAKAeM1nRaWC3GiTC2jc3AP6d11MIujmJbINiuoQI6f4p1+egB4KwX
         bZPg==
X-Gm-Message-State: APjAAAVL/31MSqw9h80uemGVxWqQ/t6rO6vdAytzsMhWieY3c1nxRkM8
        ZN1YrfscvrRkRYgTVqAEVfB8efO0Mk1u
X-Google-Smtp-Source: APXvYqzVpPUbmcD+5G95ld1l74Kl0q1JKw4guiKi0Cn9su/VfVfZUXHpnnxGewNd71ggaNYtdoEFjanI20ey
X-Received: by 2002:a63:d30f:: with SMTP id b15mr30940913pgg.341.1569951470992;
 Tue, 01 Oct 2019 10:37:50 -0700 (PDT)
Date:   Tue,  1 Oct 2019 10:37:27 -0700
In-Reply-To: <20191001173728.149786-1-brianvv@google.com>
Message-Id: <20191001173728.149786-2-brianvv@google.com>
Mime-Version: 1.0
References: <20191001173728.149786-1-brianvv@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf 1/2] selftests/bpf: test_progs: don't leak server_fd in tcp_rtt
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

server_fd needs to be closed if pthread can't be created.

Fixes: 8a03222f508b ("selftests/bpf: test_progs: fix client/server race
in tcp_rtt")
Cc: Stanislav Fomichev <sdf@google.com>

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index a82da555b1b02..f4cd60d6fba2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -260,13 +260,14 @@ void test_tcp_rtt(void)
 
 	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
 				      (void *)&server_fd)))
-		goto close_cgroup_fd;
+		goto close_server_fd;
 
 	pthread_mutex_lock(&server_started_mtx);
 	pthread_cond_wait(&server_started, &server_started_mtx);
 	pthread_mutex_unlock(&server_started_mtx);
 
 	CHECK_FAIL(run_test(cgroup_fd, server_fd));
+close_server_fd:
 	close(server_fd);
 close_cgroup_fd:
 	close(cgroup_fd);
-- 
2.23.0.444.g18eeb5a265-goog

