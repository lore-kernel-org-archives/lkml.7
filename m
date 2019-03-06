Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF39C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9E620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7ozVUe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfCFBOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:14:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfCFBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G5pA0rqA7fr0Jdt28cHKdei5ddKqqnTKnJ8VNABGE58=; b=d7ozVUe3tsE5a5KmVTHZUZGsTp
        pmKutwsxR/gGjvlL2N10p4lP4tsBUVRwupQmxMEAAq990J/1BO6LfnCLEjCwQDET1hftz/GeIOe3B
        jb8+5HFzsQE3zL0F8GCot9k5FBA6+P2w+UfwpzNiEEkPtMOyBzvThmPvjjYchq20eKMkIcQWL9KJi
        cjM8S6nDxSip8aWoZ/T7grQygYDOWXn4evSHthN3cAy85fkVOOga5+NjpNsHz1bNU+vC53/GoPv+x
        RFAKDCDoa8KBhL7q6hdy8+WJAD+QJ2vvqSySwUVhEe/RjfDqQiqKJXZ+XTkUHPX14wKzGaoNXFvNF
        PHz9h34A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1L8h-0003xa-Tg; Wed, 06 Mar 2019 01:14:32 +0000
Subject: Re: [PATCH v12 2/4] pstore/blk: add blkoops for pstore_blk
To:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551337948-16451-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1551337948-16451-3-git-send-email-liaoweixiong@allwinnertech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <21827ba0-1c89-c16e-0d64-0a508eeae915@infradead.org>
Date:   Tue, 5 Mar 2019 17:14:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1551337948-16451-3-git-send-email-liaoweixiong@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/19 11:12 PM, liaoweixiong wrote:
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index defcb75..7dfe00b 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -160,3 +160,117 @@ config PSTORE_BLK
>  	help
>  	  This enables panic and oops message to be logged to a block dev
>  	  where it can be read back at some later point.
> +
> +config PSTORE_BLKOOPS
> +	tristate "pstore block with oops logger"
> +	depends on PSTORE_BLK
> +	help
> +	  This is a sample for pstore block with oops logger.
> +
> +	  It CANNOT record panic log as no read/write apis for panic registered.

	                                              APIs

> +
> +	  It CAN record oops log even power failure if
> +	  "PSTORE_BLKOOPS_BLKDEV" on Kconfig or "block-device" on dts or
> +	  "blkdev" on module parameter is valid.
> +
> +	  Otherwise, it can only record data to ram buffer, which will be
> +	  dropped when reboot.

	  dropped on reboot.
or
	  dropped when rebooting.

> +
> +	  NOTE that, there are three ways to set parameters of blkoops and
> +	  prioritize according to configuration flexibility. That is
> +	  Kconfig < device tree < module parameters. It means that the value can
> +	  be overwritten by higher priority settings.
> +	  1. Kconfig
> +	     It	just sets a default value.
> +	  2. device tree
> +	     It is set on device tree, which will overwrites value from Kconfig,

	                                          overwrite the value from Kconfig,

> +	     but can also be overwritten by module parameters.
> +	  3. module parameters
> +	     It is the first priority. Take care of that blkoops will take lower
> +	     priority settings if higher priority one do not set.
> +
> +config PSTORE_BLKOOPS_DMESG_SIZE
> +	int "dmesg size in kbytes for blkoops"
> +	depends on PSTORE_BLKOOPS
> +	default 64
> +	help
> +	  This just sets size of dmesg (dmesg_size) for pstore/blk. The value
> +	  must be a multiple of 4096.
> +
> +	  NOTE that, there are three ways to set parameters of blkoops and
> +	  prioritize according to configuration flexibility. That is
> +	  Kconfig < device tree < module parameters. It means that the value can
> +	  be overwritten by higher priority settings.
> +	  1. Kconfig
> +	     It	just sets a default value.
> +	  2. device tree
> +	     It is set on device tree, which will overwrites value from Kconfig,

	                                          overwrite the value from Kconfig,

> +	     but can also be overwritten by module parameters.
> +	  3. module parameters
> +	     It is the first priority. Take care of that blkoops will take lower
> +	     priority settings if higher priority one do not set.
> +
> +config PSTORE_BLKOOPS_TOTAL_SIZE
> +	int "total size in kbytes for blkoops"
> +	depends on PSTORE_BLKOOPS
> +	default 0
> +	help
> +	  The total size in kbytes pstore/blk can use. It must be less than or
> +	  equal to size of block device if @blkdev valid. If @total_size is zero
> +	  with @blkdev, @total_size will be set to equal to size of @blkdev.

	                                    set equal to size of @blkdev.

> +	  The value must be a multiple of 4096.
> +
> +	  NOTE that, there are three ways to set parameters of blkoops and
> +	  prioritize according to configuration flexibility. That is
> +	  Kconfig < device tree < module parameters. It means that the value can
> +	  be overwritten by higher priority settings.
> +	  1. Kconfig
> +	     It	just sets a default value.
> +	  2. device tree
> +	     It is set on device tree, which will overwrites value from Kconfig,

	                                          overwrite the value from Kconfig,

> +	     but can also be overwritten by module parameters.
> +	  3. module parameters
> +	     It is the first priority. Take care of that blkoops will take lower
> +	     priority settings if higher priority one do not set.
> +
> +config PSTORE_BLKOOPS_BLKDEV
> +	string "block device for blkoops"
> +	depends on PSTORE_BLKOOPS
> +	default ""
> +	help
> +	  This just sets block device (blkdev) for pstore/blk. Pstore/blk
> +	  will record data to this block device to avoid losing data due to
> +	  power failure. So, If it is not set, pstore/blk will drop all data

	                     if

> +	  when reboot.

	  on reboot.

> +
> +	  It accpet the following variants:

	     accepts

> +	  1) <hex_major><hex_minor> device number in hexadecimal represents
> +	     itself no leading 0x, for example b302.
> +	  2) /dev/<disk_name> represents the device number of disk
> +	  3) /dev/<disk_name><decimal> represents the device number
> +	     of partition - device number of disk plus the partition number
> +	  4) /dev/<disk_name>p<decimal> - same as the above, that form is

	                                              above; this form is

> +	     used when disk name of partitioned disk ends on a digit.

	                                             ends with a digit.

> +	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
> +	     unique id of a partition if the partition table provides it.
> +	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
> +	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
> +	     filled hex representation of the 32-bit "NT disk signature", and PP
> +	     is a zero-filled hex representation of the 1-based partition number.
> +	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
> +	     to a partition with a known unique id.
> +	  7) <major>:<minor> major and minor number of the device separated by
> +	     a colon.
> +
> +	  NOTE that, there are three ways to set parameters of blkoops and
> +	  prioritize according to configuration flexibility. That is
> +	  Kconfig < device tree < module parameters. It means that the value can
> +	  be overwritten by higher priority settings.
> +	  1. Kconfig
> +	     It	just sets a default value.
> +	  2. device tree
> +	     It is set on device tree, which will overwrites value from Kconfig,

	                                          overwrite the value from Kconfig,

> +	     but can also be overwritten by module parameters.
> +	  3. module parameters
> +	     It is the first priority. Take care of that blkoops will take lower
> +	     priority settings if higher priority one do not set.


-- 
~Randy
