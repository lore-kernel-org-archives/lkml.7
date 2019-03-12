Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35667C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DF2214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfCLGHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:07:40 -0400
Received: from trent.utfs.org ([94.185.90.103]:40492 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfCLGHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:07:39 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id D78FE6414A;
        Tue, 12 Mar 2019 07:07:36 +0100 (CET)
Date:   Mon, 11 Mar 2019 23:07:36 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <2827.1552315718@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.999.1903112235120.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903080954040.21644@trent.utfs.org> <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk>
 <17155.1552056554@warthog.procyon.org.uk> <2827.1552315718@warthog.procyon.org.uk>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1184995494-918711500-1552370856=:21644"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1184995494-918711500-1552370856=:21644
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Mar 2019, David Howells wrote:
> I've a couple more patches for you - one a bugfix and one that will print more
> information.  They don't actually affect the problem you're seeing.  I'll post
> them as replies to this message.

Thanks for the patches. I've applied all three to v5.0 and ran 
"nfstest_cache" and was able to reproduce the messages. Please note that 
I'm only running "nfstest_cache" because it's somehow able to reproduce 
the message reliably - otherwise the message just shows up once or twice 
in syslog, but I didn't know how to reproduce it.

But I noticed something else this time, and I did not notice that before: 
while running nfstest_cache, the "duplicate cookie" messages were only 
triggered when my other, non-test mount was also mounted during the test. 
Let me describe my F29 test VM again:

* VM boots, and /usr/local/src gets mounted via NFS, read-only, and
  with w/o fsc options. cachefilesd isn't even installed here.

* I run nfstest_cache and apparently it's mounting the same NFS export
  from the server to /mnt/t, as a readonly mount.

So two mounts, one in /usr/local/src, the other in /mnt/t, both readonly 
and both w/o "fsc", but the "duplicate cookie" message is only printed 
when /usr/local/src was mounted. If /usr/local/src wasn't mounted, the 
test would complete[0] and no "duplicate message was printed. And then I 
noticed:

----------------------------------------------------------
$ mount | tail -2 | fold
horus:/usr/local/src on /usr/local/src type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255, 
hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.56.139, 
local_lock=none,addr=192.168.0.115)

horus:/ on /mnt/t type nfs4 
(rw,relatime,vers=4.1,rsize=4096,wsize=4096,namlen=255, 
hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.56.139, 
local_lock=none,addr=192.168.0.115) 
----------------------------------------------------------

My /usr/local/src mount was mounted with vers=4.2 (default), while 
nfstest_cache was mounting its test-mount with vers=4.1! Apart from the 
different rsize/wsize values, the version number stood out. And indeed, 
when I mount my regular NFS mount /usr/local/src with vers=4.1, the 
"duplicate cookie" is no longer printed.

For simplicity, I've attached two logs to this email:

* nfs_no-mount.txt.xz - showing /proc/fs/nfsfs/volumes and
  /proc/fs/fscache/stats every 0.01 seconds, while running nfstest_cache
  in another terminal. Note that no duplicate "cookie messages" were 
  triggered, as /usr/local/src was not mounted.

* nfs_with-mount.txt.xz - same, but here /usr/local/src was mounted (and 
  defaulted to vers=4.2), and thus "duplicate cookie" messages were 
  printed.


I fear that all this may complicate this strange behaviour, and now we're 
examining NFS mount versions, but I only noticed that now, not earlier :-\

I can't comment on the patches much, as you mentioned they won't make the 
message go away, but I hope it printed more details now.

Thanks,
Christian.


[0] Again, I'm using nfstest_cache only to trigger the message. Everytime
    I execute it, the test fails, because I think it expects a rw-mount:

 $ nfstest_cache --server horus --client fedora0 --runtest=acregmin_attr
 *** Verify consistency of attribute caching with NFSv4.1 on a file 
 acregmin = 10
     TEST: Running test 'acregmin_attr'
     FAIL: Traceback (most recent call last):
            File "/usr/bin/nfstest_cache", line 199, in do_file_test
              fdw = open(self.absfile, "w")
            IOError: [Errno 30] Read-only file system: 
 '/mnt/t/nfstest_cache_20190311223404_f_1'
    TIME: 4.497078s
 1 tests (0 passed, 1 failed)
 Total time: 5.529826s

-- 
BOFH excuse #209:

Only people with names beginning with 'A' are getting mail this week (a la Microsoft)
---1184995494-918711500-1552370856=:21644
Content-Type: application/x-xz; name=nfs_with-mount.txt.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.999.1903112307360.21644@trent.utfs.org>
Content-Description: 
Content-Disposition: attachment; filename=nfs_with-mount.txt.xz

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
u0oAwBWfe7HEZ/sCAAAAAARZWg==

---1184995494-918711500-1552370856=:21644
Content-Type: application/x-xz; name=nfs_no-mount.txt.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.999.1903112307361.21644@trent.utfs.org>
Content-Description: 
Content-Disposition: attachment; filename=nfs_no-mount.txt.xz

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
AAAEWVo=

---1184995494-918711500-1552370856=:21644--
