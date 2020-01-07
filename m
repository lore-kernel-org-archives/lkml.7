Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09473C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB18F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfn+eN2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAGTQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:16:23 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48675 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:16:22 -0500
Received: by mail-pl1-f202.google.com with SMTP id 2so305040plb.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sJ1qiuOaFddjvV3EMxT41XqJKgGLuuRJHE45bF9B8p8=;
        b=pfn+eN2a9Rhsgq25lRpdSPWFyexvrpgZxlkFxEffR4y2X33KinzvvzUEOliF9ZQXOa
         E9Zi2ic+Cfqxvy8R8Xp2NJI8gMfjf1W+jZbZoKcTdsYB7iiFZBP2EaBMbgYS5DqpzwbV
         oLHxtWvAaWs+zZMFzsUfQoncykLzPOePuvMA5QJ1U0XCUYcNWB/ca9CsJzVFIVBu3BI2
         D2lQNHBi196qYBwh3pHdylg1lq6hQ25y/ppShxK+ARBePcb2uc6tcQVtn663/Xe38XmE
         obk68R+QC9jVqcBuOFHZHkcFnjomB79L+YnaU0rqjx200WEp8/+dsOA18NDtaeluiLFL
         ds7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sJ1qiuOaFddjvV3EMxT41XqJKgGLuuRJHE45bF9B8p8=;
        b=AZYd0vXGRfccXJQFSZQOYCjiAuXMdOC8Rba972k46XA3ocSOmxzV++W5+Wl3+6n0o8
         PB+nbhPbCbeVm9VN5lMnCf+Lc5RawH5+WUCoYfHq6/BuF9KaAe1aalLRUYWAAkFoApsR
         9AnVp9IkZWFXyHPBJavKvw37uaWXkIHI1NyS7LSLhRBgu8TnsdwvqjjOPpu9rzKiwooe
         SY4T0rd7lPwYiLGDu9VQu4l8Rz0dXKqLkrx2bCk1IWdPJpwm7lW9nDncOJB1V9ex+6PE
         +E1/raWxsF4HD6+wcfDen57LWrykxaHOxQvHpISIc1UFzDlT2A7DDBqsWOVwBwXoGj08
         kakg==
X-Gm-Message-State: APjAAAWQ5+CQyxEqPG3bBYwPXnnBmTMlxV34cOiIg0xwms4YS7psaH+r
        36I076rxAwJZuSn30bXDu/0nRKo0
X-Google-Smtp-Source: APXvYqwMv03rImdYnn2HT29d0/88N85XQwfq+7kYtU+0TlQRwOEQO7ZfsOWZXNizMiJDGtrzHo5xlgQz
X-Received: by 2002:a63:f403:: with SMTP id g3mr1104543pgi.62.1578424581543;
 Tue, 07 Jan 2020 11:16:21 -0800 (PST)
Date:   Tue,  7 Jan 2020 14:16:08 -0500
Message-Id: <20200107191610.178185-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/2] iommu/vt-d bad RMRR workarounds
From:   Barret Rhoden <brho@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is
reported as reserved") caused a machine to fail to boot for me, but only
after a kexec.

Buggy firmware provided an RMRR entry with base and end both == 0.  That
is an invalid RMRR format, and only happens to pass the RMRR sanity
check.  After a kexec, that entry fails the RMRR sanity check, due to a
slight change in the first e820 mapping.  See the v1 link for details.

v1->v2:
v1: https://lore.kernel.org/lkml/20191211194606.87940-1-brho@google.com/
- Added the TAINT_FIRMWARE_WORKAROUND
- Dropped the commit that treated missing e820 regions as "RMRR OK"


Barret Rhoden (2):
  iommu/vt-d: skip RMRR entries that fail the sanity check
  iommu/vt-d: skip invalid RMRR entries

 drivers/iommu/intel-iommu.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

