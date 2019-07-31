Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987BCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73137206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfGaInc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:43:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45327 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGaInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:43:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so59020731eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJYmquIS1e528+G/ixh1cYrRMeCXLDQDyBuin0HsHOE=;
        b=QLXWbaTtuyGF0FbKoLlzhG5WVFr8cNSh/WgVZpqIRsjkPG0tbpo3QgZc7Y8LLSy6DS
         d04BfTp+Yf5MBjC9n+kcAiGhBo33SRYaohs5RjoObfqO2hzfFkEc+RqGdAkEgR90I3xZ
         j2dN1ToUD1wVrKNVZFFdc5T6AC1fbA0YJSthDxRxUE/G5T9MA45OmRGbMux6ZDOBJS8N
         2g8iCRoij4VOGsv12NaMpXADtNUEdYpqn1g7wRS3rlDE/3MppGaa5SWxvnTFt+xUzxc1
         e1jaOjzbeWXiPXeZFaFfV7+//dVwm1PgKnX+va/RkyHnt1g7oCEKMkCh1AS1mV/e9jDj
         d5tw==
X-Gm-Message-State: APjAAAWJFkKDf8hCBIq2dEIR10OoGCfK3ES4dcL+9YTNGxY1aobfaQ/4
        E3/lAqoWG8QIolBZBF0Zgpl+OJrpOjk=
X-Google-Smtp-Source: APXvYqx0gLvWEhbMTLzzrkL6q9R4lrhcMYnTE7DBIVVpR3i108S562rbWSVXVk8/N66B1RqZlDNrEw==
X-Received: by 2002:a50:c8c3:: with SMTP id k3mr104612123edh.189.1564562610164;
        Wed, 31 Jul 2019 01:43:30 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id e14sm135970ejj.69.2019.07.31.01.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 01:43:29 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id 31so68735309wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:43:29 -0700 (PDT)
X-Received: by 2002:a5d:568e:: with SMTP id f14mr51213275wrv.167.1564562609364;
 Wed, 31 Jul 2019 01:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190731071447.9019-1-stefan@olimex.com> <20190731071447.9019-2-stefan@olimex.com>
In-Reply-To: <20190731071447.9019-2-stefan@olimex.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Jul 2019 16:43:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64tzMypnB5Ho2A-gWPk2yYsmH9tNn+OKfb51c+d6pK=kw@mail.gmail.com>
Message-ID: <CAGb2v64tzMypnB5Ho2A-gWPk2yYsmH9tNn+OKfb51c+d6pK=kw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvmem: sunxi_sid: fix A64 SID controller support
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:15 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>
> Like in H3, A64 SID controller doesn't return correct data
> when using direct access. It appears that on A64, SID needs
> 8 bytes of word_size.
>
> Workaround is to enable read by registers.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

And for single patches, you don't need to write a separate cover letter.
Just put whatever you need to add after the "---" separator.

> ---
>  drivers/nvmem/sunxi_sid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index a079a80ddf2c..e26ef1bbf198 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -186,6 +186,7 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
>  static const struct sunxi_sid_cfg sun50i_a64_cfg = {
>         .value_offset = 0x200,
>         .size = 0x100,
> +       .need_register_readout = true,
>  };
>
>  static const struct sunxi_sid_cfg sun50i_h6_cfg = {
> --
> 2.17.1
>
