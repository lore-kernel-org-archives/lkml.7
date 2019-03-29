Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A63C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9902920811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ds/Ag/Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfC2KCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:02:25 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57954 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfC2KCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:02:24 -0400
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id EBC3924E2AAF;
        Fri, 29 Mar 2019 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1553853744; bh=n/hAicS4JO3SCAcW1j0Bor5yU57BYXIsWLe4ckI54D8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Ds/Ag/EycMrbNBJqzOT0DRz9j2T2kOZPdeHxoZ9a3bRiG0Ptp87oyvJ+uuCmKrmFl
         xJtqV8r6TfX4OfMNGS4EE/2xvRrHblxTenf72Wf9rBRjDYdPytDkNjm0OneP3g5UPF
         PFb+mI9OxYtX9k6C9Sd14Ls1lFZFrip0TclwD35cWFCaeqwEoyq/d9mcmWi6clYIMt
         VnAuoDjefYcFT4jPlzuVXc7Pt/Kwn5FyfqZ4mJN0xv8Ji1htBHHQVR8wg2kxtNoGAf
         BfAF5/wR7ebWJVf4T/e9TeRZRC1KogtVkU0ZYInYeV9Kt9ks1EMxwG1ix+RpL4VYP+
         qHhi9k2Bh9Y/g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB557A0098;
        Fri, 29 Mar 2019 10:02:22 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 Mar 2019 03:02:22 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 Mar 2019 11:02:22 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 Mar 2019 11:02:21 +0100
Subject: Re: [PATCH 1/6] net: stmmac: use correct DMA buffer size in the RX
 descriptor
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20190327203540.1884-1-aaro.koskinen@iki.fi>
 <20190327203540.1884-2-aaro.koskinen@iki.fi>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <5c480a83-dfcf-c20c-f277-4449a7b41403@synopsys.com>
Date:   Fri, 29 Mar 2019 10:02:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327203540.1884-2-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2019 8:35 PM, Aaro Koskinen wrote:
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> We always program the maximum DMA buffer size into the receive descriptor,
> although the allocated size may be less. E.g. with the default MTU size
> we allocate only 1536 bytes. If somebody sends us a bigger frame, then
> memory may get corrupted.
> 
> Fix by using exact buffer sizes.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

So, I'm seeing that the maximum allowed buffer size that can be
put in the descriptor changes between enhanced descriptors to
normal descriptors (8KB vs. 2KB right ?).

Shouldn't stmmac_main know about this limit before trying to init
descriptors ?

We do limit the MTU according to HW version but I would rather
prefer not having to need to calculate min() values in the
descriptor code and just use the value as is ...

Thanks,
Jose Miguel Abreu
