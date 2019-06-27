Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE4AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c62nqjam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0Gns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:43:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51587 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfF0Gns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:43:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so4496450wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fr091IJlyLDPMmSVtyOHFtPcDnSVYiT6XZwDIOErr7U=;
        b=c62nqjamUpIKgiIcFe5zH56Mi5/TGbku/yyyhPsJoeQmVhmTIs8N5hSdXJxZrgZRy3
         FIKW859OaiknvC0qYWcvdCrN0VOPxp5nGr0qMueJLs88j542C20qRGwa1LeLvMiAkXO/
         6sFw9gl+LoNBhRJO8eRUWs7ZowQcCFFx6Lrr7/LxB2YnKZjXx8EVEOzk/k7TKqcCY0VM
         OUej1LV+9rtwJ5qOz32zTbsO8nKo2i+Ib+wP0847PnoeSwdvj71G5yFnDYfcjeNw5P5W
         W6INA6bWMfx/MW2FyXTdS4jL3zseq2A9t6DNQwZB0bFB19Y8jd083Rcn2q1Kbkjz1X0V
         LnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fr091IJlyLDPMmSVtyOHFtPcDnSVYiT6XZwDIOErr7U=;
        b=NiivkCfSWahVCExGlRhNj/B5utHCv8iL7JVgu9SjHwxgBG4rb+zk8E9BQSi0JAy2ad
         Z/56edsWzwSWFqOhtxW+8tyg15GBN6J48YOb91+uUgSRPbwMeBEgVmdfg0nsDa3NJSeq
         vSRex1EfEkj2DNRF2C4+fXYqwj3mojCeuTUQV+/fQ045ocNw/ev7irib998DYa/gk/rN
         uq0XRr0mmPAygtmifOamznUXVsSn3n4bZLwSixOb/neT+BSBmhNZMMvS69sKEqcU6kzw
         5lJY1jElNs8f+TDDn3bgfbPkRrFux8C3DsgX3DN40J1q6XOjKNXithlA7LnUp3Dinah4
         c+/w==
X-Gm-Message-State: APjAAAXVOqlmW4+2oxXPTjm/q66rfXwMKm1HLnDudhEg8yIG0UglsqKj
        LuN4CQ24hukLQD+yovzJNliUzpn5i4dnCqjAIDE=
X-Google-Smtp-Source: APXvYqznv8TwvW1K9qKqrvLF/qS3x63C6UZFf9AHU2K/Hpl+fugYxqf+pFeMX8bv03CQylSfZpSqbH95DtsRbuyMR/c=
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr1793945wmi.73.1561617826007;
 Wed, 26 Jun 2019 23:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190626070706.24930-1-Anson.Huang@nxp.com> <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
 <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 27 Jun 2019 09:43:34 +0300
Message-ID: <CAEnQRZDzFBzgwugaK-CihQNaa=1SPPNsKm6QKOh9LqWACeFGTg@mail.gmail.com>
Subject: Re: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 3:48 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Daniel
>
> > -----Original Message-----
> > From: Daniel Baluta <daniel.baluta@gmail.com>
> > Sent: Wednesday, June 26, 2019 8:42 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Aisheng
> > Dong <aisheng.dong@nxp.com>; Abel Vesa <abel.vesa@nxp.com>; linux-
> > arm-kernel <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Daniel
> > Baluta <daniel.baluta@nxp.com>
> > Subject: Re: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
> >
> > On Wed, Jun 26, 2019 at 10:06 AM <Anson.Huang@nxp.com> wrote:
> > >
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > >
> > > Add i.MX SCU SoC's UID(unique identifier) support, user can read it
> > > from sysfs:
> > >
> > > root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> > > 7B64280B57AC1898
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/soc/imx/soc-imx-scu.c | 35
> > > +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/soc/imx/soc-imx-scu.c
> > > b/drivers/soc/imx/soc-imx-scu.c index 676f612..8d322a1 100644
> > > --- a/drivers/soc/imx/soc-imx-scu.c
> > > +++ b/drivers/soc/imx/soc-imx-scu.c
> > > @@ -27,6 +27,36 @@ struct imx_sc_msg_misc_get_soc_id {
> > >         } data;
> > >  } __packed;
> > >
> > > +struct imx_sc_msg_misc_get_soc_uid {
> > > +       struct imx_sc_rpc_msg hdr;
> > > +       u32 uid_low;
> > > +       u32 uid_high;
> > > +} __packed;
> > > +
> > > +static ssize_t soc_uid_show(struct device *dev,
> > > +                           struct device_attribute *attr, char *buf)
> > > +{
> > > +       struct imx_sc_msg_misc_get_soc_uid msg;
> > > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > +       u64 soc_uid;
> > > +
> > > +       hdr->ver = IMX_SC_RPC_VERSION;
> > > +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> > > +       hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
> > > +       hdr->size = 1;
> > > +
> > > +       /* the return value of SCU FW is in correct, skip return value
> > > + check */
> >
> > Why do you mean by "in correct"?
>
> I made a mistake, it should be "incorrect", the existing SCFW of this API returns
> an error value even this API is successfully called, to make it work with current
> SCFW, I have to skip the return value check for this API for now. Will send V2 patch
> to fix this typo.

Thanks Anson! It makes sense now. It is a little bit sad though because we won't
know when there is a "real" error :).

Lets update the comment to be more specific:

/* SCFW FW API always returns an error even the function is
successfully executed, so skip returned value */


> > > +       imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> > > +
> > > +       soc_uid = msg.uid_high;
> > > +       soc_uid <<= 32;
> > > +       soc_uid |= msg.uid_low;
> > > +
> > > +       return sprintf(buf, "%016llX\n", soc_uid);
> >
> > snprintf?
>
> The snprintf is to avoid buffer overflow, which in this case, I don't know the size
> of "buf", and the value(u64) to be printed is with fixed length of 64, so I think
> sprint is just OK.

Ok.
