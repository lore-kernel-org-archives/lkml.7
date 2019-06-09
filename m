Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A45C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E3E20693
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="SA+8YOG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfFIKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:08:54 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56412 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727853AbfFIKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:08:53 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 72C702E1466;
        Sun,  9 Jun 2019 13:08:50 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2urtvvwpVi-8nOa9Lfg;
        Sun, 09 Jun 2019 13:08:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560074930; bh=A1Nf6U0SvfT2BlL//D1jO+fs0ZHFTGiIegZYeSRr5dQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=SA+8YOG3X58lzzkWQxUgsq5XNkRaEMhVLAik6vgAWA+LyhIPHKXPgzRv8MpB3TJ+w
         F7x2Xwlkvj1bevytfO9ytA3lDrG88xYiiYv6hgsvKmZnnN5adJyE7z06mM4GmclYnh
         bNGsFLf3hPwpIcii0K+apf2qgVIRyuqYMl5gDgpM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 4GNAteVf4o-8ngWxpn4;
        Sun, 09 Jun 2019 13:08:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 0/6] mm: use down_read_killable for locking mmap_sem in
 proc
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Roman Gushchin <guro@fb.com>
Date:   Sun, 09 Jun 2019 13:08:49 +0300
Message-ID: <156007465229.3335.10259979070641486905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
https://lore.kernel.org/lkml/155790967258.1319.11531787078240675602.stgit@buzz/

v1 "mm: use down_read_killable for locking mmap_sem in access_remote_vm"
https://lore.kernel.org/lkml/155790847881.2798.7160461383704600177.stgit@buzz/

changes since v1:
* update comments and collect acks/reviews.

---

Konstantin Khlebnikov (6):
      proc: use down_read_killable mmap_sem for /proc/pid/maps
      proc: use down_read_killable mmap_sem for /proc/pid/smaps_rollup
      proc: use down_read_killable mmap_sem for /proc/pid/pagemap
      proc: use down_read_killable mmap_sem for /proc/pid/clear_refs
      proc: use down_read_killable mmap_sem for /proc/pid/map_files
      mm: use down_read_killable for locking mmap_sem in access_remote_vm


 fs/proc/base.c       |   27 +++++++++++++++++++++------
 fs/proc/task_mmu.c   |   23 ++++++++++++++++++-----
 fs/proc/task_nommu.c |    6 +++++-
 mm/memory.c          |    4 +++-
 mm/nommu.c           |    3 ++-
 5 files changed, 49 insertions(+), 14 deletions(-)

--
Signature
