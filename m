Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3166ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55E220854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sseX6QWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfJOV0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:26:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41227 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfJOV0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:26:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id w65so18162252oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjTzov0ZWMBRnnkfLydTowwTTWaZQQMz8GLbYd2DoJY=;
        b=sseX6QWUP9CFA63813y5OMpaVx25163OITn2IzLP24ux6NTGMBFIsckkEKwagWvAJq
         9yXBTSntSikoMBdORY8eLAPlVHulfEOthNtwXgw3Sxy1X0v3CvRKlAM22m0WLC13KAQp
         tg6hf/IYvnxhoNNhrcZUre5exfMwHVc6OOcnJDanCqFhPXEtxsOU7604QOyRVekBGf/Q
         9oSMyaDTlrnjKheT8DHhUuWZEeR6Oy7YrH0suqKEP5N4kQAF/FgyjxnX/IZEYuMutYqA
         9mlugtK7Tvhu+3kjPcR3vG4lbWby8JiJigfNzpb6QFeE7MNKOctL3kyENkpQV1UpzU3Z
         sZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjTzov0ZWMBRnnkfLydTowwTTWaZQQMz8GLbYd2DoJY=;
        b=VOIvC47BXNmNwcuqeb0eGwlQayQdBvlBk7XM4Xb1DjGmHuQqth5kPvZZvXV7C3Z6Cl
         T6wQHcPQUIao0ztwQAi6DFHvsez8lOGuVOiBiT/0afKcbyQpXSPPwZZe8K1teGeUqK87
         B67fL76Jb+SSTfLcoh1bG/YZv1VaQsnF6aUSUpcXvXjEOM+yorn8iwbWmjlaQ7AKz/HB
         6RF5iCYt2IvvyJBcAAJPh0R982AiH5jTj1VXlB/V7OfyNYWAvsqaT1KCWIjL44Z4IaJ/
         PCCBFAVROmzqyIpLy1fC/R2WTSefVd5v1PhIA82yPhhA892DtDoSs0/osCK/KmOD63/K
         S5FQ==
X-Gm-Message-State: APjAAAVKMYJI28JjR7bU0N0oUBY6KW9xnagolRX+1Tsrn7+nYYw6ecpF
        oW5jvTZ8wvOshoWaecUQ/BU6QtZQNMrKNtsjD/oR3w==
X-Google-Smtp-Source: APXvYqziwX4Qd/CruVwbh4d+LgL43yQ6WwVxz8RVdhbf141kc/6k1rSNikV7EoWIivQB8kktrbIH2SlneWo8tRyAGPA=
X-Received: by 2002:a05:6808:7cd:: with SMTP id f13mr551315oij.70.1571174801334;
 Tue, 15 Oct 2019 14:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <157116925749.1211205.12806062056189943042.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e4544252-d2d7-e464-94d6-4df7cda0e248@silicom-usa.com>
In-Reply-To: <e4544252-d2d7-e464-94d6-4df7cda0e248@silicom-usa.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Oct 2019 14:26:29 -0700
Message-ID: <CAPcyv4iRFZ3AZ6WOduDPxBu2sNUY3AJLO-81sWhkDityoeQAiw@mail.gmail.com>
Subject: Re: [PATCH] libata/ahci: Fix PCS quirk application
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Andreas Friedrich <afrie@gmx.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:02 PM Stephen Douthit
<stephend@silicom-usa.com> wrote:
>
> On 10/15/19 3:54 PM, Dan Williams wrote:
> > Commit c312ef176399 "libata/ahci: Drop PCS quirk for Denverton and
> > beyond" got the polarity wrong on the check for which board-ids should
> > have the quirk applied. The board type board_ahci_pcs7 is defined at the
> > end of the list such that "pcs7" boards can be special cased in the
> > future if they need the quirk. All prior Intel board ids "<
> > board_ahci_pcs7" should proceed with applying the quirk.
> >
> > Reported-by: Andreas Friedrich <afrie@gmx.net>
> > Reported-by: Stephen Douthit <stephend@silicom-usa.com>
> > Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/ata/ahci.c |    4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index dd92faf197d5..05c2b32dcc4d 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1600,7 +1600,9 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
> >        */
> >       if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
> >               return;
>
> Unless I'm missing something this will short-circuit if there are any
> older Intel controllers not explicitly listed with a PCI_VDEVICE entry
> in ahci_pci_tbl.  Those will match on:
>
>         /* Generic, PCI class code for AHCI */
>         { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>           PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

You're not missing anything, but I think we should stick with explicit
mapping as only newer controllers tend to match on class id rather
than pci-id, and there's no way to know if that class-id match is for
PCS_6 or PCS_7. Hopefully newer controllers are tested with Linux and
the BIOS fixed prior to the breakage leaking into the wild.
