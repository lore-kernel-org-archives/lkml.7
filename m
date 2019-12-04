Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D627C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309020862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TfH3rUb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfLDR6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42458 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfLDR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so133700edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9gkQnU+5q50cQeHx8NRu5HJQyIM32Z6cVBwYXSVjIU=;
        b=TfH3rUb9CyqcTteFkO3C0xlnbKPaPL+cKMDbTylgoIZRtg9/X9I+YsgFYMbiZXeyWH
         6PlZPH1K/5P+XHiHenDCQt4FvrDjS/BrRzDZryGe9Twd6Hm2D/PuFfB0RuI7ndN7FRkU
         53yRO+n+zxjDbzNLl19rt+Ux9N0QapQxf/PcuW0FZFx9aDV2esnmpEXuzPCGcvshVi5c
         mRfJ/YtyltCIrh/P45bL1k1m4RChqhZSyzX/Jcbu3guo/ePbUMweg/D/uJvHeIaqg4Gm
         5uP20oOpH/SKLR8di/NnPJ5v5R0wamwgPJl5jM6Ru4CREPcSt4DIS2z6vz82RA/SVf34
         r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9gkQnU+5q50cQeHx8NRu5HJQyIM32Z6cVBwYXSVjIU=;
        b=XyvwXrjf72jb4JmpIHp7JlpNI/+G3lX5laQL38iNo2bQiKjonnnGn2KNln+0Z62ldo
         hxAyU8KTdgdX4WEFqVUCnV0t5cdxWmyR/Awf/LXRjx6ZER6LmHwnvWpFNOaOvWa8a83d
         cGT5XsikV545qO5QQuaQN2TOqiZd5w5scV2b8qXBfY2HVPMnHvk+KwqO1soVHRkItf0F
         K3DLt42GbjtBXdK/UckY+Bg3o2LPzoz9XetPScQ4cMY5UTGl7jleiEWYO97w0BI9s8Zh
         z1+5CUZCYmgif9eB82hNyAZbXTX4MG8cZTbMqnK069qDo17meauoaZSubKsniTnbcoHB
         3V/A==
X-Gm-Message-State: APjAAAVEaUJc38ZKe4xP0Ofs6vf5X5rRLFZ9SIldrV0nwEH0tWv2Yh7J
        fgW8fAb7AeG8BufuWROIiCr9pr92GJxM+brOaZDnyw==
X-Google-Smtp-Source: APXvYqyAOfG2c7wdnsuR/CLNurVK9MGZsX+GmC1nBIDZq14OwnspMmSoQUW6yoePy6mVNE4fFTYRVftmoUuum47tYGo=
X-Received: by 2002:aa7:d445:: with SMTP id q5mr5540834edr.16.1575482311052;
 Wed, 04 Dec 2019 09:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
 <20191127184453.229321-2-pasha.tatashin@soleen.com> <957930d0-8317-9086-c7a1-8de857f358c2@xen.org>
In-Reply-To: <957930d0-8317-9086-c7a1-8de857f358c2@xen.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 4 Dec 2019 12:58:20 -0500
Message-ID: <CA+CK2bBWVLZkFo5e8gQUuiqz_b2oCOtD7-9GkCwf9BsFn9wwaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
To:     Julien Grall <julien@xen.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
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

On Fri, Nov 29, 2019 at 10:05 AM Julien Grall <julien@xen.org> wrote:
>
> Hi,
>
> On 27/11/2019 18:44, Pavel Tatashin wrote:
> > diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
> > index 3522cbaed316..1a74fb28607f 100644
> > --- a/arch/arm64/include/asm/xen/hypercall.h
> > +++ b/arch/arm64/include/asm/xen/hypercall.h
> > @@ -1 +1,29 @@
> > +#ifndef _ASM_ARM64_XEN_HYPERCALL_H
> > +#define _ASM_ARM64_XEN_HYPERCALL_H
> >   #include <xen/arm/hypercall.h>
> > +#include <linux/uaccess.h>
> > +
> > +static inline long privcmd_call(unsigned int call, unsigned long a1,
> > +                             unsigned long a2, unsigned long a3,
> > +                             unsigned long a4, unsigned long a5)
>
> I realize that privcmd_call is the only hypercall using Software PAN at
> the moment. However, dm_op needs the same as hypercall will be issued
> from userspace as well.

The clean-up I am working on now is specific to moving current PAN
useage to C wraps. Once dm_op requires to use PAN it will need to be
used the C variants, because ASM versions are going to be removed by
this series.

>
> So I was wondering whether we should create a generic function (e.g.
> do_xen_hypercall() or do_xen_user_hypercall()) to cover the two hypercalls?
>
> > diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
> > index b40485e54d80..624c8ad7e42a 100644
> > --- a/include/xen/arm/hypercall.h
> > +++ b/include/xen/arm/hypercall.h
> > @@ -30,8 +30,8 @@
> >    * IN THE SOFTWARE.
> >    */
> >
> > -#ifndef _ASM_ARM_XEN_HYPERCALL_H
> > -#define _ASM_ARM_XEN_HYPERCALL_H
> > +#ifndef _ARM_XEN_HYPERCALL_H
> > +#define _ARM_XEN_HYPERCALL_H
>
> This change feels a bit out of context. Could you split it in a separate
> patch?

Makes sense, I am splitting this into a separate patch.

Thank you,
Pasha
