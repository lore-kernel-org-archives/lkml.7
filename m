Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABEC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C542084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="UwQFIvQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfIKNMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:12:05 -0400
Received: from mail.nic.cz ([217.31.204.67]:60966 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfIKNME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:12:04 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id BB45E14153F;
        Wed, 11 Sep 2019 15:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1568207522; bh=6TGcU3a9gFfkFdQv45BkqglSwUggFy53bqdDfQ0bug4=;
        h=Date:From:To;
        b=UwQFIvQz9qO5nVUy+FcNwSAI5T6FgCjQJ4ztK8x8I+HjJxpYd1kt4Ap4zPt25LZ+J
         jD9ZkZrMb9p1zyecaIbd+/Yh8YS+bVLACBh7DLQ6zBK+jS4nKBAWBRYLirPEr8klwM
         5TKzwxXEerRWiDI/P5FirJvJDAJNeRvzAeMgK6XU=
Date:   Wed, 11 Sep 2019 15:12:02 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: moxtet: Update proper type 'size_t' to 'ssize_t'
Message-ID: <20190911151202.0002d12b@nic.cz>
In-Reply-To: <20190911055938.GA130589@LGEARND20B15>
References: <20190911055938.GA130589@LGEARND20B15>
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

Hi Austin,
this was already fixed and is staged for soc/for-next, see
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=for-next&id=6811d26df50d96635dd339cf8cdf43a6abc0c4b6

Thanks,
Marek

On Wed, 11 Sep 2019 14:59:38 +0900
Austin Kim <austindh.kim@gmail.com> wrote:

> The simple_write_to_buffer() returns ssize_t type value,
> which is either positive or negative.
> 
> However 'res' is declared as size_t(unsigned int)
> which contains non-negative type.
> 
> So 'res < 0' statement is always false,
> this cannot execute execptional-case  handling.
> 
> To prevent this case,
> update proper type 'size_t' to 'ssize_t' for execptional handling.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  drivers/bus/moxtet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 1ee4570..288a9e4 100644
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

