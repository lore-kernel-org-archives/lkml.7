Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE8BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F572089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="QAyuPC1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfG3R3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:29:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfG3R3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:29:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so30218637pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RdmJMzJpJkE1tpwAcBC2lO5tLyCjdp9GTuTXQPYwuU=;
        b=QAyuPC1xGgz2u4jqn8ZOqROMWt1+hlxJq/wFESXFu+V2ivcy4DD8nbNlM2uQeZLRPY
         DO05rDvTm4wx+czIKgMNOM5luBifS2uQyT89Mupk/c2+P0RBaUhdLM+McSHZfDPmGht6
         OD6k7FOwQYA7OrVOa+0s0CPKSixxquxU38pOd6ZhNbzX7yfNkYEMPJXvsjK6DuaLRRfk
         bSFe6gvHEcaEJO2djvEuQqYkWI1HulSz4wNMhM7LWVsBBrbFdSJqjV62eGD8e1D/iF1R
         HQlzGPY0X6bzWvPfRVxr2vPlCU2AoHtLdkRwmlLaNoyBpz9KTQxRpm2zeiSWp8w/SECX
         X5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RdmJMzJpJkE1tpwAcBC2lO5tLyCjdp9GTuTXQPYwuU=;
        b=ti6O7lCwlIBOHolSl8cr7UsqjerGItO0kgRNojQ0ugUeBEc99RVPokQAFzf53HBNv7
         yxrpPqvXhatA2ynH+dlB5U49eJA0dVkhrh67eG5gscwMJlUoZH9FwCL40dUzL9Cc9TzF
         4xC8WWeuETZXVHnopcLQZCMGiV29d2eX2es5Wwahyxd16u5pl0RXXxxGe6XCLAZx62D8
         MfFufJ+terGZDpan3tveCgta+QnwdUfeQEACHBsdypU5+N+IqpeuU6mlsZxmntiYAAPY
         qQroiZgZIeTJKc5dadYX+R0jCS+DThmr0T3QbVG27kD6nTOGgVRzKCKDgAERp6v/rc24
         +VZg==
X-Gm-Message-State: APjAAAV4DNl9vzGzy/yxxNmXK90PotgYRs834HTlB9YSiBEAtICFSnwJ
        PWgqFLImMkHbpIJNRMBHKPchZWbJ2s4=
X-Google-Smtp-Source: APXvYqwdJRnHrekFLzvk2dooQSyL2Uudf/MaUUGySMu5hQi+WTGuuvUsK9MJLLStp7OgcwuglRAgkw==
X-Received: by 2002:a63:c442:: with SMTP id m2mr111810644pgg.286.1564507750887;
        Tue, 30 Jul 2019 10:29:10 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id o129sm39856293pfg.1.2019.07.30.10.29.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:29:10 -0700 (PDT)
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
Subject: [PATCH v12 0/5] overlayfs override_creds=off
Date:   Tue, 30 Jul 2019 10:28:57 -0700
Message-Id: <20190730172904.79146-1-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series:

overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Add flags option to get xattr method paired to __vfs_getxattr
overlayfs: handle XATTR_NOSECURITY flag for get xattr method
overlayfs: internal getxattr operations without sepolicy checking
overlayfs: override_creds=off option bypass creator_cred

The first four patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.
on them).

The fifth adds the feature depends on these other fixes.

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
v12:
- Restore squished out patch 2 and 3 in the series,
  then change algorithm to add flags argument.
  Per-thread flag is a large security surface.

v11:
- Squish out v10 introduced patch 2 and 3 in the series,
  then and use per-thread flag instead for nesting.
- Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
- Add sb argument to ovl_revert_creds to match future work.

v10:
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecessary sys_admin sepolicy checking for administrative
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
