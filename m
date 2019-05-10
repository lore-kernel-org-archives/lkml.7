Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B735C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A17217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4BTeaUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfEJWYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:24:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36203 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfEJWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:24:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id c76so4563103vsd.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dqrg0jqqwTFVZg+HwDR33ruHqkuBxkLtC7FtOcFOyp0=;
        b=d4BTeaUXVFNJJJeqPBsPt3i9JuHD4wKo14zSuYu5RNeYAMlhYDP4ThmnBW/Syuzjk4
         tajrK+f0a31CsFguryP+Jd1WecjSMXsIgac9e3dlFJ+3s7fSTKuiU64+LFTBHi5WjbAp
         OsMXPOon6AW7MtTubCZviZAQ2bNzg1Nvn+hb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dqrg0jqqwTFVZg+HwDR33ruHqkuBxkLtC7FtOcFOyp0=;
        b=ZnhV1cdPUGz207AjuFytkPQRIOUhbOQ/2hxBhkI3MEkcxgahs4nZunzN92lOqywfXy
         OEH4YjkIeuti29Lcx1/O2784EAxzBJadWS5F1TilXpQCHesjRjbHmo1rcNdKQH4KOhum
         ACtHLGkyP3IDoi+5Bj+uh8UlC4hNn+FFSzs7AyMmmv9R7UTSVxA2qGC20FpayOEqd36Z
         nP86vLKaTSYN4DBRA5jsPOjwNwsC8TuBUyKCKzCc6gsIU08dKxQhirL9HXCyibydbBS0
         wvxHlhyoAzl9cBIsN6uMTnJ5VoZ6oL4taTnDgLnjWu2tahAk7ZrWgwKS1gFW2TuEb5lA
         W+AA==
X-Gm-Message-State: APjAAAV+3u28WRRT9NKpPVQZLMtd5T1yJNXDw8BB+QawQoDX0APM0jhG
        CxeLMgW+45rRzWaFNnf6Y+07cloOLQM=
X-Google-Smtp-Source: APXvYqzDqJHpxlML74nHdL52smESG4/bIM9rJdFijqMOjVkQxbisc0Bx83XpHdBQpMNhl05MUsz9Vg==
X-Received: by 2002:a67:6847:: with SMTP id d68mr7499462vsc.90.1557527045469;
        Fri, 10 May 2019 15:24:05 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id e6sm7967532vkf.0.2019.05.10.15.23.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:23:58 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id d4so2688476uaj.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:23:57 -0700 (PDT)
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr3829867uae.19.1557527037549;
 Fri, 10 May 2019 15:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 May 2019 15:23:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UN8rm_40eVz4YVVJ57d_BWkzxs1E4nYhX_mKWe2pwX0Q@mail.gmail.com>
Message-ID: <CAD=FV=UN8rm_40eVz4YVVJ57d_BWkzxs1E4nYhX_mKWe2pwX0Q@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Kees Cook <keescook@chromium.org>, re.emese@gmail.com,
        kernel-hardening@lists.openwall.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Use gen_rtx_set instead of gen_rtx_SET. The former is a wrapper macro
> that handles the difference between GCC versions implementing
> the latter.
>
> This fixes the following error on my system with g++ 5.4.0 as the host
> compiler
>
>    HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:42:14: error: macro "gen_r=
tx_SET" requires 3 arguments, but only 2 given
>           mask)),
>                ^
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c: In function =E2=80=98unsi=
gned int arm_pertask_ssp_rtl_execute()=E2=80=99:
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:39:20: error: =E2=80=98gen=
_rtx_SET=E2=80=99 was not declared in this scope
>     emit_insn_before(gen_rtx_SET
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can confirm that I was getting compile errors before this patch and
applying it allowed me to compile and boot.  Thanks!  :-)

Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
