Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CDF208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 22:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ORWiaI+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDTWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 18:04:21 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38507 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDTWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 18:04:20 -0400
Received: by mail-ed1-f42.google.com with SMTP id c1so973857edk.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldGakbeMe/Lt2zN3VzkUpoUzBgNiYR8VYYlH08lu4Jo=;
        b=ORWiaI+Ytll5EGAnzlMifemWhfONQL/8msZPZ/t4GAzbqUTRWL+AGGqRfzgLwXLiYy
         oHPdYzxjUpBtlRyjdQ530CpJDKKxaFyJBULeP4lDTl/wRK2XTLS7qR723rh74zQfIW/H
         ixP6H8jBuseWGRJWSt9MLpIqcCLqqMlpQCwmj+m4zBngIq+hM4igY4AdKlnJr6VxDtOr
         l3EaYq85sBwm3KKumaNJ1bgvLqehaU1VZ/ST0dovMxskHTSocMIyzkONaiX21+kmXy9w
         yXQnYu9JZpgDAj/jILsEWEOupBZywML2kC+4becYHw526Xv2UrS8FYD9Xc3BgNTsbuve
         hOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldGakbeMe/Lt2zN3VzkUpoUzBgNiYR8VYYlH08lu4Jo=;
        b=oNI4o/Cpv2MA+8n4jDsdPubD7VRB3p8Oms+eN53pG6nkxGYyRqmukS+hRIkdIyURA1
         /eoFb8897RKrd2e1n5ugBU1JI4hOGMsFoSf4OxrvNmF+sP73N//KQvd9q9uNToUVnWrv
         nZ63Q+cnOByovARuAFVQyqwhKqC061JQt6nOJfvwpqqwsaB2t8Fr8SdWZTHJcY9UYOhK
         eM83Xzud1D1O5lLzanAs1e+yYYO/9bzrtUW++xnlb+pvyEWk5mTToV1mg1jKVn8a5YPX
         ffVeR6vfkgCWrgliEt/Kjyi4ksdBNfK8Ozpq4l7DaS7bO7r6CxHrKdz/1b1z63xb339H
         yWxw==
X-Gm-Message-State: APjAAAWiRDh3Rtxjt2T43muFbQwZ/WF9+y3kZ69Wbhj7Pbpc/ezWxt51
        iXZpKtpKMfd7iKfle1uyuX5V7lbRb1vSg7rwulaJYA==
X-Google-Smtp-Source: APXvYqzJsP/uUBOTa8F60H6DOWHPR7LdNkf2eeXWxOZiwVI9vC4YfgDXBWK2g4ZV7P0lur0pLJWVe3HVjkyAGGl/u7c=
X-Received: by 2002:aa7:cf8f:: with SMTP id z15mr4002141edx.190.1555797858736;
 Sat, 20 Apr 2019 15:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
 <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
 <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com>
 <CA+CK2bA-wDwRT5Gv2p9Nm1Vr8LNg84rQdE6=s2m2hQLYqj5Rog@mail.gmail.com> <CAPcyv4gBu5QhgRQ+maJs108JwBrcCa9U1e9wgO8FP6Q3qwy69g@mail.gmail.com>
In-Reply-To: <CAPcyv4gBu5QhgRQ+maJs108JwBrcCa9U1e9wgO8FP6Q3qwy69g@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 20 Apr 2019 18:04:07 -0400
Message-ID: <CA+CK2bBFqq0tNOE9gh7JAhjw8XLW_pMpVQtUwbm6JwW=LWt_iQ@mail.gmail.com>
Subject: Re: [v1 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>
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

On Sat, Apr 20, 2019 at 5:02 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Apr 20, 2019 at 10:02 AM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > > > Thank you for looking at this.  Are you saying, that if drv.remove()
> > > > returns a failure it is simply ignored, and unbind proceeds?
> > >
> > > Yeah, that's the problem. I've looked at making unbind able to fail,
> > > but that can lead to general bad behavior in device-drivers. I.e. why
> > > spend time unwinding allocated resources when the driver can simply
> > > fail unbind? About the best a driver can do is make unbind wait on
> > > some event, but any return results in device-unbind.
> >
> > Hm, just tested, and it is indeed so.
> >
> > I see the following options:
> >
> > 1. Move hot remove code to some other interface, that can fail. Not
> > sure what that would be, but outside of unbind/remove_id. Any
> > suggestion?
> > 2. Option two is don't attept to offline memory in unbind. Do
> > hot-remove memory in unbind if every section is already offlined.
> > Basically, do a walk through memblocks, and if every section is
> > offlined, also do the cleanup.
>
> I think something like option-2 could work just as long as the user is
> ok with failure and prepared to handle it. It's already the case that
> the request_region() in kmem permanently prevents the memory range
> from being reused by any other driver. So if the hot-unplug fails it
> could skip the corresponding release_region() and effectively it's the
> same as what we have now in terms of reuse protection. In your flow if
> the memory remove failed then the conversion attempt from devdax to
> raw mode would also fail and presumably you could fall back to doing a
> full reboot / rebuild of the application state?

With option two, where we will simply check that every memory_block is
offlined, we will have deterministic behavior:

1. If user did not offline every dax memory section beforehand via
echo offline > /sys/devices/system/memory/memoryN/state

echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
Will be the same as now, will simply return, and user won't be able to
use dax afterwords or hotremove it.

2. If user did offline ever dax memory section beforehand
echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
Will be guaranteed to succeed to hotremove the memory, as there is
nothing that can fail.

So, if user wants to hotremove dax memory, he/she must ensure that
every section is offlined before unbinding.

Pasha
