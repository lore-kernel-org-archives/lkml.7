Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B408C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF022168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558773208;
	bh=UCF/QpCLHVEegx0leALKUm5Pa8j8WS2xH+G4wjKUqSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q7RichmwjIltsa1LgCf7niU6bxENeYGnIswMTO3tt0a4/bny3bKN3LumlmVH60pwp
	 AoPkuhFOX7UOUWZqgWZJ/k7FoLyzMHxyPGPw0BRilQdBe12D1mAwpkKAg5WqgSMR14
	 ghgsgN28hovIrTh9pkGfjiJJJtnq8mH+ZtkN40+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEYIcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:32:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35592 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfEYIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:32:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so12114071wrv.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQbVID2ep13TGIgOz1JsmCpNAIO8RhQi0YFufJhbVVg=;
        b=cXr+B1OaoOHx5XXFQAmraT6+oC+LtO/uueZajx03oz2zrDSI2V0D2pVkzaQdnr/rwg
         le1iP3fpz+vm3EMxwByByMtq+Qw8dKDEimREQA380o3+m2wAjii31o31sKrNikbTdilH
         I8GsPiCTo/UPEjClUpqAmYhoKl4FI5BBHil3yy/91GDgNnBMKil5AGuCvyeILdUQHg2i
         02DYECixrrwX3u+0r8/eVHGt5A0l1I2NBmRcWo0aXMQ/QWQ36WBKEUj3ggw0218TFeqf
         /h1Kz+Vv+1aTdheOXu5hJh9U5qtw1eGUt0D3gKeX6i68n5soANylggKKDshJPlvVJoFE
         mhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQbVID2ep13TGIgOz1JsmCpNAIO8RhQi0YFufJhbVVg=;
        b=nvv6iSlVBopxl8aiBaGnK6Wn682fBg9/vrHGPr4im1pYJLa4wxLIxLJQ61oY0sjpzt
         CNmzc20vLgLMN09Yd0zzX2oqgD17jD6Y/NO31iF6ccDHjFzcZv5v9MxAZ1wGz3lMw4CG
         LhRsb95QatfRplqJOucqWP9qtKQMxYMw8D6c0KLCXQ5vwLmMGwi44UaLCybV3XYAz3We
         VI0ARJF0jgHyDz4ryd0oCVy7CiCVqWNcBVdDKgK6nt6W92IMW4QKKN1MWkDu4s2dQHTl
         BOpTOTqPTY0pqmk6CjaBpP0ApQsdHGwl5IGCDMiK9RE2ndjn8Yf90ZoSRBzsDI9DHJ2N
         f6yg==
X-Gm-Message-State: APjAAAUx2ZtLjbZP9Rb7agNkcIzctqTrn7kYRg+t2V2yc8yG0oFOMAxr
        snramFdqzhCoUFG5GpvALOI=
X-Google-Smtp-Source: APXvYqym44vxLaO199UeocHvueOCW9xu3QQGA4Heyat8Lyc5FF/zldxf45aDJNQBgZ4CCG6FKh9TWw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr8614797wrn.133.1558773130481;
        Sat, 25 May 2019 01:32:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 205sm6271769wmd.43.2019.05.25.01.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 01:32:09 -0700 (PDT)
Date:   Sat, 25 May 2019 10:32:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/6] cpumask: Purify cpumask_next()
Message-ID: <20190525083207.GA102394@gmail.com>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525082203.6531-3-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> cpumask_next() has no side-effects. Mark it as pure.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 147bdec42215..20df46705f9c 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -209,7 +209,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
>  }
>  
> -unsigned int cpumask_next(int n, const struct cpumask *srcp);
> +unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);

I suppose this makes a code generation difference somewhere, right?

I'm wondering, couldn't it also be marked a const function? That's 
supposedly an even better category.

Thanks,

	Ingo
