Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F4C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1862064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeX5v9ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfCFTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:08:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51265 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfCFTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:08:51 -0500
Received: by mail-it1-f196.google.com with SMTP id e24so11301286itl.1;
        Wed, 06 Mar 2019 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3hq+LqjUjg+BkrZdYl/kSPNrNKGY5hWXHfQfAinw+s=;
        b=CeX5v9ww2mf+7Asj0FqY8Z4jtCmK1Az5A+PyiA/ulDFEfbMzzwOds93LrLJTv0ot+i
         qB/dcZbpf5eUt6PTI5Rc5qHOqAcHPwt5Wzl3nub0iQkXESwEW60W1bRH6IDTjPUfnKN+
         AWeTZ+8hYDDujKbwHsAIJQf4KDakpoFrLCAdHkhtKc99/kH0MG7n+azO0P+F5XE5XRFC
         Nxhjow2KSEEgfHHoC85lHH3f3EiOPwNdY/1kme9assbm+/ooyLhAM/3iIW/xIJKFUkSv
         lPSYORcfT8R7Im4y2zvhze04ZNnL57pxeT76vQCqoQzY8jVDC4S7XfwA/TnCQv4y4lso
         wFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3hq+LqjUjg+BkrZdYl/kSPNrNKGY5hWXHfQfAinw+s=;
        b=PXjb0J9wph2hYXHUMADEFw1KhKCiDVX1mLvjl2YZL0fbcHwcht0Nbk4fsjbMe5KCEf
         cTtIw09RTTKhSymv2MrJMkki3MroUHzzkzUCZ+ij9dZ4+7Lh/guAs3xvdbljLzy69oRR
         MBRo5ESeDKFKnRaoy2yQmfnpFZsY8B8o+flp4SKg31WeduBOo5Mcuq9B1EmJN5odNFxv
         oLtiJS6OB1lmhmaWoSP0SNWAOk56auzU/4/OhzeroUkXFHxHSmhxXjFXE17Cskg9NwNN
         A2rxhkBPP1PSuVnIv6F0XGuG7QR55n9txzmdnSVZgPVrpf6zZtwfS3jCTRNxdfv6lSbT
         nd/g==
X-Gm-Message-State: APjAAAV/qA6BZdzIY0SyX5bnH0vDIjNZZf/By52kidS+t/OHmWagrgDU
        u2znQKwvJKfQlr3Wqfy4/wUkmoI5hWANsXjqq1s=
X-Google-Smtp-Source: APXvYqxre7Qg17324YiENSBsRaXlZ6Rfn+CG+w7EfQ5MaSivgqBjvVpp+bYxyY75ucNZl1jKG7zxvlLdP6gr2uHKHSY=
X-Received: by 2002:a24:4650:: with SMTP id j77mr2992351itb.6.1551899330458;
 Wed, 06 Mar 2019 11:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com> <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com> <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
In-Reply-To: <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 11:08:39 -0800
Message-ID: <CAKgT0UdqCb37VNe7pABBYBXYFrVzYdPntmPf-V6ZYp9DdwmxYA@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.03.19 19:43, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >>>> Here are the results:
> >>>>
> >>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> >>>> total memory of 15GB and no swap. In each of the guest, memhog is run
> >>>> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> >>>> using Free command.
> >>>>
> >>>> Without Hinting:
> >>>>                  Time of execution    Host used memory
> >>>> Guest 1:        45 seconds            5.4 GB
> >>>> Guest 2:        45 seconds            10 GB
> >>>> Guest 3:        1  minute               15 GB
> >>>>
> >>>> With Hinting:
> >>>>                 Time of execution     Host used memory
> >>>> Guest 1:        49 seconds            2.4 GB
> >>>> Guest 2:        40 seconds            4.3 GB
> >>>> Guest 3:        50 seconds            6.3 GB
> >>> OK so no improvement.
> >> If we are looking in terms of memory we are getting back from the guest,
> >> then there is an improvement. However, if we are looking at the
> >> improvement in terms of time of execution of memhog then yes there is none.
> >
> > Yes but the way I see it you can't overcommit this unused memory
> > since guests can start using it at any time.  You timed it carefully
> > such that this does not happen, but what will cause this timing on real
> > guests?
>
> Whenever you overcommit you will need backup swap. There is no way
> around it. It just makes the probability of you having to go to disk
> less likely.
>
> If you assume that all of your guests will be using all of their memory
> all the time, you don't have to think about overcommiting memory in the
> first place. But this is not what we usually have.

Right, but the general idea is that free page hinting allows us to
avoid having to use the swap if we are hinting the pages as unused.
The general assumption we are working with is that some percentage of
the VMs are unused most of the time so you can share those resources
between multiple VMs and have them free those up normally.

If we can reduce swap usage we can improve overall performance and
that was what I was pointing out with my test. I had also done
something similar to what Nitesh was doing with his original test
where I had launched 8 VMs with 8GB of memory per VM on a system with
32G of RAM and only 4G of swap. In that setup I could keep a couple
VMs busy at a time without issues, and obviously without the patch I
just started to OOM qemu instances and  could only have 4 VMs at a
time running at maximum.
