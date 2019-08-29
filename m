Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEDFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0311D2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW91Qg5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfH2Nv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:51:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42338 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2NvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:51:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so3694569qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KrzCEKKNAi4VHbtHRw7x95sb6UYGohg8TR20YevudW8=;
        b=CW91Qg5X9VDKVEUs6SGcwws+rIhmQfjiPVAxjZxPn+aN58G2uyUmYjJOWD7VaemjSa
         T0LxG+g9ZtgnMiqm2yvENw66bx2hZgQzHxujLU2liAspqIZSqGLPaoFFiOisAYQE6PfN
         uSt5yWkF6J0NLlTyDf+OXG4BE7gYZNmyI8lJVVJR5w7QgZF/zcL8Q2HPCOB+2i02KYtA
         2PqBCBTBVyaYKxLIJgx1KH4obcgoyF0TC4PbWl90LOziN5ejvDw1qZz2rY0ckOhURjpD
         nsBLglB6rEKuMkAbOH4qWugQ+lNqrteLbrZFCFxj91ecOKl+c5mT+lXyVLiE/974DzfA
         3uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KrzCEKKNAi4VHbtHRw7x95sb6UYGohg8TR20YevudW8=;
        b=dfFZrIBwd26QYJBl/7Fwd4Fnd8R5xWb99NZ/2rHbw4x+iq/x+jWnbg6cE44a210Ziq
         SJl7lZWaL4n+pzB6GChruR/oaaZXwsMJMDv/BPk0IdX/Grkvu0uQ5EsSgIZD7jqsuZV2
         tLwFlWHitj7JML8K06fB3wDO1W5sREkJe4vWgkjYi1V7RkvRyUEIcTwE9IgEdHAGvYhb
         JhXDSEvUoAu8u/7SqpRprJEgI+i844EurPcVBpOxZFRQz6av3chw9JlFjvPZzwlOpfY0
         xgU5EEhKWUu/V1r3wl/Oo/vVNX5wQP7kYxiR7hL6x1bVMzSK2yiPyMgMQnKh0R9AAvvt
         e1Lw==
X-Gm-Message-State: APjAAAXOWvIm1D+eWZirXBQ372HONdyLwTBU+mYY2H7TZgXEWbA/TBeb
        PpLL2qUkYZ5xu4FmTT0wjNJMq/KIeZJVDt4JB6A=
X-Google-Smtp-Source: APXvYqyOOSefB7FXx2RWUFf4qV/+2+PyFA0D3HJpZpLP9x7qqXq1OSfWujHiolBHL+HMeIMTvuqikgcErK/oRSpcxI4=
X-Received: by 2002:a0c:b192:: with SMTP id v18mr6639478qvd.163.1567086683107;
 Thu, 29 Aug 2019 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190730134704.44515-1-tzungbi@google.com> <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
 <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com> <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
 <89aac768-b096-c51c-2ec7-5c135b089a31@collabora.com> <20190801145050.GA154523@google.com>
 <CA+Px+wUzyFB6vRM91PTFkY_fBfp2xybegy34rbW_D9zzNX6-8Q@mail.gmail.com> <a75bd837-6b24-6a64-00d8-0b3fe9d5a784@collabora.com>
In-Reply-To: <a75bd837-6b24-6a64-00d8-0b3fe9d5a784@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 29 Aug 2019 15:51:11 +0200
Message-ID: <CAFqH_51HLLDfJHheAOid9N6WYHHDrNxg1QOtDOOVLNLH_kRDXg@mail.gmail.com>
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating script
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Raul Rangel <rrangel@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dj., 29 d=E2=80=99ag. 2019 a les 15:44:
>
> Hi Tzung-Bi,
>
> On 29/8/19 6:19, Tzung-Bi Shih wrote:
> > Hi Enric and Raul,
> >
> > Do you have any further concerns on this patch?
>
> This patch will conflict with [2] which hopefully will be merged on next =
merge
> window through Lee's tree. As this patch is only changing the doc I'm wil=
ling to
> wait after [2] lands. It's on my radar and don't need to resend, I'll do =
the
> required changes.
>
> Best Regards,
>  Enric

I missed the patch link

[2] https://lkml.org/lkml/2019/8/23/475
