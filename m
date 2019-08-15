Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565872991;
	bh=D/Jks0xo+pMhFeOT08w4aft8IvmKTzcS5/Tm1mJgbco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oLg3XGTCWpuUDQ3G8tgaNAL5QMk0FwKGpl/+K2dYXrafIQK8D0uOSwMfvDn38hVhk
	 ESRhUymBkpUoyAgFnzQQDCXm5cOxZxbNNUTXF5ApK3Ke8kT9ovrjxJcDtDEN23RkW8
	 veaZRVWI6tAJHnX1E3diQmI4NKYhFnMPqYtdFHLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfHOMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOMnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:43:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A3C2084D;
        Thu, 15 Aug 2019 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565872988;
        bh=D/Jks0xo+pMhFeOT08w4aft8IvmKTzcS5/Tm1mJgbco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXesuGjnz699u5P/b41p5MmOtNEFuf7/LUanQq21309Kfzc2GLPGSoaAo9f2/z9m0
         6ziMuNTWX6fgzlYY6hSBuXtFk/P5ANRRorpyhTxmrGA/u/Qneee+GbCzPqMuC25Kfx
         ctt9oWCR2nZoDCRJYqJbfUT1teCC/gnopa5yv1L4=
Date:   Thu, 15 Aug 2019 14:43:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: warning: =?utf-8?B?4oCYbWVtc2V04oCZ?=
 =?utf-8?Q?_offset_=5B197=2C_448=5D_from_the_object_at_=E2=80=98boot=5Fpar?=
 =?utf-8?Q?ams=E2=80=99_is_out_of_the_bounds_of_referenced_subobject_?=
 =?utf-8?B?4oCYZXh0X3JhbWRpc2tfaW1hZ2XigJkgd2l0aCB0eXBlLCDigJh1bnNpZ25l?=
 =?utf-8?B?ZCBpbnTigJk=?= at offset 192 [-Warray-bounds]
Message-ID: <20190815124306.GA17581@kroah.com>
References: <7e44d224-ce7e-909d-e91e-9a643b5fcd71@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e44d224-ce7e-909d-e91e-9a643b5fcd71@molgen.mpg.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 06:15:51PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> No idea, if you are interested in these reports. Building Linux 5.3-rc4,
> GCC 9.2.0 shows the warning below.
> 
> ```
> In file included from arch/x86/kernel/head64.c:35:
> In function ‘sanitize_boot_params’,
>     inlined from ‘copy_bootdata’ at arch/x86/kernel/head64.c:391:2:
> ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: ‘memset’ offset [197, 448] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘ext_ramdisk_image’ with type
>  ‘unsigned int’ at offset 192 [-Warray-bounds]
>    40 |   memset(&boot_params->ext_ramdisk_image, 0,
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    41 |          (char *)&boot_params->efi_info -
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    42 |    (char *)&boot_params->ext_ramdisk_image);
>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: ‘memset’ offset [493, 497] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘kbd_status’ with type ‘unsig
> ned char’ at offset 491 [-Warray-bounds]
>    43 |   memset(&boot_params->kbd_status, 0,
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    44 |          (char *)&boot_params->hdr -
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    45 |          (char *)&boot_params->kbd_status);
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ```

Yeah, it shows up on my builds as well :(

Any chance you can make a fix for this?

thanks,

greg k-h
