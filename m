Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC269C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DD220673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgAIISb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:18:31 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgAIISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:18:31 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MTAJr-1jGbKU2Cx5-00Ubeu for <linux-kernel@vger.kernel.org>; Thu, 09 Jan
 2020 09:18:29 +0100
Received: by mail-qk1-f182.google.com with SMTP id z76so5235754qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:18:29 -0800 (PST)
X-Gm-Message-State: APjAAAXQ+IJmsOfLWaJ6BNkcUAWfs9V/+xo0h8my6joOLhF3AH4zN1+O
        HgcPP7pz/ZmMNgZPvKH07loY5pu3XeboMEZFRMA=
X-Google-Smtp-Source: APXvYqwrLUeYgK37ZgRpSE5ftnQA149aKKqaEoy2+dBDh0yYplmE9JgRJrB0Wlay2W/JZAZoEkEavviGz+ak9iB2ijQ=
X-Received: by 2002:a37:84a:: with SMTP id 71mr8135294qki.138.1578557908396;
 Thu, 09 Jan 2020 00:18:28 -0800 (PST)
MIME-Version: 1.0
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
In-Reply-To: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jan 2020 09:18:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
Message-ID: <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:faoJOCT6VPW88U7YkCUj9SIyCncQ2kSW0EVw6GeFEm9kZqb2H3X
 KtPghap5IxUF+akp9FlAkm5rzoAy95vyIOcU8R1osS7DkZKOPB1IIFSk0cq8LLiR3HuqivG
 kMUxk8AeUQam071QW963jxLruqS8xC8i/TI9MNPogN1mYHm7qlhC6gTlDMJBhHfcG4NUYTl
 U33/7LlS+DhlzfR6h7E3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1XcUQYJb8Yg=:wJH5+9ywGzk0mjDt7JZUNZ
 NztvJwvaF+3o/GthxrTuNUAuR3MsqLJP9E/T1sqJWKGHlqrG9oeGO3ubNKZFxcsW1fxCtxRip
 MxiXlInHGZZbyyZ9wGqlyVG+hLpGByvVsfIvGxSqAOFQ6d274uZbjGaCWWuJCjRCiCV/qk+Pi
 LLEQ0lmWPKIeN0cXtil1RQ0hWWmGYxH9tihyxx7Ux6jpWL7Uk97/NcnEpdKFLuG0q8t8qExL6
 5LGElsAK6vuJsLlP6GN6iuR4zSlbLVW1h/upwpWRYewDs4aj4PMGg6yL/hwuPIRV2ubVcl6R2
 KpaYpTgfS/YIJtKUgzoIW2vY+FkusqSNl0fHcfcdiKWPmrFp6vAMHgDKGQh3WhF1gkum1UxTP
 2CUzbDo+b/rAyMhgsouDFDRYQCz9S157aeFiZl2qNGOiTpNabz1tV/OGaoGgGDCHgRCCeYDpN
 v04pslYVbMQE50MXAV2v4ZWeRSOGrgSirFyElS65WoZHdDZaFVgWxAVrrBm28kfu5Zj5Y6Qaz
 1AM019QbjwxsZvuypb7ineaBWAGSZuug5fLAMWwnH/5K0ZRgM2U1EN1JQ1o/rVUZJeU3k19Kx
 S2aAfucHaaS7lNl2b+0cJDaPiBLf9vZw5K76OQClduoRArGre4AIH9wYeA6RneqShPgvxs2k7
 mB985kf2UrH6mbMKgxdTWX1eiIvsjKBsrDIikCvSEjftksLFfIee31Q+6FMO7mOViqjcCBO3D
 MmahboUQkfs2xGtP2690dNWPzC4I4Jr07vz3vSMzdfBT5a+BzdMeixr3XOUso7PiUHg7By0SZ
 Htjf9lIgPONmKO2VxnsgMeM+RrySR7Ojk1LgybDoleSb2l9nmu0blya0EEPIvkxhB/z2jEVvH
 pgjcSCHZgk4pP7PzydnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Conceptually I think this is fine, but as others have said, it would be
better to have another transport implementation posted along with this
to see if the interfaces actually work out.

> +/**
> + * struct scmi_chan_info - Structure representing a SCMI channel information
> + *
> + * @payload: Transmit/Receive payload area
> + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> + *      channel
> + * @handle: Pointer to SCMI entity handle
> + * @transport_info: Transport layer related information
> + */
> +struct scmi_chan_info {
> +       void __iomem *payload;
> +       struct device *dev;
> +       struct scmi_handle *handle;
> +       void *transport_info;
> +};

I would assume that with another transport, the 'payload' pointer would
not be __iomem

> +static int scmi_set_transport_ops(struct scmi_info *info)
> +{
> +       struct scmi_transport_ops *ops;
> +       struct device *dev = info->dev;
> +
> +       /* Only mailbox method supported for now */
> +       ops = scmi_mailbox_get_ops(dev);
> +       if (!ops) {
> +               dev_err(dev, "Transport protocol not found in %pOF\n",
> +                       dev->of_node);
> +               return -EINVAL;
> +       }
> +
> +       info->transport_ops = ops;
> +       return 0;
> +}

This looks odd: rather than guessing the transport type based on
random DT properties, I would prefer to have it determined by
the device compatible string, and have different drivers bind
to one of them each, with each driver linking against a common
base implementation, either as separate modules or in one file.

> +static int mailbox_chan_free(int id, void *p, void *data)
> +{
> +       struct scmi_chan_info *cinfo = p;
> +       struct scmi_mailbox *smbox = cinfo->transport_info;
> +
> +       if (!IS_ERR_OR_NULL(smbox->chan)) {
> +               mbox_free_channel(smbox->chan);
> +               cinfo->transport_info = NULL;
> +               smbox->chan = NULL;
> +               smbox->cinfo = NULL;
> +       }

There is something wrong if smbox->chan can be be one of
three things (a valid pointer, a NULL pointer, or an error value).

I see this is a preexisting problem, but please add a patch to
make it consistently use either NULL pointers or error codes
and remove all instances of IS_ERR_OR_NULL() from this
subsystem.

        Arnd
