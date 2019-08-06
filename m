Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41442C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DD220B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skjdDU4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfHFMuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:50:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44933 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:50:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so62669606qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P5o7bDpjWmN9ZebSBZsGlXpEvCnGcCbzXRf1g4vqlg=;
        b=skjdDU4dtUeHC+kMGTUC9fPCCNWSMbFGsd3aaAekUU7izdW2GKUeIP8Sc/7RaZ53a3
         c4WVPqMdHWjNyyW0UWhDJ0fecC+2XNYt9iZkVBq18GzQt0yMKpbUgS8dvW6mSIgHnbdh
         HgzihabMSOBMmrqfJECNcEsIof7X5520tUVHMvH5488p+gJmkSZPzVJSWkUv+6yiugI+
         dgv3Rs+IDXTYKez5jrRsEDothYUJaypa/tg0TDtMtCXOlx6daS632GYFAcAEFt4W2kE2
         cE7i2NUujJPjRXjOO6Plf8QlNLfVcl1X4iFP0PV0Dknt5Xu0vEfGta9zYRm29owweO/D
         Lcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P5o7bDpjWmN9ZebSBZsGlXpEvCnGcCbzXRf1g4vqlg=;
        b=HkX6CFh3Z3RNZR7427DHOHXUshktyWt2gMW3tfiH2Shth1WU1y9W8oKfUF+iRbx2t+
         7vxQYoYjnXNsTbtIKZDxwdoCiX9v+rr0YzGDL+gFgcQ0DCUCrVEhJ1pSOO4xsXQq4ylt
         gWpQuu/fI/Pq/wDsCmxGybetfnnq6KTKn1Qv4P+nGoxhviLkG7QvhgejK01cnl+guVIz
         SRqKvWbtbCi5Ivgd9zwVC9hhxD6flTuzNCQ+Bt4MyRkq/K3LCR+pAsBWOpK+ViETvwQr
         fHt8DRR9u2A7V/Ww4Mj3BtdLx5TZXp7wy85D4yTkbHc636FU3SHdl5pyh2dnUvYX4Mp1
         zUKg==
X-Gm-Message-State: APjAAAWzd+I1kZcoJ7Uzis9+eOnU0WAtmee+Ftauz1ptTidENNfW2qF2
        DcFovGhOpsmBg7whAWSp8/IUMwVmsJKAKhXVhAs=
X-Google-Smtp-Source: APXvYqwfWWN4YkKLQ+LRmVpH+VROfBQy2m9vp40Fsf+NNf7IJbqfFo2xpdZXFbe8bmZEplS9SM16o6+Vkfq7lHGwoQE=
X-Received: by 2002:a37:9a0b:: with SMTP id c11mr3120476qke.204.1565095852172;
 Tue, 06 Aug 2019 05:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190806030718.29048-1-luaraneda@gmail.com> <20190806030718.29048-3-luaraneda@gmail.com>
 <194fe121-151d-0b64-b83e-e4d82c02efa7@xilinx.com>
In-Reply-To: <194fe121-151d-0b64-b83e-e4d82c02efa7@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 6 Aug 2019 08:49:59 -0400
Message-ID: <CAHbBuxpM8YKxADGJv2PAPbyS-2FZ6xiwohJwGJ1DMPuGnDV-Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Aug 6, 2019 at 2:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 06. 08. 19 5:07, Luis Araneda wrote:
> > This fixes a kernel panic (read overflow) on memcpy when
> > FORTIFY_SOURCE is enabled.
> >
> > The computed size of memcpy args are:
> > - p_size (dst): 4294967295 = (size_t) -1
> > - q_size (src): 1
> > - size (len): 8
> >
> > Additionally, the memory is marked as __iomem, so one of
> > the memcpy_* functions should be used for read/write
> >
> > Signed-off-by: Luis Araneda <luaraneda@gmail.com>
[...]
> I would consider this one as stable material. Please also add there link
> to the patch which this patch fixes.

I'm dropping stable CC (for now), as I'm not sure I completely
understood the process for inclusion in stable trees.
Do I have to wait for the patch to be on Linus' tree before CCing stable?

As for the link which this patch fixes, you mean
aa7eb2bb4e4a22e41bbe4612ff46e5885b13c33e (arm: zynq: Add smp support)?
where you added SMP support for zynq.

Thanks,
Luis Araneda.
