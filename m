Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9668C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B1820679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBkayP6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHMHt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:49:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44310 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMHt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:49:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so48914923plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mW5A/F96LGmeoUnuyfmkeD+8FPBFF0FLdDwgDAb/O+4=;
        b=XBkayP6vpR2jredVX5f2OX73KWFMemXcpqfKfVTkjP/SxilMyFFk3gv87Ny5WFEP0j
         V1lEm6hG8O/zaGjtmle7HgVR10AOwRoH1MnGCbIuEzr0p22taiIryAtPSOUfQ6jmybRT
         NijkDaVah0XCYE8hb4Oj2lOfLS8wum0QRDmfmom7WtsY5zR3oSpFxNs0ppHsLrH81KZM
         YdwNnMxVOGC2b2gc9iX99+Ai+abklEly8bBj720EFBjUEEt/iy8vhVhDxOAXW0eIV1OO
         gmc13YQLgzDdlcvoklIx+AGMI/V5Eocmtb8jsp3VUHUvzL7Wy//hLcfbx7iSWibXNXV2
         n8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mW5A/F96LGmeoUnuyfmkeD+8FPBFF0FLdDwgDAb/O+4=;
        b=QySLm6xgMNiCDkOSLb1PZd9SYj0lGHlygogbU5ylhYMwVS/gPg7oF4kYNAMtOEQ92y
         9VrGUGq26tCY+0TOmPtcQRl4z2mk9dGSfcTfjiIE6IXdv5OdT8+2BXgN78pA3jxq2oU2
         Y08Lb+y7PmkCVELb1gCw8FpBzAhneGVKN8uqdevP7dMBSFU3O4VOI8Voew62blQ/A2xd
         +OcVfk28k83+TSjNynk1glj861pxKFiT4jUoWZ4fdeZ+N9ms9QugyiShfP+xs3rvyRJZ
         7nTF0j50ct4xRzK7OodRTabNhCtW4c3Ixn23Gzvuu4MDhn6mdkdg/rZ5ebQq82/CuC9P
         cCtA==
X-Gm-Message-State: APjAAAWXKMFAF+4aXWa6GslpMO/rtmuZKix9ZBsMwa5yh4uZMubNZI1n
        4KxOV9hE/VsK7vrNogUega4=
X-Google-Smtp-Source: APXvYqw0x8LOP5wdKEndM1P5xUkrPIxxnq/7TrB6kFXRLlAay93Ev8eBDadgqhhS+dxVnNd8o7eG/w==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr28555496ple.62.1565682563480;
        Tue, 13 Aug 2019 00:49:23 -0700 (PDT)
Received: from localhost (c-73-189-176-234.hsd1.ca.comcast.net. [73.189.176.234])
        by smtp.gmail.com with ESMTPSA id e17sm1101800pjt.6.2019.08.13.00.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 00:49:22 -0700 (PDT)
Date:   Tue, 13 Aug 2019 00:49:20 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fei1.li@intel.com" <fei1.li@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Message-ID: <20190813074920.GA24196@private.email.ne.jp>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
 <20190809070647.GA2152@zn.tnic>
 <3355d77da5e094ad1d3149b9236cdd204486fd69.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3355d77da5e094ad1d3149b9236cdd204486fd69.camel@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 07:51:17PM +0000,
"Kani, Toshi" <toshi.kani@hpe.com> wrote:

> On Fri, 2019-08-09 at 09:06 +0200, Borislav Petkov wrote:
> > On Thu, Aug 08, 2019 at 08:54:17PM -0700, Isaku Yamahata wrote:
> > > Make PAT(Page Attribute Table) independent from
> > > MTRR(Memory Type Range Register).
> > > Some environments (mainly virtual ones) support only PAT, but not MTRR
> > > because PAT replaces MTRR.
> > > It's tricky and no gain to support both MTRR and PAT except compatibility.
> > > So some VM technologies don't support MTRR, but only PAT.
> 
> I do not think it is technically correct on bare metal.  AFAIK, MTRR is
> still the only way to setup cache attribute in real-mode, which BIOS SMI
> handler relies on in SMM.

Then you're claiming if it's baremetal, both MTRR and PAT should be
enabled/disabled at the same time?


> > > This patch series makes PAT available on such environments without MTRR.
> > 
> > And this "justification" is not even trying. Which "VM technologies" are
> > those? Why do we care? What's the impact? Why do we want this?
> > 
> > You need to sell this properly.
> 
> Agreed.  If the situation is still the same, Xen does not support MTRR,
> and the kernel sets the PAT table to the BIOS hand-off state when MTRR
> is disabled.  The change below accommodated the fact that Xen hypervisor
> enables WC before hand-off, which is different from the default BIOS
> hand-off state.  The kernel does not support setting PAT when MTRR is
> disabled due to the dependency Isaku mentioned.
> 
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1107094.html

Thanks for supplement.
In addition to Xen, KVM+qemu can enable/disable MTRR, PAT independently.
So user may want to disable MTRR to reduce attack surface.
ACRN doesn't support MTRR.

Let me include those description for next respin.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
