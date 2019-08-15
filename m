Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D243F2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565904365;
	bh=5Ugqec8YhmCnrPP32IJ/uvLwQWW92jUjH6BSVw/2Cgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X9gUqteYhkE2b/tmoDUpeAQxsWJ9CF5H/247NPFtw2cEcBBrJBzKnPglYUMkrFOiP
	 Wy8YXAba9Jl7F2Ccfc2MtKIrN/1R+qqWfiF485CvV7fGpdl49SdXC41sOduw3SlCG9
	 2HJk72lKeVTjADAnOYMw5icDqRSgFkGv3ry4wAL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfHOV0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbfHOV0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:26:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95348205F4;
        Thu, 15 Aug 2019 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565904363;
        bh=5Ugqec8YhmCnrPP32IJ/uvLwQWW92jUjH6BSVw/2Cgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vgofVdxYzsfoQkF8U6ffc2JgVmgrzu1zI+UgfLegltxwbMKjtbCQK6ZUAW3SBNTzO
         K8//ihIQdaYsxDFhpb8cIGKfdJfZ/EyrSoi3bT7tR0SXLQufSLefkVbCN2U4pkRo6Q
         PwzLBT5iSvICmjCoo7a0i+OOHz0YYqXbh4v2pmC0=
Date:   Thu, 15 Aug 2019 14:26:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, tytso@mit.edu, viro@zeniv.linux.org.uk,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH RFC 3/2] fstests: check that we can't write to swap
 files
Message-Id: <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
In-Reply-To: <20190815163434.GA15186@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
        <20190815163434.GA15186@magnolia>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 09:34:34 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:

> While active, the media backing a swap file is leased to the kernel.
> Userspace has no business writing to it.  Make sure we can't do this.

I don't think this tests the case where a file was already open for
writing and someone does swapon(that file)?

And then does swapoff(that file), when writes should start working again?

Ditto all the above, with s/open/mmap/.


Do we handle (and test!) the case where there's unwritten dirty
pagecache at the time of swapon()?  Ditto pte-dirty MAP_SHARED pages?
