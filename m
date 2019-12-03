Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DAB20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575339372;
	bh=yspJnuwBkqreWkEPkorkWPkvQhXOPzOAL1ymr79vJOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qouENHvOVo4Rmbd5Rd0eyUSs6KYjEX3AxufGzc0gotYsDvvxZkTWSLnpXd/+vlFt3
	 RWZMgjSHut6UaL/vluXXvcVmZfVEQ41LNqxjPbEZZ4qH+oLXgl9Z/WfsUOuznXFz+a
	 o8sI0pk5ind3itKZOtIwbtAJ2G7dl/FCSkdLosXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLCCQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLCCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:16:10 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE08920674
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 02:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575339370;
        bh=yspJnuwBkqreWkEPkorkWPkvQhXOPzOAL1ymr79vJOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/lgSuYJHA9HP9QDCMpGXJtGR1kQ9COgoTYtNTB73CZPFjUyca7cWq8rJTPNY1VZY
         uNoZmzmLzhg0IflxnR9tvZsoOUSejmJNoW3zxhzoeIXuXELH3dYXum6wS5B1ScOzOr
         96tgp43BHOrf/W/fRTsc6sF7umyuW7ncrbqRkbpw=
Received: by mail-lf1-f43.google.com with SMTP id f16so1565485lfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 18:16:09 -0800 (PST)
X-Gm-Message-State: APjAAAW3k9AlV3slV6MyEzMKL2P9IOyfa4XRBQGr7RwzPq6pLs8rBnP3
        xmpP4a+1UtuL4LDIpTjC3JftVruToF/eQIoSN2I=
X-Google-Smtp-Source: APXvYqxdosNhv2sWf/b6mhJ1XhbmHiJ++cn99BHC6sDqkGREBNHW8+XXp+GdqiYIa79ZMvEBXfG6s1JyMX0aCXTaZJY=
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr1222841lfq.24.1575339368011;
 Mon, 02 Dec 2019 18:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20191202211844.19629-1-enric.balletbo@collabora.com> <20191202211844.19629-2-enric.balletbo@collabora.com>
In-Reply-To: <20191202211844.19629-2-enric.balletbo@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Dec 2019 10:15:56 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
Message-ID: <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        fabien.lahoudere@collabora.com, guillaume.tucker@collabora.com,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> make savedefconfig result in some difference, lets normalize the
> defconfig
>

No, for two reasons:
1. If running savedefconfig at all, split reordering items from
removal of non needed options. This way we can see exactly what is
being removed. This patch moves things around so it is not possible to
understand what exactly you're doing here...
2. Do not remove options just because other select them in a blind way
- via savedefconfig. As it turns out, some developers have different
view on dependencies and they expect that defconfig *explicitly* pulls
out necessary functions. IOW, they can safely remove any visible
symbol dependency assuming that defconfigs are selecting this removed
symbol explicitly. See:
https://patchwork.kernel.org/patch/11260361/
(commit which removed DEBUG_FS - Marek Szyprowski will bring it back,
I think, and Steven Rostedt answer)

Best regards,
Krzysztof

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  arch/x86/configs/x86_64_defconfig | 90 +++++++++++--------------------
>  1 file changed, 30 insertions(+), 60 deletions(-)
>
