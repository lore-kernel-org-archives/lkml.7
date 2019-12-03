Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361D020674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pUTeoB/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfLCWz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41670 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfLCWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so5721747ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Cr74USMS7o2KnmyixbloqBJA2JGrzMyz1VPBNGaTjTU=;
        b=pUTeoB/B/c7n3sIbM6o9Y00LsAXCHxNwVMJsa5upgXV/7QLVLHgYcPEKzWZ766NjXa
         314xWdi15XbJovZ/FUWSw6LpC7GnkQNQoiJRjh5YkZ7bJrg1Gw38Ysbf5Sho5KU/Z3xx
         y+V5eeKP/jqO92i8+wC22UvLXbMbNZ4XncW05NyjNTXMYqy7aQMiRIR++55pL7H1Vwne
         IIpZWLD4l/XYwJ0qAg1FuOI7mFNe2o5wG7yVegvndufwPB4AdXa759iMmJOFdo1OWazz
         f4AuMBIwHpWm6y4h2vZzmI3aVgRqskwy/M7T/ebOHfDfaEuGEDniAaxF/R1jHY/KnAVA
         1uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Cr74USMS7o2KnmyixbloqBJA2JGrzMyz1VPBNGaTjTU=;
        b=PnGiS+vpOY0FuZv7MdyvxHQmeJ7IXKCIu+8Cl9pjEpfLM7lOgvlaFnP+wS4NK6XUSd
         fWOaeuM1eC4hPfsHGPIuVC/RqmHuiSN+tqeoaKbmKBUQjehodLISDbU+6hxk63SZ73NZ
         NMVfb0S5UB7PAbKhbmAWP20uqaenJe6XwGkMMj43Bmx7J3l7xu5FAFogHPN4j1ILuWtd
         LkeRNWA9QXoG7Vm5hLd466tyjAZe1RU2UfQFjrKF0DgkzaT7O816Gv8TWRy7n6L4qKWG
         lD0l3kS0pwkjMd5uWRcPGwo9oUpmhO9nZlB8xBrQeZOPHJVcNoedIGz73KSUio39yG2N
         AOsA==
X-Gm-Message-State: APjAAAUN2H1MvBgnZ9kxwDTE/ZAQ44V81LqVsq8E7Z4kexBPjMtOe0DV
        D/B2ldLuYVrixzdTsxqcSdx5ow==
X-Google-Smtp-Source: APXvYqxe7JZN3BlGibb97rF9j+EpiLYaGeW5+ag63tvVfeiJ3KxIvN+5YbyLiPNAZ+HVcLqWQGc77A==
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr25415ljs.193.1575413754281;
        Tue, 03 Dec 2019 14:55:54 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h14sm91779lfc.2.2019.12.03.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:55:54 -0800 (PST)
Date:   Tue, 3 Dec 2019 14:55:35 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
Message-ID: <20191203145535.5a416ef3@cakuba.netronome.com>
In-Reply-To: <20191203224458.24338-1-vvidic@valentin-vidic.from.hr>
References: <20191203224458.24338-1-vvidic@valentin-vidic.from.hr>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 23:44:58 +0100, Valentin Vidic wrote:
> ENOTSUPP is not available in userspace:
> 
>   setsockopt failed, 524, Unknown error 524
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

I'm not 100% clear on whether we can change the return codes after they
had been exposed to user space for numerous releases..

But if we can - please fix the tools/testing/selftests/net/tls.c test
as well, because it expects ENOTSUPP.

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index bdca31ffe6da..5830b8e02a36 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -496,7 +496,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
>  	/* check version */
>  	if (crypto_info->version != TLS_1_2_VERSION &&
>  	    crypto_info->version != TLS_1_3_VERSION) {
> -		rc = -ENOTSUPP;
> +		rc = -EINVAL;
>  		goto err_crypto_info;
>  	}
>  
> @@ -723,7 +723,7 @@ static int tls_init(struct sock *sk)
>  	 * share the ulp context.
>  	 */
>  	if (sk->sk_state != TCP_ESTABLISHED)
> -		return -ENOTSUPP;
> +		return -ENOTCONN;
>  
>  	/* allocate tls context */
>  	write_lock_bh(&sk->sk_callback_lock);

