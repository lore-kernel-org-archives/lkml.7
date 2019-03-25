Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB920863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfCYAN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:13:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44706 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfCYAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:13:58 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CB023108AE0DE;
        Sun, 24 Mar 2019 17:13:57 -0700 (PDT)
Date:   Sun, 24 Mar 2019 20:13:57 -0400 (EDT)
Message-Id: <20190324.201357.1580092867848179795.davem@davemloft.net>
To:     Markus.Amend@telekom.de
Cc:     gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org
Subject: Re: [PATCH] net: dccp: Checksum verification considering
 skb->ip_summed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <FRAPR01MB11703F861DE24373440FD1C0FA430@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
References: <FRAPR01MB11703F861DE24373440FD1C0FA430@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Mar 2019 17:13:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Markus.Amend@telekom.de>
Date: Fri, 22 Mar 2019 14:34:58 +0000

> @@ -786,7 +787,8 @@ static int dccp_v4_rcv(struct sk_buff *skb)
>  
>  	iph = ip_hdr(skb);
>  	/* Step 1: If header checksum is incorrect, drop packet and return */
> -	if (dccp_v4_csum_finish(skb, iph->saddr, iph->daddr)) {
> +	if (__skb_checksum_validate(skb, IPPROTO_DCCP,
> +		  true, false, 0, inet_compute_pseudo)) {

The arguments on the second and subsequent lines of a function call must
begin precisely at the first column after the openning parenthesis of
the first line of the function call.

You must use the appropriate number of TAB, then SPACE, characters
necessary to achieve this.
