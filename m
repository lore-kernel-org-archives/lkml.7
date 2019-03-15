Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A79C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7720F218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="mfMPK6IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfCORYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:24:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39718 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfCORYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:24:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id i20so6805079pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQCYeAydgfSgkrqnqt9Gp2//xA3VBkKWcV3w+R+J1Kw=;
        b=mfMPK6IOjHB+66Zmi1FyS7xvLkn4u6zgqCXdKdb++UiHdoK1ihK8FVbUPeoocT+wm6
         zAfg9SqOvCNdFkN3kYE6mLFHCQ9pnOOK+OLLOgsjhmGOB5P/ebjkjz2y2n/LhQ8cLfeP
         JusVuyoleEuxpUnZIyvtP8r7KjIC8uoHXWBmfVw4tU64j1+4+wW7L9MR7421nnmObUf0
         EYFbvfrEAJAqWy9ECZUwc+HKyUW5/snObi8+zBVdyuldUIP0yJNTtTB3PuFtC4qiOpde
         rfnoU0THwtP4NOvcYC2r3Ucu0pdFmsLwQAlVmrfLqt9hSLTk0d0xIKaNbGxEJx3Pk2Zq
         K3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQCYeAydgfSgkrqnqt9Gp2//xA3VBkKWcV3w+R+J1Kw=;
        b=PyjWK8C5i8b7r/xm9G2VQx2Xqd3LkRt7wfKu5CwFEuMj1GyMx30aKGW0R5i4CezZ+7
         /QM0wCNjojnybwtZSKtvl04eYWFIFMGKCF9t2ZNpDSrzoZqngUZhV5Y/U3p7v3NCpDl1
         Tbvq4gWFL7xZbLZGGOlnRmIu+BGhKZ1d75Z8VXs+h5wno6r/v4HPVy0ub4Xj4H2EIbtA
         /e9IpE3NQ+bu1xV0sbasTVdnNGmbkp/tQaVHhQNGReo2pv1PnHgR5Y3qJpNNJpGoid13
         TZfBfO2D1UgXONZx/kesToDMhkBbvfxPAzAR6kk5xmw8G2jsKxW61CRq8gVz2HrMkd1u
         3aDQ==
X-Gm-Message-State: APjAAAWHI2VxzdAdxvAYLVNPpaY/TeEAIzKIrHAv/1ghACtbght5t6+P
        9mGkIJT+nGTJK+2rn/LinvqGpw==
X-Google-Smtp-Source: APXvYqxZi/5vhiBqawHg7FmfQE9ivtno6tvkKPVsAHWPEsEKcOqIPp10PsuPF5VO2s/eOFXoNEDKhg==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr5317603pfn.40.1552670669866;
        Fri, 15 Mar 2019 10:24:29 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 14sm5916879pft.137.2019.03.15.10.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 10:24:29 -0700 (PDT)
Date:   Fri, 15 Mar 2019 10:24:28 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315012012.GA748@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Sergey Senozhatsky wrote:
> On (03/14/19 05:42), Eric Dumazet wrote:
> > > cpu_to_be32() is capable enough to detect __builtin_constant_p()
> > > and to use an appropriate compile time ___constant_swahb32()
> > > function.
See my recent commit a0517a0f7ef23 ("selftests/bpf: use
__bpf_constant_htons in test_prog.c") where compiler was not smart
enough to figure it out (you can google similar issues for GCC < 4.8).

> > >
> > > So we can use cpu_to_be32() instead of __constant_cpu_to_be32().
> > 
> > 
> > I dunno, this is uapi, this might break user space for some funky compiler ?
> > I do not even know if cpu_to_be32() _is_ uapi.
> 
> Hmm, excellent point.
> 
> Looking at
> 
> if_pppox.h:#define PTT_EOL		__cpu_to_be16(0x0000)
> if_pppox.h:#define PTT_SRV_NAME	__cpu_to_be16(0x0101)
> if_pppox.h:#define PTT_AC_NAME	__cpu_to_be16(0x0102)
> if_pppox.h:#define PTT_HOST_UNIQ	__cpu_to_be16(0x0103)
> if_pppox.h:#define PTT_AC_COOKIE	__cpu_to_be16(0x0104)
> if_pppox.h:#define PTT_VENDOR 	__cpu_to_be16(0x0105)
> if_pppox.h:#define PTT_RELAY_SID	__cpu_to_be16(0x0110)
> if_pppox.h:#define PTT_SRV_ERR     __cpu_to_be16(0x0201)
> if_pppox.h:#define PTT_SYS_ERR  	__cpu_to_be16(0x0202)
> if_pppox.h:#define PTT_GEN_ERR  	__cpu_to_be16(0x0203)
> if_tunnel.h:#define GRE_CSUM	__cpu_to_be16(0x8000)
> if_tunnel.h:#define GRE_ROUTING	__cpu_to_be16(0x4000)
> if_tunnel.h:#define GRE_KEY		__cpu_to_be16(0x2000)
> if_tunnel.h:#define GRE_SEQ		__cpu_to_be16(0x1000)
> if_tunnel.h:#define GRE_STRICT	__cpu_to_be16(0x0800)
> if_tunnel.h:#define GRE_REC		__cpu_to_be16(0x0700)
> if_tunnel.h:#define GRE_ACK		__cpu_to_be16(0x0080)
> if_tunnel.h:#define GRE_FLAGS	__cpu_to_be16(0x0078)
> if_tunnel.h:#define GRE_VERSION	__cpu_to_be16(0x0007)
> if_tunnel.h:#define GRE_VERSION_0		__cpu_to_be16(0x0000)
> if_tunnel.h:#define GRE_VERSION_1		__cpu_to_be16(0x0001)
> if_tunnel.h:#define GRE_PROTO_PPP		__cpu_to_be16(0x880b)
> 
> You are right, probably would need __cpu_to_be32, which also does
> the constant folding.
> 
> =-=-=-=-=
> 
> Subject: [PATCH] tcp: don't use __constant_cpu_to_be32
> 
> __cpu_to_be32() can detect __builtin_constant_p() at compile time.
> So we can use __cpu_to_be32() instead of __constant_cpu_to_be32().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/uapi/linux/tcp.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 8bb6cc5f3235..cf9c246a59c8 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -70,16 +70,16 @@ union tcp_word_hdr {
>  #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3]) 
>  
>  enum { 
> -	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
> -	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
> -	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
> -	TCP_FLAG_ACK = __constant_cpu_to_be32(0x00100000),
> -	TCP_FLAG_PSH = __constant_cpu_to_be32(0x00080000),
> -	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
> -	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
> -	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
> -	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
> -	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
> +	TCP_FLAG_CWR = __cpu_to_be32(0x00800000),
> +	TCP_FLAG_ECE = __cpu_to_be32(0x00400000),
> +	TCP_FLAG_URG = __cpu_to_be32(0x00200000),
> +	TCP_FLAG_ACK = __cpu_to_be32(0x00100000),
> +	TCP_FLAG_PSH = __cpu_to_be32(0x00080000),
> +	TCP_FLAG_RST = __cpu_to_be32(0x00040000),
> +	TCP_FLAG_SYN = __cpu_to_be32(0x00020000),
> +	TCP_FLAG_FIN = __cpu_to_be32(0x00010000),
> +	TCP_RESERVED_BITS = __cpu_to_be32(0x0F000000),
> +	TCP_DATA_OFFSET = __cpu_to_be32(0xF0000000)
>  }; 
>  
>  /*
> -- 
> 2.21.0
> 
