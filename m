Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B224C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796A20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559841678;
	bh=I/rvHo9bLLx0LGwz77STImMguRJWk3J4MC7sA4wpYxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UBxQp//6hPDn39Njgn/EocEZkjjXYsoNdmTZ5ssbisplC56nzZ6WQ+cc867afPSZl
	 U2Ee8PENYn7pxRhwy+ilPmJhXhMTEOfsk5GhAQISkFdWHcSC1rzGSSE4/7W1UyER/d
	 UkPqsQL+qjyyAu4GqOJeC2mSqNrt4zUqNPGWStG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfFFRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbfFFRVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:21:16 -0400
Received: from localhost (unknown [106.200.230.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623B62083E;
        Thu,  6 Jun 2019 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559841676;
        bh=I/rvHo9bLLx0LGwz77STImMguRJWk3J4MC7sA4wpYxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZaszXjpaZrArJSQLPce12MPD86tSIVaqGz2hdOSxmJlIj7O+M2xosutN40by5PGL
         heaic1LuOVfW8s2Pb2mcv3baxvaSIqMHSpzm1hbIbNJzGBnOwN+ZMHt2lbJUY74DPS
         UvL2671Grg0zPs81woOYLKnZc69jg186SJarydzI=
Date:   Thu, 6 Jun 2019 22:48:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soundwire: stream: fix bad unlock balance
Message-ID: <20190606171807.GB9160@vkoul-mobl.Dlink>
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-19, 12:22, Srinivas Kandagatla wrote:
> multi bank switching code takes lock on condition but releases without
> any check resulting in below warning.
> This patch fixes this.
> 
>  =====================================
>  WARNING: bad unlock balance detected!
>  5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>  -------------------------------------
>  aplay/2954 is trying to release lock (&bus->msg_lock) at:
>  do_bank_switch+0x21c/0x480
>  but there are no more locks to release!

Applied after changing the log suggested by Pierre, thanks
-- 
~Vinod
