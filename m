Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58974C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C23D21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLE0oo5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfGSHc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:32:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38566 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:32:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so31209407wrr.5;
        Fri, 19 Jul 2019 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf3Z5Db1yz+0z1tr8VMjazLVeMcit8uK7umZ1IwIpvE=;
        b=SLE0oo5QSzQIP95QmV8vZvQn1KRcaWlbCpvXzONJ4/CeRcVKNOqqgxoFJZUmr88bN4
         SUQ+CSvxA++ejAB6PFDy7iY1pqyC7eUPd7rYGqB8DmhJncjBJnJCrquGzuMiNtvBU/7Q
         ky/pBrRv4pPD/LSVipCIlhHwXKkbclKmn0BCNhbugBfyEzObDonHdIPgry1LK90+nsdD
         FQus/g6DE2FqYVFcQRBSWxquPoz8YoqXVciAJ6HhcC4X4WvZhp38c7BB3sSx1BH9ylb9
         feEDLKnC9SrMapkFGLHfIToKVFCv46q2bi3p3BXQyLWoRWVwS/9mLdb/GeTQCCU8PgcT
         6+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf3Z5Db1yz+0z1tr8VMjazLVeMcit8uK7umZ1IwIpvE=;
        b=VgtugEC+Qid+tXo+hVjj9hYFO0FwnE9135h8e1rS7ciHGkRWOAAhd9AV2VP9N+B4vE
         Q7ssfeSqBQTqb1WJvT47HXrPSLKM2AnIFo9AiqK3nDKIcj1ZxD5Dq9H/Hh3id6hYzF8S
         g/ok3huYzyglZtpHoF6eR4b9CJTFpHpCAvDyO1gF+M4MBG3J3otXVDV4xjy/KMjtUA5+
         qh5Pb3+gaC1MM2IurSM8ZtvZV79HvG1dvsTeiYu+gmnzkpo/bJIBPhx1oSuwQ7P/PApS
         Ddz7aR0z1hgRlKw5HY4KJdSECwZ6Xrtu2AjMsRAq5MvWQsQh7Wo/KbNXu4u7HYxW19Xf
         l+vA==
X-Gm-Message-State: APjAAAX5ZITOW9qKXVlsJqouFBdv2TZs/U6qyosRan5DvJEWO1ltEjOJ
        /3mPDXJ6kSnAE7DkkmhtI7lIicsS0mzgh29PH78=
X-Google-Smtp-Source: APXvYqxR9/WsFLxqc7cvzJhK1urFpGl4gUB4HAwVzSC1fDeD1++buc2QQSGtK15wBHAhYaYamjbSOAR6gsjJ8ZcFoo4=
X-Received: by 2002:adf:f450:: with SMTP id f16mr23333290wrp.335.1563521544375;
 Fri, 19 Jul 2019 00:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190718151346.3523-1-daniel.baluta@nxp.com> <20190719070005.mkqvfhjras2jmo52@pengutronix.de>
In-Reply-To: <20190719070005.mkqvfhjras2jmo52@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 19 Jul 2019 10:32:12 +0300
Message-ID: <CAEnQRZC8D7MR08x_P19kmutN83Jo4wMkHySRhK702TSUHFDqiA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add DSP node on i.MX8QXP board
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Li <Frank.Li@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:00 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Daniel,
>
> thanks for your patches :) but it's quite common to bundle the driver
> related and the dt related patches. Can you add the firmware related
> patch to this series in your v2?

Sure. Will do that in v2.
