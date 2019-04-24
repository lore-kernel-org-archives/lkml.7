Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE78C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978AA20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDXENA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:13:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45870 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXENA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:13:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hJ9HC-0001md-Vb; Wed, 24 Apr 2019 04:12:55 +0000
Date:   Wed, 24 Apr 2019 05:12:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     dushistov@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ufs: Force type conversion from __fs16 to u16
Message-ID: <20190424041254.GO2217@ZenIV.linux.org.uk>
References: <20190423090118.GA465@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423090118.GA465@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:31:18PM +0530, Bharath Vedartham wrote:
> This patch fixes the sparse warning:
> warning: restricted __fs16 degrades to integer
> 
> inode->ui_u1.oldids.ui_suid is of type __fs16, a restricted integer.
> 0XFFFF is a 16 bit unsigned integer. Use __force to fix the sparse
> warning.

NAK.  As always, ask whether the code is correct and if so, why is
it correct.  Here, of course, the answer is that 16bit value with
all bits set is the same regardless of endianness.  If it was
le16, we could simply write cpu_to_le16(0xffff) and let the compiler
fold the constant expression; for fs16 it's beyond what gcc can
(reliably) do - you get essentially
	UFS_SB(sbp)->s_bytesex == BYTESEX_LE
		? (unsigned short)0xffff
		: (unsigned short)0xffff
which would be nice to optimize to 0xffff, but it's not guaranteed
to happen.

So let's do this:

static inline bool ufs_reserved_uid(__fs16 uid)
{
	return (__fs16)~uid == 0;	/* all 16 bits set */
}

and use it in... wait.  Wait, it *is* broken.  Look:
static inline u32
ufs_get_inode_uid(struct super_block *sb, struct ufs_inode *inode)
{
        switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
        case UFS_UID_44BSD:
                return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_uid);
        case UFS_UID_EFT:
                if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
                        return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_uid);
                /* Fall through */
        default:
                return fs16_to_cpu(sb, inode->ui_u1.oldids.ui_suid);
        }
}

OK, so
	* old flavours: 16bit uids, stored in ->ui_u1.oldids.ui_suid
(offset 4)
	* new flavours (44bsd, ufs2, openstep): 32bit uids, stored in
->ui_u3.ui_44.ui_uid (offset 0x70)
	* Solaris flavours (sun, sunx86): 32bit uids; if smaller than
0xffff, stored where old flavours used to, if greater or equal -
stored in ->ui_u3.ui_sun.ui_uid (offset 0x74), with 0xffff stored
in the old place.

Makes sense, and ufs_set_inode_uid() matches that (with extra
piece of information - for new flavours the lower 16 bits of uid
are duplicated into the old place, for solaris - min(uid, 0xffff)
goes there).  However, the other place with similar logics is
static inline u32
ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
{
        switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
        case UFS_UID_44BSD:
                return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
        case UFS_UID_EFT:
                if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
                        return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
                /* Fall through */
        default:
                return fs16_to_cpu(sb, inode->ui_u1.oldids.ui_sgid);
        }
}

See the problem?  For Solaris flavours we check the old *UID* location
to decide whether we want the new GID one or the old GID one.  That
makes no sense - after all, setting UID=1000, GID=80000 should be possible,
and that couldn't work; we would get 1000 stored in old UID location,
80000 - in new GID one, so this ufs_get_inode_gid() would end up
returning the old GID field, which is 16bit and could not store
80000, no matter what.

	So we have a braino in ufs_get_inode_gid(), AFAICS since
252e211e90ce5 ("Add in SunOS 4.1.x compatible mode for UFS").
It should go
                if (inode->ui_u1.oldids.ui_sgid == 0xFFFF)
                        return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
instead of checking ui_suid...

	The breakage there isn't what sparse complained about, but it
still needs fixing.  IMO it should go in two steps: first

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011ea623..7fd4802222b8 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -229,7 +229,7 @@ ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
 	case UFS_UID_44BSD:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
 	case UFS_UID_EFT:
-		if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
+		if (inode->ui_u1.oldids.ui_sgid == 0xFFFF)
 			return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
 		/* Fall through */
 	default:
then introduction of

static inline bool solaris_xid_overflow(__fs16 xid)
{
	/*
	 * Solaris indicates the use of 32bit [UG]ID by storing
	 * all-ones bit pattern in the corresponding old (16bit) field
	 */
	return (__fs16)~xid == 0;	/* all 16 bits set */
}

with these two lines turned into
                if (solaris_xid_overflow(inode->ui_u1.oldids.ui_suid))
and
                if (solaris_xid_overflow(inode->ui_u1.oldids.ui_sgid))
resp.
