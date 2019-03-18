Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD7E2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="YUm0VaKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCRQcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:32:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfCRQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:32:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so4809857pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0YKp3l4qEIPVSh/DMlvKZsLaS3E53Bm6RLCe9E6PZw=;
        b=YUm0VaKUUOzw0H/qmwMhcWR8T9xlOXrf31VmIEUaHqGVrqr/8VB91CouRpcYJvKO+m
         IBgNpN0wGWqoh9OqyXOQoj1W/oRdhfNWiikddZvj1Ib6wSA1S5V+fPO9uiHH9dxGQgE3
         9FrpuW+PTiqAuhqK7IohAuFyP0N6EKlAwqe0Z3QUe51TOVDlxunaC2VNYBxUpkyq66bm
         Ys312G6xmSs+duHs1e0w+ilgmAF4kLDKNRfq5NT0aXsIKVXHFKfmKmkUB/3f5px/Leo1
         Iyd08yC0eC5zft3I79ufdjH9bEVTmXvboCAdc6NjXn7pR4PW2/X/UQlVJLfoIMDMFVrD
         Mwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0YKp3l4qEIPVSh/DMlvKZsLaS3E53Bm6RLCe9E6PZw=;
        b=F7IMIW3PrtA6ADuXX5ZNp+fgr2PzcO84hrjFrPAggwPYyYb2tK1fnP/KqsIwHynuHS
         swkyrJdTQihY93XXgh/idwCBBj56peS567i23d5NsibbhjcmuB89gNeXHceQ8jj7phiQ
         jViAzBH4xU8u5orwaB35UQIRDmJtV5CkNLXHmcG0gr8Bd78gkuTZZV2uzlwbXzKYmTkY
         qxwGEPcae2mGXPhKDqRUiSz5p2UkXEGVGTIpadjf3q5qnjhVhVvalCD6kWr+q+z1NCgB
         JVopTEX9OQUUEyk98eT4ufbg8lq8+mCVjVBXyZnOe3ix05PT8wlcI2Tg2yDqQ88iqNDs
         erdA==
X-Gm-Message-State: APjAAAX66auTk3N8U2tasB+JsjEop9wblJC9T0DwnDBvW924kIErUeov
        kG6WaQbK5m4g9x5ScU5KC9Eztw==
X-Google-Smtp-Source: APXvYqxmdwh2W6vbmBaBFHQ4BYzdg9CFw+vFZNqD4B/mTy5zIAGVHjeteg2crtVVoC9B2AnKaRfg3Q==
X-Received: by 2002:a63:68c9:: with SMTP id d192mr18875526pgc.264.1552926730445;
        Mon, 18 Mar 2019 09:32:10 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id i29sm5277649pgb.76.2019.03.18.09.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 09:32:09 -0700 (PDT)
Date:   Mon, 18 Mar 2019 09:32:08 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190318163208.GC7431@mini-arch.hsd1.ca.comcast.net>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
 <20190316051902.GA27630@tigerII.localdomain>
 <20190316142646.GA10815@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316142646.GA10815@tigerII.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16, Sergey Senozhatsky wrote:
> On (03/16/19 14:19), Sergey Senozhatsky wrote:
> > # define __bpf_ntohs(x)                 __builtin_bswap16(x)
> > # define __bpf_htons(x)                 __builtin_bswap16(x)
> > 
> > So I sort of suspect that what should have been done was that
> > __HAVE_BUILTIN_BSWAP16__ ifdef, just like what include/uapi/linux/swab.h
> > does.
> 
> E.g. use uapi __swab16/__swab32 in selftests/bpf/bpf_endian.h?
> 
> -=-=-=-=-=-
> 
>  tools/testing/selftests/bpf/bpf_endian.h | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> index b25595ea4a78..68789b4c7ef0 100644
> --- a/tools/testing/selftests/bpf/bpf_endian.h
> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> @@ -20,38 +20,22 @@
>   * use different targets.
>   */
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> -# define __bpf_htons(x)			__builtin_bswap16(x)
> -# define __bpf_constant_ntohs(x)	___constant_swab16(x)
> -# define __bpf_constant_htons(x)	___constant_swab16(x)
> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
> -# define __bpf_htonl(x)			__builtin_bswap32(x)
> -# define __bpf_constant_ntohl(x)	___constant_swab32(x)
> -# define __bpf_constant_htonl(x)	___constant_swab32(x)
> +# define __bpf_ntohs(x)			__swab16(x)
> +# define __bpf_htons(x)			__swab16(x)
> +# define __bpf_ntohl(x)			__swab32(x)
> +# define __bpf_htonl(x)			__swab32(x)
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  # define __bpf_ntohs(x)			(x)
>  # define __bpf_htons(x)			(x)
> -# define __bpf_constant_ntohs(x)	(x)
> -# define __bpf_constant_htons(x)	(x)
>  # define __bpf_ntohl(x)			(x)
>  # define __bpf_htonl(x)			(x)
> -# define __bpf_constant_ntohl(x)	(x)
> -# define __bpf_constant_htonl(x)	(x)
>  #else
>  # error "Fix your compiler's __BYTE_ORDER__?!"
>  #endif
>  
> -#define bpf_htons(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_htons(x) : __bpf_htons(x))
> -#define bpf_ntohs(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_ntohs(x) : __bpf_ntohs(x))
> -#define bpf_htonl(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_htonl(x) : __bpf_htonl(x))
> -#define bpf_ntohl(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
> +#define bpf_htons(x)	__bpf_htons((x))
> +#define bpf_ntohs(x)	__bpf_ntohs((x))
> +#define bpf_htonl(x)	__bpf_htonl((x))
> +#define bpf_ntohl(x)	__bpf_ntohl((x))
At this point we can probably drop __bpf_xxx as well?
Care to resend with proper description when bpf-next opens?

>  
>  #endif /* __BPF_ENDIAN__ */
