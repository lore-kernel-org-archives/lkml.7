Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B563C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE19B206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WkgaWEGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfC0PPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:15:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43964 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfC0PPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:15:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so11081049wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw4fnc4vtVAqbuNp/HPbYPz4Z7KAuxlltbSrQaJ0fJ8=;
        b=WkgaWEGf6a2ktMdnDEJfczmlgtYtT12CTh9Rugf1gavb06+8FuRy8KOciGPelHGNu7
         aVLX076xX9ZPBjkOpI36QcYMiIWdimYB2m+/UfNQImKFkJIgj6ryDIDHcOraPBg3NIiu
         oN3u8y1RXVdeUUoop8YNJzpI1+V+H3EtlB4QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw4fnc4vtVAqbuNp/HPbYPz4Z7KAuxlltbSrQaJ0fJ8=;
        b=WgDESEQkEE7tF9QJ9QrmoWBelckGOq5twECf/lj27xqOqf1Vf+6xwoRIwZQljRK+5L
         CE3pfBNS5cDIYnTEh/2v74djwrlwi3QM1MRqcfejF5SVkdqXmwFAu0DmPZKfoHstW4hW
         F1z+TX0T5l8Kt0AtVFNp/mksgCXoMRxTo2Y4rqWDPNaegxmjNDAdmgOdDtPtW8CIF014
         G1LwE2oaQOiW12BQlbXE131AWLv8q6k7cFFj3iwDt+/DUguTOaroNgWNP3rW+zQsxy+a
         RqoYzRwq1H6JVr61xi2uNxAFI3HebrIDofG3wrZ1S5t6UJY+jtaz2KOW2wXxe2AdJArD
         dBdA==
X-Gm-Message-State: APjAAAXCiBM4pQRgD4w7Ard5RH3o51AGbEPc55HMwR020pxVXERoKdhJ
        T9cZmB6SEwt1TAR6N2vBowKh8sdWUaGo6znHDZahoA==
X-Google-Smtp-Source: APXvYqzDloGTcppDsG4aqOFuy1CCSMtXMvGC98sX7Orh6pFr3cnr+yWp4y478hYQcV8++1WmHZqSNInbSq+52pPpv0s=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr12831982wrs.250.1553699732001;
 Wed, 27 Mar 2019 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <CABe79T5M3FJQed018aGfRhS7eLBbtmoO33mFP=K+xHgavto64Q@mail.gmail.com> <20190327123114.GA9636@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190327123114.GA9636@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 27 Mar 2019 20:45:19 +0530
Message-ID: <CABe79T4pQQOVPDKSHcf7D1LMBzXUVD3_0NPdH+MORRZYMxtoFQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Thanks for feedback, I will talk to our HW engineer.

Regards,
Srinath.

On Wed, Mar 27, 2019 at 6:01 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Mar 27, 2019 at 02:08:46PM +0530, Srinath Mannam wrote:
> > Hi Lorenzo/Bjorn,
> >
> > Could you please help to review this patch series when you have time?
> > I believe I have addressed all your review comments.
>
> I will shortly keeping in mind that you should really ask HW designers
> to get to grips with a proper design because there are ways too many HW
> quirks this driver has to fix-up, it has become an unmanageable
> collection of work arounds.
>
> Lorenzo
>
> > Thanks,
> > Srinath.
> >
> > On Fri, Mar 1, 2019 at 10:22 AM Srinath Mannam
> > <srinath.mannam@broadcom.com> wrote:
> > >
> > > This patch set extends support of new IPROC PCIe host controller features
> > >  - Add CRS check using controller register status flags
> > >  - Add outbound window mapping configuration for 32-bit I/O region
> > >
> > > This patch set is based on Linux-5.0-rc2.
> > >
> > > Changes from v3:
> > >   - Addressed Lorenzo Pieralisi comments.
> > >
> > > Changes from v2:
> > >   - Based on Lorenzo Pieralisi comments, commit logs are expanded.
> > >
> > > Changes from v1:
> > >   - Addressed Bjorn Helgaas comments.
> > >   - Removed set order mode patch from patchset.
> > >
> > > Srinath Mannam (2):
> > >   PCI: iproc: Add CRS check in config read
> > >   PCI: iproc: Add outbound configuration for 32-bit I/O region
> > >
> > >  drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
> > >  1 file changed, 40 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
