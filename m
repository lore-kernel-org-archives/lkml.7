Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C5C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32E920868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="gktj5n7h";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="SWOcvk/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfFIMyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:54:13 -0400
Received: from mail180-16.suw31.mandrillapp.com ([198.2.180.16]:54246 "EHLO
        mail180-16.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728496AbfFIMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:54:12 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 08:54:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=6M5kKn25cx+JybbTUPMUlfxmJC9HjuWYsaCX5CQEPok=;
 b=gktj5n7hrQ92BJq10Taw48AJIToY1dtITFJXVfVreGhkP11PUy1UbbgqfylNpbqt6Xt4pJh0p24/
   2zNsKI8pUydtNmo9DDkQORsC4raltd9F61TJw1UeiFZjqzSoXxD7Sv6qsZF792DBp1Wcp9u2W5Jb
   Etuvz64uKzN9hwteqKE=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-16.suw31.mandrillapp.com id hvk0n822sc0l for <linux-kernel@vger.kernel.org>; Sun, 9 Jun 2019 12:39:08 +0000 (envelope-from <bounce-md_31050260.5cfcfdeb.v1-33d523675c2f43c89af22c199ea3c3f9@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560083947; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=6M5kKn25cx+JybbTUPMUlfxmJC9HjuWYsaCX5CQEPok=; 
 b=SWOcvk/ICuPUBA4DQ0YdzuqZFNcovc+net1r6qmTr2UZl+SyC0YmEjLJ4/5u4YJ21TzvpL
 htrQiEUyJy6ct1GjGWNob205ebNpJ0+T9HBL8hsrUakay4dZaaXuRcDYV45tit14xqhCLola
 RdtbfOtCVfKbpq81PbxoZytPNuGk8=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 4.14 0/2] Fix FUSE read/write deadlock on stream-like files
Received: from [87.98.221.171] by mandrillapp.com id 33d523675c2f43c89af22c199ea3c3f9; Sun, 09 Jun 2019 12:39:07 +0000
X-Mailer: git-send-email 2.20.1
To:     <stable@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <20190609123831.11489-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.33d523675c2f43c89af22c199ea3c3f9
X-Mandrill-User: md_31050260
Date:   Sun, 09 Jun 2019 12:39:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello stable team,

Please consider applying the following 2 patches to Linux-4.14 stable
tree. The patches fix regression introduced in 3.14 where both read and
write started to run under lock taken, which resulted in FUSE (and many
other drivers) deadlocks for cases where stream-like files are used with
read and write being run simultaneously.

Please see complete problem description in upstream commit 10dce8af3422
("fs: stream_open - opener for stream-like files so that read and write
can run simultaneously without deadlock").

The actual FUSE fix (upstream commit bbd84f33652f "fuse: Add
FOPEN_STREAM to use stream_open()") was merged into 5.2 with `Cc:
stable@vger.kernel.org # v3.14+` mark and is already included into 5.1,
5.0 and 4.19 stable trees. However for some reason it is not (yet ?)
included into 4.14, 4.9, 4.4, 3.18 and 3.16 trees.

The patches fix a real problem into which my FUSE filesystem ran, and
which also likely affects OSSPD (full details are in the patches
description). Please consider including the fixes into 4.14 (as well as
into earlier stable trees - I will send corresponding series separately -
- one per tree).

Thanks beforehand,
Kirill

P.S. the patches have been already a bit discussed in stable context some
time ago:

https://lore.kernel.org/linux-fsdevel/CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com/
https://lore.kernel.org/linux-fsdevel/20190424183012.GB3798@deco.navytux.spb.ru/
https://lore.kernel.org/linux-fsdevel/20190424191652.GE3798@deco.navytux.spb.ru/
...


Kirill Smelkov (2):
  fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
  fuse: Add FOPEN_STREAM to use stream_open()

 drivers/xen/xenbus/xenbus_dev_frontend.c |   4 +-
 fs/fuse/file.c                           |   4 +-
 fs/open.c                                |  18 ++
 fs/read_write.c                          |   5 +-
 include/linux/fs.h                       |   4 +
 include/uapi/linux/fuse.h                |   2 +
 scripts/coccinelle/api/stream_open.cocci | 363 +++++++++++++++++++++++
 7 files changed, 394 insertions(+), 6 deletions(-)
 create mode 100644 scripts/coccinelle/api/stream_open.cocci

-- 
2.20.1
