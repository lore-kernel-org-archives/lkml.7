Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131B6C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B79205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY0A99wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFZCRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:17:46 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40504 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZCRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:17:45 -0400
Received: by mail-yb1-f195.google.com with SMTP id i14so435549ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKNSTMowmRk3RkH/jcMvNDg+7Zu5bOsgngVeZGPE5Q8=;
        b=eY0A99wxkmneSw3ebBgb5whYrrPrAoGKxDfaWS3HcYMmutSOo1BH8nElIh41fZwBcD
         NwbVKrWfUvloOlQBGbMYUmhlFpV0RDV3KTes3kOXeIVwySVLujVm4OtqFcre7KKpfq/R
         D7G7dqEy6MSdABObz7svw3zakl/5/mjk7tvkyvGIWAA/cbwPg+//VTklgB0tRo1JkbFm
         7xkZFduPNqi/xRZSkxAx9H4pVVa24jOalHkwUs3GJGqmBtCST7x2tR0RXkBwf/ylqVuf
         IVXxxVoWHNndpMXYBHfCH/0w8BLAZzQ1S2BJ1yjwfCRh9Hmv9akNOAelzJl8IEVCY7xD
         uePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKNSTMowmRk3RkH/jcMvNDg+7Zu5bOsgngVeZGPE5Q8=;
        b=Dz71iBtdy2DBo8VYTF8BkAqzpm+UbiZ60NoQ65HMTNxWwGw9FmHiMjjK2gT66jQM2J
         i6hiNBSi+wsm2yvYhZ1ox+MZ3zZgZCuTw244lPTMbkNDG+P1QxzSAwTSwniEULsXGwwN
         ROWGz73cLpCv+twRiy7zzoBYTWDh55GIcaHDT3mtESNngM0rXrasD7ywdEVeqpwn9xSU
         wlqoRy5WX1vOUReyul6YToepFly/dPxMN8lHydUPB1MhxAkwS+ZxCKLzncoBgSli/osE
         aq74GTH31Jw8SdPgcCDxXDeNsA2KJanvO2OFzYIYpFJZ625X8tmntXXg0ErViH60Nqof
         8PnQ==
X-Gm-Message-State: APjAAAVqvtfsSJd2ImRLKNO20wS2pwvm3T3Uk29feZadlNIyNkaDskKC
        9CjGkwyXW3Btf7pzJVYGyr/ag4DM
X-Google-Smtp-Source: APXvYqwDspNSdPoJgwqmIEMj9DtaPrnG1jf/+52sfCgtT40gc0IXoe/rLNLInS6130uh5xIyK5h05g==
X-Received: by 2002:a25:6ac2:: with SMTP id f185mr1118036ybc.347.1561515464391;
        Tue, 25 Jun 2019 19:17:44 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id e12sm4315645ywe.85.2019.06.25.19.17.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:17:41 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id 186so318989ywo.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:17:41 -0700 (PDT)
X-Received: by 2002:a81:7882:: with SMTP id t124mr1124280ywc.494.1561515461099;
 Tue, 25 Jun 2019 19:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org> <20190625175948.24771-4-ivan.khoronzhuk@linaro.org>
In-Reply-To: <20190625175948.24771-4-ivan.khoronzhuk@linaro.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 Jun 2019 22:17:03 -0400
X-Gmail-Original-Message-ID: <CA+FuTScQ2WdEqQpsCdM_KZK9e+Zq7v5B+x=HLthxLAyOhYu-zQ@mail.gmail.com>
Message-ID: <CA+FuTScQ2WdEqQpsCdM_KZK9e+Zq7v5B+x=HLthxLAyOhYu-zQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 3/4] net: ethernet: ti: davinci_cpdma: return
 handler status
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     David Miller <davem@davemloft.net>, grygorii.strashko@ti.com,
        hawk@kernel.org, brouer@redhat.com, saeedm@mellanox.com,
        leon@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        jakub.kicinski@netronome.com,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:00 PM Ivan Khoronzhuk
<ivan.khoronzhuk@linaro.org> wrote:
>
> This change is needed to return flush status of rx handler for
> flushing redirected xdp frames after processing channel packets.
> Do it as separate patch for simplicity.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

> @@ -602,7 +605,8 @@ static int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
>                 else
>                         cur_budget = txv->budget;
>
> -               num_tx += cpdma_chan_process(txv->ch, cur_budget);
> +               cpdma_chan_process(txv->ch, &cur_budget);
> +               num_tx += cur_budget;

Less code change to add a new argument int *flush to communicate the
new state and leave the existing argument and return values as is?
