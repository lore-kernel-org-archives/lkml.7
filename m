Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FA320700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf8o0ZIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfC0Qgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:36:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33472 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfC0Qgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:36:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so14619709edg.0;
        Wed, 27 Mar 2019 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bwWy+eLTxSWd9ovZ/MLUn/2Sj3ZODuAfOnICK0GT7Q=;
        b=Xf8o0ZIGxSLwPicow7oAXPnxDzOGysm0NSMhUlR5dMVWvDKvuX37cqV2eauBFE+RzC
         JZbV51tVww37PIxO6InU+jNOF/YNS0rRLbhEhncRE62oVAqI4dWTGgcY1eUB2EJp1gdQ
         Rdy5VxCQaBAzIJQZL1IGa0tlq76eNhnFumL405bqDXgPvHIRckB70El5AODAlFgCz9KI
         Ht4/qOp5MQ+/QlZhGHtRKUsWHByp3FUAs2P/Lo5I5Vm4d2lXrysSapom894UhsGojAA3
         /luQMxgHEqbdcS0IIaX2x2PiXOXC5zsYNUr0jXRMlRyFIaz4ulaWbGIE5gl3gugyPmhv
         j+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bwWy+eLTxSWd9ovZ/MLUn/2Sj3ZODuAfOnICK0GT7Q=;
        b=R2JVw28KgkP8tHGrGvFWrVAs1wE93DuVnnUgMa+KrR5/ymNQdkYMEanqY6YIgz24lv
         UgpoEhekrL1P1bsGsTanoE6h2wR52o+qaIeaospnZEyMteAEgsv3FudSqLpoJMO8ZbcN
         M0gVP6g5nz4AIFbLrwAHpXd3A9oDfItIT6s4iCPIBqtuk/vhFs8JYAMBxKO2gtIbF4fA
         imp/hz3QL9rTpQpU+DQeyik7V23OTTmEV9QGOheCq9txbGi2WtWB4RB2indWczrcZ1Wz
         OaE5wgHGJm8zgyDrv3osGaRrBmJhrvjxTDom56xzIehiagRWfAGMgMLk3BQzVQTQCjKz
         vNbw==
X-Gm-Message-State: APjAAAU96cxNQn255lqVSmSTpbtDBIyTaumqx6V1KntFBM/kKEf8JHSi
        6mRiG+uTfh+z7ikLl2bt9ltkTjO9u5JCxEOp2IU=
X-Google-Smtp-Source: APXvYqw4R3QwPl4s6J96ViKVvpuRGLGlpllA/XCTWjdSYG6rijwD7/+/7kidgbBy+Hx41sh/Uo7iYHjGiQDK2hn5Y30=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr24520529edc.67.1553704602544;
 Wed, 27 Mar 2019 09:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190326094239.5910-1-daniel.baluta@nxp.com> <20190326094239.5910-3-daniel.baluta@nxp.com>
 <VI1PR04MB4222A8DBC2312E72AAD3AFAE805F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CAEnQRZCb=rZMdBYyYCSCQ3Dba5Nk43BvV6whHx-vNPmox-OOSw@mail.gmail.com> <1553679236.2561.27.camel@pengutronix.de>
In-Reply-To: <1553679236.2561.27.camel@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 27 Mar 2019 18:36:30 +0200
Message-ID: <CAEnQRZB17cgunkoaQQPjVdfD0gHWZs=g7ABZPSrzdCy_u_91SA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>, Teo Hall <teo.hall@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:33 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Daniel,
>
> Am Mittwoch, den 27.03.2019, 10:51 +0200 schrieb Daniel Baluta:
> [...]
> >
> > > or
> > > "fsl,imx8qxp-edma", "fsl,imx8qm-edma"?
> >
> > One thing that it is not clear for me is why there are places
> > where we use two compatible strings?
> >
> > I understand the situation where are two distinct drivers, but is there
> > any other reason to add multiple compatible strings for a node in dts?
>
> We use 2 compatible string where there should not be any differences
> between the IP blocks of this SoC and a version the driver already
> supports.
>
> So if the eDMA driver already supports the software interface for
> "fsl,imx8qm-edma" and the IP block is compatible with this, we add this
> to the DT, so the we don't need any driver changes just to support a
> new SoC. But as you can never be sure if there are subtle differences
> in the IP block and/or SOC integration when adding the DT support, we
> also add a more specific compatible to the DT. If it turns out that
> there are software visible differences, we only need to adapt the
> driver to check for the more specific compatible to trigger the changed
> behavior, allowing to keep the DT stable.

Excellent explanation Lucas! For the moment upstream eDMA driver doesn't have
support for any i.MX8 so I think using "fsl,imx8qxp-edma" should be acceptable.

Thanks,
Daniel.
