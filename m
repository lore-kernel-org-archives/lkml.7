Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B7C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B420818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573446088;
	bh=lvxCU40m4tZyyey/7nhqGzV+Zd9LeGdHgIAioJyXq2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oGyaZ91qzCl3wQDchPldCoOusUOpSlB2B9GHAvZGnRzcDvk/iMOyxDaJPlkVuHf38
	 2Vzldx17gb5T0SFzh2APyEZhYxsuD7LotnFwWh3oEt39XhzVYFkX5mOWJNLVCI7syQ
	 sC/ninwsC/QFutnEB/WZ5+WhR9D3kPikLvtBsbFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKEV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfKKEV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:21:26 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA4420818;
        Mon, 11 Nov 2019 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573446085;
        bh=lvxCU40m4tZyyey/7nhqGzV+Zd9LeGdHgIAioJyXq2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z3vmezjKdj2sbvDJNTw0HUI9laGnq4+Tt43Dnhm5C6P/g/yXezcOiATItMnJ/H0g6
         McJ/yhL9YCEXIkhNs8Ff6YXYYhL6wTOZK8c1fStEN8JMBlQRq2I+pAuVkSpnDn62Yp
         h3yq1qn2ppcqDfdrM77guOFNj0SkH3zxHzpQN5gA=
Date:   Mon, 11 Nov 2019 09:51:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 02/15] soc: ti: k3: add navss ringacc driver
Message-ID: <20191111042119.GK952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>

> +config TI_K3_RINGACC
> +	tristate "K3 Ring accelerator Sub System"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_INTA_IRQCHIP
> +	default y

You want to get an earful from Linus? We dont do default y on new stuff,
never :)

> +struct k3_ring_rt_regs {
> +	u32	resv_16[4];
> +	u32	db;		/* RT Ring N Doorbell Register */
> +	u32	resv_4[1];
> +	u32	occ;		/* RT Ring N Occupancy Register */
> +	u32	indx;		/* RT Ring N Current Index Register */
> +	u32	hwocc;		/* RT Ring N Hardware Occupancy Register */
> +	u32	hwindx;		/* RT Ring N Current Index Register */

nice comments, how about moving them up into kernel-doc style? (here and
other places as well)


> +struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
> +					int id, u32 flags)
> +{
> +	int proxy_id = K3_RINGACC_PROXY_NOT_USED;
> +
> +	mutex_lock(&ringacc->req_lock);
> +
> +	if (id == K3_RINGACC_RING_ID_ANY) {
> +		/* Request for any general purpose ring */
> +		struct ti_sci_resource_desc *gp_rings =
> +						&ringacc->rm_gp_range->desc[0];
> +		unsigned long size;
> +
> +		size = gp_rings->start + gp_rings->num;
> +		id = find_next_zero_bit(ringacc->rings_inuse, size,
> +					gp_rings->start);
> +		if (id == size)
> +			goto error;
> +	} else if (id < 0) {
> +		goto error;
> +	}
> +
> +	if (test_bit(id, ringacc->rings_inuse) &&
> +	    !(ringacc->rings[id].flags & K3_RING_FLAG_SHARED))
> +		goto error;
> +	else if (ringacc->rings[id].flags & K3_RING_FLAG_SHARED)
> +		goto out;
> +
> +	if (flags & K3_RINGACC_RING_USE_PROXY) {
> +		proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
> +					      ringacc->num_proxies, 0);
> +		if (proxy_id == ringacc->num_proxies)
> +			goto error;
> +	}
> +
> +	if (!try_module_get(ringacc->dev->driver->owner))
> +		goto error;

should this not be one of the first things to do?

> +
> +	if (proxy_id != K3_RINGACC_PROXY_NOT_USED) {
> +		set_bit(proxy_id, ringacc->proxy_inuse);
> +		ringacc->rings[id].proxy_id = proxy_id;
> +		dev_dbg(ringacc->dev, "Giving ring#%d proxy#%d\n", id,
> +			proxy_id);
> +	} else {
> +		dev_dbg(ringacc->dev, "Giving ring#%d\n", id);
> +	}

how bout removing else and doing common print?

-- 
~Vinod
