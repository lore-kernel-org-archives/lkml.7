Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D0DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B2220862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEOHfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:35:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43211 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfEOHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:35:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so279807qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 00:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n0k/DOfSXPUPs6qYK5+autUkRQX+GLsSk+sDuHBK6Q=;
        b=EOCtLZP0keg8xYpvw2DxffGZxVROcdT9nbI1lEwcvZQBRyPfrsC1SFhdP02RQgyR2A
         inn5McuSJqxb822IZJmWMeyodim5v8qvOn1uPJbtLSkUrFqKC2AjTr2H8Von5RqGXYs5
         fAGm4O7zuCXeQmfsV1HGXi9d0GEWp+mlWumL9VZmY9Z7SZ6hRW7larmdbl0yfPCM+/X0
         He2as5AB+SMbIj14AmaDazpTNbCqv1QETYmZP3fq5RpAzQs2+O9zEyjqnyN2EB31or0r
         06Tg5TLAnGo23RXEsA0m/sewoVSi6A5t9AoAGZxLOAgWekhSoD6Y6P5AxK+7f2f0hUjA
         Ordg==
X-Gm-Message-State: APjAAAWQ1fUa4Sn+b9i8y0fjeadYej5DwW7MvlLEQHecMITAzEgiL7Os
        w08cruD4s7VQsMuPLTw4o+oVRXBZAIfGnZp1aFY=
X-Google-Smtp-Source: APXvYqz/qoyJMx2JksefFN705eSKGcHcnLGYAXsYNfHRl97ONMRpsWGqlQqZlsOJ3MFlEgItyb75JvPlg0pYIdF5p1U=
X-Received: by 2002:a0c:980b:: with SMTP id c11mr32876068qvd.115.1557905700248;
 Wed, 15 May 2019 00:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
In-Reply-To: <20190512012508.10608-10-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 09:34:44 +0200
Message-ID: <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
> +                              u32 len, bool last_tre, bool bei,
> +                              enum ipa_cmd_opcode opcode)
> +{
> +       struct gsi_tre tre;
> +
> +       tre.addr = cpu_to_le64(addr);
> +       tre.len_opcode = gsi_tre_len_opcode(opcode, len);
> +       tre.reserved = 0;
> +       tre.flags = gsi_tre_flags(last_tre, bei, opcode);
> +
> +       *dest_tre = tre;        /* Write TRE as a single (16-byte) unit */
> +}

Have you checked that the atomic write is actually what happens here,
but looking at the compiler output? You might need to add a 'volatile'
qualifier to the dest_tre argument so the temporary structure doesn't
get optimized away here.

> +/* Cancel a channel's pending transactions */
> +void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
> +{
> +       struct gsi_trans_info *trans_info = &channel->trans_info;
> +       u32 evt_ring_id = channel->evt_ring_id;
> +       struct gsi *gsi = channel->gsi;
> +       struct gsi_evt_ring *evt_ring;
> +       struct gsi_trans *trans;
> +       unsigned long flags;
> +
> +       evt_ring = &gsi->evt_ring[evt_ring_id];
> +
> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> +
> +       list_for_each_entry(trans, &trans_info->pending, links)
> +               trans->result = -ECANCELED;
> +
> +       list_splice_tail_init(&trans_info->pending, &trans_info->complete);
> +
> +       spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
> +
> +       spin_lock_irqsave(&gsi->spinlock, flags);
> +
> +       if (gsi->event_enable_bitmap & BIT(evt_ring_id))
> +               gsi_event_handle(gsi, evt_ring_id);
> +
> +       spin_unlock_irqrestore(&gsi->spinlock, flags);
> +}

That is a lot of irqsave()/irqrestore() operations. Do you actually call
all of these functions from hardirq context?

      Arnd
