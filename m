Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DC3C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ACD2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfDURCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:02:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32940 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDURCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:02:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hIFrP-0005K2-A3; Sun, 21 Apr 2019 17:02:35 +0000
Date:   Sun, 21 Apr 2019 18:02:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>, jannh@google.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190421170235.GI2217@ZenIV.linux.org.uk>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
 <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:50:19PM -0700, Andrew Morton wrote:
> On Wed, 17 Apr 2019 17:22:00 +0530 Bharath Vedartham <linux.bhar@gmail.com> wrote:
> 
> > This patch fixes the sparse warning:
> > 
> > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > expression (different base types)
> > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > expression (different base types)
> > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > 
> > csum_partial returns restricted integer __wsum whereas xattr_hash
> > expects a return type of __u32.
> > 
> > ...
> >
> > --- a/fs/reiserfs/xattr.c
> > +++ b/fs/reiserfs/xattr.c
> > @@ -450,7 +450,7 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
> >  
> >  static inline __u32 xattr_hash(const char *msg, int len)
> >  {
> > -	return csum_partial(msg, len, 0);
> > +	return (__force __u32)csum_partial(msg, len, 0);
> >  }
> >  
> >  int reiserfs_commit_write(struct file *f, struct page *page,
> 
> hm.  Conversion from int to __u32 should be OK - why is sparse being so
> picky here?

Because csum_partial() returns __wsum_t, not int.

> Why is the __force needed, btw?

So that accidental mixing of those csums (both 16bit and 32bit) with
host- or net-endian would be caught.

And I'm not at all sure reiserfs xattr_hash() doesn't bugger it up, actually.

Recall that 16bit inet csum is the sum of 16bit words (treated as host-endian)
modulo 0xffff, i.e. the entire buffer interpreted as host-endian integer
taken modulo 0xffff.  That has a lovely property - memory representation
of that value is the same whether we'd done calculations on b-e or l-e
host; the reason is that modulo 65535 byteswap is the same as multiplying
by 256, so the sum of byteswapped 16bit values modulo 65535 is byteswapped
sum of original values.

csum_partial() is sum of 32bit words (treated as host-endian) modulo 0xffffffff,
i.e. the entire buffer treated as host-endian number modulo 0xffffffff.
It is convenient when we want to calculate the 16bit csum - 0xffffffff is
a multiple of 0xffff, so residue modulo 0xffffffff determines the residue
modulo 0xffff; that's what csum_fold() is.

However, result of csum_partial() on big- and little-endian hosts
does *not* have the same property.  Consider e.g. an array {0, 0, 0, 128,
0, 0, 0, 128}.  csum_partial of that on l-e will be (2^31 + 2^31)mod(2^32 - 1),
i.e. 1, with {1, 0, 0, 0} as memory representation.  16bit csum will
again be 1, with {1, 0} as memory representation.  On big-endian we
get (128 + 128)mod(2^32 - 1), i.e. 256, with {0, 0, 1, 0} as memory
representation.  16bit csum is again 256, stored as {1, 0}, i.e.
the same as if we'd done everything on l-e; however, raw csum_partial()
values have different memory representations.  They certainly are
different as host-endian (and so are 16bit csums).

Reiserfs takes csum_partial() on buffer, interprets it as host-endian
and stores it little-endian on disk.  When fetching those it does
the same calculation and fails on mismatch.  However, if the
store had been done on little-endian host and load - on big-endian
one we *will* get mismatch almost all the time.  Treating ->rx_hash
as __wsum_t (and not doing that cpu_to_le32()) would lower the
frequency of mismatches, but still would be broken.  Storing
a 16bit csum (declared as __sum16_t, again, without cpu_to_le...())
would be endian-safe, but that's not what reiserfs folks wanted
(16 bits of csum instead of 32, for starters).

IOW, what sparse has caught here is a genuine endianness bug; images
created on little-endian host and mounted on big-endian (or vice
versa) will see csum mismatches when trying to fetch xattrs.
Broken since
commit 0b1a6a8ca8a78c2e068b04acf97479ee89a024ac
Author: Andrew Morton <akpm@osdl.org>
Date:   Sun May 9 23:59:13 2004 -0700

    [PATCH] reiserfs: xattr support
    
    From: Chris Mason <mason@suse.com>
    
    From: jeffm@suse.com
    
    reiserfs support for xattrs

ISTR some discussions of reiserfs layout endianness problems, but
that had been many years ago and I could be wrong; I _think_
the conclusion had been "it sucks, but we can't do anything
without breaking existing filesystem images".  Not sure if that
was the same bug or something different, though.
