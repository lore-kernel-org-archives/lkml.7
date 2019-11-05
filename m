Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A94C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C86D21D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572960282;
	bh=/K1K9jXuxhw9OHCjOr8XzmIHfn6QwwgK1n4DV2t9XRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OKfsj6H5ILniEN6Uzf/I5XNXsIqonNopBS2sHdmbhe30Rscrxqmj0CAVkJ+WJiqeC
	 kpd2aM9OziIckLqFWiUXfRDeX0FaK2HDRY8MQXPKDjgmj6F0p+CJpfWhpNfcRbeodJ
	 UiwBnMLPv21oHr2GGmJn7iTlr+WonXkXIsc9aMPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389131AbfKENYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389075AbfKENYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:24:40 -0500
Received: from localhost (unknown [89.205.133.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19CF21D7C;
        Tue,  5 Nov 2019 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572960280;
        bh=/K1K9jXuxhw9OHCjOr8XzmIHfn6QwwgK1n4DV2t9XRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OF2nsS02yaQU25vPZA2w4ayHFC6qTjOfKsI2d60fIpkmA07ThApgH8wDd6af3+Z1S
         QwbgD+oU1cxZZc56T9ZFMERAivZb2TeaUbENzygYQwr78cJp42L2VT97GyAmrsr+gJ
         OSFWDYOcS1vhrygJMwLUGWY8EC+ymqHVCCKAoFxo=
Date:   Tue, 5 Nov 2019 14:24:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Message-ID: <20191105132435.GA2616182@kroah.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 02:34:23PM +0200, Ioana Ciornei wrote:
> This patch set adds support for Rx/Tx capabilities on switch port interfaces.
> Also, control traffic is redirected through ACLs to the CPU in order to
> enable proper STP protocol handling.
> 
> The control interface is comprised of 3 queues in total: Rx, Rx error and
> Tx confirmation.  In this patch set we only enable Rx and Tx conf. All
> switch ports share the same queues when frames are redirected to the CPU.
> Information regarding the ingress switch port is passed through frame
> metadata - the flow context field of the descriptor. NAPI instances are
> also shared between switch net_devices and are enabled when at least on
> one of the switch ports .dev_open() was called and disabled when at least
> one switch port is still up.
> 
> The new feature is enabled only on MC versions greater than 10.19.0
> (which is soon to be released).

I thought I asked for no new features until this code gets out of
staging?  Only then can you add new stuff.  Please work to make that
happen first.

thanks,

greg k-h
