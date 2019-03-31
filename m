Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D69C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BBC20856
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfCaPZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:25:01 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:47393 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbfCaPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:25:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4BBBB2800B3F5;
        Sun, 31 Mar 2019 17:24:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 00BCA5B4FE; Sun, 31 Mar 2019 17:24:58 +0200 (CEST)
Date:   Sun, 31 Mar 2019 17:24:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 12/36] thunderbolt: Properly disable path
Message-ID: <20190331152458.4ugdshjg6qyu2pzr@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328123633.42882-13-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:36:09PM +0300, Mika Westerberg wrote:
> +static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index)
> +{
> +	struct tb_regs_hop hop;
> +	ktime_t timeout;
> +	int ret;
> +
> +	if (port->sw->is_unplugged)
> +		return 0;

This check is basically a duplication of the checks added in patch 4 ...


> +
> +	/* Disable the path */
> +	ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
> +	if (ret)
> +		return ret;
[...]
>  static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
>  {
>  	int i, res;
> -	struct tb_regs_hop hop = { };
> +
>  	for (i = first_hop; i < path->path_length; i++) {
> -		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
> -				    2 * path->hops[i].in_hop_index, 2);
> +		res = __tb_path_deactivate_hop(path->hops[i].in_port,
> +					       path->hops[i].in_hop_index);
>  		if (res)
>  			tb_port_warn(path->hops[i].in_port,
>  				     "hop deactivation failed for hop %d, index %d\n",

... however you return 0 above to avoid the warning here whereas the checks
added in patch 4 return -ENODEV.  You may want to change "if (res)" to
"if (res && res != -ENODEV)" and drop the unplugged check in
__tb_path_deactivate_hop().

Thanks,

Lukas
