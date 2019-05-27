Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C4C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF0A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLTQLOEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfE0G2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:28:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53304 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0G2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:28:42 -0400
Received: by mail-it1-f195.google.com with SMTP id m141so25206948ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8EX+aBGSrqtOZLN7eyxUmkcUk0A/Ju5L1c1bYnhiNI=;
        b=qLTQLOErkYiZCZWLZsydpUkomQMNXVQBdtMc9rB1CB8V7whpCNIF9Bj/qjVm2K8sDP
         IkV9WUPa2vqEjNmemFw6A2MvtmhpRw/ohkvJQYh2T7l8WOQ8gou//bX60cBaoUF3jdZ8
         r7xmMFLdHeKNFd/Hit+LDbnP+9RU965MtzyTUL3Rk1BJXAuMZqb/7+zBQrYDPzY3+SWJ
         FjyuqEd94Db0nPijGELCONP04w568JS1aOWgDBCwI3CwOkab0OCBbNVojUTwWIbb3x4x
         l/PX8cNg8zaU2FYiZfUfYgBG96wwd85DMAi04zfmNvVSp8wrU5j3p+x+eOeLzisCZAEG
         NNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8EX+aBGSrqtOZLN7eyxUmkcUk0A/Ju5L1c1bYnhiNI=;
        b=Vk1rQEWO60dLBCD3yzLOUJkhaAqAtzGIi62RnBXW6RU5sWcWDroIKqsFJzFS6CEXMN
         Q6+5AfMPTSU0JPyJ0i8VBRg9jqcKg7dNeL+h3sB/POfdysCttBX8CMw9T3dEih5FB0gl
         wglxCNZsX7/ouan2Fn0eQll5J6e9eycO3fJpc4UZ/OvYK+IooPLCKYmZLhZmS7g6kDe+
         7WFMCYRtXUAWgXjIm15QMAN9XY44wc/xpaZyKi3MqroHKmW/K00Wuivamg5IZAyck0Ah
         i5soXJCt1uUlaeiM2S+K9jkS3t/On4LS0erR2RxkufXI9oQdDbQOVFyqWjFHpLWv7Ta0
         HIcQ==
X-Gm-Message-State: APjAAAWL4IOoWgSlpWIdyRdLzyIt5jy8SSpJm2ja7NdlWjBGTyeFtOZk
        n7QZR4EUGp8uMZ3d7M6yZ0YubVaF/WX1T/monXQAxSZiePU=
X-Google-Smtp-Source: APXvYqxxUNY7KqIqSuNLvKP6LV6FwCHpAkbJoNgL93BLRqsLwPm99e8TItETb5FEBqsG1ivcn2EKLsn1genQRyxZU8o=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr5424290jar.2.1558938521247;
 Sun, 26 May 2019 23:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <1557310449-30450-1-git-send-email-sumit.garg@linaro.org> <CAFA6WYMPKxwxzbU=CFYLw83kpXP9LwMQ3-N-hp2NyExhs_HjSQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMPKxwxzbU=CFYLw83kpXP9LwMQ3-N-hp2NyExhs_HjSQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 27 May 2019 08:28:30 +0200
Message-ID: <CAHUa44FQKJDjSv+CirRVJBPEMMpZD4AtQSUZOb3P51wD9aq63g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for the TEE subsystem
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 8 May 2019 at 15:44, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add a mailing list for patch reviews and discussions related to TEE
> > subsystem.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I forgot to include following tag as this change was suggested by Daniel. So:
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks, I'm picking this up.

Cheers,
Jens

>
> -Sumit
>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 920a0a1..c05dff7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11556,11 +11556,13 @@ F:    drivers/scsi/st.h
> >
> >  OP-TEE DRIVER
> >  M:     Jens Wiklander <jens.wiklander@linaro.org>
> > +L:     tee-dev@lists.linaro.org
> >  S:     Maintained
> >  F:     drivers/tee/optee/
> >
> >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> >  M:     Sumit Garg <sumit.garg@linaro.org>
> > +L:     tee-dev@lists.linaro.org
> >  S:     Maintained
> >  F:     drivers/char/hw_random/optee-rng.c
> >
> > @@ -15312,6 +15314,7 @@ F:      include/media/i2c/tw9910.h
> >
> >  TEE SUBSYSTEM
> >  M:     Jens Wiklander <jens.wiklander@linaro.org>
> > +L:     tee-dev@lists.linaro.org
> >  S:     Maintained
> >  F:     include/linux/tee_drv.h
> >  F:     include/uapi/linux/tee.h
> > --
> > 2.7.4
> >
