Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CEBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271C821907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEr/t5Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfIRNcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:32:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39245 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfIRNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:32:09 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so16148033ioc.6;
        Wed, 18 Sep 2019 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZFdNYiiGOjgcmbWDBqcSFS+4Hig0B1106x65CqCAe8=;
        b=AEr/t5PwUUa7Z2j94wsWLg4s12+ybS7o2UbrCX7BIr4WnGnmn+abCrepKWbLvVstbM
         NxGuG5qbyM6a9ndPikrt8III7aA8u5SK5O7qsu/aDV0yv2FHqoGXRtvY6hnMe31iTriK
         BnXG6qOJuJq5JMWEenxhG/r7wmH+jnmO1G4D/modvpMYuY4pjrn/0PQHfidER6RjW+Bx
         vlBt0d8iSUiEhGMQ5Xt4bzYze2i+uOakAFd4OxSRSc9RXVhC8TRdPk3u3cAWnP4rTydi
         YWkYWNNLy7E1cAZ8DX2y9As4YkgW1mqXQCrKiWlLLhNJiAyDv2EtJf0vIuFr0tla1iRH
         OhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZFdNYiiGOjgcmbWDBqcSFS+4Hig0B1106x65CqCAe8=;
        b=TGce75CQGzkPCz3gUx1sRFoASmY+K6z6dmT6Qa0gQeD3joaaXjF5az81ITYxGUr8ZV
         uBdBdq9hooVSNvTUHnnD8mDj5egExuYbQaphTTMxAC1hIMculLrF9WkePW3l9rmLqhEN
         nifMuEl00M5wly4RhIFMhqs3wZz5rqv+4A6tw7yfpBOV7qy8tNx6LYlfFvV6peg/PZo3
         22wWSELciGyHe0FjtfFrO1r9bgXuyHX1YeLlRzcZ7jPtoxGK55Od5vgn4MB5iOMhLLpA
         K1urmHte99xXRAFks5VKuNJB01XvZgZP2b/1/TUuluHD9qtq/LLRI7fEslMsN54qNugY
         XyUQ==
X-Gm-Message-State: APjAAAVju+5VR87Q//VDeGo9QDs4+3j2Hx4c27KXc+ObplAHM3C1K1g0
        6HEL44kxz4IFQdQ6nvF/ql2Sy6C/Y+8l0wGG3iTNsdbh
X-Google-Smtp-Source: APXvYqyhmmpO+zwfScovtWC/EO5ycJuz7XFbwIJyPuUdqy4uCHzvGh0e69NMRgSuXeGCfrtoI6JS7ZbxLMjRcTRnTv8=
X-Received: by 2002:a5e:960a:: with SMTP id a10mr5386914ioq.87.1568813528689;
 Wed, 18 Sep 2019 06:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-3-git-send-email-peng.fan@nxp.com> <20190917183856.2342beed@donnerap.cambridge.arm.com>
 <AM0PR04MB44813D62FF7E6762BB17460E888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190918110037.4edefb2f@donnerap.cambridge.arm.com>
In-Reply-To: <20190918110037.4edefb2f@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 08:31:57 -0500
Message-ID: <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:00 AM Andre Przywara <andre.przywara@arm.com> wrote:

> >
> > >
> > > > + };
> > > > +};
> > >
> > > If this is the data structure that this mailbox controller uses, I would expect
> > > this to be documented somewhere, or even exported.
> >
> > Export this structure in include/linux/mailbox/smc-mailbox.h?
>
> For instance, even though I am not sure this is really desired or helpful, since we expect a generic mailbox client (the SCPI or SCMI driver) to deal with that mailbox.
>
> But at least the expected format should be documented, which could just be in writing, not necessarily in code.
>
Yes, the packet format is specified by the controller and defined in
some header for clients to include. Other platforms do that already.



> > > > +
> > > > +typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
> > > > +                             unsigned long, unsigned long,
> > > > +                             unsigned long, unsigned long,
> > > > +                             unsigned long);
> > > > +static smc_mbox_fn *invoke_smc_mbox_fn;
> > > > +
> > > > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > > > + struct arm_smc_chan_data *chan_data = link->con_priv;
> > > > + struct arm_smccc_mbox_cmd *cmd = data;
> > > > + unsigned long ret;
> > > > + u32 function_id;
> > > > +
> > > > + function_id = chan_data->function_id;
> > > > + if (!function_id)
> > > > +         function_id = cmd->function_id;
> > > > +
> > > > + if (function_id & BIT(30)) {
> > >
> > >     if (ARM_SMCCC_IS_64(function_id)) {
> >
> > ok
> >
> > >
> > > > +         ret = invoke_smc_mbox_fn(function_id, cmd->args_smccc64[0],
> > > > +                                  cmd->args_smccc64[1],
> > > > +                                  cmd->args_smccc64[2],
> > > > +                                  cmd->args_smccc64[3],
> > > > +                                  cmd->args_smccc64[4],
> > > > +                                  cmd->args_smccc64[5]);
> > > > + } else {
> > > > +         ret = invoke_smc_mbox_fn(function_id, cmd->args_smccc32[0],
> > > > +                                  cmd->args_smccc32[1],
> > > > +                                  cmd->args_smccc32[2],
> > > > +                                  cmd->args_smccc32[3],
> > > > +                                  cmd->args_smccc32[4],
> > > > +                                  cmd->args_smccc32[5]);
> > > > + }
> > > > +
> > > > + mbox_chan_received_data(link, (void *)ret);
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static unsigned long __invoke_fn_hvc(unsigned int function_id,
> > > > +                              unsigned long arg0, unsigned long arg1,
> > > > +                              unsigned long arg2, unsigned long arg3,
> > > > +                              unsigned long arg4, unsigned long arg5) {
> > > > + struct arm_smccc_res res;
> > > > +
> > > > + arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
> > > > +               arg5, 0, &res);
> > > > + return res.a0;
> > > > +}
> > > > +
> > > > +static unsigned long __invoke_fn_smc(unsigned int function_id,
> > > > +                              unsigned long arg0, unsigned long arg1,
> > > > +                              unsigned long arg2, unsigned long arg3,
> > > > +                              unsigned long arg4, unsigned long arg5) {
> > > > + struct arm_smccc_res res;
> > > > +
> > > > + arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
> > > > +               arg5, 0, &res);
> > > > + return res.a0;
> > > > +}
> > > > +
> > > > +static const struct mbox_chan_ops arm_smc_mbox_chan_ops = {
> > > > + .send_data      = arm_smc_send_data,
> > > > +};
> > > > +
> > > > +static int arm_smc_mbox_probe(struct platform_device *pdev) {
> > > > + struct device *dev = &pdev->dev;
> > > > + struct mbox_controller *mbox;
> > > > + struct arm_smc_chan_data *chan_data;
> > > > + int ret;
> > > > + u32 function_id = 0;
> > > > +
> > > > + if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
> > > > +         invoke_smc_mbox_fn = __invoke_fn_smc;
> > > > + else
> > > > +         invoke_smc_mbox_fn = __invoke_fn_hvc;
> > > > +
> > > > + mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> > > > + if (!mbox)
> > > > +         return -ENOMEM;
> > > > +
> > > > + mbox->num_chans = 1;
> > > > + mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
> > > > + if (!mbox->chans)
> > > > +         return -ENOMEM;
> > > > +
> > > > + chan_data = devm_kzalloc(dev, sizeof(*chan_data), GFP_KERNEL);
> > > > + if (!chan_data)
> > > > +         return -ENOMEM;
> > > > +
> > > > + of_property_read_u32(dev->of_node, "arm,func-id", &function_id);
> > > > + chan_data->function_id = function_id;
> > > > +
> > > > + mbox->chans->con_priv = chan_data;
> > > > +
> > > > + mbox->txdone_poll = false;
> > > > + mbox->txdone_irq = false;
> > >
> > > Don't we need to provide something to confirm reception to the client? In our
> > > case we can set this as soon as the smc/hvc returns.
> >
> > As smc/hvc returns, it means the transfer is over and receive is done.
>
> I understand that, but was wondering if the Linux mailbox framework knows about that? In my older version I was calling mbox_chan_received_data() after the smc call returned.
>
The code already does that at the end of  send_data

> Also there is mbox_chan_txdone() with which a controller driver can signal TX completion explicitly.
>
No. Controller can use that only if it has specified txdone_irq, which
is not the case here.

Thanks
