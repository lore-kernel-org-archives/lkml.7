Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24611206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557123693;
	bh=Zzsevc3QFsdcI+m74gIccvrYIxck4T0/TqqA55LEfsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=awhZrVJ+g0oKDdppZjkrSVHJpIvsn+6Y2CYGdWE7VrV7XAPr8r/62vVmsV4myygx4
	 FfswKYMNeN/90uIXXaAcfSJdDbZxd7pTSNOLHGdISpm6JS+S4B/aNqFh5fVPxtEqqu
	 YC54/TaIubmAqKFGpjIVXO7yRGRkghwGGrVWhEPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEFGVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfEFGVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:21:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2290206A3;
        Mon,  6 May 2019 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557123690;
        bh=Zzsevc3QFsdcI+m74gIccvrYIxck4T0/TqqA55LEfsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5ApHSdOOJKw22qIecHl5v2w3x4janhQpYuAOJ+bv/ZjzuNmaY17JITsB3F8xDp5H
         9EA3aOwnyGRjBrgG1yoUS9reCRCZBK9XCzRH3+q8+4jE+mtq4NdcHRRPhYgd4yP65v
         rB/XbzFfQjdHXjtVPMfQHOfkhCL42ve4tM4dQ80E=
Date:   Mon, 6 May 2019 08:21:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     rafael@kernel.org, sramana@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers: core: Remove glue dirs early only when
 refcount is 1
Message-ID: <20190506062127.GC9557@kroah.com>
References: <20190501065313.GA30616@kroah.com>
 <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
 <0aac6bf3-6691-7c5a-31f1-fb7231c6b585@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aac6bf3-6691-7c5a-31f1-fb7231c6b585@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 10:41:34AM +0530, Prateek Sood wrote:
> On 5/1/19 5:29 PM, Prateek Sood wrote:
> > While loading firmware blobs parallely in different threads, it is possible
> > to free sysfs node of glue_dirs in device_del() from a thread while another
> > thread is trying to add subdir from device_add() in glue_dirs sysfs node.
> > 
> >     CPU1                                           CPU2
> > fw_load_sysfs_fallback()
> >   device_add()
> >     get_device_parent()
> >       class_dir_create_and_add()
> >         kobject_add_internal()
> >           create_dir() // glue_dir
> > 
> >                                            fw_load_sysfs_fallback()
> >                                              device_add()
> >                                                get_device_parent()
> >                                                  kobject_get() //glue_dir
> > 
> >   device_del()
> >     cleanup_glue_dir()
> >       kobject_del()
> > 
> >                                                kobject_add()
> >                                                  kobject_add_internal()
> >                                                    create_dir() // in glue_dir
> >                                                      kernfs_create_dir_ns()
> > 
> >        sysfs_remove_dir() //glue_dir->sd=NULL
> >        sysfs_put() // free glue_dir->sd
> > 
> >                                                        kernfs_new_node()
> >                                                          kernfs_get(glue_dir)
> > 
> > Fix this race by making sure that kernfs_node for glue_dir is released only
> > when refcount for glue_dir kobj is 1.
> > 
> > Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> > 
> > ---
> > 
> > Changes from v2->v3:
> >  - Added patch version change related comments.
> > 
> > Changes from v1->v2:
> >  - Updated callstack from _request_firmware_load() to fw_load_sysfs_fallback().
> > 
> > 
> >  drivers/base/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4aeaa0c..3955d07 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1820,12 +1820,15 @@ static inline struct kobject *get_glue_dir(struct device *dev)
> >   */
> >  static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
> >  {
> > +	unsigned int refcount;
> > +
> >  	/* see if we live in a "glue" directory */
> >  	if (!live_in_glue_dir(glue_dir, dev))
> >  		return;
> >  
> >  	mutex_lock(&gdp_mutex);
> > -	if (!kobject_has_children(glue_dir))
> > +	refcount = kref_read(&glue_dir->kref);
> > +	if (!kobject_has_children(glue_dir) && !--refcount)
> >  		kobject_del(glue_dir);
> >  	kobject_put(glue_dir);
> >  	mutex_unlock(&gdp_mutex);
> > 
> 
> Folks,
> 
> Please share feedback on the race condition and the patch to
> fix it.

Please relax, we will get to this eventually, it has only been a week...

greg k-h
