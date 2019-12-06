Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B82C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2427421835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575636312;
	bh=GHMiXwT065uPwUwIIqQU+AS8Kz5f4G24qOnNzLCcVR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XXVlliWcgL5I/q/veGZFV5Zk1ASZLuC7OKXxjdTMwELNhfldvbjmxW/asHu3c1CoR
	 8xkJllz597IqMZQ68jsc6bKGLtEQdXiPcHkWzf9cmtAEVpIKNhaDRiUP8bj8JQSnPF
	 ex+1eza144LChldD4n1h6OX+lLqZrZC/L0SBh4x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:45:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED01D205F4;
        Fri,  6 Dec 2019 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575636310;
        bh=GHMiXwT065uPwUwIIqQU+AS8Kz5f4G24qOnNzLCcVR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9gl0sSCJbv/ZU5qkoIHQlVe78vfB54tu/5RvIJNlSEZQtkeyvaQmDmwSUPODHIKE
         IuuuoGKl3uaJ2EDiwtpNhJ0PznME4zlZefVzyVR0ZFIb3kvz3snk3mdk2/vjZ6P0Ao
         JBjQwUoGO385uoxocK0605KJsvMdMdttKgJpGwPs=
Date:   Fri, 6 Dec 2019 13:45:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
Message-ID: <20191206124508.GA1360047@kroah.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206122434.29587-4-sourabhjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:54:31PM +0530, Sourabh Jain wrote:
> +static struct kobj_attribute release_attr = __ATTR(release_mem,
>  						0200, NULL,
>  						fadump_release_memory_store);
> -static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
> +static struct kobj_attribute enable_attr = __ATTR(enabled,
>  						0444, fadump_enabled_show,
>  						NULL);

__ATTR_RO()?

> -static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
> +static struct kobj_attribute register_attr = __ATTR(registered,
>  						0644, fadump_register_show,
>  						fadump_register_store);

__ATTR_RW()?

And then use an ATTRIBUTE_GROUP() macro to create a group so that you
then can do:

> @@ -1452,11 +1450,47 @@ static void fadump_init_files(void)
>  		printk(KERN_ERR "fadump: unable to create debugfs file"
>  				" fadump_region\n");
>  
> +	rc = sysfs_create_file(fadump_kobj, &enable_attr.attr);
> +	if (rc)
> +		pr_err("unable to create enabled sysfs file (%d)\n",
> +		       rc);
> +	rc = sysfs_create_file(fadump_kobj, &register_attr.attr);
> +	if (rc)
> +		pr_err("unable to create registered sysfs file (%d)\n",
> +		       rc);
> +	if (fw_dump.dump_active) {
> +		rc = sysfs_create_file(fadump_kobj, &release_attr.attr);
> +		if (rc)
> +			pr_err("unable to create release_mem sysfs file (%d)\n",
> +			       rc);
> +	}

a single call to sysfs_create_groups() here instead of trying to unwind
the mess if something went wrong.

thanks,

greg k-h
