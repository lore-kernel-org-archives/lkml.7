Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C27AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110C62068D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKUUqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:46:07 -0500
Received: from winds.org ([68.75.195.9]:54434 "EHLO winds.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUUqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:46:06 -0500
Received: by winds.org (Postfix, from userid 100)
        id C91A110D2378; Thu, 21 Nov 2019 15:46:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id C6A8E1063606;
        Thu, 21 Nov 2019 15:46:05 -0500 (EST)
Date:   Thu, 21 Nov 2019 15:46:05 -0500 (EST)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Florian Westphal <fw@strlen.de>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] udp: drop skb extensions before marking skb
 stateless
In-Reply-To: <20191121055623.20952-1-fw@strlen.de>
Message-ID: <alpine.LNX.2.21.1.1911211544070.26591@winds.org>
References: <20191121053031.GI20235@breakpoint.cc> <20191121055623.20952-1-fw@strlen.de>
User-Agent: Alpine 2.21.1 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Florian Westphal wrote:

> Once udp stack has set the UDP_SKB_IS_STATELESS flag, later skb free
> assumes all skb head state has been dropped already.
>
> This will leak the extension memory in case the skb has extensions other
> than the ipsec secpath, e.g. bridge nf data.
>
> To fix this, set the UDP_SKB_IS_STATELESS flag only if we don't have
> extensions or if the extension space can be free'd.
>
> Fixes: 895b5c9f206eb7d25dc1360a ("netfilter: drop bridge nf reset from nf_reset")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Byron Stanoszek <gandalf@winds.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>

I confirm that this fixes the memory leak on my systems. Thank you for the fast
turnaround.

Regards,
  -Byron

