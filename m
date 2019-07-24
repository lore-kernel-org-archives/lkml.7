Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FEB20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Ps3kbWjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392641AbfGXULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:11:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42187 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392025AbfGXT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so22435168plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWf1wqBywrzqDn4QoQmjv8h4FPdjfVbADD3ipadMdY0=;
        b=Ps3kbWjF13UPogwWSsC0j1C1LHTomES8Modx8qFda13HSsS2jZ4gUjMhQQyjIctloQ
         kr3kLXtMYRijIejm/ZHtQ4C3AqKPqY3ZHzBVoDk9iRt4R9cw06KEAYwmVxY3QZtIPjnq
         y+EnI9kd6drKRqNsuWKiEzoO/K332RFgL3+iVCi6iBhhkIitIXXG2sg5J8vY2z+5gHC2
         SFovx1V4uzeTYGC4PQ0ipuH3uTpIWDyVbHQw6GcPjb+ZSgRIpmH/Eo7AUWg0/vEUUIuR
         Z87flKb7/uwvWhZWnxpSDZLnP2l+ZEp4A7ejy86spDsLIF9+9jWNQJ3ucUpLAUhnmW9s
         DlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWf1wqBywrzqDn4QoQmjv8h4FPdjfVbADD3ipadMdY0=;
        b=tYhrTWOZi1LAzVlO32JhockdflVmAT4fAfbnSMKlMeCdld144INCwzbqEx4VpxTq+o
         SuCPBc/DI83IV/82msRHRFTDmBHoKUr22ayOW8gBtJ4LhOvXB5WyIc5uOligfZrsRC/n
         TxC503A6n+rkllEuR9H5/hEq3RSZtunx/z8GjD98iLeIPpoJk8YWbD4v4kMaKwB0W21U
         moTUkSckyyMiHFFxCi+1Zm8khrNOr4eUx/DncAHXBGtg1sx3fTGC6PyFTl/sSjr80eiG
         KuvTJuErXbQm+4B+ug9xfn0fzEwrfe2LoMX/tRyctl+MyQhCLqo0vlWfoJdR3yORAEGJ
         Gzww==
X-Gm-Message-State: APjAAAXgSH0x68ekQWOpEd0f6tm1vkElnOPcrjfcQYPbJVSoqOlTcOFD
        ZMUQIekAPp8UJRTQGtLfJpJI/PEV
X-Google-Smtp-Source: APXvYqyOM0dv0KNnlpru4O+Ku92Xy82BvYB2ri/rGxGwsQ32yP0CJ/DGZq3sRmE9fDxjNQjCUf4tBQ==
X-Received: by 2002:a17:902:830c:: with SMTP id bd12mr89230023plb.237.1563998253455;
        Wed, 24 Jul 2019 12:57:33 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:33 -0700 (PDT)
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
Subject: [PATCH v10 1/5] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Wed, 24 Jul 2019 12:57:12 -0700
Message-Id: <20190724195719.218307-2-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
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
2.22.0.657.g960e92d24f-goog

