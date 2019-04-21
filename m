Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D6C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7D720859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcWXxeIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfDUIk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:40:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39867 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:40:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so7434433edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzBYaJfwULQvLwqE45ZHXpeYUUmpfc5uMjyHxzdr8rY=;
        b=QcWXxeIrAccG6k1GikRcfSwPRn6LuLvUXwxsTYZ+mNxZsr3BHFJY98tpgqudAnuSm4
         VyBgjeFAzSHliF+bYyill+/OWyxIyUo/I6dam16D54rcx+VO01WDA9Ze/bcxQ42+gQBF
         CxDTf8ut0aZ1F5koDWjG73M5oFzyQRx/B8E16L7wMSgEIWqYqoUdxbf7Y63/4l/WHdwV
         /Ats+HFWBTwRMTLr4UMGYrxSN3Q2fscvEKRLAKCR5slck3VUvOVnXSjpCvQfQOhUKjty
         p+HYOJi9pi4ODjVhN66XZMlGSK997UDq6WYr4BvEcYofwrhqZmbSVDYQ6HCP6Rep0Hqq
         RlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzBYaJfwULQvLwqE45ZHXpeYUUmpfc5uMjyHxzdr8rY=;
        b=FgYqSWLU+ug5EYtBpcOJFUgeo5D/VwRrUlVNgEfvi9gJL7kpaq59nC8EVjXJDEgqsB
         8yJc0W++g1dPNtcn2tNUJEnYk7Iblk6IwbV389db0/w1tHmX2ETk0XO5PXc1bGov0cJ3
         RXqa4NQxoCZj6CG4JyAfVq6cWyQxhi1bTp0o11gZZXY9aF3hBSZ6Ge3IKXvNqiDLTUcj
         16gcoRULnyLbMOqIwLkpgR/+wPaJoi2Q38gz5F52g9Uofy0mqmAoxU97Axkgn9wJ1nUl
         05eLB8AeWpkEfK6zg9KJR+lH+zLgSeQQkynaSB2+aRNU5W7Hf1EUrntS+Jqxpbuz3TUQ
         SFAw==
X-Gm-Message-State: APjAAAWRtxU732MiuChKYPIawa+c30/3vii2OVCORPaJbl7Am9KyK/nP
        l8uxrcaiVZlXh9HwwTx+UpRbTB0uMqONHa3S+Jc=
X-Google-Smtp-Source: APXvYqx0fHCKxVzrmJejMiEtQKGxGXyaJZ3mIvwqaU7Dpjf/gUy0BClKM5BKOmHF43ZucWdn7HCzxUGmZj/fWmfR7cA=
X-Received: by 2002:a17:906:f03:: with SMTP id z3mr6572306eji.280.1555836025018;
 Sun, 21 Apr 2019 01:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190420154038.14576-1-daniel.baluta@nxp.com> <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada> <20190421082627.GB8304@Asurada>
In-Reply-To: <20190421082627.GB8304@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 21 Apr 2019 11:40:12 +0300
Message-ID: <CAEnQRZAH7qxHVk19UrUrAg3KdDbKz5tg0jwizB9TTLpciRpwfg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 11:26 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> > On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > > Firstly, according to your commit message, neither imx8qm nor
> > > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > > starts with "mclk1". So, before you change the driver, I don't
> > > > think it's even a right thing to define an "mclk0" in the DT.
> > >
> > > From what I understand mclk0 means option 00b of MSEL bits which is:
> > > * busclk for i.MX8
> > > * mclk1 for i.MX6/7.
> >
> > MSEL bit is used for an internal clock MUX to select four clock
> > inputs. However,  these four clock inputs aren't exactly 1:1 of
> > SAI's inputs. As fas as I can tell, SAI only has one bus clock
> > and three MCLK[1-3]; the internal clock MUX maps the bus clock
> > or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> > inputs[1-3]. So it doesn't sound right to me that you define an
> > "MCLK0" in the DT, as it's supposed to describe input clocks of
> > SAI block, other than its internal clock MUX's.
>
> Daniel, I think I's saying this too confident, though I do feel
> so :) But if you can prove me wrong and justify that there is an
> "MCLK0" as an external input of the SAI block, I will agree with
> this change.

Thanks a lot Nicolin for your input on this! Really appreciate it.
Let me have some time to further investigate it and really figure
out what happens at the hardware level.

thanks,
Daniel.
