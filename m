Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194BF223FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424399;
	bh=tj2oqLYULvvLSyNlQMoQuuGucML1O57tO2NXSD6MMnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PjKBGiEo4zVIwQQHnVGrJOsH7AM26V5Wz4ky0Pb0mopOhehebrWWEA89uCvPh2Na8
	 5armC/BL59DokMLKq97BOp1I60GBtINNlucGml9ZOJ5NDuUUWxUsifMg6QLDn7g4dT
	 +TeXiP3LBArKNSSgEySG9s0L41EBJJPtlT027fBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfDPOT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPOT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:19:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B4F223F9;
        Tue, 16 Apr 2019 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424396;
        bh=tj2oqLYULvvLSyNlQMoQuuGucML1O57tO2NXSD6MMnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ9Ugu4BLptS71Y5CUndU9to8xBxIx9YUjFVS3nLcFphIdrBMZDUJxUnCVUWEw9a2
         vSEW5cqc+unS5wiqaxbjraJGKfzZR0TulGBDx32W9eUcJOkZTCAsDIFg0ousLmk1v0
         AnH29CN1Hp3SLE5HZvFPL/vwhq4TRu69aFODtQK4=
Date:   Tue, 16 Apr 2019 15:29:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] debugfs: make return value of all debugfs helpers
 consistent
Message-ID: <20190416132925.GA17483@kroah.com>
References: <20190415082506.25610-1-ronald@innovation.ch>
 <20190415082506.25610-3-ronald@innovation.ch>
 <20190415084844.GA26101@kroah.com>
 <20190415232959.GC13033@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415232959.GC13033@innovation.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:29:59PM -0700, Life is hard, and then you die wrote:
> 
>   Hi Greg,
> 
> On Mon, Apr 15, 2019 at 10:48:44AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 15, 2019 at 01:25:06AM -0700, Ronald Tschalär wrote:
> > > Since commit ff9fb72bc077 ("debugfs: return error values, not NULL")
> > > almost all the debugfs helpers have stopped returning NULL. The lone
> > > holdeout was debugfs_create_u32_array(). So fix that.
> > > 
> > > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > > ---
> > >  fs/debugfs/file.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index ddd708b09fa1..bb706d073782 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -999,8 +999,8 @@ static const struct file_operations u32_array_fops = {
> > >   * Once array is created its size can not be changed.
> > >   *
> > >   * The function returns a pointer to dentry on success. If an error occurs,
> > > - * %ERR_PTR(-ERROR) or NULL will be returned. If debugfs is not enabled in
> > > - * the kernel, the value %ERR_PTR(-ENODEV) will be returned.
> > > + * %ERR_PTR(-ERROR) will be returned. If debugfs is not enabled in the kernel,
> > > + * the value %ERR_PTR(-ENODEV) will be returned.
> > >   */
> > >  struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
> > >  					    struct dentry *parent,
> > > @@ -1009,7 +1009,7 @@ struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
> > >  	struct array_data *data = kmalloc(sizeof(*data), GFP_KERNEL);
> > >  
> > >  	if (data == NULL)
> > > -		return NULL;
> > > +		return ERR_PTR(-ENOMEM);
> > >  
> > >  	data->array = array;
> > >  	data->elements = elements;
> > 
> > There is only one caller of this function in the kernel now, and it does
> > not even care about the return value at all, so we should just remove
> > the return value entirely as that's the easiest and best thing to do
> > here.
> 
> Interesting argument: since this is a helper/library function, and
> therefore potentially used in the future by others, it seems to me
> that consistency with the other functions and providing error feedback
> would be important.

Not if you never actually use the return value for anything :)

> > I was going to start doing this slowly over time, but as you are
> > touching the function now, might as well do it here :)
> 
> Are you saying the plan is to make all these helpers return void?

Yes, no caller should do anything "different" based on a return value of
a debugfs call.  Note, sometimes you do want to save off dentries for
some files that you later remove, but that's it.

thanks,

greg k-h
