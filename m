Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B9C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6BF20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8KjiXy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbfFMRA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:00:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41798 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfFLXzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:55:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so9793017pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FncTW9icD+cnLcX19bpYZpu4vyVjhu2JKDPqZ1+/Ryk=;
        b=J8KjiXy8uN1Jio07urQegYh7uz7/hdHT44kn6jPisJgD36SZ4NpMJ9DpnYXd61rR0W
         ZgZB+aaCLNkcvkS1mR+ww55lBlgpvH7IOej2m9KkCeDY6KYntmYDpVxmm1HW+vIRVS6U
         3gm3Y6KzDfgCo3727cxs0HpFf3/LIxveAPITaqEiw+0euI/lFA3D8H8TPnG/gL0yfeiS
         iIH6Xv4f2L9/EPgrGFS/NIsAXZ7o3b3yYUbzfzovcyOR+7iPI7DWa0g+VjRI4ifw8ewD
         1gc8bHzgJ1xxq/fi5fh99VVLXhI8BVUAU1Mh/lxx1dVK88biFgNTao1VF6jmpj2rAaF1
         GJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FncTW9icD+cnLcX19bpYZpu4vyVjhu2JKDPqZ1+/Ryk=;
        b=BfR88cOaF9uB5o9lhrxZi+1+Wn9CDvNcIv4K5DyYjJfMbsy1b0YRJoqONuf3uVIU8l
         XSHvRFdpcrGERtcO/pssE+n3jobhswU4WJZC0eeC4ksH4Po+D230mhdTnD/VcdNmL+8O
         AS1rbrai5SW1ByhRpx9f3rEy40JK7pX7UzNXt4YtURwb/Qu7hmcff5hNjVizGRff1/5W
         dtEjY+rRa6v3QWkX8xaml6mlB0K7eUCqsBnnS9NS4ElSbs5MxBA1+W+HNuXk3brALjGR
         dS4We/KzlegNy6PEIGDNRQ7QwlURLF9eG65fUDGFW9hk1Ixbjc9+Z/P55zhqnrz6cUaz
         SJXQ==
X-Gm-Message-State: APjAAAVwRx40Np0xKrQQumNhJadlZ/J1+C105ZYBSFzHWGlRacX1LBiZ
        WIV0YjziRX+K01/dVURaZuPhrbS6nlMlMBt9oiYtXA==
X-Google-Smtp-Source: APXvYqzfk1eRAHeNvQHbEfSZQi08QiYeoNKjd0uOd+Z+Hzx93yW3+4v31GBjDP2vyoJttKOK2Cwdpk4fRPLwanoJ+PQ=
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr27102833pgm.10.1560383729952;
 Wed, 12 Jun 2019 16:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190612232502.256846-1-nhuck@google.com>
In-Reply-To: <20190612232502.256846-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Jun 2019 16:55:18 -0700
Message-ID: <CAKwvOdkPQyK3oJk0qPQyfwVcvtdBSF6oN83VOW8kcy3zWyBkgA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: tas571x: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>,
        Mark Brown <broonie@kernel.org>
Cc:     cernekee@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 4:25 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Since tac5711_controls is identical to tas5721_controls we can just swap
> them

380 static const struct snd_kcontrol_new tas5711_controls[] = {
381   SOC_SINGLE_TLV("Master Volume",
382            TAS571X_MVOL_REG,
383            0, 0xff, 1, tas5711_volume_tlv),
384   SOC_DOUBLE_R_TLV("Speaker Volume",
385        TAS571X_CH1_VOL_REG,
386        TAS571X_CH2_VOL_REG,
387        0, 0xff, 1, tas5711_volume_tlv),
388   SOC_DOUBLE("Speaker Switch",
389        TAS571X_SOFT_MUTE_REG,
390        TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
391        1, 1),
392 };

vs

666 static const struct snd_kcontrol_new tas5721_controls[] = {
667   SOC_SINGLE_TLV("Master Volume",
668            TAS571X_MVOL_REG,
669            0, 0xff, 1, tas5711_volume_tlv),
670   SOC_DOUBLE_R_TLV("Speaker Volume",
671        TAS571X_CH1_VOL_REG,
672        TAS571X_CH2_VOL_REG,
673        0, 0xff, 1, tas5711_volume_tlv),
674   SOC_DOUBLE("Speaker Switch",
675        TAS571X_SOFT_MUTE_REG,
676        TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
677        1, 1),
678 };

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Alternatively, we could make 2 variables w/ the same variable, 1
variable.  It seems there's at least 4 `_control` variables:
tas5711_controls
tas5707_controls
tas5717_controls
tas5721_controls

so maybe `tas57X1_controls` would be appropriate?  Not sure if the
maintainers have a preference here?

(Looks like L669 also refers to tas5711, but it seems there no tas5721
equivalent for `_volume_tlv`.)
-- 
Thanks,
~Nick Desaulniers
