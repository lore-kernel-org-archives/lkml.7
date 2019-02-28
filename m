Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9F4218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfB1Srk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:47:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfB1Srk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52BBBC07C563;
        Thu, 28 Feb 2019 18:47:39 +0000 (UTC)
Received: from llong.com (ovpn-121-201.rdu2.redhat.com [10.10.121.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 221B019C5B;
        Thu, 28 Feb 2019 18:47:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v12 0/3] ipc: Increase IPCMNI limit
Date:   Thu, 28 Feb 2019 13:47:22 -0500
Message-Id: <1551379645-819-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 28 Feb 2019 18:47:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v11->v12:
 - As suggested by Matthew, change patch 2 to increment sequence number
   when there is a wrap around in generated ID instead of after a
   ID deletion.

v10->v11:
 - Remove the sysctl parameter. Now delete mode is the only way the
   sequence number is updated. The only choice users had to make is
   whether they need to specify ipcmni_extend in the boot command line
   or not.
 - Cyclical id allocation is enabled only in the ipcmni_extend mode.
 - Increase max # of ids in ipcmni_extend mode to 16M.

v9  patch: https://lkml.org/lkml/2018/9/7/1141
v10 patch: https://lkml.org/lkml/2018/11/5/791
v11 patch: https://lkml.org/lkml/2018/11/10/32

There are users out there requesting increase in the IPCMNI value to
more than 32k. This patchset does that by using a boot kernel parameter
"ipcmni_extend" to increase the IPCMNI limit from 32k to 16M when that
boot command line option is specified.

Patch 1 adds a "ipcmni_extend" boot command line parameter to extend
the IPCMNI limit from 32k to 16M.

Patch 2 changes how the sequence number within an id is being generated
by incrementing it only when the generated id is not greater than the
previous one. That reduces the chance of id reuse whether "ipcmni_extend"
is set or not.

Patch 3 makes identifier allocation go cyclical through the entire
24-bit id space with "ipcmni_extend" only to further reduce the chance
of id reuse, but probably with a slight memory and performance overhead.

The cyclical id allocation isn't done for non-ipcmni_extend mode as the
potential memory and performance overhead may be problematic on system
with slow CPU and little memory. Systems that run applications which need
more than 32k IPC identifiers can certainly afford the extra overhead.

Waiman Long (3):
  ipc: Allow boot time extension of IPCMNI from 32k to 16M
  ipc: Conserve sequence numbers in ipcmni_extend mode
  ipc: Do cyclic id allocation with ipcmni_extend mode

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++
 include/linux/ipc_namespace.h                   |  1 +
 ipc/ipc_sysctl.c                                | 14 +++++++-
 ipc/util.c                                      | 27 ++++++++++-----
 ipc/util.h                                      | 46 ++++++++++++++++++++-----
 5 files changed, 76 insertions(+), 18 deletions(-)

-- 
1.8.3.1

