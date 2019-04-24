Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48256C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EA3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="dhsGnqpY";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="AWMhRKj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfDXTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:17:02 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:28385 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDXTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=4ZV1+6WWUjQQwp+YJVOZQCaezaAssmtO2tAV4MGZuUk=;
 b=dhsGnqpYB9U+x4Baw7xYl8xFIm5yz0s3LHfzBraSrXlYvN1vIWBbMs8wg2y9Ly2fqi49VmJm2yaK
   Ss7Ym9g9RFBs0OWHyOzcDam40OkREouiwZ/P197fk/Gc0Z4msCEq+rjtI2ltxo6Y4NxFArSauU+a
   Yp/D/IAuWbmLzPf5pA4=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho2r2o1sar8e for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 19:16:59 +0000 (envelope-from <bounce-md_31050260.5cc0b62b.v1-013a07261fae4b1588fbab655730c737@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556133419; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=4ZV1+6WWUjQQwp+YJVOZQCaezaAssmtO2tAV4MGZuUk=; 
 b=AWMhRKj+XjOnDr2ZZ7rdbLsN29tfKeTshWeRuXNG61WRSLOv5bpH6thN290cW4MXbph/yx
 k3Zkg0qDawE/pJUW3g23Dq4FU6wGIo1wfezxr6NC1A1lziiWtZPtJ+PPiTL8tEDmODnPeiQ6
 t63RBYWq8q+U9+akf3mShrRpA6Tnk=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND, PATCH 3/3] fuse: Add FOPEN_STREAM and use stream_open() if filesystem returned that from open handler
Received: from [87.98.221.171] by mandrillapp.com id 013a07261fae4b1588fbab655730c737; Wed, 24 Apr 2019 19:16:59 +0000
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>, <stable@vger.kernel.org>
Message-Id: <20190424191652.GE3798@deco.navytux.spb.ru>
References: <20190424071316.11967-1-kirr@nexedi.com> <20190424160611.2A71321900@mail.kernel.org>
In-Reply-To: <20190424160611.2A71321900@mail.kernel.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.013a07261fae4b1588fbab655730c737
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 19:16:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello up there,

On Wed, Apr 24, 2019 at 04:06:10PM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: 3.14=
+
> 
> The bot has tested the following trees: v5.0.9, v4.19.36, v4.14.113, v4.9=
.170, v4.4.178, v3.18.138.
> 
> v5.0.9: Build failed! Errors:
>     fs/fuse/file.c:185:3: error: implicit declaration of function =E2=80=
=98stream_open=E2=80=99; did you mean =E2=80=98seq_open=E2=80=99? [-Werror=
=3Dimplicit-function-declaration]

This patch needs "fs: stream_open - opener for stream-like files so that
read and write can run simultaneously without deadlock" (10dce8af3422)
as its dependency. It documents so in its commit message. That base
dependency patch is being discussed here in stable context:

https://lore.kernel.org/linux-fsdevel/20190424183012.GB3798@deco.navytux.sp=
b.ru/


> v4.19.36: Failed to apply! Possible dependencies:
>     6433b8998a21 ("fuse: add FOPEN_CACHE_DIR")
>     88bc7d5097a1 ("fuse: add support for copy_file_range()")

"fuse: add FOPEN_CACHE_DIR" added another nearby constant. The conflict
with that patch should be trivially resolvable (just add FOPEN_STREAM
irregardless that there is no FOPEN_CACHE_DIR in context).

> v4.14.113: Failed to apply! Possible dependencies:
>     3b7008b226f3 ("fuse: return -ECONNABORTED on /dev/fuse read after abo=
rt")
>     6433b8998a21 ("fuse: add FOPEN_CACHE_DIR")
>     88bc7d5097a1 ("fuse: add support for copy_file_range()")

same.

> v4.9.170: Failed to apply! Possible dependencies:
>     3b7008b226f3 ("fuse: return -ECONNABORTED on /dev/fuse read after abo=
rt")
>     6433b8998a21 ("fuse: add FOPEN_CACHE_DIR")
>     88bc7d5097a1 ("fuse: add support for copy_file_range()")

----//----

> v4.4.178: Failed to apply! Possible dependencies:
>     29433a2991fa ("fuse: get rid of fc->flags")
>     3767e255b390 ("switch ->setxattr() to passing dentry and inode separa=
tely")
>     60bcc88ad185 ("fuse: Add posix ACL support")
>     6192269444eb ("introduce a parallel variant of ->iterate()")
>     6433b8998a21 ("fuse: add FOPEN_CACHE_DIR")
>     6b2553918d8b ("replace ->follow_link() with new method that could sta=
y in RCU mode")
>     703c73629f93 ("fuse: Use generic xattr ops")
>     84e710da2a1d ("parallel lookups machinery, part 2")
>     88bc7d5097a1 ("fuse: add support for copy_file_range()")
>     9902af79c01a ("parallel lookups: actual switch to rwsem")
>     9cf843e3f47c ("lookup_open(): lock the parent shared unless O_CREAT i=
s given")
>     aa80deab33a8 ("namei: page_getlink() and page_follow_link_light() are=
 the same thing")
>     cd3417c8fc95 ("kill free_page_put_link()")
>     ce23e6401334 ("->getxattr(): pass dentry and inode as separate argume=
nts")
>     fceef393a538 ("switch ->get_link() to delayed_call, kill ->put_link()=
")

similar

> v3.18.138: Failed to apply! Possible dependencies:
>     09561a53b50d ("lustre: use %p[dD]")
>     29433a2991fa ("fuse: get rid of fc->flags")
>     2b0143b5c986 ("VFS: normal filesystems (and lustre): d_inode() annota=
tions")
>     3767e255b390 ("switch ->setxattr() to passing dentry and inode separa=
tely")
>     60bcc88ad185 ("fuse: Add posix ACL support")
>     6192269444eb ("introduce a parallel variant of ->iterate()")
>     6433b8998a21 ("fuse: add FOPEN_CACHE_DIR")
>     680baacbca69 ("new ->follow_link() and ->put_link() calling conventio=
ns")
>     6b2553918d8b ("replace ->follow_link() with new method that could sta=
y in RCU mode")
>     6e77137b363b ("don't pass nameidata to ->follow_link()")
>     703c73629f93 ("fuse: Use generic xattr ops")
>     84e710da2a1d ("parallel lookups machinery, part 2")
>     88bc7d5097a1 ("fuse: add support for copy_file_range()")
>     90e4fc8890da ("9p: don't bother with __getname() in ->follow_link()")
>     9902af79c01a ("parallel lookups: actual switch to rwsem")
>     9cf843e3f47c ("lookup_open(): lock the parent shared unless O_CREAT i=
s given")
>     a06ae8609b3d ("coresight: add CoreSight core layer framework")
>     ce23e6401334 ("->getxattr(): pass dentry and inode as separate argume=
nts")
>     dab363f938a5 ("Merge tag 'staging-3.19-rc1' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/gregkh/staging")
>     fceef393a538 ("switch ->get_link() to delayed_call, kill ->put_link()=
")

similar

> How should we proceed with this patch?

I have backported this patch to above those stable trees. You can pull
the result from https://lab.nexedi.com/kirr/linux.git, branches:

=09fopen_stream-5.0.y
=09fopen_stream-4.19.y
=09fopen_stream-4.14.y
=09fopen_stream-4.4.y
=09=09( actually fixed deadlock on /proc/xen/xenbus as
=09=09  581d21a2d02a was not backported to 4.4 )
=09fopen_stream-3.18.y
=09=09( actually fixed deadlock on /proc/xen/xenbus as
=09=09  581d21a2d02a was not backported to 3.18 )


Hope it helps a bit,

Kirill

P.S.

The fact that 4.4 and 3.18 versions of stream_open patch had to
resolve xenbus conflict in a way that actually fixes /proc/xen/xenbus
deadlock (introduced in 3.14) suggests that deadlock error messages
produced by stream_open.cocci should indeed be considered by relevant
maintainers including stable team...

