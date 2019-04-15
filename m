Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B120830
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="HGElDRzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfDOX37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:29:59 -0400
Received: from chill.innovation.ch ([216.218.245.220]:58492 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfDOX37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:29:59 -0400
Date:   Mon, 15 Apr 2019 16:29:59 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 1AC19640135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555370999;
        bh=BuOtkrMAUYu1+1/8igGzKOVKPb+zN93+5YcXAGnGH+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGElDRzvO4rb9HcycAwYiJPt6LLYA7DG2VNGKGt3dnx+ezzIyRtdjAzjOKzURsAlG
         KvD5QSyxAsIJ5OP10gqbnHaEsL4QrzzxnCO1E6Ue/sDkvMrTgHJGQv/dUXVyQMYwLM
         aUKscrCWpzrY55KhgexQROUopL3hSSZjfZhCeURsE3t8oiXi6NFWf549Un3tL4GSKZ
         D2YT5iTxIdpllj7yjTHtePODGg+OCY361M5PfeXBBWScxyMfK7bPfmYYNpvdta/Noh
         h7w7MOpmBXaQFqXDM6/fAcmVXjXQOnw4bNUaeYuxi+PfKYDHy+Ayfofxq9rK8bspEU
         zsQFJ3sScUY3Q==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] debugfs: make return value of all debugfs helpers
 consistent
Message-ID: <20190415232959.GC13033@innovation.ch>
References: <20190415082506.25610-1-ronald@innovation.ch>
 <20190415082506.25610-3-ronald@innovation.ch>
 <20190415084844.GA26101@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415084844.GA26101@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Greg,

On Mon, Apr 15, 2019 at 10:48:44AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 15, 2019 at 01:25:06AM -0700, Ronald Tschalär wrote:
> > Since commit ff9fb72bc077 ("debugfs: return error values, not NULL")
> > almost all the debugfs helpers have stopped returning NULL. The lone
> > holdeout was debugfs_create_u32_array(). So fix that.
> > 
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > ---
> >  fs/debugfs/file.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > index ddd708b09fa1..bb706d073782 100644
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -999,8 +999,8 @@ static const struct file_operations u32_array_fops = {
> >   * Once array is created its size can not be changed.
> >   *
> >   * The function returns a pointer to dentry on success. If an error occurs,
> > - * %ERR_PTR(-ERROR) or NULL will be returned. If debugfs is not enabled in
> > - * the kernel, the value %ERR_PTR(-ENODEV) will be returned.
> > + * %ERR_PTR(-ERROR) will be returned. If debugfs is not enabled in the kernel,
> > + * the value %ERR_PTR(-ENODEV) will be returned.
> >   */
> >  struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
> >  					    struct dentry *parent,
> > @@ -1009,7 +1009,7 @@ struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
> >  	struct array_data *data = kmalloc(sizeof(*data), GFP_KERNEL);
> >  
> >  	if (data == NULL)
> > -		return NULL;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	data->array = array;
> >  	data->elements = elements;
> 
> There is only one caller of this function in the kernel now, and it does
> not even care about the return value at all, so we should just remove
> the return value entirely as that's the easiest and best thing to do
> here.

Interesting argument: since this is a helper/library function, and
therefore potentially used in the future by others, it seems to me
that consistency with the other functions and providing error feedback
would be important.

> I was going to start doing this slowly over time, but as you are
> touching the function now, might as well do it here :)

Are you saying the plan is to make all these helpers return void?


  Cheers,

  Ronald

