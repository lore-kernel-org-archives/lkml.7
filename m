Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C9F2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567585822;
	bh=Lh97Er4RFNHYTmr99oTQMZS7Qa/TTRWTwINXViZQoVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J83y1iPsm/D+uaRNwXZmJrXlzpEKYY3srWnPn1YPWx4VrqftRx13m9w0fQEI9lNNN
	 VxrzrmwMXIVFgmEUcCK/2o/3Y+j2cNKHbFQCJQSUjaLUkxGgbuKwtaqnWl91d7I81V
	 ci9+JtkxmhvUIH7LcQUCv7MYO3eRpUOBLztlD5k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfIDIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:30:20 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9982077B;
        Wed,  4 Sep 2019 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567585819;
        bh=Lh97Er4RFNHYTmr99oTQMZS7Qa/TTRWTwINXViZQoVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ba00XhkjsAfVIFqoUw4XDCrYjwdpq1xq93rciWJbfgzXbOezj9GZzvj6t7NWUdrUn
         9PuREUSozNg5D0nS8Ce6qA6TFK1zkdHaVa/Et5BwOcZgT4+X/MMgeJpUYC2dnuuTSF
         N+zR27Xtauu4APld4gioTaKLDj7RwaV4DxfJXhmw=
Received: by mail-lf1-f46.google.com with SMTP id c12so15183044lfh.5;
        Wed, 04 Sep 2019 01:30:19 -0700 (PDT)
X-Gm-Message-State: APjAAAW2iCBGtd+78p0IJnwoVoiS0TaEyLpL5mTuPR5rgdyfyKnBq/8m
        EtytvMrmxqOniL9YV9r2DP06SbbVlByvyHoi8kI=
X-Google-Smtp-Source: APXvYqyIxWtp5ANugFBOnOwndmgq6u8lUVFdexZfuwV5PqkiNbruroxMaNtADWXFCwo+8p0GtjHdHb09f2ZRaXGy7K8=
X-Received: by 2002:a05:6512:499:: with SMTP id v25mr19209706lfq.30.1567585817665;
 Wed, 04 Sep 2019 01:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <20190816163042.6604-3-krzk@kernel.org>
 <CAJKOXPfdvzvomUfmxhGf0qjEQH3K8TADCneo9SM6m50k4b=Gyw@mail.gmail.com> <CAK8P3a0sa8WgcNnL8jusYKFr22FqGnut4kRKM-1QcB8G+ygnMg@mail.gmail.com>
In-Reply-To: <CAK8P3a0sa8WgcNnL8jusYKFr22FqGnut4kRKM-1QcB8G+ygnMg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Sep 2019 10:30:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfoxVriL0GzZLp0wtYkCQC8Dn-0XXb678wXh4ePRy0dpA@mail.gmail.com>
Message-ID: <CAJKOXPfoxVriL0GzZLp0wtYkCQC8Dn-0XXb678wXh4ePRy0dpA@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] ARM: samsung: mach for v5.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 at 19:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Aug 21, 2019 at 9:52 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > > ----------------------------------------------------------------
> > > Linus Walleij (1):
> > >       ARM: samsung: Include GPIO driver header
> > >
> > > Pankaj Dubey (1):
> > >       ARM: exynos: Enable exynos-chipid driver
> >
> > This last patch should be dropped so I will rework the pull request
> > and send later v2. Please ignore it for now.
>
> I don't see the v2 yet. Are you still planning to send it?

Yes, I have two more patches so I plan incremental pull today or tomorrow.

Best regards,
Krzysztof
