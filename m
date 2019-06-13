Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F873C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BF3218B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560447678;
	bh=eCHij1l5AX4pQCoCcrvD/pt7Q4lbspMkAxslGpd6v+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kv18/9DNeB8XzRrkRkra+SQfrA1rjfsmB8x2lm/zOahIK9WczzpRIGX8mz5oCZxy0
	 7d4puquS833TYkNgT4EBq3ecQHBSx7yqc4mkpAjdM79vv5lQhxK/5grA/bj7LInjTj
	 OitRdVrSEu2Q6vdjcX6QGhGOx98IwNt3Mb8d3Tp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfFMRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfFMRlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:41:16 -0400
Received: from localhost (unknown [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B93B218B6;
        Thu, 13 Jun 2019 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560447676;
        bh=eCHij1l5AX4pQCoCcrvD/pt7Q4lbspMkAxslGpd6v+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pN+P0V9ImX9sqo6q6FqIFcRJe9rp+238GbRmTIO0SfAtEQBQtzUaGkdwrkkaJfu26
         ea2HdN/r/hnMoF6TG/9QR8f37IiZJpuj3ClBg9xhcHG/4gvXclFQ88fdo5FlpApFom
         zZhr7z7oILAkwruJRXEAe1CiIZoffkHgqhsrrNAE=
Date:   Thu, 13 Jun 2019 19:41:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: dynamic_debug: no need to check return value of
 debugfs_create functions
Message-ID: <20190613174105.GA9415@kroah.com>
References: <20190612153534.GA21141@kroah.com>
 <4936c8d8-9b69-1385-1bbf-9d19ac08d061@akamai.com>
 <20190613155906.GB4632@kroah.com>
 <e28815b3-6c14-6ede-de69-096093260150@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28815b3-6c14-6ede-de69-096093260150@akamai.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:09:00PM -0400, Jason Baron wrote:
> 
> 
> On 6/13/19 11:59 AM, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2019 at 10:33:23AM -0400, Jason Baron wrote:
> >> On 6/12/19 11:35 AM, Greg Kroah-Hartman wrote:
> >>> When calling debugfs functions, there is no need to ever check the
> >>> return value.  The function can work or not, but the code logic should
> >>> never do something different based on this.
> >>>
> >>> Cc: Jason Baron <jbaron@akamai.com>
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> ---
> >>>  lib/dynamic_debug.c | 12 +++---------
> >>>  1 file changed, 3 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >>> index 8a16c2d498e9..c60409138e13 100644
> >>> --- a/lib/dynamic_debug.c
> >>> +++ b/lib/dynamic_debug.c
> >>> @@ -993,20 +993,14 @@ static __initdata int ddebug_init_success;
> >>>  
> >>>  static int __init dynamic_debug_init_debugfs(void)
> >>>  {
> >>> -	struct dentry *dir, *file;
> >>> +	struct dentry *dir;
> >>>  
> >>>  	if (!ddebug_init_success)
> >>>  		return -ENODEV;
> >>>  
> >>>  	dir = debugfs_create_dir("dynamic_debug", NULL);
> >>> -	if (!dir)
> >>> -		return -ENOMEM;
> >>> -	file = debugfs_create_file("control", 0644, dir, NULL,
> >>> -					&ddebug_proc_fops);
> >>> -	if (!file) {
> >>> -		debugfs_remove(dir);
> >>> -		return -ENOMEM;
> >>> -	}
> >>> +	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
> >>> +
> >>>  	return 0;
> >>>  }
> >>>  
> >>>
> >>
> >> Looks like debugfs_create_dir() can return NULL,
> > 
> > No it can not.
> >
> 
> Ok, I looked at the wrong definition for failed_creating() :(

Yeah, tracefs should also probably change, it makes users of their api
easier...

> In that case:
> 
> Acked-by: Jason Baron <jbaron@akamai.com>

Wonderful, thanks for the review.

greg k-h
