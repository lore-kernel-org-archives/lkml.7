Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD16C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2578A216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ou8A0T5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbfETOlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391890AbfETOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so14944528wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIkoBjfIwezg37K8GyVLa4Ib4GG1DfXOe0xDWRIHC9c=;
        b=Ou8A0T5aNjnqbPlBgwGcea2Jt9WREkncm2pZ2tzBkRLRUyzdHu/788KR2EoEZb9mkK
         Uc0cJxu+0ZffxR3RKAwpxWA+Pa4RUhS5MdKIHC+QqTBZftrk7zJrl15NN6dttqr5OpMP
         8xroeKkE6/8JUdYcncxaCbltjgHZuJY1yQojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIkoBjfIwezg37K8GyVLa4Ib4GG1DfXOe0xDWRIHC9c=;
        b=f3ahCJsoIYXTDpceZ7DjHnf1r3ek5aMtCXrGGZz1ahHASMr3vEUTLNo23GTRDU6SCY
         aczLStldswlTg8tt727yvI9HUeP/c4hPS1VG0arPe2dXrdicqhHi8qy0TWocFNSbuKVb
         i/7GIb/6sShCKK5pRWWc+5BFMzCc6ebYi040HMugbJ8bHi6N7KI12FuSSRp4Zr8R42yS
         9jM/h+8gUgofy5tUWeJ2wREV6t63fbHCN+wTPrNgZIkLA838gCjzVbG0ULNYXKKM053/
         YtPulE7x/FFDq1rfDOOWebsFDSbx4GdCWrU6KokkTrV55pErfZYoRP/0bkhJpe9CvP5n
         5ZFg==
X-Gm-Message-State: APjAAAUerfeTeF/7HNO0VxPwYK6DBbuZQJq6ehyTH8SSrocKfCm0iTkL
        e2DQq5IdWG4q6pPngj35ItBHoQ==
X-Google-Smtp-Source: APXvYqyUmEWgtNuNz/KLPkSE1Lwvd2WXTdR3OckfDP8fsKM/AbqeGou/Yo4wcQWm5VhE6j5qlpjEbQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr10213096wrw.152.1558363305299;
        Mon, 20 May 2019 07:41:45 -0700 (PDT)
Received: from localhost.localdomain (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id n1sm12945556wmc.19.2019.05.20.07.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 07:41:44 -0700 (PDT)
Date:   Mon, 20 May 2019 16:41:37 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        stefanha@redhat.com, dgilbert@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
Message-ID: <20190520144137.GA24093@localhost.localdomain>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515192715.18000-3-vgoyal@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 03:26:47PM -0400, Vivek Goyal wrote:
> If fuse daemon is started with cache=never, fuse falls back to direct IO.
> In that write path we don't call file_remove_privs() and that means setuid
> bit is not cleared if unpriviliged user writes to a file with setuid bit set.
> 
> pjdfstest chmod test 12.t tests this and fails.

I think better sulution is to tell the server if the suid bit needs to be
removed, so it can do so in a race free way.

Here's the kernel patch, and I'll reply with the libfuse patch.

---
 fs/fuse2/file.c           |    2 ++
 include/uapi/linux/fuse.h |    3 +++
 2 files changed, 5 insertions(+)

--- a/fs/fuse2/file.c
+++ b/fs/fuse2/file.c
@@ -363,6 +363,8 @@ static ssize_t fuse_send_write(struct fu
 		inarg->flags |= O_DSYNC;
 	if (iocb->ki_flags & IOCB_SYNC)
 		inarg->flags |= O_SYNC;
+	if (!capable(CAP_FSETID))
+		inarg->write_flags |= FUSE_WRITE_KILL_PRIV;
 	req->inh.opcode = FUSE_WRITE;
 	req->inh.nodeid = ff->nodeid;
 	req->inh.len = req->inline_inlen + count;
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -125,6 +125,7 @@
  *
  *  7.29
  *  - add FUSE_NO_OPENDIR_SUPPORT flag
+ *  - add FUSE_WRITE_KILL_PRIV flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -318,9 +319,11 @@ struct fuse_file_lock {
  *
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
+ * FUSE_WRITE_KILL_PRIV: kill suid and sgid bits
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
+#define FUSE_WRITE_KILL_PRIV	(1 << 2)
 
 /**
  * Read flags


