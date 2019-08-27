Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D64EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A420828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfH0LyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:54:24 -0400
Received: from verein.lst.de ([213.95.11.211]:56363 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0LyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:54:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87DBF68B20; Tue, 27 Aug 2019 13:54:18 +0200 (CEST)
Date:   Tue, 27 Aug 2019 13:54:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uuid: Add helpers for finding UUID from an array
Message-ID: <20190827115418.GA5921@lst.de>
References: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:49:18PM +0300, Heikki Krogerus wrote:
> Matching function that compares every UUID in an array to a
> given UUID with guid_equal().
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi,
> 
> I don't have a user for these helpers, but since they are pretty
> trivial, I figured that might as well propose them in any case.
> Though, I think there was somebody proposing of doing the same thing
> that these helpers do at one point, but just the hard way in the
> drivers, right Andy?

XFS has something similar in xfs_uuid_mount, except that it also
tracks empty slots.  That beeing said I'm pretty sure if you ask willy
he's suggest to just convert the table to an xarray instead :)

So I'm defintively curious what the users would be where we just check
a table, but don't also add something to the table.
