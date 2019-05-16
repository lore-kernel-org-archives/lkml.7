Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FC42082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwoWLHhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfEPLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:34:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45546 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:34:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id n22so2322195lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwrlasTBgxV3sobPR5/VoyQX2EKVuzZjU/sEXjepADU=;
        b=TwoWLHhFqILvUMQtvpE+zn9CpQmC7ETm0qIHDUxmGGtVOkQQ/VKMAxGC9QIHOUqjS/
         ccWEeBiniH8sV4N8I46DrjR6uhUsPy2+guHtZxSHku6hlGfAYDoRq4vxxx3TSuvIvXP6
         L8mD/VyUYaFkL6Q06cmDdJwv1mJhvAU4xil/G71iU51jwh8qLj/KtY5mmbSwoG/GO3QV
         IaKL+VS1Dde8J+zCdD9pc1M6W4f0cH2/eNlzQQqIlm++/4raqCfV+YuEz1b2h+NbL4S/
         F0WqkTciQvRgov3q0SJhEEj7CvmiXWxccig+dvGkx+VMzbPU3PbBotGVvRm7tXpO5BKi
         v65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwrlasTBgxV3sobPR5/VoyQX2EKVuzZjU/sEXjepADU=;
        b=GOZf92ZkwhGv//wMFzBNcD/mu6xJ7dZGWmWGEw7oN/qbVInoXuMY8tG3nk+bfvto+L
         WRFg3W+IXHnMb7a11P7ic7S1GzKZ5TpRWCo9H9UXuxpdgp/4ON9gQUreNGLo8Xq4beVs
         0SnU+YJ4ftFlNhErz43btKRt5cTTtvXjLkTUlsE2PzwjusfSUtZbn+cK4eXhtztZM8bQ
         06hjqIInL828R1DrPtsFVwH6yjtEZ6EbzRyfiawZe43vTDdOt8HhKkGRh+4eysQ50FnJ
         XX/YSfi7LC1b+R0CL2WtvK8i3IEuqSvoC6lgNRRskrwCOrVCwkBaNQCBBDGG1f1A45vv
         mUSQ==
X-Gm-Message-State: APjAAAXf6RAfHNwNMBoxh4QYe0IMaGsBOY8DaLhrKqyImyIcguxuETot
        Q7pA6ZZ9yrfGPSyhidRn5ZLgNqcifEMBecngIrZ13U0Lwlg=
X-Google-Smtp-Source: APXvYqz6QAHraamvJpxiM7W8l6wETLEEkP9+3l0VSfhN2ve6pq/4QHbqGA7En79eJqPwJ8BGQbHoEcmzWQJ1urZKqAk=
X-Received: by 2002:a05:6512:6c:: with SMTP id i12mr5129323lfo.130.1558006460375;
 Thu, 16 May 2019 04:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
In-Reply-To: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 08:34:09 -0300
Message-ID: <CAOMZO5DHTAQvCwn8uiL3-gmMB2HKRBnZUHXKVej_HFLrtqO_cw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in
 binding document
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 8:25 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:

>  cs42888: codec@48 {
> @@ -25,4 +30,5 @@ cs42888: codec@48 {
>         VD-supply = <&reg_audio>;
>         VLS-supply = <&reg_audio>;
>         VLC-supply = <&reg_audio>;
> +       reset-gpio = <&pca9557_b 1 1>;

Please use GPIO_ACTIVE_LOW instead as it makes the polarity clearer.
