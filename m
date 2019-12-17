Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A767C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73222176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576553176;
	bh=47QWm6h87QsQLH9MeRqumerTPY7a5GPPIoJOkaFh86Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=om5alIdkyNqxcdj8W26MFal7Q8eI9Qz7twSSygodvr6fQroQID+v1cZbGIbTeIK5F
	 b3M0QxeP2tj2r3MjucsvU+0OUDwCbYtXdTTelJYQdW4KlsKzHQs7J4ZpNiRkUK9xvp
	 0KYktd7A2hY+fGz1/lRvlW1e2zyNrYxXyaavgKrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLQD0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfLQD0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:26:15 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B121921775;
        Tue, 17 Dec 2019 03:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576553175;
        bh=47QWm6h87QsQLH9MeRqumerTPY7a5GPPIoJOkaFh86Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UykxByrFUo58jmgTv2gIH94KHfA3UpMQJDbNVBXSTkB/kvIHZMoRvDq7Sy0bWFKl7
         QaI050oS9iB7PNfHSs0KTE3T3GSUIDwX30DQThniprf1oTjUAJR+UEfFbBe/4jlYNQ
         c2gDOmX7nnDl/fpDyoavbBfWO2DiRxJLlX0uFwG8=
Received: by mail-wm1-f52.google.com with SMTP id d139so1240588wmd.0;
        Mon, 16 Dec 2019 19:26:14 -0800 (PST)
X-Gm-Message-State: APjAAAW1taEu2ycqphT/rNjgFhMNv2GyIhZllTxJLM+mXTABb4Tp0Emr
        gW1fB7Rhmp52iBM8fL1DFrhuRlKPpt8UU57yEEA=
X-Google-Smtp-Source: APXvYqyi/kODA+aCa6GY+O+CLiFXju/r1hxujzR5u/QJ3+Scw3aSWc3tcBDeifj9xfMPc6i7kFxLAMrU8fChA/STtc0=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr2603910wmh.94.1576553173160;
 Mon, 16 Dec 2019 19:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20191217030438.26657-1-jitao.shi@mediatek.com>
In-Reply-To: <20191217030438.26657-1-jitao.shi@mediatek.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 17 Dec 2019 11:26:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
Message-ID: <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>, sj.huang@mediatek.com,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 11:08 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Changes since to v2:
>  - Edit commit msg.
>
> Changes since to v1:
>  - Edit commit msg.
>  - Remove the register trigger in probe.
>  - Rebase to v5.5-rc1.
>
> Changes in patches:
>  - match pwm_mtk_disp clock when suspend/resume
>  - trigger pwm_mtk_disp reg working after config
>
> Jitao Shi (2):
>   pwm: fix pwm clocks not poweroff when disable pwm
>   pwm: keep the trigger register after pwm setting.

Please add appropriate tags to your patches. These are not generic pwm
patches, but are specific to one driver.

Consider the prefix: "pwm: mtk-disp: " so others can filter out the
noise without looking at the content.

ChenYu

>
>  drivers/pwm/pwm-mtk-disp.c | 63 ++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 44 deletions(-)
>
> --
> 2.21.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
