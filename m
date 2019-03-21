Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D45FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YTiaNSmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCUOJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:09:37 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39021 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:09:37 -0400
Received: by mail-lf1-f43.google.com with SMTP id m13so4694473lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hbdYyODUiA2Z/YEKGK8SFEu3cURHNgEo3JDMGb+LYxk=;
        b=YTiaNSmOZzvV5n9nwN03ijojlw2rQgoRbOj8M6U08khWxiSg/mmYL/l+YLYx3m7YGL
         E5t6Ka0J4DRe/C2qrcEHVvUrAqSz3j2zDAFbNImtjrTW37XmCEmh4IgLChNDPIk9MKkN
         qA2Te1z1CIwTyiy1bKp2I1hZ1zQynK+yDMZiVi4mFI02hA237buNX9lBg+PwU1U/RTMf
         +m3WoE22GQK9TSevGVzPHxMIhY+l5ZolyVMTX1HvtPvjIbCgBOZiR6hmdbHtIboF9A/F
         P4tKMGR0fgkVM1SqbZfE4koMrxyXvoAkQLjidMJbjXyNkcsg+KzAsWkeC22ozUMdd5SK
         wjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hbdYyODUiA2Z/YEKGK8SFEu3cURHNgEo3JDMGb+LYxk=;
        b=SRJBCvYF/RzGdE7NHah8gm6x4k2vYsRprSKVJL7/i3yZhjQnbJloj0Nrt0Vp8DWYBL
         T/4I9rCQADwX38+AzeasBQAK5fT4QtFsVYPcQ0UjB/uAEutUouA1YxfjDqtX7Y3fsHCq
         5WozFqqgcO5m9wR16aP65X2uIiexLkQ05CreKjlvNS/ZL0eytm6uz8u/LB1fiE5aw1A5
         PxKBoopsGx4uR4ZO8BheshRvumgitUA75eyv+qcqUlSuzjvJOsT4ghlmvDxdwt/sYpem
         DQaThxTqt1XbVbObv7rz4j8EnrTyufKLpzW5QCAZxbR2hSRucjeMeu5jHbjmH/n3AUVO
         aLhA==
X-Gm-Message-State: APjAAAW5VoRXbOc5HO8qCC0mqfch9Wq6gqkpOuf/DJjg0B9zDHOrq1bT
        6p1dVWW+sIkyN64dMYjAYRLAx00+ghQQmi2Ikpv2
X-Google-Smtp-Source: APXvYqyKz4a0uhG/MuQigj8sUSve1tqadWavU/DUznbOb7nvpLnNKB8Wnv3y30xOIZIJdt+vtPk43Sgg6hAe62ap+vw=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr1926347lfl.91.1553177375077;
 Thu, 21 Mar 2019 07:09:35 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Mar 2019 10:09:24 -0400
Message-ID: <CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.1 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another small SELinux fix for v5.1, please merge.

Thanks,
-Paul

--
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

 Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190321

for you to fetch changes up to 6a1afffb08ce5f9fb9ccc20f7ab24846c0142984:

 selinux: fix NULL dereference in policydb_destroy()
   (2019-03-18 12:19:48 -0400)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190321

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix NULL dereference in policydb_destroy()

security/selinux/ss/policydb.c | 13 +++++++++----
1 file changed, 9 insertions(+), 4 deletions(-)

-- 
paul moore
www.paul-moore.com
