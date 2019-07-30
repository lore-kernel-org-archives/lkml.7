Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD4A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LQii4Wie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfG3R3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:29:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40400 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfG3R3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:29:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so30422395pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bBFrWA52UIw86e3/QjeXJw/OCabcRoNRYCv3kxW+2M=;
        b=LQii4WieS2MDafhUA+OlKsskPWxI5YTobLOu88Z4ddha0lABd53i4WCZ7OxuKqKL2U
         5omu44FjkhueJ2p2uUdil676QfB8AaWwVo/GXXW/8lB4YmyRYBxcOsjW6V1awdSxUZSB
         S5AU+5wN2JXSiw2ydg0XA7DLFJwleT9jZGTST0FBaPEKPLfQwGq2MgyoDnSKXJR/rkKx
         MekG+GWbYUQc2Fpm1vkEBYmn8SmzE1t+nNaI1gtgMNxfPF2shyvZWiW7wlqsan36Vyu+
         5Q7Pyu7gadXlpV24vvL4Un7FQr9SLj87xvYjKzU7/8jllMYuwH9SRNdirD0t6Ps6QVAh
         /FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bBFrWA52UIw86e3/QjeXJw/OCabcRoNRYCv3kxW+2M=;
        b=g1r9ihv4yWkaubQZ2HseKUC/k1tW3/ac9LrVLwDImqBbSAjjgtzqNBtC3iizni+LqE
         GUkttsVP7zFiWuK0f/KbD8bEAK6qB6u7btH+0Jt1j0Ni7cJ9Z4oMlZ5SLfV46fS1Wd9Q
         jUZZbuezAQoVU9yZ9atTlDpyOyzjlMeGfCQv8cLZTgidutpGBOUQuOaKI8OIvo7C7RPC
         +rU0oNoksQQQeA+44qPJxI6BX0G8s7E5DIqWn4ZP1Zz5KUJFBUYXIWpkuxQaMz3zyqPK
         y0hJ0Tjk1RQrRlD/8BQHiE+kueO9YSBO8ZuVtkfV7dhJc3LjwWh6GFGlXl94y18Ud4ss
         sNlw==
X-Gm-Message-State: APjAAAU/XlAhbePw/we+IVjxqJ01m7hUZyA++nIhh8guE3tbaRvgT8qm
        cKsBg/VRUrebCESJmMp2jJLEF89z9uc=
X-Google-Smtp-Source: APXvYqy7O+JUNFiimggQGDjVBWO2oAeYvEamsKNDhzODd3L8yHiwF/P1sGG4hZNspXySynCEu0Z/Nw==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr102026443pgc.248.1564507754414;
        Tue, 30 Jul 2019 10:29:14 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id o129sm39856293pfg.1.2019.07.30.10.29.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:29:13 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v12 1/5] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Tue, 30 Jul 2019 10:28:58 -0700
Message-Id: <20190730172904.79146-2-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730172904.79146-1-salyzyn@android.com>
References: <20190730172904.79146-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assumption never checked, should fail if the mounter creds are not
sufficient.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v11 + v12 - rebase

v10:
- return NULL rather than ERR_PTR(-EPERM)
- did _not_ add it ovl_can_decode_fh() because of changes since last
  review, suspect needs to be added to ovl_lower_uuid_ok()?

v8 + v9:
- rebase

v7:
- This time for realz

v6:
- rebase

v5:
- dependency of "overlayfs: override_creds=off option bypass creator_cred"
---
 fs/overlayfs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..9702f0d5309d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -161,6 +161,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
+	if (!capable(CAP_DAC_READ_SEARCH))
+		return NULL;
+
 	bytes = (fh->len - offsetof(struct ovl_fh, fid));
 	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
 				  bytes >> 2, (int)fh->type,
-- 
2.22.0.770.g0f2c4a37fd-goog

