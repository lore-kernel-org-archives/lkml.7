Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214AC3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A84206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="G6XZ9Ojs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgACBh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:37:29 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24157 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgACBh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:37:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578015447; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BIkC8TGDTtb25luxTx2OTLtc+r/j75Se8xqph41KguU=;
 b=G6XZ9Ojs3LunjVOWzAJH+6prGyyHA6j69Xhw2TIqbZrhMmMOUXGEbb4OaRLHEsBU3JgHGGIN
 qFYESWpwwBB4D1gEp5a3kbK+G6z5xHY6UGOW5hzhIaYOwfL0549sZIAcgDUeNdxWyWVvlTjn
 cxvV65pQfnRVbYFeezQzRKIQuvw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0e9ad7.7f61c7275ed8-smtp-out-n01;
 Fri, 03 Jan 2020 01:37:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D9F7C433A2; Fri,  3 Jan 2020 01:37:27 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBD83C433CB;
        Fri,  3 Jan 2020 01:37:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Jan 2020 09:37:26 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue
In-Reply-To: <20200102.162249.948673283541180133.davem@davemloft.net>
References: <20191231093242.6320-1-wgong@codeaurora.org>
 <20200102.162249.948673283541180133.davem@davemloft.net>
Message-ID: <297b94fe2eb5a20c75c2095e9640a495@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-03 08:22, David Miller wrote:

> I don't think this is correct.
> 
> The 'hdr' was already "pushed" earlier in this file.
> 
> Here we are padding the area after the header, which is being "put".
> 
> I'm not applying this.  If you still think it is correct, you must 
> explain
> in detail why it is and add that description to the commit log message.
> 
> Thank you.

Thanks David.
I will add more description and send patch v2.
