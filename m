Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0667BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71D2218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572453196;
	bh=R+x/BiJjAABhO4MBomPKbzt94Ok4oo5wUPTX569SJ6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQv+EvL5btnn3pfkvo39FFkyd/VDW5nHmtXmnooedOH+EHBjt8oXdcY7vdkkQBtx+
	 qQITA789nDThwKIAPX3s4YIlk73kIY6crfxl/z4CT60NiBRU9MkSy9qDE5ySrTGVxC
	 o+EI2B2QVkZvU0ecgKlQQ8WSWS1s07SOLRnLTJt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfJ3QdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3QdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:33:15 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA1D208E3;
        Wed, 30 Oct 2019 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572453194;
        bh=R+x/BiJjAABhO4MBomPKbzt94Ok4oo5wUPTX569SJ6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGba95geeKSbcCK9GWjQH/AJCr6qa7QkMYrle1YEL/ZwFd5UUcgg+TCYjJYgTBXF6
         PgpoepMXz5caV3srmydmo6B7IvFHf9OuWgvDXgt/sAtNqr7U2TcGYQl8sXUGhz60MW
         MhURFz/qimcPaK+szHYt2Tw0wv62Fvj1P0B5gmsg=
Date:   Wed, 30 Oct 2019 09:33:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Gao Xiang <hsiangkao@aol.com>, Gao Xiang <gaoxiang25@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
Message-ID: <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
 <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191030162243.GA18729@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030162243.GA18729@mit.edu>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Theodore Y. Ts'o wrote:
> On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
> > 
> > So I'm curious about the original issue in commit 740432f83560
> > ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
> > bios with its internal fio but it seems the commit is not helpful to
> > resolve potential mempool deadlock (I'm confused since no calltrace,
> > maybe I'm wrong)...
> 
> Two possibilities come to mind.  (a) It may be that on older kernels
> (when f2fs is backported to older Board Support Package kernels from
> the SOC vendors) didn't have the bio_alloc() guarantee, so it was
> necessary on older kernels, but not on upstream, or (b) it wasn't
> *actually* possible for bio_alloc() to fail and someone added the
> error handling in 740432f83560 out of paranoia.

Yup, I was checking old device kernels but just stopped digging it out.
Instead, I hesitate to apply this patch since I can't get why we need to
get rid of this code for clean-up purpose. This may be able to bring
some hassles when backporting to android/device kernels.

> 
> (Hence my suggestion that in the ext4 version of the patch, we add a
> code comment justifying why there was no error checking, to make it
> clear that this was a deliberate choice.  :-)
> 
> 						- Ted
