Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC28C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FAA20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfFSIsV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:48:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:7670 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbfFSIsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:48:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 01:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="164965719"
Received: from pgsmsx111.gar.corp.intel.com ([10.108.55.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2019 01:48:18 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.96]) by
 PGSMSX111.gar.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0439.000;
 Wed, 19 Jun 2019 16:48:17 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [RFC net-next 1/5] net: stmmac: introduce IEEE 802.1Qbv
 configuration functionalities
Thread-Topic: [RFC net-next 1/5] net: stmmac: introduce IEEE 802.1Qbv
 configuration functionalities
Thread-Index: AQHVJdrUhwXCZv9SNEKube71uT/CUqahxnCAgADin9A=
Date:   Wed, 19 Jun 2019 08:48:16 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC81472623A@PGSMSX103.gar.corp.intel.com>
References: <1560893778-6838-1-git-send-email-weifeng.voon@intel.com>
 <1560893778-6838-2-git-send-email-weifeng.voon@intel.com>
 <20190619030729.GA26784@lunn.ch>
In-Reply-To: <20190619030729.GA26784@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int est_poll_srwo(void *ioaddr) {
> > +	/* Poll until the EST GCL Control[SRWO] bit clears.
> > +	 * Total wait = 12 x 50ms ~= 0.6s.
> > +	 */
> > +	unsigned int retries = 12;
> > +	unsigned int value;
> > +
> > +	do {
> > +		value = TSN_RD32(ioaddr + MTL_EST_GCL_CTRL);
> > +		if (!(value & MTL_EST_GCL_CTRL_SRWO))
> > +			return 0;
> > +		msleep(50);
> > +	} while (--retries);
> > +
> > +	return -ETIMEDOUT;
> 
> Maybe use one of the readx_poll_timeout() macros?
> 
> > +static int est_read_gce(void *ioaddr, unsigned int row,
> > +			unsigned int *gates, unsigned int *ti_nsec,
> > +			unsigned int dbgb, unsigned int dbgm) {
> > +	struct tsn_hw_cap *cap = &dw_tsn_hwcap;
> > +	unsigned int ti_wid = cap->ti_wid;
> > +	unsigned int gates_mask;
> > +	unsigned int ti_mask;
> > +	unsigned int value;
> > +	int ret;
> > +
> > +	gates_mask = (1 << cap->txqcnt) - 1;
> > +	ti_mask = (1 << ti_wid) - 1;
> > +
> > +	ret = est_read_gcl_config(ioaddr, &value, row, 0, dbgb, dbgm);
> > +	if (ret) {
> > +		TSN_ERR("Read GCE failed! row=%u\n", row);
> 
> It is generally not a good idea to put wrappers around the kernel print
> functions. It would be better if all these functions took struct
> stmmac_priv *priv rather than ioaddr, so you could then do
> 
> 	netdev_err(priv->dev, "Read GCE failed! row=%u\n", row);
> 
> > +	/* Ensure that HW is not in the midst of GCL transition */
> > +	value = TSN_RD32(ioaddr + MTL_EST_CTRL);
> 
> Also, don't put wrapper around readl()/writel().
> 
> > +	value &= ~MTL_EST_CTRL_SSWL;
> > +
> > +	/* MTL_EST_CTRL value has been read earlier, if TILS value
> > +	 * differs, we update here.
> > +	 */
> > +	if (tils != dw_tsn_hwtunable[TSN_HWTUNA_TX_EST_TILS]) {
> > +		value &= ~MTL_EST_CTRL_TILS;
> > +		value |= (tils << MTL_EST_CTRL_TILS_SHIFT);
> > +
> > +		TSN_WR32(value, ioaddr + MTL_EST_CTRL);
> > +		dw_tsn_hwtunable[TSN_HWTUNA_TX_EST_TILS] = tils;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int est_set_ov(void *ioaddr,
> > +		      const unsigned int *ptov,
> > +		      const unsigned int *ctov)
> > +{
> > +	unsigned int value;
> > +
> > +	if (!dw_tsn_feat_en[TSN_FEAT_ID_EST])
> > +		return -ENOTSUPP;
> > +
> > +	value = TSN_RD32(ioaddr + MTL_EST_CTRL);
> > +	value &= ~MTL_EST_CTRL_SSWL;
> > +
> > +	if (ptov) {
> > +		if (*ptov > EST_PTOV_MAX) {
> > +			TSN_WARN("EST: invalid PTOV(%u), max=%u\n",
> > +				 *ptov, EST_PTOV_MAX);
> 
> It looks like most o the TSN_WARN should actually be netdev_dbg().
> 
>    Andrew

Hi Andrew,
This file is targeted for dual licensing which is GPL-2.0 OR BSD-3-Clause.
This is the reason why we are using wrappers around the functions so that
all the function call is generic.
	
Regards,
Weifeng

