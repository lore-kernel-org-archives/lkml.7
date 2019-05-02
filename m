Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02827C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C610020873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="ckSN3bxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBFtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:49:36 -0400
Received: from mail2.skidata.com ([91.230.2.91]:53825 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfEBFtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1556776197; x=1588312197;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cOnYhEx5pXVlfHn6Zs23yAt72R9SWUDC2PhFzOaJjEY=;
  b=ckSN3bxz0mlcC03/i1dCvSSmUpvgM8zJQfcrT3tQ9OvOo4iXSDHy6Zuq
   xCfv9fuVXcOQB/XOfkOWK9RzMC9JqAfcM53Cj26JbzhRw7BIE3vajC9/b
   wTtAN4/idDQ9aIUMFPYld2icsk4bht1SWf5txTB8svKRY0STOIjOrN8W9
   cIjDOtSztfRpsfdYM3N2a/Vo6p7e1c9GxxCzBH8wdBygicWfr8PxNX2fe
   RKp6UvsHqBnBu9jBrryJhHgK/LyiNHhiZDZ6biRBDQ/TUsbe/bMinW7f9
   J4SMdmBiblKur5TylIUsnDnTc5iC4UyDRjCrzevbrlYNhS5+OxoYF0T0k
   Q==;
IronPort-SDR: MIy5BJHLa/U3XJG72jLA3Hk08QIcy/ZpWW7TH+Xo+qztfMList5auJAb99dkynpJbRZ9hA/C/z
 Qpb1QVcslgR0it2eK2YrXqL3J5PaT3kipRP8BGivdlRVnEQV5cz/G/lyj4EO+KyOR1zn/Fl77K
 Zef0Q5Bcey+m2ZMhagi7BRmd1MiHWuCGXoShJmJGtMTVGUElyPVkdKcwLuN0g+QctyjAG/q44A
 PDbXv45HOMS2ssPDQOs5S2W6tXOt3d6pQon3BeTIWbzaR3q96zwwd71KqoeHitpno8TPWICfcj
 IOE=
X-IronPort-AV: E=Sophos;i="5.60,420,1549926000"; 
   d="scan'208";a="2117530"
Subject: Re: [PATCH 3/3] usb: usb251xb: Add US port lanes inversion property
To:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
 <20190424211208.17499-4-fancer.lancer@gmail.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <74095a9d-5af3-1e1c-33c0-74c9784d3854@skidata.com>
Date:   Thu, 2 May 2019 07:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424211208.17499-4-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2019 23:12, Serge Semin wrote:
> The driver bindings already declare the "swap-dx-lanes" property to
> invert the downstream ports lanes polarity. The similar config
> can be defined for a single upstream port - "swap-us-lanes". It's
> going to be boolean since there is only one upstream port
> on the hub.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   drivers/usb/misc/usb251xb.c | 2 ++
>   1 file changed, 2 insertions(+)

Acked-by: Richard Leitner <richard.leitner@skidata.com>
