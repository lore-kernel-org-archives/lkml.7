Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5340C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D820881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGBGmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:42:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37511 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:42:21 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hiCUc-0004as-UN; Tue, 02 Jul 2019 08:42:18 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hiCUc-0006Zv-Ff; Tue, 02 Jul 2019 08:42:18 +0200
Date:   Tue, 2 Jul 2019 08:42:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Message-ID: <20190702064218.25vzkxds3bjfzy3m@pengutronix.de>
References: <20190626070706.24930-1-Anson.Huang@nxp.com>
 <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
 <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZDzFBzgwugaK-CihQNaa=1SPPNsKm6QKOh9LqWACeFGTg@mail.gmail.com>
 <DB3PR0402MB3916DFE339C802871F18F9ABF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916DFE339C802871F18F9ABF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:40:14 up 45 days, 12:58, 49 users,  load average: 0.17, 0.08,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On 19-06-27 07:01, Anson Huang wrote:
> Hi, Daniel
> 
> > -----Original Message-----
> > From: Daniel Baluta <daniel.baluta@gmail.com>
> > Sent: Thursday, June 27, 2019 2:44 PM
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
> > On Thu, Jun 27, 2019 at 3:48 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > >
> > > Hi, Daniel
> > >
> > > > -----Original Message-----
> > > > From: Daniel Baluta <daniel.baluta@gmail.com>
> > > > Sent: Wednesday, June 26, 2019 8:42 PM
> > > > To: Anson Huang <anson.huang@nxp.com>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > Aisheng
> > > > Dong <aisheng.dong@nxp.com>; Abel Vesa <abel.vesa@nxp.com>; linux-
> > > > arm-kernel <linux-arm-kernel@lists.infradead.org>; Linux Kernel
> > > > Mailing List <linux-kernel@vger.kernel.org>; dl-linux-imx
> > > > <linux-imx@nxp.com>; Daniel Baluta <daniel.baluta@nxp.com>
> > > > Subject: Re: [PATCH] soc: imx-scu: Add SoC UID(unique identifier)
> > > > support
> > > >
> > > > On Wed, Jun 26, 2019 at 10:06 AM <Anson.Huang@nxp.com> wrote:
> > > > >
> > > > > From: Anson Huang <Anson.Huang@nxp.com>
> > > > >
> > > > > Add i.MX SCU SoC's UID(unique identifier) support, user can read
> > > > > it from sysfs:
> > > > >
> > > > > root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> > > > > 7B64280B57AC1898
> > > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > ---
> > > > >  drivers/soc/imx/soc-imx-scu.c | 35
> > > > > +++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 35 insertions(+)
> > > > >
> > > > > diff --git a/drivers/soc/imx/soc-imx-scu.c
> > > > > b/drivers/soc/imx/soc-imx-scu.c index 676f612..8d322a1 100644
> > > > > --- a/drivers/soc/imx/soc-imx-scu.c
> > > > > +++ b/drivers/soc/imx/soc-imx-scu.c
> > > > > @@ -27,6 +27,36 @@ struct imx_sc_msg_misc_get_soc_id {
> > > > >         } data;
> > > > >  } __packed;
> > > > >
> > > > > +struct imx_sc_msg_misc_get_soc_uid {
> > > > > +       struct imx_sc_rpc_msg hdr;
> > > > > +       u32 uid_low;
> > > > > +       u32 uid_high;
> > > > > +} __packed;
> > > > > +
> > > > > +static ssize_t soc_uid_show(struct device *dev,
> > > > > +                           struct device_attribute *attr, char
> > > > > +*buf) {
> > > > > +       struct imx_sc_msg_misc_get_soc_uid msg;
> > > > > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > > > +       u64 soc_uid;
> > > > > +
> > > > > +       hdr->ver = IMX_SC_RPC_VERSION;
> > > > > +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> > > > > +       hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
> > > > > +       hdr->size = 1;
> > > > > +
> > > > > +       /* the return value of SCU FW is in correct, skip return
> > > > > + value check */
> > > >
> > > > Why do you mean by "in correct"?
> > >
> > > I made a mistake, it should be "incorrect", the existing SCFW of this
> > > API returns an error value even this API is successfully called, to
> > > make it work with current SCFW, I have to skip the return value check
> > > for this API for now. Will send V2 patch to fix this typo.
> > 
> > Thanks Anson! It makes sense now. It is a little bit sad though because we
> > won't know when there is a "real" error :).
> > 
> > Lets update the comment to be more specific:
> > 
> > /* SCFW FW API always returns an error even the function is successfully
> > executed, so skip returned value */
> 
> OK, as for external users, the SCFW formally released has this issue, so for now
> I have to skip the return value check for this API, once next SCFW release has this issue
> fixed, I will add a patch to check the return value.

Do you really keep track of that? Please can you add a FIXME: or TODO:
tag and add the firmware version containing that bug?

Regards,
  Marco

> Thanks,
> Anson.
> > 
> > 
> > > > > +       imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> > > > > +
> > > > > +       soc_uid = msg.uid_high;
> > > > > +       soc_uid <<= 32;
> > > > > +       soc_uid |= msg.uid_low;
> > > > > +
> > > > > +       return sprintf(buf, "%016llX\n", soc_uid);
> > > >
> > > > snprintf?
> > >
> > > The snprintf is to avoid buffer overflow, which in this case, I don't
> > > know the size of "buf", and the value(u64) to be printed is with fixed
> > > length of 64, so I think sprint is just OK.
> > 
> > Ok.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
