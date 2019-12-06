Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F449C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644021835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575636540;
	bh=RcAid3Q85jwRgv30uwm5l3b6o2yOnXW3SLXq6APNSfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KfohbNmHdALSu+6q84XAbNty16ChEbWwvYpf4KOZDed3VTijEjCdmucuWjusoWhlL
	 AziEAL/5qNTkVp+2SzpXbBbuHR++jdeDJdDGX3MqLT2U+yPV+/tGv0lfgOq02Zw14k
	 YGD4PVI4Vlh9+hl8LWvILNTN7vcSXltafWWaMQVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFMs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLFMs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:48:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6665205F4;
        Fri,  6 Dec 2019 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575636538;
        bh=RcAid3Q85jwRgv30uwm5l3b6o2yOnXW3SLXq6APNSfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mq6KZ0gLrxaZO23IUL/dIcoNXVplyKO2N1F/AmlUgbvXsbymiL7rtfoxlvtt6CkB9
         hxPxNmzW0R4BOePNeBwnH3okTWl8xlBcu2bF4WG+RH4rBWLBRISiqp3jRAN6bIVbxQ
         6W4/DcMJ9YNECSVgkaECzhfCgTzccVdw5YVVfBZE=
Date:   Fri, 6 Dec 2019 13:48:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 6/6] powerpc/fadump: sysfs for fadump memory
 reservation
Message-ID: <20191206124855.GE1360047@kroah.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-7-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206122434.29587-7-sourabhjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:54:34PM +0530, Sourabh Jain wrote:
> Add a sys interface to allow querying the memory reserved by FADump for
> saving the crash dump.
> 
> Also added Documentation/ABI for the new sysfs file.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-fadump    |  7 +++++++
>  Documentation/powerpc/firmware-assisted-dump.rst |  5 +++++
>  arch/powerpc/kernel/fadump.c                     | 15 +++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
> index 5d988b919e81..8f7a64a81783 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-fadump
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump
> @@ -31,3 +31,10 @@ Description:	write only
>  		the system is booted to capture the vmcore using FADump.
>  		It is used to release the memory reserved by FADump to
>  		save the crash dump.
> +
> +What:		/sys/kernel/fadump/mem_reserved
> +Date:		Dec 2019
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	read only
> +		Provide information about the amount of memory reserved by
> +		FADump to save the crash dump in bytes.
> diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
> index 365c10209ef3..04993eaf3113 100644
> --- a/Documentation/powerpc/firmware-assisted-dump.rst
> +++ b/Documentation/powerpc/firmware-assisted-dump.rst
> @@ -268,6 +268,11 @@ Here is the list of files under kernel sysfs:
>      be handled and vmcore will not be captured. This interface can be
>      easily integrated with kdump service start/stop.
>  
> + /sys/kernel/fadump/mem_reserved
> +
> +   This is used to display the memory reserved by FADump for saving the
> +   crash dump.
> +
>   /sys/kernel/fadump_release_mem
>      This file is available only when FADump is active during
>      second kernel. This is used to release the reserved memory
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 41a3cda81791..b2af51b7c750 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1357,6 +1357,13 @@ static ssize_t fadump_enabled_show(struct kobject *kobj,
>  	return sprintf(buf, "%d\n", fw_dump.fadump_enabled);
>  }
>  
> +static ssize_t fadump_mem_reserved_show(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					char *buf)
> +{
> +	return sprintf(buf, "%ld\n", fw_dump.reserve_dump_area_size);
> +}
> +
>  static ssize_t fadump_register_show(struct kobject *kobj,
>  					struct kobj_attribute *attr,
>  					char *buf)
> @@ -1430,6 +1437,10 @@ static struct kobj_attribute enable_attr = __ATTR(enabled,
>  static struct kobj_attribute register_attr = __ATTR(registered,
>  						0644, fadump_register_show,
>  						fadump_register_store);
> +static struct kobj_attribute mem_reserved_attr = __ATTR(mem_reserved,
> +						0444, fadump_mem_reserved_show,
> +						NULL);

__ATTRI_RO()?

> +
>  
>  DEFINE_SHOW_ATTRIBUTE(fadump_region);
>  
> @@ -1464,6 +1475,10 @@ static void fadump_init_files(void)
>  			pr_err("unable to create release_mem sysfs file (%d)\n",
>  			       rc);
>  	}
> +	rc = sysfs_create_file(fadump_kobj, &mem_reserved_attr.attr);
> +	if (rc)
> +		pr_err("unable to create mem_reserved sysfs file (%d)\n",
> +		       rc);

Again, put it in an attribute group, that would have only required one
line, and not this mess of not cleaning up if something went wrong.

thanks,

greg k-h
