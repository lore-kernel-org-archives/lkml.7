Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0253C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D2D20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568361435;
	bh=p7cjNFjW8pPTHEfP9s6WMR26sSINsqGMJq16WsR6ntc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uEZiliy3veXUaT6fY1IEGvPmzc367qCWOOEUYKIYdGi5ynqvwOV/e3I80uLPUP0/U
	 I8p+55JajDzvVQE/To7uY8Nn5/mrJMWUOhF0a8z+t2n/wR+9Qc3kdD3Dyfk1f1jKOj
	 4jFg5IDZjXY0xlqgvZmbiAHTkbLdbP1tguOH1RSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfIMH5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMH5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:57:14 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367AD20830;
        Fri, 13 Sep 2019 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568361433;
        bh=p7cjNFjW8pPTHEfP9s6WMR26sSINsqGMJq16WsR6ntc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3AyRFzEsTvHtIKhjb/IKQmhEmEBxOk2DXyK+R6MoAP/b2aWL+H/cCPH4YNMEvdLF
         kymz08dFHy2WgNzTqemgeLLiMsWxp/O7K3Syj3WPNXr0NcjjrybFLRGBUN77X1qusf
         BjnIuPP7ToNd697XuTWyomufq3xuieJPqnvXdCpU=
Date:   Fri, 13 Sep 2019 09:57:09 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: v4l: cadence: Fix how unsued lanes are handled in
 'csi2rx_start()'
Message-ID: <20190913075709.t35ggip624tybd6l@localhost.localdomain>
References: <20190912204450.17625-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912204450.17625-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, Sep 12, 2019 at 10:44:50PM +0200, Christophe JAILLET wrote:
> The 2nd parameter of 'find_first_zero_bit()' is a number of bits, not of
> bytes. So use 'BITS_PER_LONG' instead of 'sizeof(lanes_used)'.
> 
> Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is purely speculative. Using BITS_PER_LONG looks logical to me,
> but I'm not 100% sure that it is what is expected here. 'csi2rx->max_lanes'
> could also be a good candidate.

Yeah, csi2rx->max_lanes would make more sense in that context. Could
you resend a new version?

Thanks!
Maxime
