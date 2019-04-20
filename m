Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE362C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EBA208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tPghUGKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfDTQgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:36:54 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45176 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTQgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:36:53 -0400
Received: by mail-ot1-f54.google.com with SMTP id e5so6487971otk.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yj9wzn35auL/sy+jXnnA3kG5x9sxPBjJxZokaO093PI=;
        b=tPghUGKQh0cLGJU6m3fdkw/7IPhUn6LLqAMqIPccD7pU/MGSMAoDbnY83bNFuM0Shl
         vz3Krc1KFnuWrOfWorXcTz4RAiCLlQmfU4+jwb96HL3e2bdEGprYA2cyVwX4VIniU4za
         A6aV5MbgH+kDYiOy2ADx5HX0wMukiPJurTuVXE/Ftdt0KJioibI/jgHYge6T5MnNubDo
         9oKlWsfw8AKWH8H+M7ntLv7/5vQ/RexiW6lPjSCsV7s/fLD8798d9bQwVwm+eoyM3Fi1
         kSKnfDCrG/8u3Qd+/5kpRzvzQb0aE2r/yzjwJIbNm9C2tgW/6aINii+/1N3Hsxbm+mar
         HH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yj9wzn35auL/sy+jXnnA3kG5x9sxPBjJxZokaO093PI=;
        b=ODDXU+cVPTEgd3y74wh+daRYUHAne104BrmI+Y74e7DC6e85k8rHyZYm6askuY47Yf
         YLPnlyUiVFn5GtmILIbM3TTRG9GjAuXdIc6H36yRdjLQNGvVkRPCn1hwINoYef3MGIiy
         mAqtzd8xVsiYoIpphu5UcawjcEc4mGutWoJFAidv63a0gb2b0MJwmSHBtGqmVkl/uPRv
         u+g8VsIz0OYcT2bPLGmuzoL9J4Hoc7lSAFLRKZ24TKyYZkbXe9+OA0JleDyDYxNgo1G4
         s0IH5hBdc82uM2Gx5BmlYxp6ROnuGy+JdH1hkbdsMLTAC/hcTE6/0oyb8IFd8YdlvwD0
         67nA==
X-Gm-Message-State: APjAAAVZb+lHSKOr0l7S5ecygHtli5/Xc6x1z99P7bj9dse2n32+ggQX
        6i4Nsfh+rO9UCYBmF6yj+81l2JnKI2zRp6m3DOcClGqV
X-Google-Smtp-Source: APXvYqzL5JYERjbiDNCEXZALt3QhyTy3JQjWs/OIvsY4rj+Ml6k6gcqZT/mGbyQrfTzoWXSzMMeI5ThK03Y/AvVXJp0=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr5606295otf.98.1555778213001;
 Sat, 20 Apr 2019 09:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
 <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
In-Reply-To: <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Apr 2019 09:36:42 -0700
Message-ID: <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com>
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

On Sat, Apr 20, 2019 at 9:30 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > +
> > > +       /* Walk and offline every singe memory_block of the dax region. */
> > > +       lock_device_hotplug();
> > > +       rc = walk_memory_range(start_pfn, end_pfn, dev, offline_memblock_cb);
> > > +       unlock_device_hotplug();
> > > +       if (rc)
> > > +               return rc;
> >
> > This potential early return is the reason why memory hotremove is not
> > reliable vs the driver-core. If this walk fails to offline the memory
> > it will still be online, but the driver-core has no consideration for
> > device-unbind failing. The ubind will proceed while the memory stays
> > pinned.
>
> Hi Dan,
>
> Thank you for looking at this.  Are you saying, that if drv.remove()
> returns a failure it is simply ignored, and unbind proceeds?

Yeah, that's the problem. I've looked at making unbind able to fail,
but that can lead to general bad behavior in device-drivers. I.e. why
spend time unwinding allocated resources when the driver can simply
fail unbind? About the best a driver can do is make unbind wait on
some event, but any return results in device-unbind.
