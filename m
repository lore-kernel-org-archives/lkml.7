Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2FEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4638D2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmQBp9cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfFNNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:24:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfFNNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:24:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so2536815wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWjSiEtdMO12OoUCtL1vHglcHoug/gXBV+OlmolHQRY=;
        b=OmQBp9cdMxiYMKC7DBZXYCLvxIKQrlLPcAjj/mfYJ1TovAdeKZLYNKY8Nf5g7JfmNm
         H7ynExTFF9qmk5kYuZUrLMFID0DF5jXarU9D9C2Iw7EKKiunk/dv397VC868NTGR7iET
         rUF7f7HF4Jf09qDukf7bvCLtD49gFKXRtoueEFc9L1+hGSetQizBACUs1NAfBgIWPhzF
         N/8nuqMafjmaz0F7lB9pcwVGpI+viPDDCg+dHG2WSQc1VLOUPOrsvfxqSO8OhXqnsUh2
         6nTy7xTKzd+PFd4PXJv3B4h6APUyN06f8/kkpkPoCNikj16bknsyrhp7YRDqTId2kKBi
         yXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWjSiEtdMO12OoUCtL1vHglcHoug/gXBV+OlmolHQRY=;
        b=M69J6SxjwIVCGlLoGn5GukulMnFAANcKCuQct6knvZtV9fMUX80Nzk/xO6q7e7yu9T
         GZ6712bCY4HtiaTSpx3puFgsgqs6m8cFeoQRhimqzkQrnKwQ6yenlfkPJ1bX798qlpXf
         EEhacLWoKu6EbtrXY5w982MCepepooJ80Pqs51hmgiCfmDj0DwbWEe5MCj73rM2wvdca
         tN/REvwrhjpr1EFgLSSj6jyIhN8weOnB+vSOnx28zo74ApCicbJUxKvDPFZdmlouGqqT
         UljqPMNJigOZ6I305hmc92WlQjyEvfT4G/rDPx4IBygff7HVX3bLg49pz0yQVoidX06G
         iDPg==
X-Gm-Message-State: APjAAAWruizCi8fRVC3M4XGS6ZNphCjdNQqzWRA8Q6TmTqh962XL4008
        HfQESqa38JSrsInLvEZ+FXwnuuJmTwEQ6f2fM6kP
X-Google-Smtp-Source: APXvYqzXlvfKtJ/LoBOlv3ZXoIzEEDMUzxMsdNZbc6a7gE9y3XvfZal6S/12iZGSKWEeg9fpflU8nW9EOJ/nkdzwz1E=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr15138460wre.294.1560518642613;
 Fri, 14 Jun 2019 06:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com> <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
In-Reply-To: <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 14 Jun 2019 08:23:51 -0500
Message-ID: <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com>
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "zhichang.yuan" <zhichang.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[try another address for Zhichang; first one bounced]

On Fri, Jun 14, 2019 at 8:20 AM Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> [+cc Zhichang, logic_pio author]
>
> On Fri, Jun 14, 2019 at 5:26 AM John Garry <john.garry@huawei.com> wrote:
> >
> > If, after registering a logical PIO range, the driver probe later fails,
> > the logical PIO range memory will be released automatically.
> >
> > This causes an issue, in that the logical PIO range is not unregistered
> > (that is not supported) and the released range memory may be later
> > referenced
> >
> > Allocate the logical PIO range with kzalloc() to avoid this potential
> > issue.
> >
> > Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > ---
> >
> > Change to v1:
> > - add comment, as advised by Joe Perches
> >
> > diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> > index 19d7b6ff2f17..5f0130a693fe 100644
> > --- a/drivers/bus/hisi_lpc.c
> > +++ b/drivers/bus/hisi_lpc.c
> > @@ -599,7 +599,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
> >         if (IS_ERR(lpcdev->membase))
> >                 return PTR_ERR(lpcdev->membase);
> >
> > -       range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> > +       /* Logical PIO may reference 'range' memory even if the probe fails */
> > +       range = kzalloc(sizeof(*range), GFP_KERNEL);
>
> This doesn't feel like the correct way to fix this.  If the probe
> fails, everything done by the probe should be undone, including the
> allocation and registration of "range".  I don't know what the best
> mechanism is, but I'm skeptical about this one.
>
> >         if (!range)
> >                 return -ENOMEM;
> >
> > @@ -610,6 +611,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
> >         ret = logic_pio_register_range(range);
> >         if (ret) {
> >                 dev_err(dev, "register IO range failed (%d)!\n", ret);
> > +               kfree(range);
> >                 return ret;
> >         }
> >         lpcdev->io_host = range;
> > --
> > 2.17.1
> >
