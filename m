Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C5FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HGnGEJ0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKZVeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:34:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45820 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:34:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so21931612ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 13:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aJX5qdSFRHtCgBIpCX8dfES7Ed9Qciad/tFjyvqy864=;
        b=HGnGEJ0dJifCxbADDrVJ32WsAkobK8u5N0dQiMJeH0k3Z/xOZDC87Y/a6n/u7G+3GW
         SQxq/lgrKh/pt7Z8OYdw9uw9ciSYN5V9XBx4W5V1yUzdpKLWPN4/zjMsQpVTVCTa1yaV
         6gRJnRObEBGLM9WqJ5mmdBUVYSmpSfo5N5VLQCR/ytNwZXyUhIL8d/jElkzQq6e2clMv
         u06m4OYkZA+6UlIEkBrsNStCN2hqi6Jn7gpuSPusHxk7F219GT3MK8QSr17sztIcJ4iL
         J+sx+O5AmZl4N6XEOOeCr99JzKJbbNfqjufcRLBhfVWIsZOm0yHNzlKnctl9y+EJRMES
         kazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aJX5qdSFRHtCgBIpCX8dfES7Ed9Qciad/tFjyvqy864=;
        b=JgG3bkFMtU/F5eF+pq3U1Ot9XBbGohGQMFeKq0gE7bpHvXqoU3WQwmXhnAthi8Bzt1
         UnLcpjsBEiFHCXI300l9g07elStDeCfOTza9RQRzmrpiwFiZfYDRH9GbHx0UR9ahwXIT
         YYVm30O/5sz/C47/XDVAfco9LhiuHPxgZC4gmdkBwMLv0i5+g4Y9uDgqg8dNKsjkapat
         k2V6j3y4PSDeXLUwHeeDqD2aSgBYa6YUHMO1/TwgJ7dnLFRtMjZz2K8Z162e8fs6HiKn
         QJE11gy5njan8QHo6f04frWBLHqH1p3Xf3G1nJDZVf2uBKsV5wyPDhe+8XiidcBhzZDS
         6sFw==
X-Gm-Message-State: APjAAAWEXm0Bp3XPH6N8dwsFF59MZdZe7ZwF8kYYCLTSJ1qe9ZbzsKsZ
        2Q2ry9frxFZq0GE1xgMOErYrBUH59PruNPl3kvmAT9czxQ==
X-Google-Smtp-Source: APXvYqwYnQXp3LcVcUyqHAyVFGjBtP7la8FOZ4rueFza7IGmfxYs6IJRt4yP6q06fOK4HWYh2iEFpvP9jcjxZfA89yU=
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr28003318ljj.243.1574804042523;
 Tue, 26 Nov 2019 13:34:02 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Nov 2019 16:33:51 -0500
Message-ID: <CAHC9VhRnN4yWO0So+u4Ktm1N8EpAbe+W1AGPXU-U7Bd7cPBv7g@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Audit is back for v5.5, albeit with only two patches.  Both patches
pass our test suite and are listed below, please merge for v5.5.

- Allow for the auditing of suspicious O_CREAT usage via the new
AUDIT_ANOM_CREAT record.

- Remove a redundant if-conditional check found during code analysis.
It's a minor change, but when the pull request is only two patches
long, you need filler in the pull request email.

Thanks,
-Paul
--
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

 Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20191126

for you to fetch changes up to c34c78dfc1fc68a1f5403f996de8ca62f298d7b2:

 audit: remove redundant condition check in kauditd_thread()
   (2019-10-25 11:48:14 -0400)

----------------------------------------------------------------
audit/stable-5.5 PR 20191126

----------------------------------------------------------------
Kees Cook (1):
     audit: Report suspicious O_CREAT usage

Yunfeng Ye (1):
     audit: remove redundant condition check in kauditd_thread()

fs/namei.c                 |  8 ++++++--
include/linux/audit.h      |  5 +++--
include/uapi/linux/audit.h |  1 +
kernel/audit.c             | 15 ++++++++-------
4 files changed, 18 insertions(+), 11 deletions(-)

-- 
paul moore
www.paul-moore.com
