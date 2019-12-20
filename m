Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F7624680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLTMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:32:22 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57384 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfLTMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:32:21 -0500
Received: from 2606-a000-111b-43ee-0000-0000-0000-115f.inf6.spectrum.com ([2606:a000:111b:43ee::115f] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1iiHRt-00077n-5i; Fri, 20 Dec 2019 07:32:15 -0500
Date:   Fri, 20 Dec 2019 07:32:03 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Kevin Kou <qdkevin.kou@gmail.com>
Cc:     vyasevich@gmail.com, marcelo.leitner@gmail.com,
        davem@davemloft.net, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: do trace_sctp_probe after SACK validation and check
Message-ID: <20191220123203.GA5616@hmswarspite.think-freely.org>
References: <20191220044703.88-1-qdkevin.kou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220044703.88-1-qdkevin.kou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:47:03AM +0000, Kevin Kou wrote:
> The function sctp_sf_eat_sack_6_2 now performs
> the Verification Tag validation, Chunk length validation, Bogu check,
> and also the detection of out-of-order SACK based on the RFC2960
> Section 6.2 at the beginning, and finally performs the further
> processing of SACK. The trace_sctp_probe now triggered before
> the above necessary validation and check.
> 
> This patch is to do the trace_sctp_probe after the necessary check
> and validation to SACK.
> 
> Signed-off-by: Kevin Kou <qdkevin.kou@gmail.com>
> ---
>  net/sctp/sm_statefuns.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 42558fa..b4a54df 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -3281,7 +3281,6 @@ enum sctp_disposition sctp_sf_eat_sack_6_2(struct net *net,
>  	struct sctp_sackhdr *sackh;
>  	__u32 ctsn;
>  
> -	trace_sctp_probe(ep, asoc, chunk);
>  
>  	if (!sctp_vtag_verify(chunk, asoc))
>  		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
> @@ -3319,6 +3318,8 @@ enum sctp_disposition sctp_sf_eat_sack_6_2(struct net *net,
>  	if (!TSN_lt(ctsn, asoc->next_tsn))
>  		return sctp_sf_violation_ctsn(net, ep, asoc, type, arg, commands);
>  
> +	trace_sctp_probe(ep, asoc, chunk);
> +
>  	/* Return this SACK for further processing.  */
>  	sctp_add_cmd_sf(commands, SCTP_CMD_PROCESS_SACK, SCTP_CHUNK(chunk));
>  
> -- 
> 1.8.3.1
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
