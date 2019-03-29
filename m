Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2052C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0736217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SS5GrAAY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2TECxcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfC2N2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:28:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfC2N2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:28:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18EDC60D0C; Fri, 29 Mar 2019 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553866112;
        bh=ttxK1vHfpw0tY4gLSA2pokyf+ylJ1NAHeCZYUAoEuZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SS5GrAAYzNEHl6CAVvee+dk6QjK3RffWx2BBZEc4e4lDDfb9l9gh6c63haghPDHto
         QPhzlcxqcM7XKFR00Ul433Z9WcjQuLIIsjj2ztmlD8TEe2CqcATrJf0NnUTKMtrSGe
         QD/pleYj3xZJ0tC2yiDABGxwSSOOjou5GJxfDiZA=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B82260ACE;
        Fri, 29 Mar 2019 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553866109;
        bh=ttxK1vHfpw0tY4gLSA2pokyf+ylJ1NAHeCZYUAoEuZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q2TECxcnYHKAoM9/IfA96QNSBeVLL5e/Kz2Cx/3UysVNdB4MkLWqnOJAkaK8E0dEQ
         ik80ymul+CccVh8itc44MfiQYIvWI2/t6wyQMl5CMa2/SRwIKYeW0QO6bQ0ayeaRmJ
         hy7tuZYwUzNZuWjQd8AnTuN7z6olRV8UIw6tRvKo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B82260ACE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] rcu: tree_stall: Correctly unlock root node in
 rcu_check_gp_start_stall
To:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553858828-23097-1-git-send-email-neeraju@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7a9eed5a-9bcf-460c-abb9-1e9bd6eae102@codeaurora.org>
Date:   Fri, 29 Mar 2019 18:58:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553858828-23097-1-git-send-email-neeraju@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 4:57 PM, Neeraj Upadhyay wrote:
> Only unlock the root node, if current node (rnp) is not
> root node.
>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>



> ---
>   kernel/rcu/tree_stall.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index f65a73a..0651833 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h


why this is showing as under tree_stall.h while it is under 
"kernel/rcu/tree.c"

> @@ -630,7 +630,9 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
>   	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
>   	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
>   	    atomic_xchg(&warned, 1)) {
> -		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
> +		if (rnp_root != rnp)
> +			/* irqs remain disabled. */
> +			raw_spin_unlock_rcu_node(rnp_root);

Looks good as it will balance the lock .if it is the root_node, which 
was not there earlier, and unlock was happening without any lock on root.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>   		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   		return;
>   	}
