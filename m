Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D68C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD720656
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKLOz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:55:29 -0500
Received: from er-systems.de ([148.251.68.21]:37382 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfKLOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:55:28 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 09:55:28 EST
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 04484D6005E;
        Tue, 12 Nov 2019 15:45:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id D45F2D6005A;
        Tue, 12 Nov 2019 15:45:50 +0100 (CET)
Date:   Tue, 12 Nov 2019 15:45:50 +0100 (CET)
From:   Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
cc:     linux-kernel@vger.kernel.org
Subject: ocfs2: xattr problems with 5.4.0-rc7
Message-ID: <alpine.LSU.2.21.1911121355550.7620@er-systems.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-1838456657-1573569950=:7620"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.101.3/25631/Tue Nov 12 10:51:17 2019 signatures 58.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-1838456657-1573569950=:7620
Content-Type: text/plain; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


Hello,

with 5.4.0-rc7 and 4.9.200 we see the following errors with 
mkdir or touch on a ocfs2 mountpoint:

root@s2:/shared/ClusterShareDisk# mkdir dir
mkdir: cannot create directory ¡dir¢: Invalid argument

which produces this output:

root@s2:/shared/ClusterShareDisk# dmesg
[ 6918.815770] (mkdir,19461,0):ocfs2_xa_set:2242 ERROR: status = -22
[ 6918.815772] (mkdir,19461,0):ocfs2_mknod:408 ERROR: status = -22
[ 6918.816215] (mkdir,19461,0):ocfs2_mknod:486 ERROR: status = -22
[ 6918.816216] (mkdir,19461,0):ocfs2_mkdir:652 ERROR: status = -22

We got some ACLs:
$ getfacl /shared/ClusterShareDisk/
getfacl: Removing leading '/' from absolute path names
# file: shared/ClusterShareDisk/
# owner: root
# group: root
user::rwx
user:admin:rwx
group::rwx
mask::rwx
other::---
default:user::rwx
default:user:admin:rwx
default:group::rwx
default:mask::rwx
default:other::---

And of course it is mounted with user_xattr and acl option.

Reverting
commit 56e94ea132bb5c2c1d0b60a6aeb34dcb7d71a53d
Author: Jia-Ju Bai <baijiaju1990@gmail.com>
Date:   Sun Oct 6 17:57:50 2019 -0700

     fs: ocfs2: fix possible null-pointer dereferences in
ocfs2_xa_prepare_entry()

fixes the problem.

Greetings,


     Thomas
---74181308-1838456657-1573569950=:7620--

