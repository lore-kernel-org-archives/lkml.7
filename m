Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AA2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54845206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTngCim1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfLCSCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:02:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbfLCSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575396158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z8dvj8kFmh1WTx80eOyUxkbJrCOExfJvvib0F9ZPfMU=;
        b=ZTngCim1Bz3vrw5ADjpqw7ggNk1Td+N6PBWY+iOGyjiSkMI0dlm3Fph3CwcDNiHZWRXyUv
        Hm/dzd4qjWvCZVrUP+ULji6vhU6sZcq3aSsqs5+yLNPa5pbqRu5Mv00WrYwmCKEl+Qwyp4
        73pkZxFzbJej5N/8v/5SlWZNEltnUL8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-kamc6gMAOOqYEfAnLEnESQ-1; Tue, 03 Dec 2019 13:02:37 -0500
Received: by mail-qt1-f198.google.com with SMTP id l25so3035690qtu.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7TyUK75z3gSeLUezvvwUSnOgAhmrIYgUPpNpgpDgb/A=;
        b=KCJqpaUJ79ScokhKHlP8EtpUAwOWibIgr2RcZYNqjmOoz/w2YetnnuCISw56NDYg9N
         /eTJdezLQtnh7o+4ASN96saa5UR9kasVoF7vOPEeMiLLNRKCi84gKJ3JuI0NVmqllD8w
         MoNKdg4cF0pc0VaDKH3c4tlAPVgcOwXXc8YY3NouojTqoEAQmqpQ0iIEktZf2UTLwfT2
         gWesGPHpD8RqOK304G3zcVLpKGxQZbvxxBydr4G/TEQuCCMCo8bYGZtMyesl7FzCFJjB
         iBTC+1p7/7KWdKNx7cOjbydFJJciMPvk7A6+EKx2AXMHB7ajDImY+kh1i/h2HYHtLcBR
         hAVA==
X-Gm-Message-State: APjAAAX4aUh4u7WCtCeu7IBHnq06Q6tpdwcDmNg8UyTh+7qVXjyGPZrc
        OLh+O8Zhg8/RueVmOgGKZDGWoDiY1zQXx9YzFAUD+gWe0aQsIG6vuHOr8cegWxHdH9P7c4yqLSt
        LAUJLLAEo9TZ4+dd62G3zkDzN
X-Received: by 2002:ac8:1115:: with SMTP id c21mr6493955qtj.188.1575396157421;
        Tue, 03 Dec 2019 10:02:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeqJaFIBrZ30jZk5bPBbxSJFnLjWUZJiKiIsonvJtQscGcJ6gku6hv8gFC2ZVATffWY87t0g==
X-Received: by 2002:ac8:1115:: with SMTP id c21mr6493931qtj.188.1575396157239;
        Tue, 03 Dec 2019 10:02:37 -0800 (PST)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g18sm2119167qkm.112.2019.12.03.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:02:35 -0800 (PST)
From:   trix@redhat.com
To:     ebiederm@xmission.com, christian.brauner@ubuntu.com, arnd@arndb.de,
        akpm@linux-foundation.org, guro@fb.com, deepa.kernel@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH] signal: move print_dropped_signal
Date:   Tue,  3 Dec 2019 10:02:21 -0800
Message-Id: <20191203180221.7038-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
X-MC-Unique: kamc6gMAOOqYEfAnLEnESQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If the allocation of 'q' fails, the signal will be dropped.
To ensure that this is reported, move print_dropped_signal to be
inside the '(q =3D=3D NULL)' if-check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index bcd46f547db3..294a4625200e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -427,11 +427,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_=
t flags, int override_rlimi
 =09    atomic_read(&user->sigpending) <=3D
 =09=09=09task_rlimit(t, RLIMIT_SIGPENDING)) {
 =09=09q =3D kmem_cache_alloc(sigqueue_cachep, flags);
-=09} else {
-=09=09print_dropped_signal(sig);
 =09}
=20
 =09if (unlikely(q =3D=3D NULL)) {
+=09=09print_dropped_signal(sig);
 =09=09atomic_dec(&user->sigpending);
 =09=09free_uid(user);
 =09} else {
--=20
2.18.1

