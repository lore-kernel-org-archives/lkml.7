Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191BE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfGaSuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:50:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38273 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfGaSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:50:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so51547512oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvWn80+U0LvGvvaofUboozNKhaUOBnRMvh7GiRVlCRc=;
        b=Tj15nJgVV2eyPKVrnm9L2nQS05kqgIesTLFTZx8Vv8arDbdPqV+bYt8WLUdWb7nzxD
         A2mD84TfumuFDvmFHpEdlv2xFe+sIAgq4pQpb531peHSPxJ5l5HaMc5YNcR8nWNLmomk
         /QKaj50gjM/1PptPSVlyFLySyQNIKLhZ8gFCgNOTD4YCwHTKUBYwhA/ljw+3Y7PKASF0
         +hlTRXZlEgBNDk0OeWWpX9S+75arOO/jAfqzsq6uopVubyiv8EP8suMqJ4lohzFIOOlN
         hk3JGW1kfr5fMS+uESOeitFKVJw6dFpQV6Y/tcLJOFbzFUxL4ULIuZyu5ONbXCgQNUt1
         O/IA==
X-Gm-Message-State: APjAAAU+EHQh7tUXD+3Huq6Jk0/Dpoxh9kEXq6c1sbSOA2v7jQmW8viw
        aY3Nn3DsnPdE5AMS+noB//J7ri+p
X-Google-Smtp-Source: APXvYqzZI7PqPpJXo/6JsV6zcR74RSIRDGWBDr000XhfoM45nxwwSoHxoZZdx9HlQs8aFsTGDMsblA==
X-Received: by 2002:aca:4a4e:: with SMTP id x75mr59556789oia.154.1564599037531;
        Wed, 31 Jul 2019 11:50:37 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id x19sm23427507oto.42.2019.07.31.11.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:50:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id t76so51582813oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:50:36 -0700 (PDT)
X-Received: by 2002:aca:bb45:: with SMTP id l66mr59857756oif.108.1564599036402;
 Wed, 31 Jul 2019 11:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-41-swboyd@chromium.org>
 <20190730183503.GX7234@tuxbook-pro> <VE1PR04MB668744C680C7AC2498AE9A478FDC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <5d40b871.1c69fb81.94f40.c465@mx.google.com>
In-Reply-To: <5d40b871.1c69fb81.94f40.c465@mx.google.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 31 Jul 2019 13:50:25 -0500
X-Gmail-Original-Message-ID: <CADRPPNTZEemXv1a8oFq8OVUVUygo5RFRhECiY_Onz8A5wBEZAw@mail.gmail.com>
Message-ID: <CADRPPNTZEemXv1a8oFq8OVUVUygo5RFRhECiY_Onz8A5wBEZAw@mail.gmail.com>
Subject: Re: [PATCH v6 40/57] soc: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:01 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Leo Li (2019-07-30 14:26:01)
> >
> > The patch looks good to me too.  I can take it through my tree with your reviewed-by.
> >
>
> I split it for you just in case you want different patches.
>

Thanks.  I will take the fsl/nxp part only then.

Regards,
Leo
