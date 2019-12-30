Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FDDC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4899F222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljUmIFIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfL3D2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 22:28:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46119 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfL3D2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 22:28:17 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so26845775ilm.13;
        Sun, 29 Dec 2019 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gSpV16gqUugWiREKjeRqrw8NqwpDXSNtuIvz7v7i9E=;
        b=ljUmIFIw0TpKNbfOsZzPy0594sjYu/WDS2ogd7eV+SZZ16rOMs8kMTDMp6r6z/HcDC
         gqeF9js1oULvAa9uPuKoajyItsjEtWIyVR5bWaYyUdJ6TJCtRwzq4+RZVsJAoLwTgmCe
         ULropm0NWnpv5zpmOeO+HeH1QR+jfN9rvbHK1upIzD+IeCFoYPpaQIq080RnM95H2VwG
         TqqF12ZBn8tHuciOJ2AXNUyop1HJqJacA0AgEg+pthBgH0U4qE8OnMLggownEhd75RHg
         8ltU/kKIbQzSd85SF6xHDqt6XgBdTXu0malc/i+gHCoLM+Bkv2aHzp4g+/NbaLl2cqwE
         2fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gSpV16gqUugWiREKjeRqrw8NqwpDXSNtuIvz7v7i9E=;
        b=N1I9eg27O08XzFzVQ/o7vFqIKqDyPv8a+JG//EYzmkzl1GT/BStW5HsFjH9t/h/dvO
         Ynr33qAXVCm2EkRx+7mFaIB4QunFHDZooKAaB2GRPLCwRZgEYabuD9/iDa6XAGD8jNOT
         0CaAW2yrqgSQyB+pCqLSybuOKHk/dVOUaXv+TJz1ivPjsbODhI6q79fzg6+kN4TS+ZGd
         9jNXDFS+UK/EzxlCq0kqEqqjhH8iZibpuL7hP1flwjtbBsKleCc+qINdJOmkGZG0xCjP
         Ld9P8N75LGhLRyNXcMCG73X2BO9oqRTAof+Vr6mI3uVnFeFKbKThrCnBzKnMHB3018BA
         amTw==
X-Gm-Message-State: APjAAAWRDPcxlHNtL/BsTBtor7+HF6wsmRCeK7HmLp3NIg5MT/giGjr1
        8fVy8sJDvXHvN1yGvIaCV1hJtS62TkW8AHumQ/c=
X-Google-Smtp-Source: APXvYqyQZm4ZquKEMpBoMyD+GpdMoP23S7ymcucZjFHMEh+UdO/8w5BBcW4WhKQqF8cH3yxedUvYcOX8n0XBNCAgQNA=
X-Received: by 2002:a92:84d1:: with SMTP id y78mr55495168ilk.69.1577676496461;
 Sun, 29 Dec 2019 19:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20191121072910.31665-1-bibby.hsieh@mediatek.com> <1575426135.31411.2.camel@mtksdaap41>
In-Reply-To: <1575426135.31411.2.camel@mtksdaap41>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 29 Dec 2019 21:28:05 -0600
Message-ID: <CABb+yY2w_h-weh15hFkGuC-b7XLYrvkT7QVkkj1u6uS99qOnrg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: avoid racing condition with mutex
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 8:22 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Jassi:
>
> Are mbox_send_message() and mbox_client_txdone() thread-safe? If these
> two are thread-safe, this bug should be fixed in mailbox core not
> client.
>
mbox_client_txdone should be called only when the client _knows_ the
message has been sent.
There is difference between knowing when tx is done, and assuming
tx-done because there is no way of knowing it.
Your issue arises because you immediately call mbox_client_txdone
after mbox_send_message, which may be the only way to do it but that
doesn't mean you shouldn't have to take any other precautions (like a
mutex). So I think your patch is reasonable.

Cheers!


> Regards,
> CK
>
> On Thu, 2019-11-21 at 15:29 +0800, Bibby Hsieh wrote:
> > If cmdq client is multi thread user, racing will occur without mutex
> > protection. It will make the C message queued in mailbox's queue
> > always need D message's triggering.
> >
> > Thread A              Thread B                  Thread C              Thread D...
> > -----------------------------------------------------------------------------------
> > mbox_send_message()
> >       send_data()
> >                       mbox_send_message()
> >                               *exit
> >                                               mbox_send_message()
> >                                                       *exit
> > mbox_client_txdone()
> >       tx_tick()
> >                       mbox_client_txdone()
> >                               tx_tick()
> >                                               mbox_client_txdone()
> >                                                       tx_tick()
> > msg_submit()
> >       send_data()
> >                       msg_submit()
> >                               *exit
> >                                               msg_submit()
> >                                                       *exit
> > -----------------------------------------------------------------------------------
> >
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-cmdq-helper.c | 3 +++
> >  include/linux/soc/mediatek/mtk-cmdq.h  | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > index 9add0fd5fa6c..9e35e0beffaa 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -81,6 +81,7 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
> >       client->client.dev = dev;
> >       client->client.tx_block = false;
> >       client->chan = mbox_request_channel(&client->client, index);
> > +     mutex_init(&client->mutex);
> >
> >       if (IS_ERR(client->chan)) {
> >               long err;
> > @@ -352,9 +353,11 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> >               spin_unlock_irqrestore(&client->lock, flags);
> >       }
> >
> > +     mutex_lock(&client->mutex);
> >       mbox_send_message(client->chan, pkt);
> >       /* We can send next packet immediately, so just call txdone. */
> >       mbox_client_txdone(client->chan, 0);
> > +     mutex_unlock(&client->mutex);
> >
> >       return 0;
> >  }
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> > index a74c1d5acdf3..0f9071cd1bc7 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -28,6 +28,7 @@ struct cmdq_client {
> >       struct mbox_chan *chan;
> >       struct timer_list timer;
> >       u32 timeout_ms; /* in unit of microsecond */
> > +     struct mutex mutex;
> >  };
> >
> >  /**
>
