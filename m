Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FACC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E257218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsM6Ojtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEaKUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:20:15 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44869 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:20:15 -0400
Received: by mail-oi1-f178.google.com with SMTP id e189so572970oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iy+b2XmhA0ntKME0CnMJCgRk0OfnARxxHVb5nAyoOQI=;
        b=NsM6Ojtr9vYMDTe1/mfRqJupLufihu+ZNUA0u/SNXUiXRqSs5vzhrg6EJCVVp47vua
         csDeujruhQ52gKRcsDzg+TNOyATTyYrEUPZRQ8CgvxuRfHVTHBESoi3M3caz1MktLeeQ
         gcOjC16+wZ4tOKU/esGTXt7IbhtV7MP+3F1fWGcWV1+EIoEGDKhrYgu/QmFjCFPPAYJx
         fM5KFxta5mP1FY4t9E8EFGCQC1DGAtEaRVK2khkPqqm7xE+4dZ8N/K6EOVG5xlUlyHUg
         Iretlr5BJIcYk+L+LCNn4iNJwpmrX9suAxk4syrbuBbPMFc+6dDd+Hy/FiI8feCuByOK
         7M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iy+b2XmhA0ntKME0CnMJCgRk0OfnARxxHVb5nAyoOQI=;
        b=BLTvkQpBRh1ps9zH00t2EhYI+Hdye7qVQDduMEteu1ob2MGgUXjYtX4scXd8rmUgOy
         oeG5sAvY6GID1NzazTD7QOx2vSZxT/rgRWj6QgQtCNih95rw8FGsRL2dcJa/FQ81RRxJ
         i8v2XoymjrQKl8wEborbEh6ChmGWCMZ36OBqule2fFmkkgnmmkfrWlxD08+YLEOkHWDA
         ++9HdYp+TY9s2TmwttJDNmcy2GJ/aZiPU0O2hMNT/k4dJxcmWRbynt3H+VZFrD5Rih31
         zCvsytcnvz/XrzaMcxWqyEtzM1nzXazWqDvaNN+2+XBQBySR3NgGouLgoyVvVdGZtEWj
         UYYA==
X-Gm-Message-State: APjAAAWwoVDx6kqvFbEBCjIky/3//iykEAUGGPcEuP5HYN8XB8e1QDax
        +bEy0Jc8WgAUB9j33UC+D6iEyjquspFv3acptYY7MA==
X-Google-Smtp-Source: APXvYqyXFvGVgoiZdcOxGr/H1SlhMtGXL6Lz7te6iFo0TuR9613uWJrlqnQVhGO1bcWpGSXyPQR0yNsMKuEton5QgRg=
X-Received: by 2002:aca:80e:: with SMTP id 14mr5832960oii.2.1559298014153;
 Fri, 31 May 2019 03:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfREyt3P2H8bL9=6+EQ1S3Ja7Urkhy1x7sCHaaubMqV1Q@mail.gmail.com>
In-Reply-To: <CAJKOXPfREyt3P2H8bL9=6+EQ1S3Ja7Urkhy1x7sCHaaubMqV1Q@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 31 May 2019 18:20:03 +0800
Message-ID: <CA+Px+wXs1u9VjkzDerb-BVPQRLZNMnw8Rh5prkb+0mHAggwWgg@mail.gmail.com>
Subject: Re: [BISECT] No audio after "ASoC: core: use component driver name as
 component name"
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 5:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The problem might be in component name. The driver->name and
> fmt_single_name(dev, &component->id) are:
> snd_dmaengine_pcm != 3830000.i2s
> snd_dmaengine_pcm != 3830000.i2s-sec
> samsung-i2s != 3830000.i2s
>
> This commit should not go in without fixing the users of old
> behavior... I could adjust the platform names for primary and
> secondary links... but now it looks like two components will have the
> same name.
That is because the two component drivers used the same name in
somehow.  But yes, we should not have the commit without fixing
potential errors for users depend on old behavior.

Could you send a patch to revert the commit b19671d6caf1?
