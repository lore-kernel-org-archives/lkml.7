Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D4CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB92054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfJ3QXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:23:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41030 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726665AbfJ3QXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:23:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9UGMhhq017904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 12:22:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C3B8420456; Wed, 30 Oct 2019 12:22:43 -0400 (EDT)
Date:   Wed, 30 Oct 2019 12:22:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
Message-ID: <20191030162243.GA18729@mit.edu>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
 <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
> 
> So I'm curious about the original issue in commit 740432f83560
> ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
> bios with its internal fio but it seems the commit is not helpful to
> resolve potential mempool deadlock (I'm confused since no calltrace,
> maybe I'm wrong)...

Two possibilities come to mind.  (a) It may be that on older kernels
(when f2fs is backported to older Board Support Package kernels from
the SOC vendors) didn't have the bio_alloc() guarantee, so it was
necessary on older kernels, but not on upstream, or (b) it wasn't
*actually* possible for bio_alloc() to fail and someone added the
error handling in 740432f83560 out of paranoia.

(Hence my suggestion that in the ext4 version of the patch, we add a
code comment justifying why there was no error checking, to make it
clear that this was a deliberate choice.  :-)

						- Ted
