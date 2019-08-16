Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B4C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D8206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="fyzCdLDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHPJ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:28:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39620 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfHPJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:28:30 -0400
Received: by mail-vs1-f66.google.com with SMTP id u3so3308269vsh.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KwYdFMrs2uqk68qN6B+I1aTFc12mXSjCsUdciNeUO7Y=;
        b=fyzCdLDxDEvff0YzhGJ6ZhfCbs0u+Z3Sf50AXCD16lghsqbEnDtCkbVe64VykJQE6d
         8+ODGxo8qDyACL5RvpFh66Wk8KxdgwbOw7/j/hRjH07BzzmNC9R8gb5hpYWe3indAJqJ
         pANB/ismDMgTAm/nNdDHDoO/UoWG/suO+Xwrw6hCzEiTKm2Yl0p86fKveaxdA3Mn6TNt
         tZwFOpymeWvqhZEBxbqNAWSQq1Zh4r43VSzWL4KBZRJ06tTXLFPN165+tuN2Uk5wjLu1
         nMgBt3skOjoJffzQjmgj35AEsGVpZf4TNU2NSzWV40ZWW5D03YoFDKYtt/Lr063MBkmL
         b9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KwYdFMrs2uqk68qN6B+I1aTFc12mXSjCsUdciNeUO7Y=;
        b=fPMaenhNHbig/guOOHpIWsA2pJbHGhKowwYClOFPENB+kD5YzNCHwWMrJNo69p4Hsj
         SeZoOOdDr5+YxnjHSOP/576maD52GVMINMKg0dRS0Zj+uma7/IIQu4WBQpjsBx7EdT1M
         cr9WCRscwFjryjU+/K3k2Y0H6LFM+MiZlTNb4WBlNCTCerdkaT0mrdGyRCEKpQWJNO7E
         MgdSs5BNmk9qQQwKMrIMQEJ4b5WXTJtTjwfXLnL2F7C5RY/xLz4u4UNn0JdNmiydbh7I
         H8v4PmVdhevAnTHXBlnEZPlcvV/Avh1a0lsS5rYKbxx7Xw01+TaDhO9UWukKW//WPC5t
         Mlnw==
X-Gm-Message-State: APjAAAVv3A9B2AKxd2iBpQ2QZF0dLmNhXnBKcN6SloA8JeYSG4pfCbAe
        ezEC2eGjZM1RI1mI29JGMOsH3vvU5AdLcDhNuW/bgQ==
X-Google-Smtp-Source: APXvYqyfAgG3EdeQBS93sMjZIwyIwpmLnXWpnoEISIrGKxq5pIGvknWDpGsbwSvidZKAm9qiYZhRFF2SLfOSP7fY3SE=
X-Received: by 2002:a67:6507:: with SMTP id z7mr5571817vsb.206.1565947708395;
 Fri, 16 Aug 2019 02:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190816063109.4699-1-jian-hong@endlessm.com> <F7CD281DE3E379468C6D07993EA72F84D18929BF@RTITMBSVM04.realtek.com.tw>
 <F7CD281DE3E379468C6D07993EA72F84D1892A52@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1892A52@RTITMBSVM04.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 16 Aug 2019 17:27:51 +0800
Message-ID: <CAPpJ_edibR0bxO0Pg=NAaRU8fGYheyN8NTv-gVyTDCJhE-iG5Q@mail.gmail.com>
Subject: Re: [PATCH] rtw88: pci: Move a mass of jobs in hw IRQ to soft IRQ
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> A few more questions below
>
> > > From: Jian-Hong Pan [mailto:jian-hong@endlessm.com]
> > >
> > > There is a mass of jobs between spin lock and unlock in the hardware
> > > IRQ which will occupy much time originally. To make system work more
> > > efficiently, this patch moves the jobs to the soft IRQ (bottom half) =
to
> > > reduce the time in hardware IRQ.
> > >
> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > > ---
> > >  drivers/net/wireless/realtek/rtw88/pci.c | 36 +++++++++++++++++++---=
--
> > >  1 file changed, 29 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> > > b/drivers/net/wireless/realtek/rtw88/pci.c
> > > index 00ef229552d5..355606b167c6 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > > @@ -866,12 +866,29 @@ static irqreturn_t rtw_pci_interrupt_handler(in=
t
> > irq,
> > > void *dev)
> > >  {
> > >     struct rtw_dev *rtwdev =3D dev;
> > >     struct rtw_pci *rtwpci =3D (struct rtw_pci *)rtwdev->priv;
> > > -   u32 irq_status[4];
> > > +   unsigned long flags;
> > >
> > > -   spin_lock(&rtwpci->irq_lock);
> > > +   spin_lock_irqsave(&rtwpci->irq_lock, flags);
>
> I think you can use 'spin_lock()' here as it's in IRQ context?

Ah!  You are right!  The interrupts are already disabled in the
interrupt handler.  So, there is no need to disable more once.  I can
tweak it.

> > >     if (!rtwpci->irq_enabled)
> > >             goto out;
> > >
> > > +   /* disable RTW PCI interrupt to avoid more interrupts before the =
end of
> > > +    * thread function
> > > +    */
> > > +   rtw_pci_disable_interrupt(rtwdev, rtwpci);
>
>
> Why do we need rtw_pci_disable_interrupt() here.
> Have you done any experiment and decided to add this.
> If you have can you share your results to me?

I got this idea "Avoid back to back interrupt" from Intel WiFi's driver.
https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/net/wireless/intel=
/iwlwifi/pcie/rx.c#L2071

So, I disable rtw_pci interrupt here in first half IRQ.  (Re-enable in
bottom half)

>
> > > +out:
> > > +   spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
>
> spin_unlock()
>
> > > +
> > > +   return IRQ_WAKE_THREAD;
> > > +}
> > > +
> > > +static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
> > > +{
> > > +   struct rtw_dev *rtwdev =3D dev;
> > > +   struct rtw_pci *rtwpci =3D (struct rtw_pci *)rtwdev->priv;
> > > +   unsigned long flags;
> > > +   u32 irq_status[4];
> > > +
> > >     rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
> > >
> > >     if (irq_status[0] & IMR_MGNTDOK)
> > > @@ -891,8 +908,11 @@ static irqreturn_t rtw_pci_interrupt_handler(int
> > irq,
> > > void *dev)
> > >     if (irq_status[0] & IMR_ROK)
> > >             rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
> > >
> > > -out:
> > > -   spin_unlock(&rtwpci->irq_lock);
> > > +   /* all of the jobs for this interrupt have been done */
> > > +   spin_lock_irqsave(&rtwpci->irq_lock, flags);
> >
> > Shouldn't we protect the ISRs above?
> >
> > This patch could actually reduce the time of IRQ.
> > But I think I need to further test it with PCI MSI interrupt.
> > https://patchwork.kernel.org/patch/11081539/
> >
> > Maybe we could drop the "rtw_pci_[enable/disable]_interrupt" when MSI
> > Is enabled with this patch.
> >
> > > +   if (rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
> > > +           rtw_pci_enable_interrupt(rtwdev, rtwpci);

Then, re-enable rtw_pci interrupt here in bottom half of the IRQ.
Here is the place where Intel WiFi re-enable interrupts.
https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/net/wireless/intel=
/iwlwifi/pcie/rx.c#L1959

Now, we can go back to the question "Shouldn't we protect the ISRs above?"

1. What does the lock: rtwpci->irq_lock protect for?
According to the code, seems only rtw_pci interrupt's state which is
enabled or not.

2. How about the ISRs you mentioned?
This part will only be executed if there is a fresh rtw_pci interrupt.
The first half already disabled rtw_pci interrupt, so there is no more
fresh rtw_pci interrupt until rtw_pci interrupt is enabled again.
Therefor, the rtwpci->irq_lock only wraps the rtw_pci interrupt
enablement.

If there is any more entry that I missed and will interfere, please let me =
know.

Thank you
Jian-Hong Pan
