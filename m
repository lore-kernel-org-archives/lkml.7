Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B49E2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551726830;
	bh=AbsOpbA07Cv7Rm5EiihGC6HcnRxmEnizqy12NJBm+UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ruiDD5emPXJTo+3pMzIuIvS3CpWvNxvb2H9fcn1+6VDNTpM06W3O/b/R13G/+ZPzV
	 ZCBSheyRwpjDFaa8gX4aZ+s+cmVQpZ9lXy1z2m3xTaM0ICWAg5HBh21Tn7U4Ctf7gp
	 jgFi3AfVlyz2Xvjomoxsj4yWjzNaN9rlnjgS/9co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCDTNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:13:48 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44591 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:13:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id x21so4937635ywx.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aK0M0EiBqkVrwI5zhtbHcvzqiuEwqS72VfobOx94u04=;
        b=tQY/8XTNp8Jg7xr6T2p81aWS51RHUEWBUL7xzR/M1oei72/jBhuud6BGfLARkkw03a
         jiZB2+GtJqewk4jbRJlHt3wrJDJEhEKqWQ6AM13sEc1mmrZFXX6du5YEjPWhAqEarq04
         y+qU3p+FeX91AH1Gr1zotMxwjRBiwDWAVPYyfPB+x7foCSFWTyp0jwcSfBQ99sy4DH9q
         AIMmFTwKg6wVm9tX3xp5AYCQ77wrBj4F2eojL1mYGovzwpBFyYdCFx9n0rLW8mW9zgOa
         rsuYBrigxm5ueEg07JdO8Lzubpxue2VMge5eZwHQeShJfGV8wtWKFnJov6Rrx3Ji8rSk
         hdkA==
X-Gm-Message-State: APjAAAWj8odgggRyyNblKKVjdoy+wVJ7prThMxUcjrE7ZyIy6eWS5A3y
        M3zEkW0SbP3UFD2w9hXKv98=
X-Google-Smtp-Source: APXvYqx3uSLSfjeKLSN4KzA85sxETmTJc3iojCUNRzzqn3SqaXb3qkSgnP+LcswtZobNlwlYzUER3g==
X-Received: by 2002:a25:2f91:: with SMTP id v139mr9660229ybv.407.1551726827678;
        Mon, 04 Mar 2019 11:13:47 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:8d76])
        by smtp.gmail.com with ESMTPSA id s186sm2989973yws.13.2019.03.04.11.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 11:13:46 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:13:44 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] perpcu: correct pcpu_find_block_fit comments
Message-ID: <20190304191344.GB17970@dennisz-mbp.dhcp.thefacebook.com>
References: <20190304104541.25745-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304104541.25745-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:33:52AM +0000, Peng Fan wrote:
> pcpu_find_block_fit is not find block index, it is to find
> the bitmap off in a chunk.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>   Based on https://patchwork.kernel.org/cover/10832459/ applied linux-next
> 
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7f630d5469e8..5ee90fc34ea3 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1061,7 +1061,7 @@ static bool pcpu_is_populated(struct pcpu_chunk *chunk, int bit_off, int bits,
>  }
>  
>  /**
> - * pcpu_find_block_fit - finds the block index to start searching
> + * pcpu_find_block_fit - finds the offset in chunk bitmap to start searching
>   * @chunk: chunk of interest
>   * @alloc_bits: size of request in allocation units
>   * @align: alignment of area (max PAGE_SIZE bytes)
> -- 
> 2.16.4
> 

So really the block index is encoded in the bit offset. I'm not super
happy with either wording because the point of the function really is to
find a block(s) that can support this allocation and it happens the
output is a chunk offset.

Thanks,
Dennis
