Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DAA207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAASLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:11:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46907 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727237AbgAASLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:11:07 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 001IAtE2003793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Jan 2020 13:10:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D366E420485; Wed,  1 Jan 2020 13:10:54 -0500 (EST)
Date:   Wed, 1 Jan 2020 13:10:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20200101181054.GB191637@mit.edu>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 04:54:18PM -0600, Eric Sandeen wrote:
> > Because I was not able to find any documentation for it, what is format
> > of passed buffer... null-term string? fixed-length? and in which
> > encoding? utf-8? latin1? utf-16? or filesystem dependent?
> 
> It simply copies the bits from the memory location you pass in, it knows
> nothing of encodings.
> 
> For the most part it's up to the filesystem's own utilities to do any
> interpretation of the resulting bits on disk, null-terminating maximal-length
> label strings, etc.

I'm not sure this is going to be the best API design choice.  The
blkid library interprets the on disk format for each file syustem
knowing what is the "native" format for that particular file system.
This is mainly an issue only for the non-Linux file systems; for the
Linux file system, the party line has historically been that we don't
get involved with character encoding, but in practice, what that has
evolved into is that userspace has standardized on UTF-8, and that's
what we pass into the kernel from userspace by convention.

But the problem is that if the goal is to make FS_IOC_GETFSLABEL and
FS_IOC_SETFSLABEL work without the calling program knowing what file
system type a particular pathname happens to be, then it would be
easist for the userspace program if it can expect that it can always
pass in a null-terminated UTF-8 string, and get back a null-terminated
UTF-8.  I bet that in practice, that is what most userspace programs
are going to be do anyway, since it works that way for all other file
system syscalls.

So for a file system which is a non-Linux-native file system, if it
happens to store the its label using utf-16, or some other
Windows-system-silliness, it would work a lot better if it assumed
that it was passed in utf-8, and stored in the the Windows file system
using whatever crazy encoding Windows wants to use.  Otherwise, why
bother uplifting the ioctl to one which is file system independent, if
the paramters are defined to be file system *dependent*?

    	      	  	     	- Ted
