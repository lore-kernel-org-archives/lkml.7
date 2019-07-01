Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F6CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B6821850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfGAQKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:10:36 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:51287 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726646AbfGAQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:10:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 47501629;
        Mon,  1 Jul 2019 16:10:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: act42_3f2b48fec7d3c
X-Filterd-Recvd-Size: 1392
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Jul 2019 16:10:33 +0000 (UTC)
Message-ID: <42624f83da71354a5daef959a4749cb75516d37f.camel@perches.com>
Subject: Re: [PATCH net] ipv4: don't set IPv6 only flags to IPv4 addresses
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Date:   Mon, 01 Jul 2019 09:10:32 -0700
In-Reply-To: <20190701160805.32404-1-mcroce@redhat.com>
References: <20190701160805.32404-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-01 at 18:08 +0200, Matteo Croce wrote:
> Avoid the situation where an IPV6 only flag is applied to an IPv4 address:
[]
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
[]
> @@ -468,6 +473,9 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
>  	ifa->ifa_flags &= ~IFA_F_SECONDARY;
>  	last_primary = &in_dev->ifa_list;
>  
> +	/* Don't set IPv6 only flags to IPv6 addresses */

umm, IPv4 addresses?


