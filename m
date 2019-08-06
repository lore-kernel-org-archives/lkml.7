Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146DBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15D2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQK7Lw6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfHFADz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:03:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40910 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHFADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:03:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so30904762oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg/DgxD3VnnGHA1TcpT2F4zdWkdlPFk/7sUfWPDW9zE=;
        b=bQK7Lw6Ta7pxzVic0w3JpbqQC3Q3gA+uD3iHWbJfaDr5Fhk6XXl1PTil8laFZKlseS
         2szxRHloYyOd8o8vSzhxOpV+obbD4Q7/zlz/LW6AAJJsoXsIZ4GlHNl0IqY3yTn3hC0X
         Hi0Mjj0RcipQvLI+6MEHX5kc5BMpxtaUalx5p5inl3pJo5u3zAhBAwUCA6xZoH9+DCxk
         J+Fhh//1Lx4sNGlyuqyIoaIDkI1vuGCbkByJMsTQU24sj13y44TxbS9P5IVFlcDwPloi
         eraKnbPZ4symb7LieX8BKOz5OmmxpdmuXDFhJHW+Yj29vD27NUuF3CpeI8DZyh1LdTil
         D9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg/DgxD3VnnGHA1TcpT2F4zdWkdlPFk/7sUfWPDW9zE=;
        b=cYXcemPeZ0ZxfIMcUw2L6p2+UXqwi8AakIcDkjY5MvdJ1MDBClrTEC6Dw1WY7/H9GZ
         AAMZYgMKgiLkaUiU2WlZ7HIFrMOv3O9peCkcdPsNy1vOF+5tqBkoiTsrHHEv/jIAeT9M
         9U2WzdkRYFRgKWM/7K3VhR2QnG9Dpbmm6EueUlTX1iZG1RxUkQ/7VU7MKbLucTjsuZIZ
         du4BrKjnbUasRJoegBsYxQyf3OEOVRiPX9T8rl/9JWhlfklSBLa1lkYQaaGPDAgLQJJQ
         kXXyu5O0EzWjFqAYbUZo/CQ48dZ3G7OqjHeFd023ipyMYBMRT5rdipN0J/jeIbj2ih0C
         BhKw==
X-Gm-Message-State: APjAAAUuV9BErIsqRClHgoEAj6o1jDRyCyXGr013w7iDidnR8U0jOlOx
        Vv6zCF1F98x4GpuAmbFANdL/zzwrhGtKTp9QpZApnw==
X-Google-Smtp-Source: APXvYqwIS1h7siX+nevMs4Z+Oy5KRR3DjgmRHxK4CUcKMskHi2jBpE3xTaaEjAqNsmEHp6TlpFd5duss1Xn1hOoOda0=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr517569otk.139.1565049834029;
 Mon, 05 Aug 2019 17:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190805130403.06dc27b4@canb.auug.org.au> <20190805145638.222e58b1@canb.auug.org.au>
In-Reply-To: <20190805145638.222e58b1@canb.auug.org.au>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 5 Aug 2019 17:03:18 -0700
Message-ID: <CAGETcx_Xwu64+CFz_AxUpDBeRBfB9+qU7pSc+KvVFVOOsjMUvw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the driver-core tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 9:56 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 5 Aug 2019 13:04:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the driver-core tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> >
> > drivers/of/platform.c:674:12: warning: 'of_link_to_suppliers' defined but not used [-Wunused-function]
> >  static int of_link_to_suppliers(struct device *dev)
> >             ^~~~~~~~~~~~~~~~~~~~
> >
> > Introduced by commit
> >
> >   690ff7881b26 ("of/platform: Add functional dependency link from DT bindings")
>
> It also produced this warning:
>
> drivers/of/platform.c: In function 'of_link_property':
> drivers/of/platform.c:650:18: warning: ?: using integer constants in boolean context [-Wint-in-bool-context]
>   return done ? 0 : -ENODEV;
>

Thanks for reporting Stephen!

I'll fix the bool vs int thing right away. Weird that no other
compilation caught it.

As for the function not used, I'll move all the new code into the
already existing ifndef CONFIG_PPC for now.

Looks like PPC doesn't populate platform devices from DT using the
generic of_platform_default_populate_init() in drivers/of/platform.c.
I tried grepping around, but I don't see clearly where all the devices
are populated from DT for PPC. I'm not familiar with PPC, so if you or
someone else can give me a pointer to how devices are populated in
PPC, that's be helpful. If there's interest in this series for PPC,
I'd be happy to add support to however PPC populates the devices from
DT -- specifically, creating device links for devices as they are
populated.

Thanks,
Saravana
