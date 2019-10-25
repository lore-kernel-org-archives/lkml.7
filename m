Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA9CA9EBE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC4D22468
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d48BzWsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439691AbfJYL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:29:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439522AbfJYL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uL6B8L1AUAy/UiZQvA9Cim16okzyI5YnHL1NCMV9QY=;
        b=d48BzWsHTqzy6ckzTzBbMxSAWuiaf0vrm54/BJ+yFoz01vYCeWp/H98Dvl+LkpRlisLH0F
        5M9h2gs1ga82BVUljLdXT9AAxbFSzKLMTvLjlyJiiUN2Gu7fW0mlGKrmRuf3iS7nEQtqzY
        q0vMq3B0TSPjwDhtDBXk0M34HNPELG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-gql4jOGdMU6fVGp2id9bSA-1; Fri, 25 Oct 2019 07:29:27 -0400
Received: by mail-wr1-f71.google.com with SMTP id e14so912718wrm.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a/jvPs2SyoieuY5sUx5bSduqfiYAGGvkqIa6LCkCRY=;
        b=BikOp1uXl6f4XGwBjxLqVkQfLFXUqBodPFyjcf3o3Cf4/Enkzs8bLfNAr9B1EptZGO
         XFdLK5uPrL/WPMVR0JfVnouOib6xg+Oft0/EfWrdC7H93w2jH1XZGvLAnRnl9hyYxbpu
         muFmz4y5nWZq5PWAMHD9Z/NimZCRTW+mD4nTZ1R7J8CHnIvSCL14pUz/tLFji6/SNE7v
         SrliLsUJoWRJlRFF4BFp0jEtE/ATf6JXEEdj9fArlhfUG4aFU1nT/4Xl2UdXc8p75mbI
         W/MQ/uDSn2sRxyW4E6G5M62fEP9zw8P78sDV+xGcMHqvArtFnTbYJuvi3u0jDhA+3kNY
         mFxQ==
X-Gm-Message-State: APjAAAWwDjVzc6fOtcXZrwNDy+q2PsPNuI3FS1SY5eiGf20UxMJ6IaBb
        jlRo4nhKHAopdy9D0koEeQDQcmh2wDHDtoHrsbsRrJ8wSnOFrCStwBhPVD3LnGr+KQnfwZOsOV4
        tfoSsuYclCN7qvR3trNmK5GMi
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518269wrn.303.1572002965917;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvfPJJ2c/wmZStZlRDQhI1hTNTMWyooEQFpsvxbtMEd+kN4kjZa+gDkGbcqMbI/WXcN+LFaw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518261wrn.303.1572002965778;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] ovl: unprivieged mounts
Date:   Fri, 25 Oct 2019 13:29:17 +0200
Message-Id: <20191025112917.22518-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: gql4jOGdMU6fVGp2id9bSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d122c07f2a43..c7f21a049c6b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1739,6 +1739,7 @@ static struct dentry *ovl_mount(struct file_system_ty=
pe *fs_type, int flags,
 static struct file_system_type ovl_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "overlay",
+=09.fs_flags=09=3D FS_USERNS_MOUNT,
 =09.mount=09=09=3D ovl_mount,
 =09.kill_sb=09=3D kill_anon_super,
 };
--=20
2.21.0

