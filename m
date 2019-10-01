Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B80C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB42053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKLc4BdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfJARhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:37:46 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35784 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfJARhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:37:46 -0400
Received: by mail-pf1-f202.google.com with SMTP id r7so10780181pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3+w4QsZSJoLh853gBsFQX1yVGVE86OfZ0POYrmn9pHU=;
        b=EKLc4BdVvrOA881KZYHEn6ikBQGKo5TVuNhmnxKpZVyWpOn45UQ6LoQyiOxOx7L3hC
         mS3/3bAje8xM3gD1wCAsNpKY5mjWKNa/VF3Qz1Bo8Ds0b7JImYv9gPI1wlbKmTMvRO+D
         ZOOOMgU9Oxd/GpCEXArPBkf0RpH8/sef+NwED+gM8hTMZjtfLkPqU+AJ5jK6GwGQlksn
         2GoKJ8aD5hc1j3KTNEpy8xco2s657h+8msI8UttOH5kixwSEtJongK3rMLvzD7Bi2Hv1
         UKNLkTc9jNHtufNJdVoQbvS/KncrjsHzpTe/cFiSCYGEtTsz7GXG1ktsrtxbWC6kIT/8
         mAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3+w4QsZSJoLh853gBsFQX1yVGVE86OfZ0POYrmn9pHU=;
        b=PLK/DTEkRut+2ZUty/qgO2RVVG7WS/7LRYZypA/uY55e0y3hdxTnYnjj/1O8sbNoAg
         ABw8gOG4OwcvXgwAaoO1hp13mVG9N7sCWOTdRXYz0oWeZoR9m8zRSrhETXd8HT2zelPf
         MsKRUNpxmPwRzwtOpklvZLDNT+5LQDvo7f0qImaljLlP/SJNS35UuWycnswgVnPonpuS
         r41N/wt9Rx960UWlVtzNQ5RS+8iGbJz6Yyo4t6VScocX9nLeEOqOcbQ4l5T5zzbYs90E
         nbIVGJCLzgF8noG1q/L62M5SCAzkfXYozDfQdh51yjOCpKG4r3r86iE2IdAsCqnMA/0M
         NC2w==
X-Gm-Message-State: APjAAAV5z+b+n4eZYI3bpb21qbSFinA+IRC6X7fL42BxmsYRQQXj+zoG
        FfTWyCzCHP+3tkot+GSdQXlOrHYBoQ6z
X-Google-Smtp-Source: APXvYqzh7leVxFKHdDQPmZYu3Us5x9qMqvVeWemq0AVPn1urC7cQbYSuTPtSo0OyKCw3z1h198Q2hecUAQG9
X-Received: by 2002:a63:4924:: with SMTP id w36mr15608050pga.113.1569951463622;
 Tue, 01 Oct 2019 10:37:43 -0700 (PDT)
Date:   Tue,  1 Oct 2019 10:37:26 -0700
Message-Id: <20191001173728.149786-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf 0/2] selftests/bpf: test_progs: don't leak fd in bpf
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

This patch series fixes some fd leaks in tcp_rtt and
test_sockopt_inherit bpf prof_tests.

Brian Vazquez (2):
  selftests/bpf: test_progs: don't leak server_fd in tcp_rtt
  selftests/bpf: test_progs: don't leak server_fd in
    test_sockopt_inherit

 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.23.0.444.g18eeb5a265-goog

