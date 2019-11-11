Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3196FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D5206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvu+8N/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKHhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:37:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40284 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:37:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id i3so4305244qvv.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4Zb47p2XPwOCswEiVCxFP3pBYMa8dixjcKcMTAk1Xk=;
        b=Gvu+8N/lhR7xyJ0lGg6oiJJrH5spP3uTiLTY1hjI1MQw7T2ABX41o5lsHenviAHG9e
         Lfax9OZnTplip+abpfLRUNX3sr8mCLZyv01XVtD+uuObGt5p/ShA4nfi5nrooxc2l0xR
         q8p+MbexiTGoAT5xg4F1AFUwJ3lZiI3PwB0lJeTFffms9sRF8cm3hlKgDIFvpj0MW9CU
         s5d6s/uQ7G/7saHs+tYTUrm/1UXYhR+Oeui90reYAfFE0Z41w18BqZxZNlBcUNiWozBq
         K2SjQ6OOgFyJTqyGsJqx/9dNCr60a6pmjVGB/+s4bonMwDVTYCZy+ar2pJYDVR8qS4yC
         xXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Zb47p2XPwOCswEiVCxFP3pBYMa8dixjcKcMTAk1Xk=;
        b=js9qSAjeP7JEmgkox/UCwu0si/Wh0hwKkGbmcYes5A7+0A1Xtj63BY01pZizVbqWBG
         lrfI/MXh4Vx7oZayx7VWefjgvCyL/so/LYf4yvul90VYMFH8Z6XLYT+FdZn1Kh0Aflzg
         iX3w3GKHApNzKEy6LyCXuPuu7H3p6/aWjS1iodBd3U/KYPrOZItnvj0brrs9iKirbYY9
         Ebb76L/bwpy0q/MuHwG038cBUEYFIRHnzLWT+7biC1damzFEveNlQzPOjrKGtGtxHubj
         AmyT8YwC4wUePI/vTbFiXdHyngKeI1yFGaaJr/bVvU5qX7+9KsmuvWqtzME3C7f0onPR
         8snA==
X-Gm-Message-State: APjAAAUH0cEhKr8C5PbBIWl+GqsCPhQIca0FknetYF4L6sLPkC9ACJFT
        KEslA3mLBozLHUYSoLRX67k4WwE/be/yrG+sfU0=
X-Google-Smtp-Source: APXvYqxpJG9+Wp9uWvq5SOdQ0ClpNoEw5Bq9RYcUBHDxKCS9kLWbq+/2zfW9+9hTfC22q3nUJO9pss3ALBiVuNJqFsg=
X-Received: by 2002:ad4:538b:: with SMTP id i11mr18033921qvv.211.1573457871628;
 Sun, 10 Nov 2019 23:37:51 -0800 (PST)
MIME-Version: 1.0
References: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com> <20191109024502.GA9187@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20191109024502.GA9187@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 11 Nov 2019 15:37:40 +0800
Message-ID: <CAA+D8APXbQYTUBpaPSBtK7J3LfKL0LA8sXrOomEaHTBjqpOV6A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_audmix: Add spin lock to protect tdms
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        timur@kernel.org, Xiubo.Lee@gmail.com,
        linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
        festevam@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Nov 9, 2019 at 10:48 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Nov 06, 2019 at 03:27:45PM +0800, Shengjiu Wang wrote:
> > Audmix support two substream, When two substream start
> > to run, the trigger function may be called by two substream
> > in same time, that the priv->tdms may be updated wrongly.
> >
> > The expected priv->tdms is 0x3, but sometimes the
> > result is 0x2, or 0x1.
>
> Feels like a bug fix to me, so  might be better to have a "Fixes"
> line and CC stable tree?
>
> Anyway, change looks good to me:
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>

Ok, will send v2.

best regards
wang shengjiu
