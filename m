Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB32190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp8gpYSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfCVQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55613 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCVQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so2721634wmf.5;
        Fri, 22 Mar 2019 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRD2Tk6gsvXCPqqyoD6G2EpxyCHXvPYUJgqWhcRomj0=;
        b=Wp8gpYSf+MwIic6tjdG7qaKaGYFsV4iHOCMV1gKEqRU08qNL6QoxKiFZtU9bGXL+7q
         9NVsm5WWa9TYd33itZZDqxYyplZgXlNeMysP8lPBK4Olg0dUsoiodA5SsoNX9lCkvd9m
         Jzi0eN2ZSIpcPcXTKDgh+ZYbFDdY8VWPt7U+W6fDJXUxvfiiyQ6iZMO3UFIGYrCYs0db
         c5G38XmDUoC1yK/wa5/eDctRGaqtOLoGV50Q8ibVjBfa9bh+ad0vlEsWnjdQBjDlymZg
         /Wd99IkjQzCUO5skzFOhfH2depRXBHNO+WfY0rQ81uJLQab5sQdMOhOeimGELeIFaO20
         k8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRD2Tk6gsvXCPqqyoD6G2EpxyCHXvPYUJgqWhcRomj0=;
        b=eQII0dxbJ6GEvv5UfDEX4N6E3FEHUfvLYl1rAdtfoXano70tMOP/Lhml4ArnsHWhTa
         6GrYmSVD66tmimv4kAt/OpiqbhSIVAfuzYBFRUVG3tKCcKyT5m2kWe2DAD8HPq7KAMB3
         Jr6uY+Rl03QRBf0e9lvUTsWVXVsUZDdNuAD225WrmxsgYZHoAGv0kElrTrQypBEF40Y5
         3gg7fIO7faz6+809jhIZdt0mSqGXnI0BYliSc14yhYyVZAbnki2SF5cfPDNjESY5BU0Q
         LOqmH0zap4S51A/B8N0R22sajLbV267sg2L49v6Cz+B+8uW+mL+94vUxOZOdtH+YKDJz
         6LZA==
X-Gm-Message-State: APjAAAUqyW3gE2Hc8Src0h5Sg9BocO9KGUjDLkphUXGxT6LHG9LJ1kJi
        Rb+RNj+8/JBEtNsMgMdEcfNS0dGf
X-Google-Smtp-Source: APXvYqyiL5yi+Lv9xwb/OJ/FyiMgAHG4y1Z39WJhuuDmTQJQxqQGeAd+efDQjuM2CBW8fpgK65rFSA==
X-Received: by 2002:a1c:2782:: with SMTP id n124mr3816790wmn.102.1553271526346;
        Fri, 22 Mar 2019 09:18:46 -0700 (PDT)
Received: from kwango.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id h14sm12494029wre.90.2019.03.22.09.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 09:18:45 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.1-rc2
Date:   Fri, 22 Mar 2019 17:19:47 +0100
Message-Id: <20190322161947.15053-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc2

for you to fetch changes up to 9d4a227f6ef189cf37eb22641f6ee788b7dc41bb:

  rbd: drop wait_for_latest_osdmap() (2019-03-20 16:27:40 +0100)

----------------------------------------------------------------
A follow up for the new alloc_size logic and a blacklisting fix, marked
for stable.

----------------------------------------------------------------
Ilya Dryomov (3):
      rbd: set io_min, io_opt and discard_granularity to alloc_size
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()
      rbd: drop wait_for_latest_osdmap()

 drivers/block/rbd.c          | 28 ++++++----------------------
 include/linux/ceph/libceph.h |  2 ++
 net/ceph/ceph_common.c       | 18 +++++++++++++++++-
 net/ceph/mon_client.c        |  9 +++++++++
 4 files changed, 34 insertions(+), 23 deletions(-)
