Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="r1oDaOpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDIOjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:39:36 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:53384 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:39:36 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 10:39:34 EDT
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 2287520225;
        Tue,  9 Apr 2019 16:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1554820444; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wf/HKXFJp77C3OBCoOQnY7LE7lLcS23G/i5zGo7W69k=;
        b=r1oDaOpFR3FBj2N0kfVgFcLRPFpX6Dmyw1yYIB6mhvDhEHfrTlV50CjfSoetsVTl0xd11H
        Hdx9KppFN3y3TQIE9WtlaOr1pHbp+Z50thdLGARuWOFfNX1FlpWVU8rQ+l5zbRjlyUT3i8
        csnruU7ahlR4q6lofJu7fKR+6dO2/ga90aZVyqeWTc++NucU8+VA8JXIMYTzeMfZyy25Cj
        /zJmjP6ldM93nzyAMvX/E/AMA5bI5zmo3yYYtUfKuIg7Y2C/VTkFwatyWqyu+k6MX6iNSq
        g7FxmMPvCKoNuzmyRLSa/a6gTAwFATn6jXweOBshY+gK76J+UxkNd39xA5oIbw==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 7C94FBEEBD;
        Tue,  9 Apr 2019 16:34:00 +0200 (CEST)
Message-ID: <5CACAD57.1030703@bfs.de>
Date:   Tue, 09 Apr 2019 16:33:59 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: cxgbi: remove redundant __kfree_skb call on skb
References: <20190409133819.21127-1-colin.king@canonical.com>
In-Reply-To: <20190409133819.21127-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 09.04.2019 15:38, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error return path via label rel_resource checks for a non-null
> skb before free'ing it.  However, skb is always null at this exit
> path, so the null check and the free are redundant and can be removed.
> Removing this allows the original goto's to rel_resource to be cleaned
> up; the first can be replaced by a return of -EINVAL, the second can
> be replaced by a more appropriate -ENOMEM return since allow_wr has
> failed go allocate some memory.
> 
> Addresses-Coverity: ("Logically Dead Code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> index 75e1273a44b3..5a4387f437d5 100644
> --- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> +++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> @@ -979,14 +979,14 @@ static int init_act_open(struct cxgbi_sock *csk)
>  	csk->atid = cxgb3_alloc_atid(t3dev, &t3_client, csk);
>  	if (csk->atid < 0) {
>  		pr_err("NO atid available.\n");
> -		goto rel_resource;
> +		return -EINVAL;
>  	}
>  	cxgbi_sock_set_flag(csk, CTPF_HAS_ATID);
>  	cxgbi_sock_get(csk);
>  
>  	skb = alloc_wr(sizeof(struct cpl_act_open_req), 0, GFP_KERNEL);
>  	if (!skb)
> -		goto rel_resource;
> +		return -ENOMEM;

I would expect a cxgb3_free_atid(csk->atid) here. Did i miss something ?

re,
 wh


>  	skb->sk = (struct sock *)csk;
>  	set_arp_failure_handler(skb, act_open_arp_failure);
>  	csk->snd_win = cxgb3i_snd_win;
> @@ -1007,11 +1007,6 @@ static int init_act_open(struct cxgbi_sock *csk)
>  	cxgbi_sock_set_state(csk, CTP_ACTIVE_OPEN);
>  	send_act_open_req(csk, skb, csk->l2t);
>  	return 0;
> -
> -rel_resource:
> -	if (skb)
> -		__kfree_skb(skb);
> -	return -EINVAL;
>  }
>  
>  cxgb3_cpl_handler_func cxgb3i_cpl_handlers[NUM_CPL_CMDS] = {
