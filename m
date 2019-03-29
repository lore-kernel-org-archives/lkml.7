Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE55C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDED2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fIxIIwwW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jRxo3qpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfC2KMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfC2KMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DBA060AA3; Fri, 29 Mar 2019 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553854372;
        bh=K4Y+LP1DzkWTHtQ6YZCuRcfRS2ftY+C0r2s9gCi5ZLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fIxIIwwWIeUXeAtsxPuRcA/uf207j5Jo0MSuZ0TAT+hXgE9R3aIUa6ybrsqyCefr9
         OhK691QpS+9N1htCemZgfUQnns5b/O/0PBc7dtK2P2gBBhmnRrlhoXPqGHljLkdBQ9
         ZfJbx3dxmB1aXwmucF/PZaT4X2BtFkUprY19VlZc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A45FB6063A;
        Fri, 29 Mar 2019 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553854371;
        bh=K4Y+LP1DzkWTHtQ6YZCuRcfRS2ftY+C0r2s9gCi5ZLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jRxo3qpJznW7OyV19vVacj2s2z2u0lXDL3BcTs0L4AfU/xFqSX5ibfpJAlyMcquLg
         fwzzOr9VBzdmk60y4yWZkUnuzitvhBzavCcnUupn819pxHVRzP3maiKZv9kMk2SYCx
         OP2HkWof/b0TEwC+sp+tkz/GXZM/120hdv+0tuxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A45FB6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] rcu: tree_plugin: Dump specified number of blocked tasks
To:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553853352-14253-1-git-send-email-neeraju@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <35a95581-138d-b047-b809-aff803287a23@codeaurora.org>
Date:   Fri, 29 Mar 2019 15:42:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553853352-14253-1-git-send-email-neeraju@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 3:25 PM, Neeraj Upadhyay wrote:
> dump_blkd_tasks() uses 10 as the max number of blocked
> tasks, which are printed. However, it has an argument
> which provides that number. So, use the argument value
> instead. As all callers currently pass 10 as the number,
> there isn't any impact.
>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Looks good to me.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   kernel/rcu/tree_plugin.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3960294..08bcd87 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -740,7 +740,7 @@ void exit_rcu(void)
>   	i = 0;
>   	list_for_each(lhp, &rnp->blkd_tasks) {
>   		pr_cont(" %p", lhp);
> -		if (++i >= 10)
> +		if (++i >= ncheck)
>   			break;
>   	}
>   	pr_cont("\n");
