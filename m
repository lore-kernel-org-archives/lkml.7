Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575662083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfCAWWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:22:35 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:53543 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbfCAWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:22:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8264818224D65;
        Fri,  1 Mar 2019 22:22:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub56_8a8f7680ec829
X-Filterd-Recvd-Size: 1848
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Mar 2019 22:22:32 +0000 (UTC)
Message-ID: <9bcd6a2389a8ffce41768ddc8b224daedacf76b7.camel@perches.com>
Subject: Re: [PATCH] sctp: chunk.c: correct format string for size_t in
 printk
From:   Joe Perches <joe@perches.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 14:22:30 -0800
In-Reply-To: <20190228113652.55552-1-maennich@google.com>
References: <20190228113652.55552-1-maennich@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 11:36 +0000, Matthias Maennich wrote:
> According to Documentation/core-api/printk-formats.rst, size_t should be
> printed with %zu, rather than %Zu.
> 
> In addition, using %Zu triggers a warning on clang (-Wformat-extra-args):
[]
> diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
[]
> @@ -192,7 +192,7 @@ struct sctp_datamsg *sctp_datamsg_from_user(struct sctp_association *asoc,
>  	if (unlikely(!max_data)) {
>  		max_data = sctp_min_frag_point(sctp_sk(asoc->base.sk),
>  					       sctp_datachk_len(&asoc->stream));
> -		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%Zu)",
> +		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%zu)",
>  				    __func__, asoc, max_data);

trivia: the format is also missing a terminating '\n'

