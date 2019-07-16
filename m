Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F59C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9C4217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563268018;
	bh=sLeJAGoi6fbJl/VVolgOKFuiWf+MDSI1pIqVj9ar2uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OANWQtIhGs+ikckWR15OFBVNGvyTV3l5di7Pu3EZ0a2S3mUGR/U17VrxwVA9bF14W
	 hFq88heP0vqnT8dO0/4CZA56sY2NNrAep5GUABWVjmxpulfVVY9CsqOjzIN30tf+sP
	 lSFJLYC4lud/58Ebja4G0EuzrhOzyIhi9eF6czF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfGPJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfGPJG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:06:56 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CB2217D9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563268016;
        bh=sLeJAGoi6fbJl/VVolgOKFuiWf+MDSI1pIqVj9ar2uk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H41dQvPRZCOK0u3tIALceDa7Ciy6R22No8F1DJDtPDfkbZP4yq1w0XbEDJrbs6iS9
         POZgDz1igIbMqcME5m6oISLkJPevFShbmL1IskR+AtZIaLXeOctT424c3b/ytZeBcH
         eWXObYMQJCCHGDE8YvqcLXDFg8s+2HQM1HC2NYzo=
Received: by mail-lj1-f175.google.com with SMTP id v18so19135317ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:06:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUIk/gWSozFSkRc2hzPjsGIgOWvTJIBOGZR/+oEgjjUQtfA/n2p
        vqxBb3CgTwuRf5t+UKaVa4k4yWUiS2AFn/2h7+4=
X-Google-Smtp-Source: APXvYqxCZng3zYWjzQTjtV/26d0IoB6FVFDI634g+iFqqrBwpA0cXUo83GeZu94zDjolDmOXC59cJaRNhePVGSb8WVw=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr16375828ljc.210.1563268014039;
 Tue, 16 Jul 2019 02:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn> <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Jul 2019 11:06:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdY7xqcBJzU6pe1pSmpbNoBY6yh0rih2t4XGXaYWP3WfA@mail.gmail.com>
Message-ID: <CAJKOXPdY7xqcBJzU6pe1pSmpbNoBY6yh0rih2t4XGXaYWP3WfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 at 05:48, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The cpu_dai variable is still being used after the of_node_put() call,
> which may result in double-free:
>
>         of_node_put(cpu_dai);            ---> released here
>
>         ret = devm_snd_soc_register_card(dev, card);
>         if (ret < 0) {
> ...
>                 goto err_put_clk_i2s;    --> jump to err_put_clk_i2s
> ...
>
> err_put_clk_i2s:
>         clk_put(priv->clk_i2s_bus);
> err_put_sclk:
>         clk_put(priv->sclk_i2s);
> err_put_cpu_dai:
>         of_node_put(cpu_dai);            --> double-free here
>
> Fixes: d832d2b246c5 ("ASoC: samsung: odroid: Fix of_node refcount unbalance")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  sound/soc/samsung/odroid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
