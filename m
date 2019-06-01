Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E01C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CBB2717F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFAITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 04:19:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46068 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 04:19:16 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BA44E28A1F8;
        Sat,  1 Jun 2019 09:19:15 +0100 (BST)
Date:   Sat, 1 Jun 2019 10:19:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: Use struct_size() helper
Message-ID: <20190601101912.2a609581@collabora.com>
In-Reply-To: <20190531173532.GA7141@embeddedor>
References: <20190531173532.GA7141@embeddedor>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 12:35:32 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*defslvs) + ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc))
> 
> with:
> 
> struct_size(defslvs, slaves, ndevs - 1)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/i3c/master.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index b9d2b88928e1..923b04052038 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -924,9 +924,8 @@ int i3c_master_defslvs_locked(struct i3c_master_controller *master)
>  		ndevs++;
>  
>  	defslvs = i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR,
> -					sizeof(*defslvs) +
> -					((ndevs - 1) *
> -					 sizeof(struct i3c_ccc_dev_desc)));
> +					struct_size(defslvs, slaves,
> +					ndevs - 1));

ndev - 1 should be aligned on the struct_size open parens, or even
better, be put on one line since it seems to fit the 80-chars limit:

defslvs = i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR,
				struct_size(defslvs, slaves, ndevs - 1));


>  	if (!defslvs)
>  		return -ENOMEM;
>  

