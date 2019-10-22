Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5996CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8A4207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZBFn+4JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfJVUqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:46:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:46:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so5728787pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTz2gA5Vgd+VWXyia7j9i0zhx2iVoEFHW3eopMIkCvw=;
        b=ZBFn+4JN6wTs5zPUNSPxP4riFuqh6MBDRoX+j6kfrK8y/X7XxJc2j+fQgzAcGNVdi3
         REJvrkfBWPDoqKCA4NQiilOVQ0ivKN5ikZEKClEq3xMJUL5a+cCAxJrCfOlnUq4/zRIH
         IVbKLyKc88CrUF/Uwfjyph9zVHE9fl6s9qC4pIbI94M+x/Sd143vCmNSgV+8Fdi+r6IL
         +Y0iuDpYyzTXII+BzQwiLiL0yBH8ql9lH/ctLoxo85SP65/UypoDdrDSPb7rms2yUq/t
         RWaQBEAptheR2dnST5N0i2EhoeeLdwg2NnoIChw1yP36/idz3Q9bfv6xTWvqfwA1OexZ
         RbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTz2gA5Vgd+VWXyia7j9i0zhx2iVoEFHW3eopMIkCvw=;
        b=flxWnvG/49aY+TNPrnR5t88gWLMasDNnZMf/dBJFgVnrkH5XZyNrs/z+dp/imwQoNV
         wuMbNAoL2Ianv87XrpsAjXp0kBGzvNtwVyzIcLMjVz9DlHEQklDHN+NM5OOm0b+bnYQE
         n7TbuznEqfjFJJdTr0Z2nZIcTyPFLidB4utVnzRV8mR87mnX5CWBVKvmSenroHh2QVS+
         MukypTyVhKlijBBfCH6keBRl93W3lLYWRvpNL1oQvmWGSFkycBgwc8MXZ0DehPUvjzoF
         2oan8VLd2Y8RFJ/AOUo+dJV2Kuey1Bqvj4TFjaDVpVR/dbxdapxltAZfoa0h4TruvPtO
         uyPQ==
X-Gm-Message-State: APjAAAXjKfqKplFDVhU/AvJxA9UMVcSS8MAWmurACrlgfaexw+32i2ir
        /BKPk2mumTiXu8zV3ADsqiWlnKA3V+at0A==
X-Google-Smtp-Source: APXvYqxZEe8zdF5s+ksC85SyvZGPDJkmKtKuSQPm6Cqk/w5iXIl6fu/fjEgRpdIi06VP7Gv4e5RUjg==
X-Received: by 2002:a63:4556:: with SMTP id u22mr5662508pgk.2.1571777167769;
        Tue, 22 Oct 2019 13:46:07 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id l184sm19810903pfl.76.2019.10.22.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:46:07 -0700 (PDT)
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
Subject: [PATCH v14 2/5] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Tue, 22 Oct 2019 13:44:47 -0700
Message-Id: <20191022204453.97058-3-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191022204453.97058-1-salyzyn@android.com>
References: <20191022204453.97058-1-salyzyn@android.com>
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
v11 + v12 +v13 + v14 - rebase

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
2.23.0.866.gb869b98d4c-goog

