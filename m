Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB44C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4BE213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCM5IHx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfCFK65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:58:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39719 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfCFK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:58:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so9951623edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lgpO6Nc3rni5EmlwzR6zMwCapbBbmxD/kLh39iky6A=;
        b=bCM5IHx0ckrPyZj4A+iDvAEUWOtnHcZyOqoXsqk7aKHk5A/60rqAVhPQhGXvOk26i+
         NSzNkQIP78O6sidlRmIYGt+wlgX6wpRu4I5N6093eCgBOU1GANiRpz1SDMtZKNJgMF8N
         yMMWOzJ/h5GsU4MclwWD7+jWKEJLG5mAhqsSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lgpO6Nc3rni5EmlwzR6zMwCapbBbmxD/kLh39iky6A=;
        b=RO1xLNez/2yvh+bnJhXDLxOiunwY5gNPUnMcrGr54WrMkiHHhAaaayduG1KIqpV63d
         Q5igjKnGuE4quj/YnJkSdX/h79PwniunA3P41yOd83OgboQV3z0gZQqrSEZ9KaW2TOYN
         NgGqaODadQ8cqCdiv2yxks7v378wBsYU5oS0tD2sMvSQNnhAqlfAlhFyro9aZzYGCIwH
         X+MW5/NCHKS/ErasHO4Q6DnSE8inGvjalxjb3Wn3uyEqL4QZ/BGrZSHEHdce2QJCboUu
         ugcdY5wjlKsUJEbFhly5LujZAehNiy6+GQQ3ADB8pjfxXzu+830gd7U48H15OyaY7iMe
         aKRg==
X-Gm-Message-State: APjAAAUYCxYHdokeN7KOb9/ZlbSQ4OEIrJfNFsS8xl6eH+wbbtGrPbwi
        HkFvSf8WKtxjern6ELzaLqzDJVfQEBH3miO5iNgVrg==
X-Google-Smtp-Source: APXvYqxbEE4NpLGuyqvbsTXXRwPGyh+R5XuBq1A5NYE1h+XYTJ2EWiLjNZfx1cqgN1yrYpGb9aBrD/NTYgPDHxlq8pA=
X-Received: by 2002:a50:bb21:: with SMTP id y30mr22432999ede.156.1551869935168;
 Wed, 06 Mar 2019 02:58:55 -0800 (PST)
MIME-Version: 1.0
References: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com> <1551865835-50974-9-git-send-email-bibby.hsieh@mediatek.com>
In-Reply-To: <1551865835-50974-9-git-send-email-bibby.hsieh@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 6 Mar 2019 18:58:44 +0800
Message-ID: <CANdKZ0cBRfSjS021waSWB-RE6PPBt+ZpvnZmVWABgB8Y1nVe+w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] soc: mediatek: cmdq: add polling function
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, kendrick.hsu@mediatek.com,
        Frederic Chen <Frederic.Chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 5:51 PM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index d3873ab..71c167c 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -231,6 +231,27 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_clear_event);
>
> +int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
> +                 u16 offset, u32 value, u32 mask)
> +{
> +       int err;
> +
> +       if (mask != 0xffffffff) {
> +               err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
> +                                             CMDQ_GET_ARG_B(~mask),
> +                                             0, 0, 0, 0, 0, CMDQ_CODE_MASK);

All other codes use CMDQ_IMMEDIATE_VALUE instead of 0 for arguments of
cmdq_pkt_append_command. Also use CMDQ_IMMEDIATE_VALUE here?

> +
> +               if (err != 0)
> +                       return err;
> +       }
> +       offset = offset | 0x1;
> +
> +       return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
> +                                      CMDQ_GET_ARG_B(value),
> +                                      offset, subsys, 0, 0, 0, CMDQ_CODE_POLL);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_poll);
> +
