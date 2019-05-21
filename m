Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E006C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD362182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gz+qpT90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEUUgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:36:24 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:32778 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfEUUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:36:23 -0400
Received: by mail-pf1-f181.google.com with SMTP id z28so62348pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pdMnlQMpicFeAISSl6SetG7UCP7qGuD4qS0DzjL6Ug=;
        b=gz+qpT90Axv83cbkiouFZO1oIr+TkgmvDpdd25B+7DFd4tz5+TpHPwWQSpH5dIyb48
         6a5ygg2J2pfSVZ0gkGrs3KDAZdD6B53AZkOtT2VS3oXt4a0PZzQCNNrgn46n1vqVDz6n
         7izNaMXDzVIN+Zk6mjfNav/BljVWZg5/fR038=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pdMnlQMpicFeAISSl6SetG7UCP7qGuD4qS0DzjL6Ug=;
        b=f11TCS1RzF/bTW3z1Unmda2uj6m2QsCsBWFrQLYZo5gpFi14JJl3PBzHoF8t5KcvNE
         DcQhflATao7L04J0qVVOWQJIrIC/E2w/Sp4kZY7NTp3Jo97aWVkjKCFrc9BWa0U2uVdc
         vmNJ4lQB/Yi1J1jPDPfyLWfMIO+xc3m60STllZkbbVkR2XKNr9hn7P+ISSgKatfmihRT
         xzVO1OwRU7MjMrCXl5I0k8ZdzQMGth4dzCCVf4h+oyyXb+M4a2UnzpEDlJ1GcEmZh2y6
         iZE5PRc7l+lrEtIJY/p85iEfs8+EveO/a54M0J6tAP6AZgtEt6qPyIA0tyDYbTvxA1LJ
         C43w==
X-Gm-Message-State: APjAAAXTQGacWhL/qkJeW28haL6vlUdSW9faHentC0gQ08Ug9TtXy3UG
        YwxSmphFP7cyIaU5LrXbWejQbQ==
X-Google-Smtp-Source: APXvYqxg4xHpBGsoG+5Yv4eVbvoY3I3a0Q5ah6TcNSDyscIN30dOKmqFEvR6rVFugfZjW0rqWiWnlg==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr85270351pgd.26.1558470982599;
        Tue, 21 May 2019 13:36:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14sm22949968pgl.43.2019.05.21.13.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:36:22 -0700 (PDT)
Date:   Tue, 21 May 2019 13:36:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG v5.2-rc1] ARM build broken
Message-ID: <201905211331.E0D1EDC0@keescook>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
 <201905200855.391A921AB@keescook>
 <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com>
 <201905201142.CF71598A@keescook>
 <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc>
 <A22646AB-300F-4E0A-95DE-06633C2A2986@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A22646AB-300F-4E0A-95DE-06633C2A2986@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:23:36PM +0200, H. Nikolaus Schaller wrote:
> >>>  HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so - due to target missing
> >>> Undefined symbols for architecture x86_64:
> >>>  "gen_reg_rtx(machine_mode)", referenced from:
> >>>      (anonymous namespace)::arm_pertask_ssp_rtl_pass::execute() in arm_ssp_per_task_plugin.o

Are you seeing this error still, even after the fix I sent? Perhaps I
misunderstood that it solves all of the build issues?

> That seems to be a significant assumption about the build infrastructure
> which now became permanently enabled by the "default y" for GCC_PLUGINS.
> 
> I am not sure what the right way forward is. Probably for me it is to find
> out if I can fix my cross-toolchain. Or if the kernel should better check
> if gcc-plugins can really be built, if they are automatically enabled.
> Or keep all gcc-plugins disabled until explicitly configured for?

Right, that seems to be the case: it seems that the gcc plugin build
sanity detection script is not working in your environment. You can
check it directly.

Here's the bits from the Kconfig (though I added --show-error for you,
in case that's useful):

preferred-plugin-hostcc := $(if-success,[ $(gcc-version) -ge 40800 ],$(HOSTCXX),$(HOSTCC))

scripts/gcc-plugin.sh --show-error "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)"

I'm not sure what your kernel build picks for gcc-version, HOSTCXX
HOSTCC and CC...

-- 
Kees Cook
