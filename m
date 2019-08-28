Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84BFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AAB2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv8oEDT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfH1Lmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:42:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40753 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1Lmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:42:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id h8so2642812edv.7;
        Wed, 28 Aug 2019 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHBfv5zjSEya+0Y/i6kKdeisc73VpG/vbKcbcAGWi3Q=;
        b=Uv8oEDT3sDFgzoLnkO582psGXc3+5qq6bCYGdmUVGdSdIAUDsmmCrmbzOwwo0TxzRT
         plcS5x5XUH0BT+dgcpj2kGi040BP2D3x1kgIzrBQwfvbOgm5vs9iLqNDztaPpEWXBkmr
         SBbvFIz3p2m4UvFK4IsfVU4tIWiyHk+3SNDlwtjGUEfvNnlNlKDXQGAj4ZHFm8MeuxSi
         6tIY+Gs6IqXzwIjG/3DhpxLmOR9Ptsa5O/FW6ObFGzXJwQwYGlQIaqjSWM6lp2+JLRgx
         KNx63qglS1qpV/sybXXcqLwD8LZ+Ck+QNiR/i7g+adLMCj8dpsNmicKKedcF643WZt9A
         L4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHBfv5zjSEya+0Y/i6kKdeisc73VpG/vbKcbcAGWi3Q=;
        b=hgJ4zRqDhSrIrs085cWu5pJvBL8YSH8qGqqoT95f5LCaSxo1XGa6Hb5vj2YggsVaRb
         QzoR8e4KxQ8USHuO54X4t98vOt0GpBksttfZX2dh3K6c/0QiwOpj5wXtsjT0ZBJbV5O3
         ug8Kbdll28/smYGSWw9+7AXvWrnOyk+g/YHXWEY2CLDh1NfN6o1cWQPxAxz/19nfTcbo
         xiGn69iGKOb6qG0QM92i8ho4HR+Qz6Ufie8+v2PMIauDlzfaFl4eod6lLQXzrtwqPePN
         sm/9rklEPKNpj4Cx0i3ExpzPyg4f+h9W+W+H/kPYjWV+u++wDqPtqJExFlgeQMmTgXwz
         QyQg==
X-Gm-Message-State: APjAAAUhZgJRTLbiAeDRrCguDBBk7apmDVK6WsjlC1Ad45oMuBapSjLq
        76zA7/e0jVPuC56qZGkroR2Vehlb8W9IQjJoyA8=
X-Google-Smtp-Source: APXvYqwiuWc/qla2uovuk7m1aKx3c6zg1cpqDRe3loN0F+Yt/wGHuSFur575MSgIYElejaU8KfmFTnKDjHrpXipRlYc=
X-Received: by 2002:a17:906:5e50:: with SMTP id b16mr2770107eju.254.1566992564016;
 Wed, 28 Aug 2019 04:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190723030206.2919-1-hslester96@gmail.com> <20190828032118.GA2966@b29397-desktop>
In-Reply-To: <20190828032118.GA2966@b29397-desktop>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Wed, 28 Aug 2019 19:42:32 +0800
Message-ID: <CANhBUQ0PEOoVoVscO66spy0Jv4jf5wwtGKRUwa4vd=7b70kBwA@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: msm: Use device-managed registration API
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:24 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 19-07-23 11:02:07, Chuhong Yuan wrote:
> > Use devm_reset_controller_register to get rid
> > of manual unregistration.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_msm.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> > index bb4645a8ca46..067542e84aea 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> > @@ -216,7 +216,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >       ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
> >       ci->rcdev.of_node = pdev->dev.of_node;
> >       ci->rcdev.nr_resets = 2;
> > -     ret = reset_controller_register(&ci->rcdev);
> > +     ret = devm_reset_controller_register(&pdev->dev, &ci->rcdev);
> >       if (ret)
> >               return ret;
> >
> > @@ -272,7 +272,6 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >  err_iface:
> >       clk_disable_unprepare(ci->core_clk);
> >  err_fs:
> > -     reset_controller_unregister(&ci->rcdev);
>
> It is devm API, why the unregister needs to be called at
> fail path?
>

I am not very clear about your problem...
After using devm_reset_controller_register(), I have removed
reset_controller_unregister() calls
in this patch.

> Peter
>
> >       return ret;
> >  }
> >
> > @@ -284,7 +283,6 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
> >       ci_hdrc_remove_device(ci->ci);
> >       clk_disable_unprepare(ci->iface_clk);
> >       clk_disable_unprepare(ci->core_clk);
> > -     reset_controller_unregister(&ci->rcdev);
> >
> >       return 0;
> >  }
> > --
> > 2.20.1
> >
