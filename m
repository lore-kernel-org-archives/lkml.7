Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B9C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C7920678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBLEGYkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgAIFLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:11:51 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40034 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgAIFLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:11:50 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so4671274ilo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 21:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfHlaQy6US7aBw4wjE4YMzRfD8j4wvVn9C/uKXknGvE=;
        b=VBLEGYkdTZtdqR94sj6Tjf0h7XJq62AIYsTyd021wihafB/YFnQabl26zlE6suDM3b
         YDoyoxxzX/u6qN8yuTxaZE7sLz5INyP7B2NVAKQbaOU7p3+SRqtKHOLSel8BnW4EvEmL
         HJVwLSrnwsWoy2OT6r+FzNg3Hb7kHcxo6X5QyujDVSPzL+TMS6UJ0D+23U6qH8FJ+O6X
         D2Mqip21qT/RzMp6BncnERjzOwUsWoS9AjuWBmAr5AhrAiQONi/7eUzgjF8PkTH1JsCg
         P+6CaXE7Ir4pSrKnQRBuCewXmK+CuwIUj8SkT9sHuobdiK8s38RXGkToOdIhZeygll+8
         ZIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfHlaQy6US7aBw4wjE4YMzRfD8j4wvVn9C/uKXknGvE=;
        b=FLyJfwVxSkF68+kYFoKAb15ldBWc+yo7Zk4Cv9UTU4rXuO0SRNzXQWwgtsJ+wByIlb
         hJXuPIsabCH+hcTfwHtBkzAtpZ6Nw+822l/OnRxR7oGHUA6C51BMYBb8F+JBX+s90sXo
         RhI+VAgWnz7GYjzp6l58rS9N7CPy5wQXYEfXbl5OZlyHExGeMNEJli1DQeLIDyRwk1m9
         NfEwmYtVZz8gxRcqD6QDm7fWheY7hwc5jll864vpRLCryJMuauSuiQTyVLeFA7gaPA3K
         atebvEmSiJNZsejsEvo3x1dR6xmSiERlymk3Wy/lG+KZG8EvBhmLgKgc7qNk5f/zsWP0
         PY7Q==
X-Gm-Message-State: APjAAAWAVueSDpRNk87fufNE54v5iirotFWc858xBZQ7kE+brV2wxePR
        9T24u902nZ11tRZvVujwTrWkEW2gjjO/3VoFivhFOw==
X-Google-Smtp-Source: APXvYqy6jhW/BWgmeQryfExSbB5ZZCHIWOH5y455b2gRqd8d/+uz2PUeTmV3LSSnzW9mzk+cRkzMj2Q25Jj/hNuJe7U=
X-Received: by 2002:a92:2907:: with SMTP id l7mr7102602ilg.140.1578546709305;
 Wed, 08 Jan 2020 21:11:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3@eucas1p2.samsung.com>
 <20200108115007.31095-1-m.szyprowski@samsung.com>
In-Reply-To: <20200108115007.31095-1-m.szyprowski@samsung.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 9 Jan 2020 13:11:38 +0800
Message-ID: <CA+Px+wUo7i331kEuc2mjE9uqSna7Lxnua=hvgPc+0T2YdeCgMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: max98090: fix incorrect helper in max98090_dapm_put_enum_double()
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 7:50 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Thanks for finding and fixing the bug.

The fix also reminded me: there are two possible "context" to call
max98090_dapm_put_enum_double( ): DAPM and userspace mixer control.
- max98090_shdn_save( ) is designed for mixer control because it
acquires dapm_mutex.
- max98090_shdn_save_locked( ) is designed for DAPM without acquiring lock.

Current code:
> +static int max98090_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
[snip]
> + max98090_shdn_save(max98090);
> + ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
> + max98090_shdn_restore(max98090);

Should it cause a deadlock if DAPM calls the
max98090_dapm_put_enum_double( )?  I didn't see a deadlock last time I
tested the series.  Will do further analysis on this.
