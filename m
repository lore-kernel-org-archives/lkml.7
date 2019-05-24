Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752E2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391255AbfEXLnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:43:15 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35719 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbfEXLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:43:14 -0400
Received: by mail-wm1-f52.google.com with SMTP id w9so2777254wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQ5Notts0BAv9aikRNQKLy1psUiEzig1oST72IhaGow=;
        b=SNSGOPprwVKCrwRJJSj2pDWUOnlUGflmmHVZOsX99cADIvadSjy7kDVt9teLeWbpkV
         7/56/m4EH4BUg+mUqlrMz9wRyaUX1s/KeGxDXwV8eVzPGfDG21DpX9ObvGRJVZDVkdje
         pJAObpl8PnTrXaBQ36ucFgEYw0Rn0a+uFmd+qL/LcTchka7rLnlNN2Cxq9lqVQE+deoj
         pi0kXW7oinJWwaewJrh0NZe/qslcyHs6FscLelhIZI1tyfSrVNMPKoj/7eQ5ykB6znS7
         LOHWg0D9Xp39ULkGCw6O+FwZIuF4ubDVtHvruypeqt4P3oMWlNaZwV0NDlkAoGOSIRrj
         hn3A==
X-Gm-Message-State: APjAAAXoLtfLt2sIEFEby76FJ/huDBEBxxekD0EpyhHkYDhZDUglQkJg
        QL14lo+0orEzsOqoVUy981P7QmzT/r4=
X-Google-Smtp-Source: APXvYqyM7KgS6R5ZRv/7BgvhV2xOQx8JJLv0FBpz1HKYks8F4VO4kLpVKwOXUcKrjx5ZlTesSmCa+w==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr16519573wmi.15.1558698192747;
        Fri, 24 May 2019 04:43:12 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a128sm2210109wmc.13.2019.05.24.04.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 04:43:11 -0700 (PDT)
Date:   Fri, 24 May 2019 13:43:10 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190524114310.6h3tlslncepa6323@butterfly.localdomain>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box>
 <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
 <CAO9zADyq44Sn0kYZBC55C0ykpHaASzp+27K3BofbkEniK6af-w@mail.gmail.com>
 <CAO9zADw_PnZMyVJKek-GT96esPXdh007hnzenveawOAM3CvK9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADw_PnZMyVJKek-GT96esPXdh007hnzenveawOAM3CvK9g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:27:50AM -0400, Justin Piszcz wrote:
> On Thu, May 16, 2019 at 10:17 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> >
> > On Thu, May 16, 2019 at 10:14 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> > >
> > > On Tue, May 14, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > > Could you check what khugepaged doing?
> > > >
> > > > cat /proc/$(pidof khugepaged)/stack
> > >
> > > It is doing it again, 10:12am - 2019-05-16
> > >
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > >    77 root      39  19       0      0      0 R 100.0   0.0  92:06.94 khugepaged
> > >
> > > Kernel: 5.1.2
> > >
> > > $ sudo cat /proc/$(pidof khugepaged)/stack
> > > [<0>] 0xffffffffffffffff
> > >
> 
> As a workaround/in the meantime--I will add the following to lilo/grub:
> transparent_hugepage=never
> 
> Justin

Cc'ing myself since i observe such a behaviour sometimes right after KVM
VM is launched. No luck with reproducing it on demand so far, though.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
