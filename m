Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8265C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17221841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="USpN0r7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfCVPu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41974 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCVPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so1802070pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jys16SbOV6LXMFuPXraz4zkoDank0KKEN5f828e0ghI=;
        b=USpN0r7fC0QeamtVZwXo8tKXjp8QtAO3esKnf51OVHv7O6ErxJ50wER0o4bQSLeNg+
         pn0s8/Y5AzWNRg14dv5SE1qbSFkDj+EGNGM3ILstfHiitalmNqj/XB2W4VDXz0kFH1wT
         nrxdv0iosoYI+E3Msl600b+STbZd9QujnpZiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jys16SbOV6LXMFuPXraz4zkoDank0KKEN5f828e0ghI=;
        b=feqGp+GZzayXXcmxs+re3vSro0UfylVHWlP9uxKAf2Z63hrtEMt3gK+8Mr8Kg4WfhW
         ubM6M518E487dpkoN4R2lCGUXgr/15Uzv64LezipfAaS4nyA1P4cn0z3GYaVnRrR3kD+
         kY/Djg/KQf/ZmgxFiTEi1KscQPBMKQ6mUW+KzUf/UFylCr0ey6qADDlsGEanSwjs/O3B
         ryPSwqGq/YBM3u3cPtgTXwTy1PFTgkeu53ZYAkk84mVausUrT/tPa2Wm8S+I7tCM60to
         q90BToFSTJm2bgUEYLweyNNqkb8t4HHuvWJx7KiPuPMbMDmWIAuKoMIFu9WxTpb3jgcp
         hFig==
X-Gm-Message-State: APjAAAW3517wqLtyE+3jTPl/SpHNnqOpelkfjWmOSnBoZIi9/yZt3gFN
        pnB4l0T1VohWJD3uwVRv9ynL0A==
X-Google-Smtp-Source: APXvYqyd/a5/Ro9HRqULPZUlqL090jF9XCPquQ2M4SA+JfKlr3DrQBHgaaL7ArYQ1gBgcP0ATWZtag==
X-Received: by 2002:a17:902:1a9:: with SMTP id b38mr10253285plb.37.1553269826628;
        Fri, 22 Mar 2019 08:50:26 -0700 (PDT)
Received: from [172.27.227.215] ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id j17sm4992790pfa.51.2019.03.22.08.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:50:25 -0700 (PDT)
Subject: Re: [PATCH net] net: vrf: remove redundant vrf neigh entry
To:     linmiaohe <linmiaohe@huawei.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <ad33efdf-2627-2b5e-978b-886e4771db49@cumulusnetworks.com>
Date:   Fri, 22 Mar 2019 16:50:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 3:10 PM, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When vrf->rth is created, it wouldn't change in his lifetime.And in
> func vrf_finish_output, we always create a neigh with ip_hdr(skb)->daddr
> as key because rth->rt_gateway is equal to 0. But I think we only need
> one vrf neigh entry because we strip the ethernet header and reset the
> dst_entry in vrf_process_v4_outbound.
> So I set rth->rt_gateway to loopback addr(It's ok to set any other
> valid ip address, just choose one.). And we would only create one vrf
> neigh entry. This helps saving some memory and improving the hitting
> rate of neigh lookup.
> If there is something I misunderstand, it's very nice of you to
> let me know. Thanks a lot.
> 
> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
> ---
>  drivers/net/vrf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 7c1430ed0244..2b0227fb8f53 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -738,6 +738,7 @@ static int vrf_rtable_create(struct net_device *dev)
>  		return -ENOMEM;
> 
>  	rth->dst.output	= vrf_output;
> +	rth->rt_gateway = htonl(INADDR_LOOPBACK);
> 
>  	rcu_assign_pointer(vrf->rth, rth);
> 

Did you investigate how neighbor entries are getting created? The vrf
device has IFF_NOARP set, so neigh entries should not be created.
