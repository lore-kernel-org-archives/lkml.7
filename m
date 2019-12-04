Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337CCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A5220675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CmqYRADb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfLDRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:55:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42013 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:55:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so126143edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QBiOCr7c4l7fZjKklo3yZ4ZIuYTkAcsgsNgIGBN47E=;
        b=CmqYRADbzr0G4HWvjRmoRSG65lHFiqcXXzx9WbxdkJJtwwFPkv6L6uhvSr8NbL8H00
         3ezARPSmbB3svk8QCSrCaesCNvwd3cCxpBYJrVUau6Y/wlyJqh4o0Q61o4n/Vfy08utU
         rk0ZgwPE6al6bX+5S8CbsYWWOIQm0TFRdeFGOXwPBKse5ivL13zdlezYWKuVzPkN9uth
         L9C3RaP8eZOybLz1t2XIHf9h1vtWINA35xwdU/D152hAFrl/3hd7BxjnxP8o466XkLlX
         QUO4JYN8wnAWLeM4QY3xtEPmN3f51q8sFeXANuD1LkDioIr9xfYxmX1myGmWjpW/iUdR
         5UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QBiOCr7c4l7fZjKklo3yZ4ZIuYTkAcsgsNgIGBN47E=;
        b=U64Y+1M9hYqHwGdhDnIWgO0eczQw5SWH6x0Wd8fmWyd1py+WvRRF3AXC7yw/uJCVLh
         i6dtP49MAOx4vALKzvhhKRv9OmmGs8x/fie0je+K0b+kX3UaOYadShvjRXWm9B3B+1oS
         6fvpqCN9ueJ8Z+3jG42ULWDf+xwgawPc4AZBOoH/5QogB1QejVaJucw9P34HGQ+Urkfw
         YPXVXIQ2iPe7bNHjV2BfdSVEOF1lgZyGnt4FKbEwukSn2OEQcQObFVQH2wVVfp9O7ehz
         CIB4ibXfna7t6wjRZWrXnigeBkvPRHojVLL+Ioo4/2nIh4KLpBVeeodsvmpLbvvCSLdh
         2VYw==
X-Gm-Message-State: APjAAAXQx+1641QDAinrRDUWrn/5lH8eChRgRpD096WmTQRBFvH/PPCP
        86sG34C5BZmWivYSMsbny5TL3USFRslkLYwRJRDXDg==
X-Google-Smtp-Source: APXvYqx7i07mE15LTmdSADtpXZLOKFffb5f4NXu7AgyOJ73gnljvL0fH/4Msr28AHfBKwp3ckEATIvL1W63kFa6ISew=
X-Received: by 2002:a50:84ab:: with SMTP id 40mr5637114edq.14.1575482142681;
 Wed, 04 Dec 2019 09:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
 <20191127184453.229321-2-pasha.tatashin@soleen.com> <957930d0-8317-9086-c7a1-8de857f358c2@xen.org>
 <e785a585-8b71-8a49-285e-2bcb1437500b@citrix.com>
In-Reply-To: <e785a585-8b71-8a49-285e-2bcb1437500b@citrix.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 4 Dec 2019 12:55:31 -0500
Message-ID: <CA+CK2bDV5pUYb5c-mkA9heE-CMg1MZdC=zz6zkDJDUZuuUpOmA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Julien Grall <julien@xen.org>, James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:10 AM Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
>
> On 29/11/2019 15:05, Julien Grall wrote:
> > Hi,
> >
> > On 27/11/2019 18:44, Pavel Tatashin wrote:
> >> diff --git a/arch/arm64/include/asm/xen/hypercall.h
> >> b/arch/arm64/include/asm/xen/hypercall.h
> >> index 3522cbaed316..1a74fb28607f 100644
> >> --- a/arch/arm64/include/asm/xen/hypercall.h
> >> +++ b/arch/arm64/include/asm/xen/hypercall.h
> >> @@ -1 +1,29 @@
> >> +#ifndef _ASM_ARM64_XEN_HYPERCALL_H
> >> +#define _ASM_ARM64_XEN_HYPERCALL_H
> >>   #include <xen/arm/hypercall.h>
> >> +#include <linux/uaccess.h>
> >> +
> >> +static inline long privcmd_call(unsigned int call, unsigned long a1,
> >> +                unsigned long a2, unsigned long a3,
> >> +                unsigned long a4, unsigned long a5)
> >
> > I realize that privcmd_call is the only hypercall using Software PAN
> > at the moment. However, dm_op needs the same as hypercall will be
> > issued from userspace as well.
>
> And dm_op() won't be the only example as we continue in cleaning up the
> gaping hole that is privcmd.
>
> > So I was wondering whether we should create a generic function (e.g.
> > do_xen_hypercall() or do_xen_user_hypercall()) to cover the two
> > hypercalls?
>
> Probably a good idea.

It sounds good to me, but let's keep it outside of this series.

Thank you,
Pasha
