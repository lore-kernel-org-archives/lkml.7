Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D762C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D3020867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V7oSDnKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfJGWwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:52:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44365 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:52:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id m13so15408083ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FVwCMABg99tdlNx6emr/YdtOOEDE07gvzo7XLhdzGn4=;
        b=V7oSDnKyrOIIH1lEp/sZO38TFu/EZpj9S6PVOsbW+YUVG6TXoA6nnSvv+1IowrVkrO
         oEpxaTepVnV/Au8RTXdfGWonG11LjAsM9pra//9xN26bn3nOJy5iESRsCc2/Tq7v0TVl
         bq1F9kB1oeio/YZeioER9QWM/T3OgqgX47vKR8MQNZssgj2rCstFoGzlT0j1/IZ3KECj
         x3K2tH7ZwXNzlqc/CZnKEf4/D+nOnuzF+3y6Ke8lYq0+b5W2UWzdVpIBJyGuhpKIpRPZ
         I6bds1F3YH+e/LdURJlBDDnqNMn3pH+RyREcWw5qG880D57NHkqtOVqMwu6Du66jQjth
         BQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FVwCMABg99tdlNx6emr/YdtOOEDE07gvzo7XLhdzGn4=;
        b=sOrjnjl1jy9EEqwURH0hTIs+XDf1BlioTdLIxfC6kbZaSdSgLgmz9nIQFgcXZ+WGiI
         dl38V9jTS2QkiJIRa/8uojzPdAEVQPcECoqd7r0JOWBt7u17qQqUgajp4VuiVPY3h4zm
         EmZoWXpDD/BAC26ZbbFjRQpMZn1fqbGrNMDq018k6T3IsRAXVvH4pWEc9bsqXmLe1G86
         VNd4ThI3c9E8zQnlIektGg/q2wOhmTlvXJEXAlIblT2cyQ8DcVTfPrv9rGfWGtjSfn5X
         mZ5H7CYvLQV7civl2agph9T3bc245ALrez1muYbW3J2geC7y6yzWrYSFE7IV3QMTqWAz
         L9Dg==
X-Gm-Message-State: APjAAAVEbXUxOtoyWZiTcCFx6MS1Zk2KfOolnLCnQABPsbmB6uQG1bMj
        cwU9Nk/1wxUMa4WFVdlSSPlt5z8cEbpa/Q9/ecZArIXiBA==
X-Google-Smtp-Source: APXvYqxg+H1tip5gK9A7b7kI8GMbzy7+jVDELfMGMJgxAbv8kx7evCyysHRIFhzMqjo61LplPKBpIS/ZMq1ij+j30Yk=
X-Received: by 2002:a2e:5418:: with SMTP id i24mr18422510ljb.126.1570488726917;
 Mon, 07 Oct 2019 15:52:06 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Oct 2019 18:51:56 -0400
Message-ID: <CAHC9VhR6KFR+1F1eWyYEHnRfJyYhUP7RYf6=FsZOX=_m24btbg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One patch for SELinux to ensure we don't copy bad memory up into
userspace, please merge for the next v5.4-rc.

Thanks,
-Paul
--
The following changes since commit 15322a0d90b6fd62ae8f22e5b87f735c3fdfeff7:

 lsm: remove current_security() (2019-09-04 18:53:39 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20191007

for you to fetch changes up to 2a5243937c700ffe6a28e6557a4562a9ab0a17a4:

 selinux: fix context string corruption in convert_context()
   (2019-10-03 14:13:36 -0400)

----------------------------------------------------------------
selinux/stable-5.4 PR 20191007

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix context string corruption in convert_context()

security/selinux/ss/services.c | 9 ++++++++-
1 file changed, 8 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
