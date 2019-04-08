Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D152BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bti0s9/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDHWQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:16:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45245 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:16:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id f19so6098552edw.12;
        Mon, 08 Apr 2019 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEz+KfXjNVYGyc4uT9k+iyNDdN1YAKjm8PCXiv9+Aw8=;
        b=Bti0s9/vqkCuj76qIguyF/tC7v+yT/Q5Zf4dHw6ulh12s/SzmtvSh8cTZzLHG/GsL/
         /SWVlnUB4fCsLuSwqrG9TauC+3iQ9mF7O5VK27ETB3dsmpX++/HmWGCiDjwE+WW8VuD8
         emU4skeeL4pdgegKH9Yxd67c1XmfRuVdw3/ta1545/gogxJh7bSl8uVoy6MdKJr9Ovek
         gC2AH5hNCsL7JEPGUgtH8xJQggjGRNrJ7dqY422K4mN4/L6LigqM8mHwUOzMDg4CZEpo
         kZvxKcK/JBBgjUYFusPCharl9FxwAnXBkdSKB9MkCTFY5+wNupJpOADXIJxcc1Sd+RT2
         8JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEz+KfXjNVYGyc4uT9k+iyNDdN1YAKjm8PCXiv9+Aw8=;
        b=AoW0shFjbZy4GB7BoNsHFjRxyXler23IhbXHaaRMFAsxxFDhuz+wikNQ4B/StNfX/1
         2Nitt3nTMktjaAHChZdqhIiyTAfwWl4at10QraYw80Mqtwa8ndhz1Y2RvdmpSoDs54Ml
         0X6bLALn7kNJATMldU4Rwp9zpFYKsb3YTlGw+6jtmNZfMbYRmvwVrbNN6v8oWm+neStR
         5Zco3wc1FfB+viKHoEKmj/4nAc5Zu/EXIitGwxXwgTGYQFOgA9UPVCkQD2VRZXbP9rfl
         LX+KW7vtjAMl89Ba8LsD2rQif9d7ERKNvOFJDIurCvG3pBRqSE/ATCPRGnPaSeNt7pGL
         ZGIA==
X-Gm-Message-State: APjAAAVp+fZcrskZ2iuMkU9H1Ri9jZioLcBKzNh4QZUxOcLTpMvcrIpM
        0jUgO0Kcizf2WDSaW44d9KG3iti6k4Uqew==
X-Google-Smtp-Source: APXvYqwzdxxKXuV/9NX9na8GOjPrcewDrI+cRjZQfMJFB3ojlj+Hxn9V057+9HAJSKWQ+TIDEahfEw==
X-Received: by 2002:a50:d591:: with SMTP id v17mr20863390edi.180.1554761795085;
        Mon, 08 Apr 2019 15:16:35 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id x45sm9255069edm.64.2019.04.08.15.16.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:16:34 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:16:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] s390: qeth: address type mismatch warning
Message-ID: <20190408221632.GB18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-4-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:26:17PM +0200, Arnd Bergmann wrote:
> clang produces a harmless warning for each use for the qeth_adp_supported
> macro:
> 
> drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
>       different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
>         if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
>             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
>         qeth_is_ipa_supported(&c->options.adp, f)
>         ~~~~~~~~~~~~~~~~~~~~~                  ^
> 
> Add a version of this macro that uses the correct types, and
> remove the unused qeth_adp_enabled() macro that has the same
> problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I wonder if it is better to just change the func parameter to type long.
I guess it's better to keep the type safety to make sure values aren't
unintentionally mixed but the body of the functions is the same so does
the type actually matter?

Regardless, this change does fix the warning so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/net/qeth_core.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
> index c851cf6e01c4..d603dfea97ab 100644
> --- a/drivers/s390/net/qeth_core.h
> +++ b/drivers/s390/net/qeth_core.h
> @@ -163,6 +163,12 @@ struct qeth_vnicc_info {
>  	bool rx_bcast_enabled;
>  };
>  
> +static inline int qeth_is_adp_supported(struct qeth_ipa_info *ipa,
> +		enum qeth_ipa_setadp_cmd func)
> +{
> +	return (ipa->supported_funcs & func);
> +}
> +
>  static inline int qeth_is_ipa_supported(struct qeth_ipa_info *ipa,
>  		enum qeth_ipa_funcs func)
>  {
> @@ -176,9 +182,7 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
>  }
>  
>  #define qeth_adp_supported(c, f) \
> -	qeth_is_ipa_supported(&c->options.adp, f)
> -#define qeth_adp_enabled(c, f) \
> -	qeth_is_ipa_enabled(&c->options.adp, f)
> +	qeth_is_adp_supported(&c->options.adp, f)
>  #define qeth_is_supported(c, f) \
>  	qeth_is_ipa_supported(&c->options.ipa4, f)
>  #define qeth_is_enabled(c, f) \
> -- 
> 2.20.0
> 
