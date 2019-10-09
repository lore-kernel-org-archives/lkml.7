Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BCECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12FE21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJIJht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:37:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48077 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:37:49 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iI8Ph-0004BJ-SS; Wed, 09 Oct 2019 11:37:45 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iI8Ph-0000SJ-7m; Wed, 09 Oct 2019 11:37:45 +0200
Date:   Wed, 9 Oct 2019 11:37:45 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Message-ID: <20191009093745.r5vevql7bcdhxleo@pengutronix.de>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
 <20191009090043.4yq4l7iac3zgytnp@pengutronix.de>
 <DB3PR0402MB3916595DFC84910873FBA91AF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916595DFC84910873FBA91AF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:34:42 up 144 days, 15:52, 98 users,  load average: 0.00, 0.08,
 0.33
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

On 19-10-09 09:09, Anson Huang wrote:
> Hi, Marco
> 
> > On 19-10-07 09:15, Anson Huang wrote:
> > > The SCU firmware does NOT always have return value stored in message
> > > header's function element even the API has response data, those
> > > special APIs are defined as void function in SCU firmware, so they
> > > should be treated as return success always.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V1:
> > > 	- Use direct API check instead of calling another function to check.
> > > 	- This patch is based on
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fpatch%2F11129553%2F&amp;data=02%7C01%7Canson.
> > huang%
> > >
> > 40nxp.com%7Cbefd2849a124462caa4a08d74c972dc9%7C686ea1d3bc2b4c6f
> > a92cd99
> > >
> > c5c301635%7C0%7C0%7C637062084506889431&amp;sdata=7fW8hZB4AaUK
> > 9QTKTJQR7
> > > LuV2nGo6e%2Fqb%2Fqmn4ykquk%3D&amp;reserved=0
> > > ---
> > >  drivers/firmware/imx/imx-scu.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/imx/imx-scu.c
> > > b/drivers/firmware/imx/imx-scu.c index 869be7a..03b43b7 100644
> > > --- a/drivers/firmware/imx/imx-scu.c
> > > +++ b/drivers/firmware/imx/imx-scu.c
> > > @@ -162,6 +162,7 @@ static int imx_scu_ipc_write(struct imx_sc_ipc
> > *sc_ipc, void *msg)
> > >   */
> > >  int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool
> > > have_resp)  {
> > > +	uint8_t saved_svc, saved_func;
> > >  	struct imx_sc_rpc_msg *hdr;
> > >  	int ret;
> > >
> > > @@ -171,8 +172,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc,
> > void *msg, bool have_resp)
> > >  	mutex_lock(&sc_ipc->lock);
> > >  	reinit_completion(&sc_ipc->done);
> > >
> > > -	if (have_resp)
> > > +	if (have_resp) {
> > >  		sc_ipc->msg = msg;
> > > +		saved_svc = ((struct imx_sc_rpc_msg *)msg)->svc;
> > 
> > Why do we need to check the svc too?
> 
> It is because the SCU firmware API has many different category called SVC, each category has
> many different function, and the function value could be same in each category,
> for example, there are IRQ, PM, MISC etc. SVC category, and each of them could have function
> type defined as 0, 1, 2 .... That is why I need to save both SVC and FUNC to identify the SCU FW
> API. See below: 
> 
> PM SVC:
> #define PM_FUNC_SET_PARTITION_POWER_MODE 1U /* Index for pm_set_partition_power_mode() RPC call */
> #define PM_FUNC_GET_SYS_POWER_MODE 2U /* Index for pm_get_sys_power_mode() RPC call */
> #define PM_FUNC_SET_RESOURCE_POWER_MODE 3U /* Index for pm_set_resource_power_mode() RPC call */
> 
> MISC SVC:
> #define MISC_FUNC_SET_CONTROL 1U /* Index for misc_set_control() RPC call */
> #define MISC_FUNC_GET_CONTROL 2U /* Index for misc_get_control() RPC call */
> #define MISC_FUNC_SET_MAX_DMA_GROUP 4U /* Index for misc_set_max_dma_group() RPC call */

Ahh, okay get it. Thanks for the explanation.

> > 
> > > +		saved_func = ((struct imx_sc_rpc_msg *)msg)->func;
> > 
> > Nitpick, should we call it requested_func/req_func?
> 
> OK, I will change them If I have to sent out a new version, otherwise, I think the saved_func and saved_svc
> should also be fine.

Just a nitpick ;)

Feel free to add my

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regards,
  Marco

> 
> Thanks,
> Anson

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
