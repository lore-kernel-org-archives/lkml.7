Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86672206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuG8Ha+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfGXTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:06:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45372 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfGXTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:06:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so35815752oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KtVufpUZ58RU1zjgPmdl20B5uByd2wRviCv9GvHavsA=;
        b=tuG8Ha+oSAtwsR4BbKKoyd9ulnXWMTMdpz/YKgw9EYJKCYWBQ/kZid41q/fA/e6CDO
         AQxkB1tGGqrvUpaL0UouB7KkqHTZbadmIROZGVFj1J7jMraVgWtDljvvb8nRYmjT9eK5
         ebQdnAN+WAZTqwQ+w58NC6++5xhIjJMXrHA+iN8b4Z5p37ADlVxtBgC6KCzF+DyzydMb
         49iFZmYr7OnPMzeIjA90eYBr+8nACOaajs1YLugcYBmo8hDaJxzeKPt9bxCOwJ+aUxrF
         GfGGaKJJbpieNE1wnu7hZX5CVjFeTNvcOEdueYy76sHfMETWsmoI7/0JyLtwM8KAGN96
         uzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=KtVufpUZ58RU1zjgPmdl20B5uByd2wRviCv9GvHavsA=;
        b=qObrAhFpal1RGoVj2Ck7noOIuHyAy1/AA2AFt1cCSg8C3QKb70E0gy3cYE5PiJRGC4
         fYHHdZPwye0uqraVwK6FGClfKgiQXgNc7AD22h0bBkPkDBvhg2gpDzEA2SX9+4EhuUzY
         4vuNk7pGCYxLAolQyBstkv1Bn7FMNFe1v7v0yQiuW2geRDWwHgHU99XqBjKp5cnx+rEu
         g5J2nfSzn4Gv9xG7+7g0FqSNtcENmWV5iDuV6LzPKjHhDS3+ruxj3HJ41oFRPbD1g3pv
         KLuGZzvhJWix2l2L15pdv67Pmj0dsz2gCSyU7g8XiiHwwgqc38p85H5xKDLwaZSls+fK
         eKxw==
X-Gm-Message-State: APjAAAWDuaX1WmPYaN4c/6gMpKigV5W7ZfCehoNiEynmkMWB3WEB7MVE
        bcUg3ikSF4emTNPvTP/UNA==
X-Google-Smtp-Source: APXvYqwUL4XU6vjsGnIPIda+dqEDI/OsMsv4nBlRQ7au1JpY+irFSh4d96JzD5wp6h9LKTPiRf0wPA==
X-Received: by 2002:aca:4588:: with SMTP id s130mr40179886oia.79.1563995203864;
        Wed, 24 Jul 2019 12:06:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f84sm16164089oig.43.2019.07.24.12.06.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:06:42 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2041:57e1:ec94:5f0c])
        by serve.minyard.net (Postfix) with ESMTPSA id D66DB1800CD;
        Wed, 24 Jul 2019 19:06:41 +0000 (UTC)
Date:   Wed, 24 Jul 2019 14:06:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Message-ID: <20190724190640.GK3066@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1563978634.git.Asmaa@mellanox.com>
 <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:45:57PM -0400, Asmaa Mnebhi wrote:
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Sorry to be picky here, but it's considered bad style to have an
empty message.  I probably wasn't clear before, but you should
add some text like "Found by build regression/improvement testing."
or something like that.  Just so people know where it was found.

Could you also add a "Fixes" field?  This is important in case
someone pulls the original patch, they can look forward and see
if any bugs were fixed.  From the kernel docs:

If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts.  For example::

        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")

I was going to do that myself, but since another spin is required...

Thanks,

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 5720433..285e0b8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -76,7 +76,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
>  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
>  	struct ipmb_request_elem *queue_elem;
>  	struct ipmb_msg msg;
> -	ssize_t ret;
> +	ssize_t ret = 0;
>  
>  	memset(&msg, 0, sizeof(msg));
>  
> -- 
> 2.1.2
> 
