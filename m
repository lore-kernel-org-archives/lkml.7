Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E93218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LzTXjWqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfCOJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:47:40 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:55694 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:47:39 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D762624E1EE6;
        Fri, 15 Mar 2019 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552643259; bh=ht9KIVYJd+XQbOcjibfzz5Yqm4/3Gpbtp1/B/WRFVb4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=LzTXjWqmR2rIwe6aG/qnsql+j90FHNN0STnMiJ66/LFGT9T27fPvv5L4TP1nYbFSV
         NMyjTmjNSlfzoPaf1piUoqoAUe+PEYqmWxM4aBrxXvpke7/XUiaqmiIQZrqi0OKlho
         0wuhQ1fXcMdIvuU/XFQWWflPUQAfIXxGeYWRCWoWJYOczVbYpBdhAV6Y+ab3Mzdawp
         fl72J46g9ZqgHyLl2zP615EkQySNbRsyf2ApgmrFs1B16gLQQwVNj7ncz01ZGKzPCM
         LjvQparWW3aitVPf5GBjnDPcKrMMJVu4iEtTreY6bEywmhkdIganDB6cgavuS+TUyY
         HZ2z0iXjrXnuQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 655E1A0066;
        Fri, 15 Mar 2019 09:47:37 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 02:47:37 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 10:47:34 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Mar 2019 10:47:34 +0100
Subject: Re: [PATCH 1/2] net: stmmac: don't set own bit too early for jumbo
 frames
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <23cf7ae6-6262-ee45-3be7-75233dd27104@synopsys.com>
Date:   Fri, 15 Mar 2019 09:47:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314194320.25566-1-aaro.koskinen@iki.fi>
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
> Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
> routine") overlooked jumbo frames when re-ordering the code, and as a
> result the own bit was not getting set anymore for the first jumbo frame
> descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
> frames") tried to fix this, but now the bit is getting set too early and
> the DMA may start while we are still setting up the remaing descriptors.
> And with the chain mode the own bit remains still unset.
> 
> Fix by setting the own bit at the end of xmit also with jumbo frames.
> 
> Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
> Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

With Sergei comment fix:

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks,
Jose Miguel Abreu
