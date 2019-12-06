Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAAEC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3652724676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575659666;
	bh=LPnXnjKbm0b4gtrlcehg2oiRCOVCNtSW0HjJxtovOtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lAdWXLiWWUmIVQIzVtBgEWgnu1FoUJ2Ni7rUf1o+SWLfNnPbGRdGELAnozQGMSIiV
	 FrdvhcpCnz23pbvcIikuGuePC8A/OhEPRUqY6TlHDrLGyFlahnipRzolzlE7nrw4WX
	 r7cDt7jDyLTWIumNtJxwHG2zVUSVunm0ITI9Mpxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLFTOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:14:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfLFTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:14:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B65321835;
        Fri,  6 Dec 2019 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575659663;
        bh=LPnXnjKbm0b4gtrlcehg2oiRCOVCNtSW0HjJxtovOtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1kJqvtEecr1K6h1tqyXRWHiTEmaVksOxPW/2vTlWvPJzQ7b0SUYP7gfqyC5qkz/Iu
         6kegACy2K8Jz/ABZjfANuBWSi1JjqBBrcgv/k+qb1LhEbQW4MKdx9KPFBzZzbxfvIj
         8b3jh3FVbJb3+gHUf1m9TLx0UeZNEQyivQAJf8yI=
Date:   Fri, 6 Dec 2019 20:14:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] sysfs: wrap
 __compat_only_sysfs_link_entry_to_kobj function to change the symlink name
Message-ID: <20191206191420.GA192422@kroah.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-3-sourabhjain@linux.ibm.com>
 <20191206124642.GB1360047@kroah.com>
 <3aabdf19-ccbf-e99a-c560-2b110e8b536a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aabdf19-ccbf-e99a-c560-2b110e8b536a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:57:53PM +0530, Sourabh Jain wrote:
> 
> 
> On 12/6/19 6:16 PM, Greg KH wrote:
> > On Fri, Dec 06, 2019 at 05:54:30PM +0530, Sourabh Jain wrote:
> >> The __compat_only_sysfs_link_entry_to_kobj function creates a symlink to a
> >> kobject but doesn't provide an option to change the symlink file name.
> >>
> >> This patch adds a wrapper function create_sysfs_symlink_entry_to_kobj that
> >> extends the __compat_only_sysfs_link_entry_to_kobj functionality which
> >> allows function caller to customize the symlink name.
> >>
> >> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> >> ---
> >>  fs/sysfs/group.c      | 28 +++++++++++++++++++++++++---
> >>  include/linux/sysfs.h | 12 ++++++++++++
> >>  2 files changed, 37 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> >> index d41c21fef138..5eb38145b957 100644
> >> --- a/fs/sysfs/group.c
> >> +++ b/fs/sysfs/group.c
> >> @@ -424,6 +424,25 @@ EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
> >>  int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
> >>  				      struct kobject *target_kobj,
> >>  				      const char *target_name)
> >> +{
> >> +	return create_sysfs_symlink_entry_to_kobj(kobj, target_kobj,
> >> +						target_name, NULL);
> >> +}
> >> +EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
> >> +
> >> +/**
> >> + * create_sysfs_symlink_entry_to_kobj - add a symlink to a kobject pointing
> >> + * to a group or an attribute
> >> + * @kobj:		The kobject containing the group.
> >> + * @target_kobj:	The target kobject.
> >> + * @target_name:	The name of the target group or attribute.
> >> + * @symlink_name:	The name of the symlink file (target_name will be
> >> + *			considered if symlink_name is NULL).
> >> + */
> >> +int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
> >> +				       struct kobject *target_kobj,
> >> +				       const char *target_name,
> >> +				       const char *symlink_name)
> >>  {
> >>  	struct kernfs_node *target;
> >>  	struct kernfs_node *entry;
> >> @@ -448,12 +467,15 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
> >>  		return -ENOENT;
> >>  	}
> >>  
> >> -	link = kernfs_create_link(kobj->sd, target_name, entry);
> >> +	if (!symlink_name)
> >> +		symlink_name = target_name;
> >> +
> >> +	link = kernfs_create_link(kobj->sd, symlink_name, entry);
> >>  	if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
> >> -		sysfs_warn_dup(kobj->sd, target_name);
> >> +		sysfs_warn_dup(kobj->sd, symlink_name);
> >>  
> >>  	kernfs_put(entry);
> >>  	kernfs_put(target);
> >>  	return PTR_ERR_OR_ZERO(link);
> >>  }
> >> -EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
> >> +EXPORT_SYMBOL_GPL(create_sysfs_symlink_entry_to_kobj);
> >> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> >> index 5420817ed317..123c6f10333a 100644
> >> --- a/include/linux/sysfs.h
> >> +++ b/include/linux/sysfs.h
> >> @@ -300,6 +300,10 @@ void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
> >>  int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
> >>  				      struct kobject *target_kobj,
> >>  				      const char *target_name);
> >> +int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
> >> +				       struct kobject *target_kobj,
> >> +				       const char *target_name,
> >> +				       const char *symlink_name);
> > 
> > sysfs_create_symlink_entry_to_kobj()?
> > 
> > I can't remember why we put __compat_only there, perhaps because we do
> > not want people to really use this unless you really really have to?
> 
> We don't have much option here. I tried replicating the sysfs files
> in older patch series but creating symlink at old location is much
> better approach.
> 
> The __compat_only_sysfs_link_entry_to_kobj function is pretty generic,
> unable to understand the reason behind restricting its usage.
> 
> > 
> > So then keep compat_only here as well?
> 
> Sure, I will rename the wrapper function.
> 
> But how about changing the function signature instead of creating
> a wrapper function?
> 
> Considering the fact that there are only two places this function
> has called.
> 
> > 
> > What breaks if you remove those undocumented sysfs files?  What
> > userspace tool do you have that will even notice?
> 
> The scripts used in kdump service need those sysfs files to control
> the dump collection. So we can't just move the sysfs files to the
> new location.

If you can not change them, then just document them and live with it.
Why do this extra work to create a symlink for something you will never
use?

greg k-h
