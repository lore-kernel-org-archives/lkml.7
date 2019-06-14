Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1CC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C592A2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="BFQ7n7Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNHJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:09:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32862 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFNHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:09:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so1296382ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxfyM6IErwzUuZQc4rX6nb5MYVBMEiaUIJAOhGRqMq4=;
        b=BFQ7n7ZxnDJCfw3InVQV8Lykl7mTzTO/uKjfT68koQImu8DCSUAFvWIamSHmM+uW7E
         GZVxCsJcMdhXyWOdvsBS8286msfvR4ZWO78pNH0mqpSacM6BftYDWL1xMkdIh7w9MiX3
         3tb2/ogsbdl7Lw2YtiCBHiD3UaatAaBTKNvM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxfyM6IErwzUuZQc4rX6nb5MYVBMEiaUIJAOhGRqMq4=;
        b=SeA1hWKtxGEsZnVCNCsOBNvNNBQIBjDiGqDclEa7df29UH0Bfm4kTi/08IFRTHVQun
         gcSO27BPHiETwLr6PIoL3pF8v0xpJ+w9Ilv7v5rwq3T6WjiprOqkplY47wZlKH5684Qs
         E3U+GggHD0d1xY0TZYqN8SBebDSwkfggJaqAQrh29OFxOK2r1mWqJk3XRJuQ8e/UtUVW
         WID2l3YV+T2khMiOXedWfa5ZSBYEnA1V6c1QfP/gpKfPcbBhSRW0XxVBk1SGGg4C1eob
         4fz0sGMuiXOIkYYfQwcXo3t4LVbBOipfz/uwSjl63U6g2DGDLvxUshNMv+724oQ5VwgP
         WUjg==
X-Gm-Message-State: APjAAAVJX3PlSEh5MS9YD1m+a2s1eKkxioHKOZhRm/9FtMH5RC3Keyf4
        fwyVw14IR5gQaiv4ru/f4jbut6sXW7H25hgDxpohOygEUAPDz+uma41s35knlDx1soNuVGdXaZI
        soxgTNFksv4Wm4jtF5latURaRPG0sCs0RUg==
X-Google-Smtp-Source: APXvYqygzgKoulB56EW6IgCZUnp+so8s8umG4AYyfJaRVIp1tDhleNADbz8MqdlwR5Bohv/3k4ORVDx+UFQFAkoJJWU=
X-Received: by 2002:a2e:760f:: with SMTP id r15mr34139345ljc.18.1560496143737;
 Fri, 14 Jun 2019 00:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com> <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190612150819.GD15747@redmoon>
In-Reply-To: <20190612150819.GD15747@redmoon>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Fri, 14 Jun 2019 12:38:51 +0530
Message-ID: <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
Subject: Re: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo and Hou Zhiqiang
 PAB_INTP_AMBA_MISC_STAT does have other status in the higher bits, it
should have been masked before checking for the status

Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>

On Wed, Jun 12, 2019 at 8:38 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 08:36:12AM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > In the loop block, there is not code to update the loop key,
> > this patch updates the loop key by re-read the INTx status
> > register.
> >
> > This patch also add the clearing of the handled INTx status.
> >
> > Note: Need MV to test this fix.
>
> This means INTX were never tested and current code handling them is,
> AFAICS, an infinite loop which is very very bad.
>
> This is a gross bug and must be fixed as soon as possible.
>
> I want Karthikeyan ACK and Tested-by on this patch.
>
> Lorenzo
>
> > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > ---
> > V5:
> >  - Corrected and retouched the subject and changelog.
> >
> >  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > index 4ba458474e42..78e575e71f4d 100644
> > --- a/drivers/pci/controller/pcie-mobiveil.c
> > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >       /* Handle INTx */
> >       if (intr_status & PAB_INTP_INTX_MASK) {
> >               shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > +             shifted_status &= PAB_INTP_INTX_MASK;
> >               shifted_status >>= PAB_INTX_START;
> >               do {
> >                       for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >                                       dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
> >                                                           bit);
> >
> > -                             /* clear interrupt */
> > -                             csr_writel(pcie,
> > -                                        shifted_status << PAB_INTX_START,
> > +                             /* clear interrupt handled */
> > +                             csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> >                                          PAB_INTP_AMBA_MISC_STAT);
> >                       }
> > -             } while ((shifted_status >> PAB_INTX_START) != 0);
> > +
> > +                     shifted_status = csr_readl(pcie,
> > +                                                PAB_INTP_AMBA_MISC_STAT);
> > +                     shifted_status &= PAB_INTP_INTX_MASK;
> > +                     shifted_status >>= PAB_INTX_START;
> > +             } while (shifted_status != 0);
> >       }
> >
> >       /* read extra MSI status register */
> > --
> > 2.17.1
> >



-- 
Thanks,
Regards,
Karthikeyan Mitran

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
