Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6819C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64049218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dMxOjhEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCOVk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:40:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37819 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfCOVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:40:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so9654840otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXqZ3fs1h8bFlT1FjQbn+ruBhiy5pxGvGGkBrL+ziZ4=;
        b=dMxOjhEk4RHLmzSLE4lQTZVgN11etrEKqGOjwq7KGk0+9pFT1XdWQWKMoagGEBE4QJ
         9+rwbp0Kyt5hGZhLO7RGq7P8CSKi7A2yb9oD64GPfFfppft4S1pggMfrVbrqk0ejdu1u
         a24bqDOpDx0fCMzM49D6jrAyV8ZdHDP3zX9cM8gaFTEK42No70VIVDJ+sLg+i73+P6Zv
         ZlURBoT1lveOyWzVvHXhHSccRuRRez3S5JRF8gQtagiHwVW7CcznUUDaxaMJtOmvBMJR
         jMLMfqAifqnNSndc+XYGqz64aLjWDj3EV8RatIVhxbggRNOllYFiYVR9rZgmUlL8js+L
         OVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXqZ3fs1h8bFlT1FjQbn+ruBhiy5pxGvGGkBrL+ziZ4=;
        b=O1PCEYWGzod80w47CGh4SBMxnJFoKPojc85zK6PAR1RQ4qXsD0LaUn7DOfNpMayjWL
         Q2i27f3jUueWBuj5t+/nLaJJxTupJ2rhqeN9MdKOqIRFID0dl2szf1x4XYgJZH/5ysqJ
         Cf5NJWkRcZT7TYMn+9zvMLAJeykefyngQ5Uzuorytfd6hQyKB7nq04Csz+UBgnNB92a0
         TpvmhQsCPj6DAFUuvOfbfhNEsKPHudy4U/zY8hfMLk0vwnx3tb9GGJ4NDEqK7cZdliSP
         t5ESerZVNanlugktDnkGgOjm3RukEdt9omuJS3ZwS9LvvXlsaga6d/t/c42PSVp+vbJy
         OW0A==
X-Gm-Message-State: APjAAAV7aZLTzwwnmFJH9p6BnOKT3QEfvu4OPY621Ugc+6z50cAn2p17
        mKX1LxnE+UVQSnpJ/2I0Q86QHTvjjhDuiBmhR8nuO6bN
X-Google-Smtp-Source: APXvYqzhENjss0YqPjw6E+53BtdMWijwJrgAvTppAV+nr8GYJkrBNwx5gy52zaEakYjdXus+2Mjx3oa5ieJR8DP/umg=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr3433830otk.86.1552686057744;
 Fri, 15 Mar 2019 14:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-9-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:40:46 +0100
Message-ID: <CAFBinCBC8OcGRSdNTcqPzH6jbWiO1J_9+BcmZmpSJ+uVTjrHUw@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: meson: g12a: Add G12A USB nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the nodes for the USB Complex found in the Amlogic
> G12A SoC.
>
> It includes the :
> - 2 USB2 PHYs
> - 1 USB3 + PCIE Combo PHY
> - the USB Glue with it's DWC2 and DWC3 sub-nodes
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +                               g-tx-fifo-size = <128 128 16 16 16>;
I'm not sure about these values but it seems you have already successfully them.
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses the following
values (which are identical to the ones on GXL/GXM, but using the
values below I couldn't get dwc2 to work on GXL when I tried it last):
  dev_tx_fifo_size[0] = 128;
  dev_tx_fifo_size[1] = 128;
  dev_tx_fifo_size[2] = 128;
  dev_tx_fifo_size[3] = 16;
  dev_tx_fifo_size[4] = 16;

Thus I'm still giving my Reviewed-by based on the assumption that the
g-tx-fifo-size values you have are working (at least for you)


Regards
Martin
