Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54A2C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B970A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="RUey+MSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:32:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37294 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:32:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so2089389otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 23:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=RUey+MSk1Jxsoa8ZqmDeOeA4Qu0lkrGc8OKXCXqKYlNDPNE/RI693KUy2YDy1bs0Bq
         ckWMixCAW5axJ3kJe7EpdMPizq+94X82FKhtwD7vIIOrm5PL4rWL5tMsRQc+gCoqi2TK
         RVgk0Kg9QPwUIVbMM59J11QqVgfeIgZPu4jOo1P8CBl7ke4N9DJQqfgylUSmvoKQKCbj
         mBjTqC/uvyUH/7bVZEmz7QQpfP5gtFAcrfBHGIuVQoZJNq8iC+Dgu0eAy4vcTOSab/Fh
         5mD7rv1Vz3M2bsNxX5R/1UKzn0KB1ehwLLvkMlxZ8kQlbvrKCCz1llIjyOUowure8p6X
         BRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=Q3ohUa6tph1eAZVv6CdQ665C6SgqF97EmoGUWRr/teadRy+xm1gbZBmHoTQj5OMTEU
         c7Vj9QcVQG9AoBNnucN9dbKUgl21jQVL9ZOn5Of+Gx2I2B75B/Uno2W8O7EBU0H99baK
         1hBjD31Mfeqk67WiKYViNG5U/FrvgVBDVrw65lByfODObvvzpDSkoXxGKFD2hkzLU0GR
         rhIj+Kvukvw20SdWVWbQ4p4XtxwHapIkVmP+oQHfUl79oQCn5TTpxDa4cnA4L0ptX9yg
         vBBLnuZsBJqPfuniXTsMDkbUajTLAN8hYGGOUw3OEtQ1TMQqK6WWxxOrZhdSFluUuyTV
         WHqg==
X-Gm-Message-State: APjAAAUWy1UGKi6xjmC/GvNLNQC7BjX8yYRKoopspZ6Dgsyxt7J+OaTF
        cQbWKfmSQxsGmkQ0WVOedsciUaCPTQhFaWNLsmTSHg==
X-Google-Smtp-Source: APXvYqxVdzze/Bv9h7nJAgHDFshYj18n/blQjGCiUjfCo8aBpbC+/jW+Mgs+B30i9qOHhWav26iyCwsoCBet2GWzaNY=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5418112otg.363.1574321547958;
 Wed, 20 Nov 2019 23:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 23:32:16 -0800
Message-ID: <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Pankaj Gupta <pagupta@redhat.com> writes:
> >
> > >  Remove logic to create child bio in the async flush function which
> > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > >  data write request.
> > >
> > >  Instead we are performing flush from the parent bio to maintain the
> > >  correct order. Also, returning from function 'pmem_make_request' if
> > >  REQ_PREFLUSH returns an error.
> > >
> > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >
> > There's a slight change in behavior for the error path in the
> > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > converted to -EIO.  Now, they are reported as-is.  I think this is
> > actually an improvement.
> >
> > I'll also note that the current behavior can result in data corruption,
> > so this should be tagged for stable.
>
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests? If not I
> think a synchronous wait is going to be a significant performance
> regression. Are there any numbers to accompany this change?

Why not just swap the parent child relationship in the PREFLUSH case?
