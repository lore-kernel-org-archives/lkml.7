Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAA521872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iDoMYGmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfCOJuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:50:21 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:32804 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:50:21 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5968310C25AB;
        Fri, 15 Mar 2019 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552643420; bh=c+Qr1Ias9dKk1NS/aXZYKW+l14PZkCpHCox4/2k3HfY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=iDoMYGmJZnkvzl2kfBijvGZ5FPOFwJOuu+vUQQ47AxrEuycmzzdRB7vEFzVJRk2tR
         ao/QQN4Nyxnt9Vl3wffClQo5XBiTbO3PnHhWQmoxtY5WZG4Gtd3rApeUP1QoM+vM5v
         77lu8F7j6dGWbwcwl8VytXtCYfeldGFtjh7v9huOecRh9r6X/RSl3KNyJN24V91nOE
         xF0ZVhG6vphGVopGtEZLf43qhIpga2Dfgy4+la84Bq0PsKBb4tbv1pp1x//dHD7/Sm
         ng6xyHjJShyqIOi0Zxf6iube+7zqvOK+sT9CCqgwBoktRPRVdcGQYiWtO1msQv9ZPB
         k6+zyfYppuU5A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 06960A0071;
        Fri, 15 Mar 2019 09:50:18 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 02:50:18 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 10:50:16 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 10:50:16 +0100
Subject: Re: [PATCH 2/2] net: stmmac: fix jumbo frame sending with non-linear
 skbs
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
 <20190314194320.25566-2-aaro.koskinen@iki.fi>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <08a089e6-16a7-1f6c-e356-a5bcea360078@synopsys.com>
Date:   Fri, 15 Mar 2019 09:50:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314194320.25566-2-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2019 7:43 PM, Aaro Koskinen wrote:
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> When sending non-linear skbs with jumbo frames, we set up the non-paged
> data and mark that as a last segment, although the paged fragments are
> also prepared. This will stall the TX queue and trigger a watchdog warning
> (a simple reproducer is to run an iperf client mode TCP test with a large
> MTU - networking fails instantly).
> 
> Fix by checking if the skb is non-linear.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks,
Jose Miguel Abreu
