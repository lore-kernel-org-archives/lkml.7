Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B930EC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 00:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762EC2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 00:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ZGp4MnmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHQANy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 20:13:54 -0400
Received: from mail.nic.cz ([217.31.204.67]:36010 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHQANw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:52 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 20:13:51 EDT
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 09E4D140C8A;
        Sat, 17 Aug 2019 02:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1566000275; bh=o3hrlRW5CjoVs+pdk8G3E3sTG4fodRvbVKqZjz8Y5g4=;
        h=Date:From:To;
        b=ZGp4MnmTDMXnO8kS2M1/ODPbtfZRPlSY8ceZr9X7/zUoeS4pSCUH+T9p0qqE0Xot2
         wVlBdQWIvSqc2CCyzVxzYtYLK7R8fkViMheVJ83lgylLqWZWIig7msb8ciQ3mgoi1J
         HlPbGtY9F9UBCKtBPrtWhrjQdIoGGWD+/hccD6nw=
Date:   Sat, 17 Aug 2019 02:04:34 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bus: moxtet: fix unsigned comparison to less than
 zero
Message-ID: <20190817020434.4ef2dc5f@nic.cz>
In-Reply-To: <20190816224106.11583-1-colin.king@canonical.com>
References: <20190816224106.11583-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.3 at mail.nic.cz
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 23:41:06 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the size_t variable res is being checked for
> an error failure however the unsigned variable is never
> less than zero so this test is always false. Fix this by
> making variable res ssize_t
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 5bc7f990cd98 ("bus: Add support for Moxtet bus")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/bus/moxtet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 1ee4570e7e17..288a9e4c6c7b 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -514,7 +514,7 @@ static ssize_t output_write(struct file *file, const char __user *buf,
>  	struct moxtet *moxtet = file->private_data;
>  	u8 bin[TURRIS_MOX_MAX_MODULES];
>  	u8 hex[sizeof(bin) * 2 + 1];
> -	size_t res;
> +	ssize_t res;
>  	loff_t dummy = 0;
>  	int err, i;
>  

Hi Colin,
thanks. Should I just Ack this, or do I need to send patch to the
developer who commited my patches?
Thanks.

Marek
