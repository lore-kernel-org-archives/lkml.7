Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84C22073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfDOReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:34:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfDOReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:34:18 -0400
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1hG5Uf-0001DW-Sj; Mon, 15 Apr 2019 19:34:09 +0200
Date:   Mon, 15 Apr 2019 19:34:08 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] drivers: clk: Update clock driver to handle clock
 attribute
Message-ID: <20190415193408.2a385113@litschi.hi.pengutronix.de>
In-Reply-To: <BYAPR02MB59920087C354B84C9CFED2E0B8280@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
 <20190412110044.194666db@litschi.hi.pengutronix.de>
 <BYAPR02MB59920087C354B84C9CFED2E0B8280@BYAPR02MB5992.namprd02.prod.outlook.com>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 17:50:12 +0000, Jolly Shah wrote:
> Hi Michael,
> 
> > -----Original Message-----
> > From: Michael Tretter <m.tretter@pengutronix.de>
> > Sent: Friday, April 12, 2019 2:01 AM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: mturquette@baylibre.com; sboyd@codeaurora.org; Michal Simek
> > <michals@xilinx.com>; linux-clk@vger.kernel.org; Tejas Patel
> > <TEJASP@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; linux-
> > kernel@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org;
> > kernel@pengutronix.de
> > Subject: Re: [PATCH] drivers: clk: Update clock driver to handle clock attribute
> > 
> > On Mon, 04 Mar 2019 15:19:10 -0800, Jolly Shah wrote:  
> > > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > >
> > > Versal EEMI APIs uses clock device ID which is combination of class,
> > > subclass, type and clock index (e.g. 0x8104006 in which 0-13 bits are
> > > for index(6 in given example), 14-19 bits are for clock type (i.e pll,
> > > out or ref, 1 in given example), 20-25 bits are for subclass which is
> > > nothing but clock type only), 26-32 bits are for device class, which
> > > is clock(0x2) for all clocks) while zynqmp firmware uses clock ID
> > > which is index only (e.g 0, 1, to n, where n is max_clock id).
> > >
> > > To use zynqmp clock driver for versal platform also, extend use
> > > of QueryAttribute API to fetch device class, subclass and clock type
> > > to create clock device ID. In case of zynqmp this attributes would be
> > > 0 only, so there won't be any effect on clock id as it would use
> > > clock index only.
> > >
> > > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > > ---
> > >  drivers/clk/zynqmp/clkc.c | 42 +++++++++++++++++++++++++++++-------------
> > >  1 file changed, 29 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> > > index f65cc0f..c13b014 100644
> > > --- a/drivers/clk/zynqmp/clkc.c
> > > +++ b/drivers/clk/zynqmp/clkc.c
> > > @@ -53,6 +53,10 @@
> > >  #define RESERVED_CLK_NAME		""
> > >
> > >  #define CLK_VALID_MASK			0x1
> > > +#define NODE_CLASS_SHIFT		26U
> > > +#define NODE_SUBCLASS_SHIFT		20U
> > > +#define NODE_TYPE_SHIFT			14U
> > > +#define NODE_INDEX_SHIFT		0U
> > >
> > >  enum clk_type {
> > >  	CLK_TYPE_OUTPUT,
> > > @@ -80,6 +84,7 @@ struct clock_parent {
> > >   * @num_nodes:		Number of nodes present in topology
> > >   * @parent:		Parent of clock
> > >   * @num_parents:	Number of parents of clock
> > > + * @clk_id:		Clock id
> > >   */
> > >  struct zynqmp_clock {
> > >  	char clk_name[MAX_NAME_LEN];
> > > @@ -89,6 +94,7 @@ struct zynqmp_clock {
> > >  	u32 num_nodes;
> > >  	struct clock_parent parent[MAX_PARENT];
> > >  	u32 num_parents;
> > > +	u32 clk_id;
> > >  };
> > >
> > >  static const char clk_type_postfix[][10] = {
> > > @@ -396,7 +402,8 @@ static int zynqmp_clock_get_topology(u32 clk_id,
> > >
> > >  	*num_nodes = 0;
> > >  	for (j = 0; j <= MAX_NODES; j += 3) {
> > > -		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
> > > +		ret = zynqmp_pm_clock_get_topology(clock[clk_id].clk_id, j,
> > > +						   pm_resp);  
> > 
> > I think, having clk_id as the index in the array of clock descriptors
> > and each descriptor having a clk_id, which might be equal to the clk_id
> > (on zynqmp), but might be different from the index (versal) is really
> > confusing. It would be better if there would be a clear separation
> > between the driver internal id and the id that is used at the interface
> > with the firmware.  
> 
> If we use different ids, we will need to hard code some mappings to
> convert them to one being used by firmware. For user, both are clock
> ids but id values are different compared to zynqmp where it was
> sequential starting from 0. 

We don't need to hardcode the mapping, because this patch already adds
a mapping by adding the clk_id as a field of zynqmp_clock. What I am
suggesting in to never refer to the index in clock[] as clk_id, but as
index, i or whatever. This would emphasize when we are dealing with a
clock id that can be used to communicate with the firmware and an index
that can be used within the driver.

> 
> >   
> > >  		if (ret)
> > >  			return ret;
> > >  		ret = __zynqmp_clock_get_topology(topology, pm_resp,  
> > num_nodes);  
> > > @@ -459,7 +466,8 @@ static int zynqmp_clock_get_parents(u32 clk_id, struct  
> > clock_parent *parents,  
> > >  	*num_parents = 0;
> > >  	do {
> > >  		/* Get parents from firmware */
> > > -		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
> > > +		ret = zynqmp_pm_clock_get_parents(clock[clk_id].clk_id, j,
> > > +						  pm_resp);
> > >  		if (ret)
> > >  			return ret;
> > >
> > > @@ -528,13 +536,14 @@ static struct clk_hw  
> > *zynqmp_register_clk_topology(int clk_id, char *clk_name,  
> > >  						   const char **parent_names)
> > >  {
> > >  	int j;
> > > -	u32 num_nodes;
> > > +	u32 num_nodes, clk_dev_id;
> > >  	char *clk_out = NULL;
> > >  	struct clock_topology *nodes;
> > >  	struct clk_hw *hw = NULL;
> > >
> > >  	nodes = clock[clk_id].node;
> > >  	num_nodes = clock[clk_id].num_nodes;
> > > +	clk_dev_id = clock[clk_id].clk_id;
> > >
> > >  	for (j = 0; j < num_nodes; j++) {
> > >  		/*
> > > @@ -551,13 +560,14 @@ static struct clk_hw  
> > *zynqmp_register_clk_topology(int clk_id, char *clk_name,  
> > >  		if (!clk_topology[nodes[j].type])
> > >  			continue;
> > >
> > > -		hw = (*clk_topology[nodes[j].type])(clk_out, clk_id,
> > > +		hw = (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
> > >  						    parent_names,
> > >  						    num_parents,
> > >  						    &nodes[j]);
> > >  		if (IS_ERR(hw))
> > > -			pr_warn_once("%s() %s register fail with %ld\n",
> > > -				     __func__, clk_name, PTR_ERR(hw));
> > > +			pr_warn_once("%s() 0x%x: %s register fail with %ld\n",
> > > +				     __func__,  clk_dev_id, clk_name,
> > > +				     PTR_ERR(hw));
> > >
> > >  		parent_names[0] = clk_out;
> > >  	}
> > > @@ -621,20 +631,26 @@ static int zynqmp_register_clocks(struct  
> > device_node *np)  
> > >  static void zynqmp_get_clock_info(void)
> > >  {
> > >  	int i, ret;
> > > -	u32 attr, type = 0;
> > > +	u32 attr, type = 0, nodetype, subclass, class;
> > >
> > >  	for (i = 0; i < clock_max_idx; i++) {
> > > -		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
> > > -		if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))
> > > -			continue;
> > > -
> > >  		ret = zynqmp_pm_clock_get_attributes(i, &attr);
> > >  		if (ret)
> > >  			continue;
> > >
> > >  		clock[i].valid = attr & CLK_VALID_MASK;
> > > -		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
> > > -							CLK_TYPE_OUTPUT;
> > > +		clock[i].type = ((attr >> CLK_TYPE_SHIFT) & 0x1) ?
> > > +				CLK_TYPE_EXTERNAL : CLK_TYPE_OUTPUT;
> > > +		nodetype = (attr >> NODE_TYPE_SHIFT) & 0x3F;
> > > +		subclass = (attr >> NODE_SUBCLASS_SHIFT) & 0x3F;
> > > +		class = (attr >> NODE_CLASS_SHIFT) & 0x3F;
> > > +
> > > +		clock[i].clk_id = (class << NODE_CLASS_SHIFT) |
> > > +				  (subclass << NODE_SUBCLASS_SHIFT) |
> > > +				  (nodetype << NODE_TYPE_SHIFT) |
> > > +				  (i << NODE_INDEX_SHIFT);  
> > 
> > In the commit message you write that on versal the index is returned in
> > bits 13..0 of the get_attr response from the firmware. However, the code uses
> > the index that is used in the get_attr call and ignores the index in
> > the response.
> >   
> 
> Yes index is from bit 0:13. Attributes response doesn't contain index
> as it is same for what attribute is being queried for which is i.

If the index i is sufficient for retrieving the class, subclass and
type which will be used to construct the clk_id, then why do you need
the class, subclass and type in the clk_id anyway?

> 
> > Moreover, on zynqmp bits 0 and 2 of the response are already in use,
> > but would be part of the index on versal. Therefore, as I
> > understand, the response formats of zynqmp and versal are actually
> > different formats and should be distinguished more clearly.
> >   
> 
> Bits 0 to 2 are same bot Zynqmp and Versal as versal doesn't contain
> index in attribute response. Only new attribute fields for versal are
> class, subclass and type. Driver reconstructs clock id using those
> value and index as i.

OK. So the get_attributes call will never contain the clock index, but
only the class, subclass and type fields. On the other hand, the clk_id
contains the same class, subclass and type fields, but also the index
of the clock. Therefore, the clk_id and the get_attr formats differ and
e.g. NODE_CLASS_SHIFT, which is used to read from get_attr shouldn't be
reused to write to the clk_id, because the clk_id and the get_attr
response essentially have different formats.

Maybe have a look at my other patch [0], which changes how the firmware
responses are unmarshaled and makes the difference between the
attributes and the clock id more obvious.

Michael

[0] https://lore.kernel.org/linux-clk/20190412095220.22855-1-m.tretter@pengutronix.de/T/#u

> 
> Thanks,
> Jolly Shah
> 
> 
> > Michael
> >   
> > > +
> > > +		zynqmp_pm_clock_get_name(clock[i].clk_id,  
> > clock[i].clk_name);  
> > >  	}
> > >
> > >  	/* Get topology of all clock */  
> 
