Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E9F229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563969015;
	bh=7cDmvSdXx7R91mdbB8raYepiGCr+m08yAbZBHR6nYms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=cnyGinjOWoDiSa6KDFbyU5gk5ESN6NTF83W9uyNzyvedfOXJIilbO2iWrq/NuzAcx
	 i75OpHIPS5BEVZgxrLwdcwNxoHKhubz8xL65+dAsZWEh8Oax089N+D64bQzRZjGoPz
	 S9CPf6Iv3KX5xNHipYEEoVVOkCC9lnrn4lFYehcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfGXLuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387393AbfGXLuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:50:14 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471DD22387;
        Wed, 24 Jul 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563969012;
        bh=7cDmvSdXx7R91mdbB8raYepiGCr+m08yAbZBHR6nYms=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HwI4hRn8vZRUDokkkUOJfg9Xhuenbsj49RncrNPNpO8Cm3fOXbbCqZ6Z3CnpcHfgc
         JeUw3gNzprlxW6Cu30LDt/Z6yVkERqlH98BtI3dkAqyv8/+qLsql6AG3xxr0h+PrS2
         mowlt3kiH4Uyld9M6J8Tv5MFawosXYwfPjfQnptw=
Message-ID: <49ef4b704f7925c584a2bab6650648ba456b5717.camel@kernel.org>
Subject: Re: [RFC PATCH] ceph: fix directories inode i_blkbits initialization
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 07:50:11 -0400
In-Reply-To: <874l3b694l.fsf@suse.com>
References: <20190723155020.17338-1-lhenriques@suse.com>
         <c657b0d65acd5e8bc9d5d726d68e2ad1fff38b51.camel@kernel.org>
         <87o91k61sr.fsf@suse.com> <874l3b694l.fsf@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 11:04 +0100, Luis Henriques wrote:
> Luis Henriques <lhenriques@suse.com> writes:
> 
> > "Jeff Layton" <jlayton@kernel.org> writes:
> > 
> > > On Tue, 2019-07-23 at 16:50 +0100, Luis Henriques wrote:
> > > > When filling an inode with info from the MDS, i_blkbits is being
> > > > initialized using fl_stripe_unit, which contains the stripe unit in
> > > > bytes.  Unfortunately, this doesn't make sense for directories as they
> > > > have fl_stripe_unit set to '0'.  This means that i_blkbits will be set
> > > > to 0xff, causing an UBSAN undefined behaviour in i_blocksize():
> > > > 
> > > >   UBSAN: Undefined behaviour in ./include/linux/fs.h:731:12
> > > >   shift exponent 255 is too large for 32-bit type 'int'
> > > > 
> > > > Fix this by initializing i_blkbits to CEPH_BLOCK_SHIFT if fl_stripe_unit
> > > > is zero.
> > > > 
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > > ---
> > > >  fs/ceph/inode.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > Hi Jeff,
> > > > 
> > > > To be honest, I'm not sure CEPH_BLOCK_SHIFT is the right value to use
> > > > here, but for sure the one currently being used isn't correct if the
> > > > inode is a directory.  Using stripe units seems to be a bug that has
> > > > been there since the beginning, but it definitely became bigger problem
> > > > after commit 69448867abcb ("fs: shave 8 bytes off of struct inode").
> > > > 
> > > > This fix could also be moved into the 'switch' statement later in that
> > > > function, in the S_IFDIR case, similar to commit 5ba72e607cdb ("ceph:
> > > > set special inode's blocksize to page size").  Let me know which version
> > > > you would prefer.
> > > > 
> > > 
> > > What happens with (e.g.) named pipes or symlinks? Do those inodes also
> > > get this bogus value? Assuming that they do, I'd probably prefer this
> > > patch since it'd fix things for all inode types, not just directories.
> > 
> > I tested symlinks and they seem to be handled correctly (i.e. the stripe
> > units seems to be the same as the target file).  Regarding pipes, I
> > didn't test them, but from the code it should be set to PAGE_SHIFT (see
> > the above mentioned commit 5ba72e607cdb).
> 
> Ok, after looking closer at the other inode types and running a few
> tests with extra debug code, it all seems to be sane -- only directories
> (root dir is an exception) will cause problems with i_blkbits being set
> to a bogus value.  So, I'm sticking with my original RFC patch approach,
> which should be easy to apply to stable kernels.
> 
> Cheers,

Sounds good. I'll just plan to merge your RFC patch, after I run some
more tests on it.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

