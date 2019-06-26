Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8541C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88CD2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Y7nsmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFZS1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:27:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40131 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:27:53 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so3838877ioc.7;
        Wed, 26 Jun 2019 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZfM3WNDDF9GuJKzE5mdCdSAtOo3TH52oJkX/nrxJjM=;
        b=G0Y7nsmQdmW7klneIUIoJ3Pb5aD5br9jJpfpTuL41AlhhjSMaEA7NKcN4FNTP9Czmp
         iIi1g/Nlh0hIndZaxk6sMXCEURxf+fu+VVScYvY5NPC8vsmxpwPvO2Icji+7q3XU2HZv
         LHYILL5lIS3+YS3tWTQV1cP2q3uq89/TCwggdyXJZRuvnDEz5aDusH47p58E38okLekG
         lcRHbFfvQUxi4rLpaLJKmzu8CJNO+n1BA8YBadPMmgD7HY17iB0qwEiwRt4QRzVKfYMl
         nkPAvI0uw1BYCNrxP1mqMjTe850DG5MSSw0ncRFAmHr3/uLI/jfBgxZhYLjTENWtjirM
         dvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZfM3WNDDF9GuJKzE5mdCdSAtOo3TH52oJkX/nrxJjM=;
        b=jdrPNlJ5tGb1EyfQ9xnWq5TJGGn0/g8Parc9TEWwEGwCz6JqWy/NJ62acDK69cvqXR
         rm01TE/l+11iOTTACaytRZ/sJN1w7uP3D1SioVU1iDcEGziCLxF0ZWsp/XEhTAr9ZUIh
         CLVuuB5V449G1bMXRctqhW9kl3wMzAEPL4htMAWU7MgIRgoIK+yWPZfj04qIDnVYHzz4
         zaN8rbAyWGwQABUA/6RC/RtQ3qkpanYHlh2ccw4ypfHtZd7GFhOlUVLymhk7JIIh7J6O
         4Qmw7VqaKYnrpANIBxLtG2xNPLTdhZpfGoiPhw3GM3Z4NfTsmboQEcFHrrjUXfBYw8EH
         JNQA==
X-Gm-Message-State: APjAAAUywvu1jNYQhdDbv0lzb4+LDs4QSORQQbkhGjw9tNnV7N3TrerB
        jPO5aA1ZPN7LJJRzW8QoK06jx4ZbdLKYs4mSYMs=
X-Google-Smtp-Source: APXvYqzICV2CVaS0x99+KU5be+tDhkjLlvc37tKr4vvOVEWKczPXIXw4jK2QjINe4XC+jyYlQ7NLHLeaSXSzULDIjX8=
X-Received: by 2002:a02:c492:: with SMTP id t18mr6474836jam.67.1561573672517;
 Wed, 26 Jun 2019 11:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
 <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
In-Reply-To: <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 26 Jun 2019 13:27:41 -0500
Message-ID: <CABb+yY2B_bGqZhd3HRm2qOwGNXG8UYvRo0_uBmwGbx_1gA-vfA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 6/26/19 6:31 AM, Peng Fan wrote:
> >>> The firmware driver might not have func-id, such as SCMI/SCPI.
> >>> So add an optional func-id to let smc mailbox driver could
> >>> use smc SiP func id.
> >>>
> >> There is no end to conforming to protocols. Controller drivers should
> >> be written having no particular client in mind.
> >
> > If the func-id needs be passed from user, then the chan_id suggested
> > by Sudeep should also be passed from user, not in mailbox driver.
> >
> > Jassi, so from your point, arm_smc_send_data just send a0 - a6
> > to firmware, right?
> >
> > Sudeep, Andre, Florian,
> >
> > What's your suggestion? SCMI not support, do you have
> > plan to add smc transport in SCMI?
>
> On the platforms that I work with, we have taken the liberty of
> implementing SCMI in our monitor firmware because the other MCU we use
> for dynamic voltage and frequency scaling did not have enough memory to
> support that and we still had the ability to make that firmware be
> trusted enough we could give it power management responsibilities. I
> would certainly feel more comfortable if the SCMI specification was
> amended to indicate that the Agent could be such a software entity,
> still residing on the same host CPU as the Platform(s), but if not,
> that's fine.
>
> This has lead us to implement a mailbox driver that uses a proprietary
> SMC call for the P2A path ("tx" channel) and the return being done via
> either that same SMC or through SGI. You can take a look at it in our
> downstream tree here actually:
>
> https://github.com/Broadcom/stblinux-4.9/blob/master/linux/drivers/mailbox/brcmstb-mailbox.c
>
> If we can get rid of our own driver and uses a standard SMC based
> mailbox driver that supports our use case that involves interrupts (we
> can always change their kind without our firmware/boot loader since FDT
> is generated from that component), that would be great.
>
static irqreturn_t brcm_isr(void)
{
         mbox_chan_received_data(&chans[0], NULL);
         return IRQ_HANDLED;
}

Sorry, I fail to understand why the irq can't be moved inside the
client driver itself? There can't be more cost to it and there
definitely is no functionality lost.
