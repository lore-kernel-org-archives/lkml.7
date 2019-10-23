Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C5CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D07821906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHIg3gQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbfJWIDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:03:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38727 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390069AbfJWIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:03:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so16617454otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uunPk4FRGMVRF/7mka4EzN9Nm4HV/2M2f5HwcfgzDg=;
        b=gHIg3gQn71VKU1Zb5o/Bjl3AtqVaiUFOBs/9yFdHsyR5Cp3O9qFur0Z7Yp6eGhpSJP
         zwARXUjs2v0bUpgfQNpyh3eSjlOfqyeklONDjphVP78YlJqbsj6txItzZMqz4fLMkXjE
         ujdJRD/EJ6Dn4eD61vueYzyHTWA2nMju0JbBrdnWyHj3k0z5rIMg6SaSDLL/aGtcsJyz
         mM79AoUbEry+9j1JIloGvt49aoCGf7Gc5GT1Lt07h+2w635KjXjOVVq/P8OhlKbEhx/9
         sb6SUs2Kmy//iuqTRXE9jU1OwV+XtPfM1lxotMBnnPjKkStTZ/JgbvF6bo4zsjRaxsII
         7J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uunPk4FRGMVRF/7mka4EzN9Nm4HV/2M2f5HwcfgzDg=;
        b=cwKLMLcj55Tc5L7HVfFr0x+b/M0E/UEmSOddFTz52dYfA1PpuR6UDqpRw93Ld9MDfv
         i5KrsV6VhoC1noUHnW8ia66R+kQNubLnG/rig0g6rA05k/seZ3Rvek4qp4QjiVmiH++0
         01bHP0K28IELtIGNY+GcQWGC7rSIqN/iAu+hiVyw6fWvC4jRYvQITM8zTQme6GCvBbJz
         MR+uKT5exfZllNLHXTOmEg7oxfL7gp9PlqLNfWZzshpN5ZBscmzO0Y7pKnBSw/EiEf5O
         ZddQhOXYNgvZoYEgA+H0cquFmlminn6VIvsxZOVz3cyuJJPuaP7k6quG9t6ZLfuRIvsS
         nz3w==
X-Gm-Message-State: APjAAAWE8YmgjS2iQyD0ENH470+ibR5WJWDzt8tcYERGGiJuTb+SDOv5
        9yBw8M4TCI01n1tGh1k1XxkHEqy47rZUgv+/jiPHXg==
X-Google-Smtp-Source: APXvYqyfHE/ivBJeAMwtq+xDy7lllkwK/zu3sWWZGYeVM4ARAomhLhU7HXNGvp44TV8sDYdi8DuU8C7CCvatK56LIEM=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr4015609otn.103.1571817800353;
 Wed, 23 Oct 2019 01:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191023063103.44941-1-maowenan@huawei.com>
In-Reply-To: <20191023063103.44941-1-maowenan@huawei.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 23 Oct 2019 16:03:07 +0800
Message-ID: <CA+Px+wU5UrVC0pk5pbfGTdVsh7OHcBx_MhbC3Bjmj_+zgn54PQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?U2h1bmxpIFdhbmcgKOeOi+mhuuWIqSk=?= 
        <shunli.wang@mediatek.com>, yuehaibing@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:31 PM Mao Wenan <maowenan@huawei.com> wrote:
>
> If SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=y,
> below errors can be seen:
> sound/soc/codecs/cros_ec_codec.o: In function `send_ec_host_command':
> cros_ec_codec.c:(.text+0x534): undefined reference to `cros_ec_cmd_xfer_status'
> cros_ec_codec.c:(.text+0x101c): undefined reference to `cros_ec_get_host_event'
>
> This is because it will select SND_SOC_CROS_EC_CODEC
> after commit 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV"),
> but SND_SOC_CROS_EC_CODEC depends on CROS_EC.
>
> Fixes: 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>

Thanks for the catching.
