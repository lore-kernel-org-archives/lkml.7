Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7CC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892052133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565875180;
	bh=HFXQAFDpp3inO4W+xusMOFdVhwa9Gi6AIGEKoCjQ0mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2gKXtT8wm345EPyGpOkYkvFRacaCUWXasgqnBg/4MUik+prQT6hfp/OgdlzUdq1r8
	 qkHVHgIg4PH2lmoAN+11XV0iyLRivVsIuUnbsRPN2yTmvQQrGOrqdB3fMhsfqKZyeK
	 2bJt0FLNfc5LvYVDdQiZa3CEJbw7fiNFovhIjrh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfHONTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbfHONTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:19:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A27B2083B;
        Thu, 15 Aug 2019 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565875178;
        bh=HFXQAFDpp3inO4W+xusMOFdVhwa9Gi6AIGEKoCjQ0mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezessHcgm5nt5CaRNi+dtrhOXaXTOgB63KfLBPU4DGt5ci+tiVH7rrOqjk8e1KuZo
         /yHXrQIAv8Q096JykPfnWajQot1gcxEPBE7E5Dfyi2PuxC1SHNATsjnvuKbFM1Gt2t
         hDQDXfJLEl82o9h6bFWqoPSk5O1S8UMnxmtD/T4U=
Date:   Thu, 15 Aug 2019 15:19:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: warning: =?utf-8?B?4oCYbWVtc2V04oCZ?=
 =?utf-8?Q?_offset_=5B197=2C_448=5D_from_the_object_at_=E2=80=98boot=5Fpar?=
 =?utf-8?Q?ams=E2=80=99_is_out_of_the_bounds_of_referenced_subobject_?=
 =?utf-8?B?4oCYZXh0X3JhbWRpc2tfaW1hZ2XigJkgd2l0aCB0eXBlLCDigJh1bnNpZ25l?=
 =?utf-8?B?ZCBpbnTigJk=?= at offset 192 [-Warray-bounds]
Message-ID: <20190815131935.GA21644@kroah.com>
References: <7e44d224-ce7e-909d-e91e-9a643b5fcd71@molgen.mpg.de>
 <20190815124306.GA17581@kroah.com>
 <alpine.DEB.2.21.1908151452250.1923@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1908151452250.1923@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:54:32PM +0200, Thomas Gleixner wrote:
> On Thu, 15 Aug 2019, Greg KH wrote:
> > On Tue, Aug 13, 2019 at 06:15:51PM +0200, Paul Menzel wrote:
> > > Dear Linux folks,
> > > 
> > > 
> > > No idea, if you are interested in these reports. Building Linux 5.3-rc4,
> > > GCC 9.2.0 shows the warning below.
> > > 
> > > ```
> > > In file included from arch/x86/kernel/head64.c:35:
> > > In function ‘sanitize_boot_params’,
> > >     inlined from ‘copy_bootdata’ at arch/x86/kernel/head64.c:391:2:
> > > ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: ‘memset’ offset [197, 448] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘ext_ramdisk_image’ with type
> > >  ‘unsigned int’ at offset 192 [-Warray-bounds]
> > >    40 |   memset(&boot_params->ext_ramdisk_image, 0,
> > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    41 |          (char *)&boot_params->efi_info -
> > >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    42 |    (char *)&boot_params->ext_ramdisk_image);
> > >       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: ‘memset’ offset [493, 497] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘kbd_status’ with type ‘unsig
> > > ned char’ at offset 491 [-Warray-bounds]
> > >    43 |   memset(&boot_params->kbd_status, 0,
> > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    44 |          (char *)&boot_params->hdr -
> > >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    45 |          (char *)&boot_params->kbd_status);
> > >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ```
> > 
> > Yeah, it shows up on my builds as well :(
> > 
> > Any chance you can make a fix for this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/boot&id=a156cadef2fe445ac423670eace517b39a01ccd0
> 
> I guess I need to reprioritize that and mark it for stable....


Please do, it's the only build warning I currently have for
'allmodconfig' on x86 for 4.14.y, 4.19.y, and 5.2.y and is annoying :)

thanks,

greg k-h
