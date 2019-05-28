Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD2217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559085746;
	bh=wy8T6AuFg8mT+W9wICjqXQ1IhqP39U392lEzIEKyBRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rvK9QXa22GE1WJ5FEpozPZZMYvyTAkB4B41NWmX+kNERX/ac27jarjOUYH18ohgh3
	 DlHcVmKeCeqwJVASj/j4fsX1EgHCjZNsE4FMvwB4hJTM9A1Dp7uWx01T92RU92pk+N
	 Sns8ErY7+DIg9Q4xWS3QtedXaNjBRoyzNNJSzvYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfE1XW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1XWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:22:25 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348D320B1F;
        Tue, 28 May 2019 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085745;
        bh=wy8T6AuFg8mT+W9wICjqXQ1IhqP39U392lEzIEKyBRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMokZuuGSwk7OfFBqVZd+fBBUVwL8Nse1T9hZi80B9zS262OqKBnhTLg9W+TCKFww
         nVnsjRw1IaGbmKKbg5pk7A5SaVyabiIDdpapLcZN1PPd9lBhO3K5BFMTtMTX0BQZb4
         HpPRbqsdWJLZuGAmbu66IEXcWuLOYiaJcMtghKYo=
Date:   Tue, 28 May 2019 16:22:24 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
Message-ID: <20190528232224.GA29225@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
> +/**
> + * rsu_send_msg() - send a message to Intel service layer
> + * @priv: pointer to rsu private data
> + * @command: RSU status or update command
> + * @arg: the request argument, the bitstream address or notify status
> + * @callback: function pointer for the callback (status or update)
> + *
> + * Start an Intel service layer transaction to perform the SMC call that
> + * is necessary to get RSU boot log or set the address of bitstream to
> + * boot after reboot.
> + *
> + * Returns 0 on success or -ETIMEDOUT on error.
> + */
> +static int rsu_send_msg(struct stratix10_rsu_priv *priv,
> +			enum stratix10_svc_command_code command,
> +	unsigned long arg,
> +	void (*callback)(struct stratix10_svc_client *client,
> +			 struct stratix10_svc_cb_data *data))
> +{
> +	struct stratix10_svc_client_msg msg;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	reinit_completion(&priv->completion);
> +	priv->client.receive_cb = callback;
> +
> +	msg.command = command;
> +	if (arg)
> +		msg.arg[0] = arg;
> +
> +	ret = stratix10_svc_send(priv->chan, &msg);

meta-question, can you send messages that are on the stack and not in
DMA-able memory?  Or should this be a dynamicly created variable so you
know it can work properly with DMA?

And how big is that structure, will it mess with stack sizes?

thanks,

greg k-h
