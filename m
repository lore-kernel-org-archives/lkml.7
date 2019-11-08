Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB775C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C101821882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lPy/NPVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfKHCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:42:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46620 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:42:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so3912643otr.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 18:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toJ5uCNFjWzAJBR7ewaPVlC4vkW0KDP/L41X/HMgzgw=;
        b=lPy/NPVDDKD+ljwMBp5nM3NVDpwEfFYxmWpm5I2XkGmYtaHYtOtuieVIpZ11xSy5D5
         zDu67m4cQNjGUQr+N3ov/20jQetm+yuZmeWgycWda/4Z8WWX2JqYr0ibGqm+PQBYhfTV
         FFphYJWpn0ZVinfKUyrxMsb4yNcnrqag9h3ss+ouB+Qxgf9FSOwCEPszXFWHay7/a2BR
         yjqh5G92uY/ZvsjM9xQgsg/0csXrSv+O2AK0wqeAnjVXS+9wHONM/o1DGmTvOyI7CTcH
         WUtxubP94Xixp79t2VSY3o1w4ZEoj+7uxOTBvwEg2KSaIXv2OhS/bUyYcuKs4AzwOoXS
         8w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toJ5uCNFjWzAJBR7ewaPVlC4vkW0KDP/L41X/HMgzgw=;
        b=BM/IsgWbBypmg0BfLC+gZOQPVgqR8LmU2pwQ3ftQn/SvH7WFxOjHL+L7tlEv0tFBx/
         9ICFcHEj4P5APvjKQhZr9xa8gcuo2Gfk+y5XPea7vszZrMqLY+cle2BhECbgr6w3dDBU
         smcy0Q54U8FjHBTY77DdRM77zB6YMQJm/3YZ1aiatjs4CionH9XBzL1IzxasGmSdZCqy
         yF1/PLfd+spZdz6XcpES/IuSRIpfEUqQDiK3ir/cIPw9x5p3BspZpCETxLnOc1fe1O0f
         weUTOIMvbVQynudPzoNahdx//5ZTJd/K/gAscujmlnZoPVEcuoiaBi8+R3lJzEk4Fp7I
         z5aw==
X-Gm-Message-State: APjAAAVac9rt3Psmu34JGPSgEGeEyRRKuGaoIGyiMlnvdzXdBOrSZF3n
        5s812erHEFsjlVUfmoqUTLl83qmN6l4lJ8u1/xjvg/Qj
X-Google-Smtp-Source: APXvYqxiarfUJuzJ/cdOES1XRvlOh8CKmQ30F2dBwib+G2RYBXD1qCju76LJ23t8FPP3e6cmQLgaXAwfB5jE1+JkAmg=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr5849948otd.247.1573180918867;
 Thu, 07 Nov 2019 18:41:58 -0800 (PST)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191001075559.629eb059@lwn.net> <20191107131313.26b2d2cc@lwn.net>
In-Reply-To: <20191107131313.26b2d2cc@lwn.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Nov 2019 18:41:46 -0800
Message-ID: <CAPcyv4ihn9kgO-VDOK=Jyj8RrG2RVXUvu8Y66zR7JYZm9-rWPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:13 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Hi, Dan,
>
> A month or so ago I wrote...
>
> > > See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> > > and a follow-on example profile for the libnvdimm subsystem.
> >
> > Thus far, the maintainer guide is focused on how to *be* a maintainer.
> > This document, instead, is more about how to deal with specific
> > maintainers.  So I suspect that Documentation/maintainer might be the
> > wrong place for it.
> >
> > Should we maybe place it instead under Documentation/process, or even
> > create a new top-level "book" for this information?
>
> Unless I missed it, I've not heard back from you on this.  I'd like to get
> this stuff pulled in for 5.5 if possible...  would you object if I were to
> apply your patches, then tack on a move over to the process guide?

Sorry for the delay.

Yes, the process book is a better location now that this information
is focused on being supplemental guidelines for submitters rather than
a "how to maintain X subsystem" guide.

I do want to respin this without the Coding Style addendum to address
the specific feedback there, but other than that I'm happy to see this
move forward.
