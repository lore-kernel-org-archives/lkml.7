Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFAD206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575365195;
	bh=sru8eq3Cr7bx4QiMdvafoc3zemYXXUyqjF9CRPlwlxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ERAlTSyipVKLPa9sqFUvp3Txjfy5xjdE68Hc12A1X69uMgnftJHu3bTVWp0quoj0q
	 CngzESL+DOJlQnYT+Axlfqi4Q4poa840vnhDumyFNMqetvetAftPXM1AKBquirg/th
	 1fgeIszl7awR4XOwlUBNCBM1TBZgSmqIHXV3RovM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfLCJ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:26:34 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68D020848
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575365194;
        bh=sru8eq3Cr7bx4QiMdvafoc3zemYXXUyqjF9CRPlwlxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D593Kd8Y0qaE+X5Fw5v//tQuGm5o6xEmgpyBFKWB9RNM0CRDxlFT3RrwP200XvkIZ
         /ysQOIkE4HR/BDOv8WzjMYknO64yO3xuqk240/BkTXi4TFRY4RpX4vDzSnAn+7ZFux
         +4aEY7pEldnnuHFd43Ty/537uTCCt4ffNAflH/wc=
Received: by mail-lf1-f53.google.com with SMTP id y19so2304937lfl.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:26:33 -0800 (PST)
X-Gm-Message-State: APjAAAXTpetOujXvwz8WanW1pWzosvjS5lultUqQ5ZmqLfxpSdVS/LKd
        11M8fRgc5GZgPl+cQL8pRz4TVxM0fq0aUqyWVrg=
X-Google-Smtp-Source: APXvYqyDx2OvNOVw7duhGgLCqfN8u2bKDi2nl6vKYv1ayjrywJ3mH8wSOoJYi2cXIk961X6jyGqdI/EoqhTNLS9lllw=
X-Received: by 2002:a19:4849:: with SMTP id v70mr2095784lfa.30.1575365191708;
 Tue, 03 Dec 2019 01:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
 <20191202211844.19629-2-enric.balletbo@collabora.com> <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
 <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com>
In-Reply-To: <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Dec 2019 17:26:20 +0800
X-Gmail-Original-Message-ID: <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
Message-ID: <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
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

On Tue, 3 Dec 2019 at 17:05, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Krzysztof,
>
> Many thanks for your quick answer.
>
> On 3/12/19 3:15, Krzysztof Kozlowski wrote:
> > On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> make savedefconfig result in some difference, lets normalize the
> >> defconfig
> >>
> >
> > No, for two reasons:
> > 1. If running savedefconfig at all, split reordering items from
> > removal of non needed options. This way we can see exactly what is
> > being removed. This patch moves things around so it is not possible to
> > understand what exactly you're doing here...
>
> Ok, makes sense, I can do it, but if you don't really care of having the
> defconfig sync with the savedefconfig output for the below reasons or others,
> that's fine with me.
>
> The reason I send the patch is because I think that, at least on some arm
> defconfigs, they try to have the defconfig sync with the savedefconfig output,
> the idea is to try to make patching the file easier, but I know this is usually
> a pain.

Till I saw DEBUG_FS removal and Steven's answer, I was all in in such
patches from time to time. However now I think it's risky and instead
manual cleanup of non-visible symbols is better.

Best regards,
Krzysztof
