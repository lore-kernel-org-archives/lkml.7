Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0309C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E64218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfC2R44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:56:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53968 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfC2R4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:56:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1BAF14EF9874;
        Fri, 29 Mar 2019 10:56:52 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:56:52 -0700 (PDT)
Message-Id: <20190329.105652.1950793642095951687.davem@davemloft.net>
To:     Markus.Amend@telekom.de
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dccp@vger.kernel.org
Subject: Re: [PATCH v2] net: dccp: Checksum verification enhancement
From:   David Miller <davem@davemloft.net>
In-Reply-To: <FRAPR01MB117083E6F526BDCB88742713FA5F0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
References: <FRAPR01MB117083E6F526BDCB88742713FA5F0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Mar 2019 10:56:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Markus.Amend@telekom.de>
Date: Tue, 26 Mar 2019 08:54:41 +0000

> Modify checksum verification to allow the validation of skb->ip_summed, in case the checksum has already been verified in lower layers.

Please format your commit message to ~80 column lines.

> @@ -763,8 +763,9 @@ int dccp_invalid_packet(struct sk_buff *skb)
>  	}
>  
>  	/* If header checksum is incorrect, drop packet and return.
> -	 * (This step is completed in the AF-dependent functions.) */
> -	skb->csum = skb_checksum(skb, 0, cscov, 0);
> +	 * (This step is completed in the AF-dependent functions.)
> +	 * skb->csum = skb_checksum(skb, 0, cscov, 0);
> +	 */

Please do not just comment out code, explain what is operation can be expected
to be done already here and why.
