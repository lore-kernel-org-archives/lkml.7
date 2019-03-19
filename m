Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5492220989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CXfcdZ0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfCSKhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:37:34 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:48198 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:37:32 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id E430224E25C3;
        Tue, 19 Mar 2019 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552991851; bh=6kxg2tSxEykM74vBi5zgLmyDXj9+ZFUZTCyY8+H2Wjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=CXfcdZ0Si7Ta5Z6YOXJzTe4QpgidFLYE0aJbzpbCY3mwZ352uiHwDzf0wbYDNB7G0
         DvdVRYyCjOuTKnSV+9ypPuO4ztpD/TmU7ka8hybqENWeiD1L2Dr/4H/MDsAmrrzaGs
         MFCOvlh8mzHt8P45wEhz3uqxy+cAwV1QULtAZL3Bg8fiTzYAlcEpnUAQyghj+Rou1/
         QbNqk5iGT1ote4WD/hS4ezsWGw4vd4TGRDOQAUsixb5wqIu4mntNfwMIyvBpMM8TBP
         HWr98WzP+FJOUjP9bWUk5g8t7+BhscAGERJaZ6gpJZxgxwHo3Tv5NDa9qSbdKLA4FM
         i9m+UPkLSUIsg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D7F47A0093;
        Tue, 19 Mar 2019 10:37:29 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 03:36:43 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 11:36:21 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 11:36:20 +0100
Subject: Re: [PATCH] net: stmmac: fix memory corruption with large MTUs
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20190318213608.612-1-aaro.koskinen@iki.fi>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <92e465e5-0c77-e22f-d7e1-4689f3d655e7@synopsys.com>
Date:   Tue, 19 Mar 2019 10:36:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318213608.612-1-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/2019 9:36 PM, Aaro Koskinen wrote:
>  	/* Fill DES3 in case of RING mode */
> -	if (priv->dma_buf_sz >= BUF_SIZE_8KiB)
> +	if (priv->dma_buf_sz == BUF_SIZE_16KiB)

Shouldn't this be: "if (priv->dma_buf_sz > BUF_SIZE_8KiB)" ?

Thanks,
Jose Miguel Abreu
