Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB69C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B7A21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjHJgVde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439382AbfJYL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:29:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438379AbfJYL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I33B+0F6drNe2DO1ImWZrj95FAKHCL4hyPcaly3kasA=;
        b=RjHJgVdeoZqBNgfJFU0FQcr/g3cNGFS3xEn95OYh1qd4ToizDJYfKTLE/B2DCqLzNutVKR
        74bVg0KLyYikFKblm18BumWhFHM1RBicaT/QGJrVDU0TAldDujIVWU0vW0Xc5YvzZwp4dA
        ZhIvaRi4yIrCARwH/8Ts0+hozfe3U7g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-ikXUQY0AO_OQCuEfpsu3iw-1; Fri, 25 Oct 2019 07:29:23 -0400
Received: by mail-wr1-f69.google.com with SMTP id k10so914024wrl.22
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8l72uHGzG6m6K3/bpmVJ/Qpjsjtmq+Lqod9QQYQlTc=;
        b=Sq8S+xxlpDczB173X6rj2JWcXqtIxHVC+N1U3cPT6/OeYjiShb/MS9VCB2NBGARkQJ
         7sZ7bJAZc+qmoEWYcDXCMJjyqmn05zV6QLSnvQ0OlArjk0wSK+Gsx/UBvl6QFerlGqVo
         gcekDCwPquZY9BJlF4176eQi0eJs0TetPGz54PIpsoIYmtYc5AuBtDuo0kCpRhurYh7h
         68pPJWanKx5EBLiHMhUU7TmTNmQDMq7Kny7CawFv9mJDshV/tIqzcm3OPt+UeklT+ou2
         enlH14x/BQbU0H3ronvnttKdUgSRSY2qtdBaTBIg/m1hP4a796E8zljANSfGEB8FzS9d
         XMjA==
X-Gm-Message-State: APjAAAUjKhl4s1XgfEMcOgn/ieOfPYXq4A79oQ2HerckK8Jfh+RdsJty
        MX11Vuh8MpVi/jvZUf3vM+07xAe9pR+Tx8BaVKStxU4wAourbMs62wIKLX2eKFICmZl63fpLJxt
        PccoTzXlhHfyoQ4yrZBvq4kp5
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525705wrw.280.1572002961875;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPpQGXTNJrxLkgVezHj1T1jGuquL8GQd5mEOwUp11MWfS05ZJe9b8tNYouTGJhnrGVK8HvrQ==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525688wrw.280.1572002961667;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] ovl: document permission model
Date:   Fri, 25 Oct 2019 13:29:13 +0200
Message-Id: <20191025112917.22518-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ikXUQY0AO_OQCuEfpsu3iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing piece of documentation regarding how permissions are checked in
overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesy=
stems/overlayfs.txt
index 845d689e0fd7..674fc8b1e420 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -246,6 +246,50 @@ overlay filesystem (though an operation on the name of=
 the file such as
 rename or unlink will of course be noticed and handled).
=20
=20
+Permission model
+----------------
+
+Permission checking in the overlay filesystem follows these principles:
+
+ 1) permission check SHOULD return the same result before and after copy u=
p
+
+ 2) task creating the overlay mount MUST NOT gain additional privileges
+
+ 3) non-mounting task MAY gain additional privileges through the overlay,
+ compared to direct access on underlying lower or upper filesystems
+
+This is achieved by performing two permission checks on each access
+
+ a) check if current task is allowed access based on local DAC (owner,
+    group, mode and posix acl), as well as MAC checks
+
+ b) check if mounting task would be allowed real operation on lower or
+    upper layer based on underlying filesystem permissions, again includin=
g
+    MAC checks
+
+Check (a) ensures consistency (1) since owner, group, mode and posix acls
+are copied up.  On the other hand it can result in server enforced
+permissions (used by NFS, for example) being ignored (3).
+
+Check (b) ensures that no task gains permissions to underlying layers that
+the mounting task does not have (2).  This also means that it is possible
+to create setups where the consistency rule (1) does not hold; normally,
+however, the mounting task will have sufficient privileges to perform all
+operations.
+
+Another way to demonstrate this model is drawing parallels between
+
+  mount -t overlay overlay -olowerdir=3D/lower,upperdir=3D/upper,... /merg=
ed
+
+and
+
+  cp -a /lower /upper
+  mount --bind /upper /merged
+
+The resulting access permissions should be the same.  The difference is in
+the time of copy (on-demand vs. up-front).
+
+
 Multiple lower layers
 ---------------------
=20
--=20
2.21.0

