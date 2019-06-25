Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4612084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfFYKge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728377AbfFYKge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:36:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2921ACCE;
        Tue, 25 Jun 2019 10:36:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A1B321E4323; Tue, 25 Jun 2019 12:30:19 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:30:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
Message-ID: <20190625103019.GA1994@quack2.suse.cz>
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604123158.12741-2-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-06-19 07:31:58, Steve Magnani wrote:
> In some cases, using the 'truncate' command to extend a UDF file results
> in a mismatch between the length of the file's extents (specifically, due
> to incorrect length of the final NOT_ALLOCATED extent) and the information
> (file) length. The discrepancy can prevent other operating systems
> (i.e., Windows 10) from opening the file.
> 
> Two particular errors have been observed when extending a file:
> 
> 1. The final extent is larger than it should be, having been rounded up
>    to a multiple of the block size.
> 
> B. The final extent is not shorter than it should be, due to not having
>    been updated when the file's information length was increased.
> 
> The first case could represent a design error, if coded intentionally
> due to a misinterpretation of scantily-documented ECMA-167 "file tail"
> rules. The standard specifies that the tail, if present, consists of
> a sequence of "unrecorded and allocated" extents (only).
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the testcase and the patch! I finally got to reading through
this in detail. In udf driver in Linux we are generally fine with the last
extent being rounded up to the block size. udf_truncate_tail_extent() is
generally responsible for truncating the last extent to appropriate size
once we are done with the inode. However there are two problems with this:

1) We used to do this inside udf_clear_inode() back in the old days but
then switched to a different scheme in commit 2c948b3f86e5f "udf: Avoid IO
in udf_clear_inode". So this actually breaks workloads where user calls
truncate(2) directly and there's no place where udf_truncate_tail_extent()
gets called.

2) udf_extend_file() sets i_lenExtents == i_size although the last extent
isn't properly rounded so even if udf_truncate_tail_extent() gets called
(which is actually the case for truncate(1) which does open, ftruncate,
close), it will think it has nothing to do and exit.

Now 2) is easily fixed by setting i_lenExtents to real length of extents we
have created. However that still leaves problem 1) which isn't easy to deal
with. After some though I think that your solution of making
udf_do_extend_file() always create appropriately sized extents makes
sense. However I dislike the calling convention you've chosen. When
udf_do_extend_file() needs to now byte length, then why not pass it to it
directly, instead of somewhat cumbersome "sector length + byte offset"
pair?

Will you update the patch please? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
