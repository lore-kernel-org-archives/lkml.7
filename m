Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88026C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648C42133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfHOMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:54:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfHOMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:54:38 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyFGz-0004Ri-1T; Thu, 15 Aug 2019 14:54:33 +0200
Date:   Thu, 15 Aug 2019 14:54:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?ISO-8859-7?Q?Re=3A_warning=3A_=A1memset=A2_offset_=5B197=2C_4?=
 =?ISO-8859-7?Q?48=5D_from_the_object_at_=A1boot=5Fparams=A2_i?=
 =?ISO-8859-7?Q?s_out_of_the_bounds_of_referenced_subobject?=
 =?ISO-8859-7?Q?_=A1ext=5Framdisk=5Fimage=A2_with_type=2C_=A1unsig?=
 =?ISO-8859-7?Q?ned_int=A2_at_offset_192_=5B-Warray-bounds=5D?=
In-Reply-To: <20190815124306.GA17581@kroah.com>
Message-ID: <alpine.DEB.2.21.1908151452250.1923@nanos.tec.linutronix.de>
References: <7e44d224-ce7e-909d-e91e-9a643b5fcd71@molgen.mpg.de> <20190815124306.GA17581@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1831806387-1565873673=:1923"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1831806387-1565873673=:1923
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Aug 2019, Greg KH wrote:
> On Tue, Aug 13, 2019 at 06:15:51PM +0200, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > 
> > No idea, if you are interested in these reports. Building Linux 5.3-rc4,
> > GCC 9.2.0 shows the warning below.
> > 
> > ```
> > In file included from arch/x86/kernel/head64.c:35:
> > In function ‘sanitize_boot_params’,
> >     inlined from ‘copy_bootdata’ at arch/x86/kernel/head64.c:391:2:
> > ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: ‘memset’ offset [197, 448] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘ext_ramdisk_image’ with type
> >  ‘unsigned int’ at offset 192 [-Warray-bounds]
> >    40 |   memset(&boot_params->ext_ramdisk_image, 0,
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    41 |          (char *)&boot_params->efi_info -
> >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    42 |    (char *)&boot_params->ext_ramdisk_image);
> >       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: ‘memset’ offset [493, 497] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘kbd_status’ with type ‘unsig
> > ned char’ at offset 491 [-Warray-bounds]
> >    43 |   memset(&boot_params->kbd_status, 0,
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    44 |          (char *)&boot_params->hdr -
> >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    45 |          (char *)&boot_params->kbd_status);
> >       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ```
> 
> Yeah, it shows up on my builds as well :(
> 
> Any chance you can make a fix for this?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/boot&id=a156cadef2fe445ac423670eace517b39a01ccd0

I guess I need to reprioritize that and mark it for stable....
--8323329-1831806387-1565873673=:1923--
