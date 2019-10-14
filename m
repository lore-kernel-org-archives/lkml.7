Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD65FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889E5217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e19VT+Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfJNOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:53:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36301 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732915AbfJNOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:53:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so8128694plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MUs5IRxVEkbGv3sc+yn4Je2yBcMqr3MnSyvIzQazqY=;
        b=e19VT+QkTrL09IPRbvNbIjgVDVmfKGoEdPHG8hvoY+zeaxRxiPFmYgnwSgNneZJ6Ig
         aqsgSHuKeGBnVy1h+jLqb2ET03NBzBxuUGcMoDB5TR6ggb4zHC5LRbGgrTRYoyRh6Gq9
         F2+7X8pLp4wX9kKpEVzSYVqklGwLFh5VCqdMec83L8kF/wshA5ICryBSjBtuawyyn3qS
         MfiXgnOWrTSd/E74uL+BaRL32fHFom7EXuKeP8X1o9hXW470rW0yKMTMVvdw8sk4F7Bq
         C3qdR2VleztgJnZhmSSgLQiMF2u5TKv8irBisb4FM0Hj7rzppWysiwNqSmRokZrajRgv
         Ku2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MUs5IRxVEkbGv3sc+yn4Je2yBcMqr3MnSyvIzQazqY=;
        b=MxUIKbq78QQMjBRbAiDvC9Sb61xSskVXjEb7LjmLi04sqvq9yVdRl5A5CrwQb2Z4zI
         gEvSultwj8xUwagZKok748mgvrImAEokChlnYGm20VOinVBe8BhSLFW83e07kL//eLpL
         d4eb8zMq+KLUIArcI51XTXbz4EFwaijuItbhBN5QDuZW03RH+ziSB6Dq2l0SfYWS4flp
         cDJUOHVP9Oqp3pLQeeaCgbGosh3V1paEClC4t/FImmnc4MTp2T2txEQIvoFg5GqmPE3S
         XIET7C1L5cDy4NoWRHaz78Pb3GIOqt971qUcoOmO/yqUffnA3TsOsW0CufiQWEnunIF0
         siWA==
X-Gm-Message-State: APjAAAWez1HDJdmHAZM/OMoKm1TzER1EKNjMj0knADy6wEznLvc6Kl53
        j8V74LtrQaKvwziIvUlty0TvuCv2M12k88m+WxE=
X-Google-Smtp-Source: APXvYqykP9Q55Rbz0tYEa868JGtVQIwHkjlwiUOysgV8+EQwJs8sR102EDcyTL5zK2/Kg+R4hPwwoSPk+vSfptoBfOY=
X-Received: by 2002:a17:902:b288:: with SMTP id u8mr29152440plr.119.1571064820195;
 Mon, 14 Oct 2019 07:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
 <alpine.DEB.2.21.1910141430310.2531@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910141430310.2531@nanos.tec.linutronix.de>
From:   Yi Zheng <goodmenzy@gmail.com>
Date:   Mon, 14 Oct 2019 22:51:52 +0800
Message-ID: <CAJPHfYMvTCAGztnhVS7moyO2xMThmnmD7x0auLAMvw1rdEfHcg@mail.gmail.com>
Subject: Re: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Zheng Yi <yzheng@techyauld.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas

I canceled that patch. In my testing, that will not fix the problem.
Why the IRQ is unexpectedly masked, that is not an easy bug for me.
More time need to hacking the driver/kernel code.

Thanks for your reply.

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2019=E5=B9=B410=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 8 Oct 2019, Yi Zheng wrote:
> >      There is some defects on IRQ processing:
> >
> >      (1) At the beginning of handle_level_irq(), the IRQ-28 is masked, =
and ACK
> >          action is executed: On my machine, it runs the 'else' branch:
> >
> >             static inline void mask_ack_irq(struct irq_desc *desc)
> >             {
> >                 if (desc->irq_data.chip->irq_mask_ack) {
> >                         desc->irq_data.chip->irq_mask_ack(&desc->irq_da=
ta);
> >                         irq_state_set_masked(desc);
> >                 } else {
> >                         mask_irq(desc);
> >                         if (desc->irq_data.chip->irq_ack)
> >                                 desc->irq_data.chip->irq_ack(&desc->irq=
_data);
> >                 }
> >             }
> >
> >          It is an 2-steps procedure:
> >          1. mask_irq()
> >          2. desc->irq_data.chip->irq_ack()
> >
> >          the 2nd step, the function ptr is omap_mask_ack_irq(), which
> >          _MASK_ the hardware INTC-IRQ-32 and then do the real ACK actio=
n.
>
> Sure. Where is the problem?
>
> >      (2) mask_irq()/unmask_irq() are not atomic actions: They check the
> >          IRQD_IRQ_MASKED flag firstly, and then mask/unmask the irq by =
calling
> >          the function ptrs which installed by irq controller drv.  Then=
, those 2
> >          functions set/clear the IRQD_IRQ_MASKED flag.
> >
> >          I think the sequence of the hw/sw action should be mirrored re=
versed:
> >          mask_irq():
> >             check IRQD_IRQ_MASKED;
> >             set hardware IRQ mask register;
> >             set software IRQD_IRQ_MASKED flag;
> >
> >          unmask_irq():
> >             check IRQD_IRQ_MASKED;
> >             /* NOTE: should before the hw unmask action!! */
> >             clear software IRQD_IRQ_MASKED flag;
> >             clear hardware IRQ mask register;
> >
> >          The current unmask_irq(), hw-mask action runs before sw-mask a=
ction,
> >          which gives an very small time window. That cause an unexpecte=
d
> >          iterated IRQ.
>
> It's completely irrelevant because _ALL_ those operations run with
> irq_desc->lock held. So nothing can actually observe that state.
>
> >      Here is my the detail of my analyzing of handle_level_irq():
> >
> >      (1) Let record the HW-IRQ-Controller Status and the SW-Flag IRQD_I=
RQ_MASKED
> >          pair as following: (hw-mask, sw-mask).
> >
> >      (2) In the 1st level of IRQ-28 ISR calling, in unmask_irq(), after=
 the HW
> >          unmask action, and before the sw-flag IRQD_IRQ_MASKED is clear=
ed, there
> >          is a VERY SMALL TIME WINDOW, in which, another IRQ-28 may trig=
gered.
> >
> >          In that time window, the mask status is (0, 1), which is no an=
 valid
> >          value.
>
> Again. Irrelevant because not observable.
>
> >       My fixup is in the attachment, which remove the unexpected time w=
indow of
> >       IRQ iteration.
>
> Please don't send attachments. See Documentation/process/submitting-patch=
es.rst
>
> Thanks,
>
>         tglx
>
