Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C06B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoKkx8lK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLaPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:32:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35034 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:32:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so35523836edv.2;
        Tue, 31 Dec 2019 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q46sgyzFCoqZCnDvkjuU+q1N3qAm1ojvKT53GL9XfFI=;
        b=SoKkx8lK10byoSOJpNl6uxfWB0HCqCbEDA9WDSUAIPDUly7zMzwsXjtIEwtX/NQsCK
         gwsPrha6BEhiaEHw9jJhuUdkaploQVhAy2ln5ukw12SKqh/hOV6c8BNpzDbWMzI/9C57
         /6V8tgzMmn8dJgRwUc/rzm4bOBA39qrDTi/FWW2UrdLTUSrvPrCeFuyx7doV2ZCeitwz
         5f1B5ynkAz/M2pBJb3kjL36uhtXjFDmrGrpuEdu7hTfoMX1S8wYpSDsYdsE/Hp8uHLWH
         8rNBYs7V074V++WTh89g/4y4wHW7RQX7AqeqeJvI6TBM7fMu2rB1eAA2w9fIwFdAeZnw
         gx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q46sgyzFCoqZCnDvkjuU+q1N3qAm1ojvKT53GL9XfFI=;
        b=nUcbVV1UWpBIhWxlS48y6dgIVmM2L/06DCkF/zg960+ps1ZVbYvqZk+UaoDhVF5EaU
         WqlGmnU1dyYvMeWqG+Uz+cMvGBm9yFj543OBPaoi3JjG1mZflMtuGZXcc6PufZHKyiEh
         cBMxLyxQ9mUmXa+WVjtQgxWy4zEjrp6DNDrTovta92crV3DqMH+p8pOPcF+RVFwbLk7p
         Bb12HYgFns2KOvRd7Eivi1EqFStNYS1QLXnV9FOjyjmSwtwMujRXCf8A2XpM3aI4X6U5
         XPyfqeksBdgCSTjcLuPDGfHkegJK1gOv9ulj7U3UHIcDJa+uCXVgNSlbjQHumvVkOeZK
         JcqQ==
X-Gm-Message-State: APjAAAVLdYr8N87ia9yZfwaw5olMUWTvWTME7E+rkrYp+kPMOx0Aia7t
        hxnD5Jbyu5gwqwkdXWrXIMIj1rU/ss5KbU2/jUE=
X-Google-Smtp-Source: APXvYqzQloGOdbtCaSjT2mVsGVV5HxAwcWBjMQNtw4CkqOonMP0cX7iFD+FAOQl9Yi3PaCr71gLtv6WZ7zehEa70JJ8=
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr69858873ejd.70.1577806354952;
 Tue, 31 Dec 2019 07:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20191230143028.27313-1-alobakin@dlink.ru>
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 31 Dec 2019 17:32:24 +0200
Message-ID: <CA+h21hq95SmS3BraUQeEytP+3Y7irmShBEwpXqqJv+xOp4ePrg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 00/20] net: dsa: add GRO support
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Matteo Croce <mcroce@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Paul Blakey <paulb@mellanox.com>,
        Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, 30 Dec 2019 at 16:31, Alexander Lobakin <alobakin@dlink.ru> wrote:
>
> I mark this as RFC, and there are the key questions for maintainers,
> developers, users etc.:
> - Do we need GRO support for DSA at all?
> - Which tagger protocols really need it and which don't?
> - Does this series bring any performance improvements on the
>   affected systems?

If these are these questions for maintainers, developers, users etc,
then what has determined you to make these changes?

Thanks,
-Vladimir
