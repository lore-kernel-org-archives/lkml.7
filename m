Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C2AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D0421743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556613854;
	bh=ai5WXNsolKgaIDUM/1ta9XUJxF3Aiffc0uUdzVBXesM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cdPdIyRPn11i19/7rG8GhwJUZpWtWIWMqwKcNhbAUKGouFXuC/SpMxw8Jlvon5Skt
	 Ynjo8zM3N3TUDOAryxwNDrZDvh/MARHKOc+9ldHqRSU2841GqXsHF6Xb9UAGkJuhxY
	 mohVuikqssoTVC7AmHTvqJyYwc8iotFqE0u23Gc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfD3IoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3IoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453E82080C;
        Tue, 30 Apr 2019 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556613851;
        bh=ai5WXNsolKgaIDUM/1ta9XUJxF3Aiffc0uUdzVBXesM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFXM4i89mIFJsvs2Tpfro8iqjI3BKVXgqr6MI1I7b0s1rXjjdKatRRvmRdOG3FWMM
         phdAFkUElkKxCizyXTf37VP1mUKF0+uyfu6lgiEuqdsRto4zTF/WDOYUrAvRXjcepU
         JAaReAS4fRhiINty3/yLSrZoRwvZq88dgdXmy5Bc=
Date:   Tue, 30 Apr 2019 10:44:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tyler Hicks <tyhicks@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wang Hai <wanghai26@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] bridge: Fix error path for kobject_init_and_add()
Message-ID: <20190430084409.GD11737@kroah.com>
References: <20190430002817.10785-1-tobin@kernel.org>
 <20190430002817.10785-2-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430002817.10785-2-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:28:15AM +1000, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
