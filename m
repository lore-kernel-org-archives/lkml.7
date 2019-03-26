Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF38C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EDA20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563399;
	bh=1z5jZLcbsuXG/n/Jogp39/oFMe3gjqNKKx4jP11VJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+Gnqn6Y8dccdcB6pl1UaVF80jp+HVBm1eYI/lljGcW9H6zU2E45peq1Ny7AT4sZb
	 /YxolqSU8XhnR4+6oxThCBEDTvW0B9gcmhanq1CpD/y76p3yqzxa7ZWCj9l0pzua9e
	 /+C74sL7bmLcGY4Qyi+a0S6i00emqV28TTqjqBPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfCZBXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:23:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC182084D;
        Tue, 26 Mar 2019 01:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563396;
        bh=1z5jZLcbsuXG/n/Jogp39/oFMe3gjqNKKx4jP11VJt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntgpt/zT7niUMmUNxxnL2q8j1DMyeQHnq4GKOLbSI0xfZooSGFRZz7FkScFPsgCEI
         vERXXU0N4BjkAN5WMxcg8iiAK31q5+IhEe4TbxJ0oy+Bdl+it1oCoUOnFPWeQZGMVs
         KQVPbDpfq0QFjONgODd3duyBOlmUY+GENuoBklM8=
Date:   Tue, 26 Mar 2019 10:21:09 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Wei Wang <weiwan@google.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dccp@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 18/25] tcp/dccp: drop SYN packets if accept
 queue is full
Message-ID: <20190326012109.GD29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-19-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-19-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:09PM +0100, Arnd Bergmann wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Per listen(fd, backlog) rules, there is really no point accepting a SYN,
> sending a SYNACK, and dropping the following ACK packet if accept queue
> is full, because application is not draining accept queue fast enough.
> 
> This behavior is fooling TCP clients that believe they established a
> flow, while there is nothing at server side. They might then send about
> 10 MSS (if using IW10) that will be dropped anyway while server is under
> stress.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Neal Cardwell <ncardwell@google.com>
> Acked-by: Yuchung Cheng <ycheng@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 5ea8ea2cb7f1d0db15762c9b0bb9e7330425a071)

Also queued up for 4.9.y
