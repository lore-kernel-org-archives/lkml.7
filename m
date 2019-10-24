Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61ECCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F5B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfJXUee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:34:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34802 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbfJXUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:34:34 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9OKYJcq008461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 16:34:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 19C74420456; Thu, 24 Oct 2019 16:34:19 -0400 (EDT)
Date:   Thu, 24 Oct 2019 16:34:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Boaz Harrosh <openosd@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: File system for scratch space (in HPC cluster)
Message-ID: <20191024203419.GG1124@mit.edu>
References: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
 <20191024145504.GD1124@mit.edu>
 <70755c40-b800-8ba0-a0df-4206f6b8c8d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70755c40-b800-8ba0-a0df-4206f6b8c8d4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 06:01:05PM +0300, Boaz Harrosh wrote:
> > You could use ext4 in nojournal mode.  If you want to make sure that
> > fsync() doesn't force a cache flush, you can mount with the nobarrier
> > mount option.
> 
> And open the file with O_TMPFILE|O_EXCL so there is no metadata as well.

O_TMPFILE means that there is no directory entry created.  The
pathname passed to the open system call is the directory specifying
the file system where the temporary file will be created.

This may or may not be what the original poster wanted, depending on
whether by "scratch file" he meant a file which could be opened by
pathname by another, subsequent process or not.

    	 	      	  	    	 - Ted
