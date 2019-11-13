Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B3C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2B21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qv+QCjhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKMMvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:51:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726195AbfKMMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573649480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AEYP6d5aalZAfcFv0NrW7o6lXGeRFq/9ZDlpjwAiWdQ=;
        b=Qv+QCjhnD0UYP1bY+Kn48W8Oq7s9S8TJhyjSW1zZuujL9TXIx9/zIIG+waOwfzar/822JM
        KYJHDl19bNL5B5XRx32Z1tO5s4pURIIQWDnXimGAwxXD6ljIKzPHlz3YSYd7ZfPtfqYl7/
        pu1ZYZNjyxIEYkbfn3qmvIC7qwLlN6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-m0dnMIFPMLKZywH4aiBcjw-1; Wed, 13 Nov 2019 07:51:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id l184so1311951wmf.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=miLVHytVLBaZY4qRF4Hh54R/kGdync3E1wgmyFgh4so=;
        b=ACSDAy8Ezg44yQ4rPJmx4HTezRugrbcTLubp3vVvrXmSkCBYTT0jDkp84g1LFgv/fs
         O1F77MnBc3B1M71REMguFbMBOfcD8rIlOA4NFrQUlv4ZuYSmxJD9SyMLirfwz/zvGev8
         7C7WVd6qyqCW5VhuwcvQCm+Z7jxnGjQAVkq7cdh7scP6R0oylFnNvxA9/SEGtDx0M+Wk
         I6YrxF19Wo46VLP17DsVuTMNrADbCNx8x++Q1k256GWs0OxkbvXfC8tSFRzCpGJLhSOs
         eHMOdQlynNe3d90P/tCrgafZKud6O+2PO3Rudy6gNDHLnIR47V7T6MEv1dxwdJHb/hc6
         BjHw==
X-Gm-Message-State: APjAAAXznjxfLY8aH9Y2a6bfecfnWLwKkzx54rfVt4nNlcE7xa6CQi5W
        kOe9WSG03JT8yGKpL7fHRUkM7IdBBxJVJOlPZ6ltwwxhD9N9Ir610XJKAdUD8m3eGs1yZx5yAUc
        U9PwW6pR7YFzJ0eeOdc0+Wf7i
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr2582107wrj.391.1573649477835;
        Wed, 13 Nov 2019 04:51:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqi8MVjGYsZE1Fd2uuOZsh+3k4ruvI3QhtSRwtPfnv/LsKOAMb2NX00BIk78fbl0gKHRqQHQ==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr2582087wrj.391.1573649477582;
        Wed, 13 Nov 2019 04:51:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u26sm2207436wmj.9.2019.11.13.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 04:51:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] selftests: kvm: fix build with glibc >= 2.30
Date:   Wed, 13 Nov 2019 13:51:15 +0100
Message-Id: <20191113125115.23100-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-MC-Unique: m0dnMIFPMLKZywH4aiBcjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glibc-2.30 gained gettid() wrapper, selftests fail to compile:

lib/assert.c:58:14: error: static declaration of =E2=80=98gettid=E2=80=99 f=
ollows non-static declaration
   58 | static pid_t gettid(void)
      |              ^~~~~~
In file included from /usr/include/unistd.h:1170,
                 from include/test_util.h:18,
                 from lib/assert.c:10:
/usr/include/bits/unistd_ext.h:34:16: note: previous declaration of =E2=80=
=98gettid=E2=80=99 was here
   34 | extern __pid_t gettid (void) __THROW;
      |                ^~~~~~

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selft=
ests/kvm/lib/assert.c
index 4911fc77d0f6..d1cf9f6e0e6b 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -55,7 +55,7 @@ static void test_dump_stack(void)
 #pragma GCC diagnostic pop
 }
=20
-static pid_t gettid(void)
+static pid_t _gettid(void)
 {
 =09return syscall(SYS_gettid);
 }
@@ -72,7 +72,7 @@ test_assert(bool exp, const char *exp_str,
 =09=09fprintf(stderr, "=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D\n"
 =09=09=09"  %s:%u: %s\n"
 =09=09=09"  pid=3D%d tid=3D%d - %s\n",
-=09=09=09file, line, exp_str, getpid(), gettid(),
+=09=09=09file, line, exp_str, getpid(), _gettid(),
 =09=09=09strerror(errno));
 =09=09test_dump_stack();
 =09=09if (fmt) {
--=20
2.20.1

