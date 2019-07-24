Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DD222ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="G5AjQYft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392009AbfGXT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:57:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42713 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391982AbfGXT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so21452290pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hIqVIsW0Jzv3qlJGiJ8fmrkQndrI1bOT+U/YKeP91w=;
        b=G5AjQYftTGGOfdkJsIj3NaLgEDUlZP91m+rouc5jJaPeUxm49PKwX+kPqwAa2V7AnB
         2eqvQ+C2gczG8vr1SCtVrY3GUttlIvDAlx8ABZeFpls9ipL1G7U6PIwaJPjKNAV7kpmo
         6jgCzp0OAnxEEm47X0bE/HyhjPo9UxQCuWVvm5eUgAJhqJm+DieWs6iS8XZdj98C4w8g
         pyFf2gGtyDUzJozXaLHY18a9NtYkX/WqgTkYm6lyaBr5jHE0etxoYdBgamdu3iqzekt7
         Pz18kON/KoDzsy9GlupQqjI9N13kcAZtWCbaE9YkAgRg1E7P1/e2tdstcOvngir6qOV/
         NN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hIqVIsW0Jzv3qlJGiJ8fmrkQndrI1bOT+U/YKeP91w=;
        b=uM7iTUrw21/u6wAkMJnznQbP4JGgWj1rtLjGCFuCugvUIQfYixtQzTSfrDAzGKqKt+
         sE8wUZzKJkdNJ8+AI6motzMFri0CFmHh8zmk0Rj3/ssSludTkGlhTuNsH95ZwThT2q9X
         L25v9ECOGYE2EwcEN3ymExVTqy67t/nK6phiq7bm454FUoPPzamTL9NXbgHTiUjEuYg7
         MnAcoPm3Z//e06lb1MEGhZb65WxZk/uj4oY2ODScS/dQiO6xAZC5SF7Az45UGRy1e6NF
         G2S9pkntBQHWqXBzf7AhoVKxatEHA5Lzg+pq6FV3yx+JO9m6LAFSr+80c6hcMRInA0mg
         wgGA==
X-Gm-Message-State: APjAAAX6mZzZUcsdYdBgql5peW5eV1uCEtZvcVtI4gVRy0j631+Khkmv
        nRRJTwlhisndbGJArGSorhV0nlEl
X-Google-Smtp-Source: APXvYqzZWQoYs7Fqyx9XIWGApgxx0jM5sfYBQXgu4zGqe1/h6VS9ZqeEJKn7ZZDuvPulVlMjtuT2zA==
X-Received: by 2002:a63:b64:: with SMTP id a36mr73284058pgl.215.1563998247307;
        Wed, 24 Jul 2019 12:57:27 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:26 -0700 (PDT)
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
Subject: [PATCH v10 0/2] overlayfs override_creds=off
Date:   Wed, 24 Jul 2019 12:57:11 -0700
Message-Id: <20190724195719.218307-1-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series:

overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Add optional __get xattr method paired to __vfs_getxattr
overlayfs: add __get xattr method
overlayfs: internal getxattr operations without sepolicy checking
overlayfs: override_creds=off option bypass creator_cred

The first four patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.

The fifth that adds the feature depends on these other fixes.

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied for sepolicy, the
mounter's credentials might not overlap the credentials of the caller's
when accessing the overlayfs filesystem.  For example, a file that a
lower DAC privileged caller can execute, is MAC denied to the
generally higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds

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

---
v10:
- Rebase
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecassary sys_admin sepolicy checking for administrative
  driver internal xattr functions.

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation, drop rationalizations.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.
