Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682482075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVDNCgPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfC1WwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:52:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39470 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfC1WwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:52:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so282640ljg.6;
        Thu, 28 Mar 2019 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l01MrjknVr/cfr706N/1WhyAYwKvnMacoKZSRvjh/Ac=;
        b=aVDNCgPwqwedJe3n3rdQmXu64mZBPaFvZkTCGPUd04eFxeWgyPYVGJwMh/GqKZ6ZkN
         g2ZVLmnPTfUsl5tOiyeH0Sz9xzUaoPgMqtvuk504aO+n3VszEQbizk5SZosvusLlneoj
         AICX9AvYMqEEdeKirfZWZq480h6RNj8u4HJavOhkHfvKj7NzM8L0Al7OSLiRrasqqrYG
         WHroCN9td2KVHq5fhE5lRNXO0n5s4Ehuem+3WR4BxpEZqzQuPkGdnAoebBuUJfxvPJMv
         UJByXVLAoNHOx2o74EgJMRLH2hb7RHEIE3c/Fizu7riGYOu11/uzwr3aKwXolUrpPq5M
         EXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l01MrjknVr/cfr706N/1WhyAYwKvnMacoKZSRvjh/Ac=;
        b=XR1NIPRdCyx3vZNxVhIAWNtnKvFdtuY/tNtIFtgsREnbQ7AvzbP6bI2D6uTzgKyI9s
         1K/SJSowAcJB8MLiWdNkvxwhp5/ulMEouctHC6VzBlAF4mQ5gWwUSsQIPyYYn49e6ywW
         xYwHKxfL6XfENgJhHecQRHaJJGap4Jy2/kSt8HZKvWU0ZEdOj9d46LI4Lc5A+wgRDoC4
         0WMsbtPIbKewMnhsjfVH9isdu7akTWgmz+QxzUv/kQtar1cZnQwmX88CPHfogaBX8/Km
         Gw+07/HmxxvjuP1Wa3l4X7SWWaEfQ3j7F8HDJEEgUR5q/VZDI6dH0nj7QtrEWXFiQcgI
         0g6Q==
X-Gm-Message-State: APjAAAXuJVE63xljdh7paiaG+SU4owC9Mg3KehNx4EdQhfQi4ZtD5dxg
        TP7NSO21psbYrSN3yPmHyN9yNv+ValOq4uIajfA=
X-Google-Smtp-Source: APXvYqz+6ytiwEBwiXDCrjXUfS3FZK20Fk6wDITNgH7B3/AFm+CM/GTdnVJQjjuvSlZCvmQ2XAkg57lpuMmWT8wvEnM=
X-Received: by 2002:a2e:899a:: with SMTP id c26mr24573397lji.192.1553813533790;
 Thu, 28 Mar 2019 15:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190328133828.20999-1-angus@akkea.ca> <20190328133828.20999-3-angus@akkea.ca>
In-Reply-To: <20190328133828.20999-3-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Mar 2019 19:52:03 -0300
Message-ID: <CAOMZO5DPHCReoQtYcRj01rETdF79sba+tHDJCSrVpCLbq4gW0Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] dmaengine: imx-sdma: Add clock ratio 1:1 check
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Thu, Mar 28, 2019 at 10:39 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On imx8mq B0 chip, AHB/SDMA clock ratio 2:1 can't be supported,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
>
> To limit this change to the imx8mq for now this patch also adds an
> im8mq-sdma compatible string.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

This has already been applied and it is in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190328&id=25aaa75df1e659901d77085bcdd25eaabf265688

Please send an incremental fix instead.
