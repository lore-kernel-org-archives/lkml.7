Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA54206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMHohC68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZMKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:10:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39952 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:10:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id d46so2948453eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6cWpzPYdvrM5xOSbjBFlERJHpYkz+I/GXvkEASQsMs=;
        b=hMHohC68D87OBjxb5kVGiaEDeAoO33hy2jyfIt7pG7huHaxqtTGsnSCLrzaBmW1iaJ
         KhgnXKXvaV4mUH5I6L/qfVNpvnIuXE750u9aROBTVb1GJtSNEfrEnuHdIgdH9Lg8pmet
         ZSNA58CwCaJe1D7FR+E7zf6P1AfArKGVrGGrrDLTGegJrvAl3TRuM8m4eImI+pIWlMde
         YuwYI0xt0Hmxmyai3TS4Qa2W4rhIE8r0Fw3pmymFEahSMckei6eOhox7lUXSNL4OYxEs
         mSGphCE46TEzLjhADYgqBzM14VYymylxtA4pBqwFqcxCnFMs4DMll+OGAXEPK60rP1AQ
         tWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6cWpzPYdvrM5xOSbjBFlERJHpYkz+I/GXvkEASQsMs=;
        b=GVFvBhC/qKFbUqyqfk5M3h2dgYFKYArjrL64A694a6AdqjxgrByxN9FWHx6Zn8nYzE
         nHO1/mmDnhohg/Y3LdWF9K/4ChC8uoUz3iFUH6gu5cL03LIdXEGuN+XwgaD+m5LSu5bZ
         UKzlf8TALKQAaPp4/pJVyovVcwiiEQHojT3NWJvv8zUFRzr/W0r7KJR053RLLrdcssai
         nW4m5oJebA5T1rtKBCGNM2GFWHEvibFr9LNIqjSiyNci3vV37/chOt0R8Y00pcXUPBjB
         q08kdp7F+tHIVZgq9ketp3iZw+orM+rfN8SSVZ6iQprZsXu1t6WkgBIa1qbzfHvaatRf
         daSw==
X-Gm-Message-State: APjAAAW5mLaSI29ZoU4bdxA/UHzIb0m5aKKSa/GTUtNWuq9JbiKOfqJn
        /vjr0HwoPtwfQC6OW4GKzIHxBC6d8ZxPU+BaFRg=
X-Google-Smtp-Source: APXvYqxfN3bxndoMxgbIuIl4dIOc0y80SLjYhQ0ObqgGATSkuduCdLsf6ZZnhBrVpZK1c8Hms2y4J7Y6UORerCMkYwg=
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr18305012eja.58.1556280622287;
 Fri, 26 Apr 2019 05:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190421193853.10188-1-daniel.baluta@nxp.com> <20190421193853.10188-3-daniel.baluta@nxp.com>
 <20190426100025.GD14916@sirena.org.uk>
In-Reply-To: <20190426100025.GD14916@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 26 Apr 2019 15:10:10 +0300
Message-ID: <CAEnQRZCPPr1iHvKEj=fOsE8A2iW=XZd=CaoFqAoUqJftg4pN9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 1:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> > Basically the same actions as for system PM, so make use
> > of pm_runtime_force_suspend/pm_runtime_force_resume.
>
> This doesn't apply against current code, please check and resend.

Hi Mark,

This patch is already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=812ad463e0894d78e93ab8017e0edbe69038c55c

The only patch left in the series that needs to be applied is this:

https://www.spinics.net/lists/alsa-devel/msg89733.html

I will reply also to that email, to be easier for you to find it.
