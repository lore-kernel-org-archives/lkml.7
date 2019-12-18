Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9792467E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLRI1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:27:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:27:51 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B9B71291FC9;
        Wed, 18 Dec 2019 08:27:49 +0000 (GMT)
Date:   Wed, 18 Dec 2019 09:27:46 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] i3c: make 'i3c_bus_set_mode' static
Message-ID: <20191218092746.28ebf54c@collabora.com>
In-Reply-To: <20191217120150.2134326-1-ben.dooks@codethink.co.uk>
References: <20191217120150.2134326-1-ben.dooks@codethink.co.uk>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben,

On Tue, 17 Dec 2019 12:01:50 +0000
"Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk> wrote:

> The function i3c_bus_set_mode() is not declared or
> exported, so make it static to avoid the following
> warning:
> 
> drivers/i3c/master.c:530:5: warning: symbol 'i3c_bus_set_mode' was not declared. Should it be static?
> 
> If it is needed in the future, then it should be declared
> and suitably exported.
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Thanks for this patch, but I already a similar fix [1].

Regards,

Boris

[1]https://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git/commit/?h=i3c/next&id=026d8450d499904f4712676e2149cdb758d0a601

> ---
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: linux-i3c@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/i3c/master.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 043691656245..7f8f896fa0c3 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -527,8 +527,8 @@ static const struct device_type i3c_masterdev_type = {
>  	.groups	= i3c_masterdev_groups,
>  };
>  
> -int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
> -		     unsigned long max_i2c_scl_rate)
> +static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
> +			    unsigned long max_i2c_scl_rate)
>  {
>  	struct i3c_master_controller *master = i3c_bus_to_i3c_master(i3cbus);
>  

