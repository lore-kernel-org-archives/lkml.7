Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0003FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47F92075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="IBgMkTOv";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="ZY8ztMXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfC0JpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:45:09 -0400
Received: from mail177-9.suw61.mandrillapp.com ([198.2.177.9]:60576 "EHLO
        mail177-9.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbfC0JpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:45:08 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 05:45:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=QRZD9IeRzD6ncGuICtHLI2c6ggBPdMBAZtFU/phEuLc=;
 b=IBgMkTOvOwl2c+DKI3zX/RlYpJEKSZPA5IRmKU1u0cVleXaglEiNJo1OPYnulVQUEmMZyVDYGtQn
   u0j1P0B/XEJmvScraMYk4NNaUeMcYHQCeT/j/PLWAToRxamuM+gWGW7gYUtz8hJ034HeWHS6vU6O
   pQRjIgdmbJlUapTzIX8=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-9.suw61.mandrillapp.com id hjd32822rtkk for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:15:06 +0000 (envelope-from <bounce-md_31050260.5c9b3f1a.v1-75970decb7ab4fbfa0d3434f3d904bbe@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553678106; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=QRZD9IeRzD6ncGuICtHLI2c6ggBPdMBAZtFU/phEuLc=; 
 b=ZY8ztMXQudhMb8/qx0ut+0eVuiIsHxh2uSBlB3I3NQN42z+2Vk96ewIikukIJcg4pJVbiy
 ZMMSHP3CpeZIVGqD68jnhLchuiAwHNXLguIENzcquPMOQFT+yrK+i9fkp/PPrlsBEtGBdYDH
 3IVjWwhnr+e79FowhQ5DWusjXc6FU=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND1, PATCH 0/2] fuse: allow filesystems to have precise control over data cache
Received: from [87.98.221.171] by mandrillapp.com id 75970decb7ab4fbfa0d3434f3d904bbe; Wed, 27 Mar 2019 09:15:06 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <cover.1553677194.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.75970decb7ab4fbfa0d3434f3d904bbe
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 09:15:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos,

This is a resend of the patches that teach fs/fuse/ to give filesystems
full control over data cache if the filesystem server indicates to
kernel that it is fully responsible for data cache invalidation. This
functionality is essential when the data in cache are relatively big and
it is very desirable to avoid automatically clearing the data cache of
inode on file size change. The second patch of the series describes the
problem in details as well as the fix to it.

I send the change initially ~ 2 weeks ago

	https://lwn.net/ml/linux-fsdevel/20190315212556.9315-1-kirr@nexedi.com/

but had not heard from you at all. Could you please have a look?

Thanks beforehand,
Kirill

Kirill Smelkov (2):
  fuse: convert printk -> pr_*
  fuse: allow filesystems to have precise control over data cache

 fs/fuse/cuse.c            | 13 +++++++------
 fs/fuse/dev.c             |  4 ++--
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 18 +++++++++++++-----
 include/uapi/linux/fuse.h |  7 ++++++-
 5 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.21.0.392.gf8f6787159
