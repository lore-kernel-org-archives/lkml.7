Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B41206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucy7l0PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfGYGAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:00:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44709 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfGYGAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:00:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so49277277wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwJcmk5yiFlme1u00/d80HZseBmnYpsKoUulVK5QiqA=;
        b=ucy7l0PIIgkVo6/HBTwEDgLsRwwNI/lHafiIlrF8pPx7QPRJllYj0UOJJMhSd7jP8U
         ytYcFqO1GLhsEkK1yF12onQ5WPdq4tyGgROGVIBwcIVzRNsInv64PHIK8d3xRK1R9qWd
         gaAm5kNOsy2Wvp6AcpDlYFC07uW8JmWj8mw3vuys/hM0wWxJXx0KS7eWKCOwkeFrkRjk
         K6wY1G7XP/LqsRqt4TAcHWSSFJiOSQFt+jh8KDBCbPhocAtic193G1R638pZcv9Yt+WM
         dvLt6KH6BF48BHGOlRqvqBqxdXnMXorYX5qOvN0vaWqYn2bsdu/RKqQZPwmzl45tljMD
         HDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwJcmk5yiFlme1u00/d80HZseBmnYpsKoUulVK5QiqA=;
        b=CBdaGmPsKXtQQcHjp4gjzSGgIYZmVjr4DwrfNzaEgWl2N3tlPcyntim6Tsyi8KOVSg
         AjYLjCAh1+tF6X/HjcoRSdCO+yMa02mq+3gDWuO3ekGDnQi+3sJv9E+bCB8Aax8l5Qxc
         WhOJ2YTSL5v4kC5Dgz0h/5cNN4kxNfCn3vRPGhiYEZhHqWTFVygvPzYsmZN0db+SsM7I
         UGNYlUp1sd8sdqsFBMYmbq9CEwPAAe5oZIkC6iqf7D/r35MlcpmVV3zSxrw9fX7u2Wkr
         +OBSmMNHVUj/2i9siE3qV1JSN3kPak+I7BkZ+WaHkmbV24etDOE8mSjg+Za/VDWH4ZFe
         eIsg==
X-Gm-Message-State: APjAAAU5AfMHWOvNAHTWVyBLohLQlOPhLDcHFUvn5wDH53Vhn/pK+lja
        z3DqtV+qYnCKgTCt7EiR4IiFq1VfZiYOBk2HiYM=
X-Google-Smtp-Source: APXvYqzMQe4AbvN+dLqV0ii4ui6djRNNceKLvVW0FznYpmDPAHgEgKVrzpvWCeklkVcneU/eivkYc+c51aZguQ7gVQU=
X-Received: by 2002:adf:db46:: with SMTP id f6mr41138857wrj.212.1564034412867;
 Wed, 24 Jul 2019 23:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-2-daniel.baluta@nxp.com>
 <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 Jul 2019 09:00:01 +0300
Message-ID: <CAEnQRZDtAwAWn+fEWcfiXROc+X5bhwdas=R=JdizcfPjyFSv0A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 01/10] ASoC: fsl_sai: add of_match data
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 1:34 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > New revisions of the SAI IP block have even more differences that need
> > be taken into account by the driver. To avoid sprinking compatible
> > checks all over the driver move the current differences into of_match_data.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>
> Looks like Mark has applied this already? If so, should probably
> drop applied ones and rebase the remaining patches for a resend.

Yes 1/10 and 2/10 were already applied. Will drop them from next version.
