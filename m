Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06507C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FB72184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PzoghoiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfGRQpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:45:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39166 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:45:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so31002323edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KgRfHejv/zIzuUta64QTdW+DJVmqS0zjC4X90cCy9QI=;
        b=PzoghoiUeT+cfTCoJNBcMdcHj4lUEnnKPdIB0RIR7UfIhBNExY45DGUWwEb6VInVhX
         cdfKfmcchZblLxSSZF5AFrMDhwPcAlqFPUCLjsX8x8+8Zcs2u2GmFaiF1ECh4v8PQ2F8
         j4HhGExKdqzRvuS2Dl4OmXpajh5psO9uuIZTpdM7O5nZPeYs4yVRzt8mIMiynp96OWiC
         uDolhH6hlq7pA1VxLsr2gjfo3hvLExYypRB7JfUrW4J1IQdRCAoGrAG5ih/r8aFRnlxJ
         PBn48/MCV1UMTY8QGKa/jew7xYNxn6sUpCvfRcBqSKGRUcEPnUkv/zraQfpIgkIpixCd
         ortg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KgRfHejv/zIzuUta64QTdW+DJVmqS0zjC4X90cCy9QI=;
        b=Utv7ARdTlmo/K15qiJuyPbjzYIs4tbXvsMlZpeOxTqDeNhXkhY0GuIbZsW6Zezd+UO
         t55mmn/Q1/ddZRzSo+ReCgb2im4MouyjWK8uOvLEkALGwAMuBIzEoZpVPfK/p7xD0+LD
         FkMI0y568YRYArMWmm9ltU13f4D+U5GODc883tNWbNgs8Kt1DqKrW0tzAbskgk/YzB/S
         fSERuEs7vIHEKt/yJRj8lo5VlHWn0DPvQtmzg+GoE0oPgDSZn4plWFn2+uDM/9H1D3Wb
         wKmM73Ua+fltEI1JHdGEgbnIsObgUzx/JdpOgPhf6XpRQZmdjgSPydtV2mvQWUTLYIxO
         bx6w==
X-Gm-Message-State: APjAAAUo7/qHqxm2pj67NPhRWFMfx4Cmc2XKA49YiIu87IWxtWMvYG7O
        Gjo1++clzPmx5YGjn1YOukezjd++/GsnmkD9hKc=
X-Google-Smtp-Source: APXvYqxFDf5VCS9acxFCu5q7BESVni3L/MJZz4NoBB7LBP3pSJFBG6PopXkq/zkj8QMkeiPsyBwKVx67bKcjyYdDtg4=
X-Received: by 2002:a17:906:9447:: with SMTP id z7mr37111939ejx.165.1563468347812;
 Thu, 18 Jul 2019 09:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190718024133.3873-1-leonardo@linux.ibm.com> <CA+CK2bBu7DnG73SaBDwf9cBceNvKnZDEqA-gBJmKC9K_rqgO+A@mail.gmail.com>
 <6cd8f8f753881aa14d9dfec9a018326abc1e3847.camel@linux.ibm.com>
In-Reply-To: <6cd8f8f753881aa14d9dfec9a018326abc1e3847.camel@linux.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 18 Jul 2019 12:45:36 -0400
Message-ID: <CA+CK2bA9_B8siPCSSdrN_yecGZZy82UNx7P=QK8N5GuPjto1HQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in ZONE_MOVABLE
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:04 PM Leonardo Bras <leonardo@linux.ibm.com> wro=
te:
>
> On Thu, 2019-07-18 at 08:19 -0400, Pavel Tatashin wrote:
> > On Wed, Jul 17, 2019 at 10:42 PM Leonardo Bras <leonardo@linux.ibm.com>=
 wrote:
> > > Adds an option on kernel config to make hot-added memory online in
> > > ZONE_MOVABLE by default.
> > >
> > > This would be great in systems with MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy=
 by
> > > allowing to choose which zone it will be auto-onlined
> >
> > This is a desired feature. From reading the code it looks to me that
> > auto-selection of online method type should be done in
> > memory_subsys_online().
> >
> > When it is called from device online, mem->online_type should be -1:
> >
> > if (mem->online_type < 0)
> >      mem->online_type =3D MMOP_ONLINE_KEEP;
> >
> > Change it to:
> > if (mem->online_type < 0)
> >      mem->online_type =3D MMOP_DEFAULT_ONLINE_TYPE;
> >
> > And in "linux/memory_hotplug.h"
> > #ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
> > #define MMOP_DEFAULT_ONLINE_TYPE MMOP_ONLINE_MOVABLE
> > #else
> > #define MMOP_DEFAULT_ONLINE_TYPE MMOP_ONLINE_KEEP
> > #endif
> >
> > Could be expanded to support MMOP_ONLINE_KERNEL as well.
> >
> > Pasha
>
> Thanks for the suggestions Pasha,
>
> I was made aware there is a kernel boot option "movable_node" that
> already creates the behavior I was trying to reproduce.

I agree with others, no need to duplicate this functionality in a
config, and Michal in a separate e-mail explained the reasons why we
have MEMORY_HOTPLUG_DEFAULT_ONLINE.

>
> I was thinking of changing my patch in order to add a config option
> that makes this behavior default (i.e. not need to pass it as a boot
> parameter.
>
> Do you think that it would still be a desired feature?
>
> Regards,
>
> Leonardo Br=C3=A1s
