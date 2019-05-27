Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26721C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24C820815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="NPKhxVwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfE0VUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 17:20:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37819 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0VU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 17:20:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id p15so7441026pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40aJElXopBegwzQ8ePRCnoFLtpNJc5rE4Ki98H/K1kU=;
        b=NPKhxVwWIJx1LBNcBDtLUSddXV3ry9beJwFVJ2YMKrSq1tDX95FVXmKdbkjTxdZI65
         k/Ig9dYusogLBmCK5MHijRT3qmVmtwUjOLaOAtjQXrfFUIw06exZ4/dTMKIB5zh8iiFW
         gHunJ6toz742yaS/xOYA/pM+4+/bKfwphM5YufcAwCrF/0ra9kH8RzsRQZVk3Q8FZi7D
         ThtbNC/duHrziFlzWz8WqCIvla8AZItOYDe8aq/9rZMCQvUzEpr6BZ5sXr3U0NwwoozQ
         zEsdyNIatSoyweoCvhD5VCgaMa2xssIKzv92fZeqix3IpSV7gF/b92VGQMKdo9eLReQp
         o+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40aJElXopBegwzQ8ePRCnoFLtpNJc5rE4Ki98H/K1kU=;
        b=UFhb9Lnn1591FEUQj4pSgwaltSa6Vh6s6grFm1T6lJxqF/VwJtjzOZs9BcXL/6pDQT
         ymTHmmElsxF/zYpFAHANUR2Hk7gW/p4VxJAjSLlMUgi/Wz2P21zrMP2b2QMOATQT6UEK
         8T+vRj54PtXX3PnmTU1pGc2+i+tvdRH0yx7W1M252g+dVp7hisxY1FfVTwb3EwWQdSfl
         oZ+GrwKG55e1cGL9EkFjdBoQeqyJL1zQV/yv4vRQe2r2Fgd1ofb03OzrvGM9L48iWtw9
         TnywjTkPKtMwGe/GSRcHMmr4xz1YdE+NzONcQCzr8CYmIxlvIlW3JbOA+TdPgaGYkcVH
         YtKA==
X-Gm-Message-State: APjAAAUC3KD1DGOEEZ66TKBqjSdhYaWMZM8DiSzNYEV7K4V4w/OSHNuP
        kn1T5UvKnYsUlfJYZLjp+vKpfQ==
X-Google-Smtp-Source: APXvYqxjDmo6wDOGUSnTI0w7VelrYirVcIj/BheUlfjtmSE5nkCUUQJ1ZacRrKocZr/TJmNDzlc3cQ==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr131102396pld.284.1558992028676;
        Mon, 27 May 2019 14:20:28 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id t24sm10900074pfq.63.2019.05.27.14.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 14:20:28 -0700 (PDT)
Date:   Mon, 27 May 2019 14:20:26 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] macvlan: Replace strncpy() by strscpy()
Message-ID: <20190527142026.3a07831f@hermes.lan>
In-Reply-To: <20190527183855.GA32553@embeddedor>
References: <20190527183855.GA32553@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 13:38:55 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> The strncpy() function is being deprecated. Replace it by the safer
> strscpy() and fix the following Coverity warning:
> 
> "Calling strncpy with a maximum size argument of 16 bytes on destination
> array ifrr.ifr_ifrn.ifrn_name of size 16 bytes might leave the destination
> string unterminated."
> 
> Notice that, unlike strncpy(), strscpy() always null-terminates the
> destination string.
> 
> Addresses-Coverity-ID: 1445537 ("Buffer not null terminated")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/macvlan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 61550122b563..0ccabde8e9c9 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -831,7 +831,7 @@ static int macvlan_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	struct ifreq ifrr;
>  	int err = -EOPNOTSUPP;
>  
> -	strncpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
> +	strscpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
>  	ifrr.ifr_ifru = ifr->ifr_ifru;
>  
>  	switch (cmd) {

Why not use strlcpy like all the other places IFNAMSIZ is copied?
