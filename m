Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D1DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 23:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280792075A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 23:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="L6bjxaxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfDTXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 19:19:37 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35024 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDTXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 19:19:37 -0400
Received: by mail-oi1-f175.google.com with SMTP id j132so6256691oib.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nnv3nFKnHwdfb1tQUBBdChAgSYqjmcWYJ4x8yIvqqBk=;
        b=L6bjxaxQljUFK9wvHH6ANy4kjjAuOH79E7XwtzfGFJ0b6UKLFYtcFZRpHIEvK81bsi
         OVAlVKUsU/0IiCPbD57ovHV6jVz0Ywx6QSrRZBDkuiskj1qNyAsKh32LZdVjX9nFF5Tw
         2s3CK4FqmzH4cKjeGtzCqo+7xFCmWzAxlSsx+l3i0HqZZ0qUkofNSvIgkgTsvoh4UqpF
         48ZdTHmg3QwyfUzAtCImu8LNhk7SQtzQe0kfkNyfzDEGRd+gShRISNr4RYogxdj6xpoU
         mU2fdJUOn6etaYH3VuqF1GHcsMXadvThGI+yzEBsZsFAaJnk37eYkH2IY2NpJnzh8a6L
         PzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnv3nFKnHwdfb1tQUBBdChAgSYqjmcWYJ4x8yIvqqBk=;
        b=EqzxouxLOXnl+sEcmlGehWjhme5fPycEpDChU4CEpdosNTltWGVZQuJ4wYCZEJdL0j
         lUpr9utceaQVojAqTJhJpHRbLwrQuhCUii/Dgzo/q0R0+vDOV0J3pToRFJSwrxLuRJ9p
         NvbHbKjrySCeV/pEM2IZA8T+oOOl07V78ZCQkGsy5u9biYCXwBKJSvebN+8Ee4bWcvC6
         m08tfwzrrFGSdszy1kdkXDknaq8FO4z/wxOnfO0vq+7EApRgE6iCRd+1p2kfReMQ2vPW
         aA3+4c7dlqD/8mcVtVqu2OSS5q0F6N5YWj7LjJFTE4HO/ino6YbrhNTcgJqc+/bF2FOI
         mHRA==
X-Gm-Message-State: APjAAAW62gv7UJLMwDmyikS/oRMcN2WxjtPTyJSeT7xZyL4CVAeKxuXW
        Pmp8BXuz1qEXooMW1baF+Mn8TAwpKDZQxsjh/mZ75w==
X-Google-Smtp-Source: APXvYqzxeewGoMHfjWesxJnv2BsUMO5Z+mG7JRGSsX09T0mBiWN2H+7ua0kGSQ8bbN3T9n9QOFSL8pMp71DkNHXugzM=
X-Received: by 2002:aca:f581:: with SMTP id t123mr6399074oih.0.1555802376510;
 Sat, 20 Apr 2019 16:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
 <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
 <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com>
 <CA+CK2bA-wDwRT5Gv2p9Nm1Vr8LNg84rQdE6=s2m2hQLYqj5Rog@mail.gmail.com>
 <CAPcyv4gBu5QhgRQ+maJs108JwBrcCa9U1e9wgO8FP6Q3qwy69g@mail.gmail.com> <CA+CK2bBFqq0tNOE9gh7JAhjw8XLW_pMpVQtUwbm6JwW=LWt_iQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBFqq0tNOE9gh7JAhjw8XLW_pMpVQtUwbm6JwW=LWt_iQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Apr 2019 16:19:25 -0700
Message-ID: <CAPcyv4in0N9yHzXBWTBTyeYcLgxKBkjj2UBPLpkBuyP2kUY22w@mail.gmail.com>
Subject: Re: [v1 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 3:04 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sat, Apr 20, 2019 at 5:02 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Sat, Apr 20, 2019 at 10:02 AM Pavel Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > > > Thank you for looking at this.  Are you saying, that if drv.remove()
> > > > > returns a failure it is simply ignored, and unbind proceeds?
> > > >
> > > > Yeah, that's the problem. I've looked at making unbind able to fail,
> > > > but that can lead to general bad behavior in device-drivers. I.e. why
> > > > spend time unwinding allocated resources when the driver can simply
> > > > fail unbind? About the best a driver can do is make unbind wait on
> > > > some event, but any return results in device-unbind.
> > >
> > > Hm, just tested, and it is indeed so.
> > >
> > > I see the following options:
> > >
> > > 1. Move hot remove code to some other interface, that can fail. Not
> > > sure what that would be, but outside of unbind/remove_id. Any
> > > suggestion?
> > > 2. Option two is don't attept to offline memory in unbind. Do
> > > hot-remove memory in unbind if every section is already offlined.
> > > Basically, do a walk through memblocks, and if every section is
> > > offlined, also do the cleanup.
> >
> > I think something like option-2 could work just as long as the user is
> > ok with failure and prepared to handle it. It's already the case that
> > the request_region() in kmem permanently prevents the memory range
> > from being reused by any other driver. So if the hot-unplug fails it
> > could skip the corresponding release_region() and effectively it's the
> > same as what we have now in terms of reuse protection. In your flow if
> > the memory remove failed then the conversion attempt from devdax to
> > raw mode would also fail and presumably you could fall back to doing a
> > full reboot / rebuild of the application state?
>
> With option two, where we will simply check that every memory_block is
> offlined, we will have deterministic behavior:
>
> 1. If user did not offline every dax memory section beforehand via
> echo offline > /sys/devices/system/memory/memoryN/state
>
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
> Will be the same as now, will simply return, and user won't be able to
> use dax afterwords or hotremove it.
>
> 2. If user did offline ever dax memory section beforehand
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
> Will be guaranteed to succeed to hotremove the memory, as there is
> nothing that can fail.
>
> So, if user wants to hotremove dax memory, he/she must ensure that
> every section is offlined before unbinding.

Sounds reasonable to me.
