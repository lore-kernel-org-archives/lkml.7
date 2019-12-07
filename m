Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF094C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8831421835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="uMfC4y2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwLMZwVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLGMNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 07:13:54 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58179 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfLGMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 07:13:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1ACF4227E5;
        Sat,  7 Dec 2019 07:13:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 07 Dec 2019 07:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mcGrWRJUFj7ehQYFYco7tPNn8Y8
        5s4FRf3fEKKPX6jk=; b=uMfC4y2c1+D2Q7jewrjlO/6sfqi84q9+qqYVMvHOzsY
        /eogmi8hWGyr9yk/DHHg3WJ4UNWMEunm+luyDUV/+BT7krW+F7ENQgI6Yh/I40NX
        CRXOXmXu4wwqxIvOzpBQ1SrOeFofGKdpte9P9R+8/K6fOYX9AA8BomFdPMv4szL+
        /BbeJVA7KxlPk//UrrwNilRtGJykFQQqcwGqAMwc4TC7FNnj/sbH2fRHeuB8nwr1
        ApcpewUaC3NjRriA8jd9MRKrszDqEP7b8DqzFWi20azeTJaWY0CGVlJ/MktCQ47M
        bHblmvCl6cW0TjOL29SQoibN1QbImDNxUwqnkGtCLLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mcGrWR
        JUFj7ehQYFYco7tPNn8Y85s4FRf3fEKKPX6jk=; b=IwLMZwVMajyG/imqlC6Kb2
        r4c7Sd1N8ECVTleusQDPttHqb45pI2ry9HHDmqKXQ4QqxJ1mLCTClVefPSwNeEin
        8uQZy+IolyHqc6+RhXXd4G3Nj/7kKNHijSfO8r8/l/VT9Fy2TGM313fhU5+H/PVn
        kwc77aWF3d96Eo5fF6VkkrB1OVsMUa2nPmYqEbt36rrZG5yq/nnhOSGjqFHoxyi6
        D1kI2W/tgLyeXfXTCchCZMqPDByzyUQ7RyEIRMdiRquyjHAgBVR44rm8j7ksTrvi
        rps2ySgUCuiK2iNZTRQ9YiJFsTedyz3maodRpfnkpXFbQwJqZ968wOMelOTLhj7w
        ==
X-ME-Sender: <xms:gJfrXc6-kBs9FX35yWW9kurUKIb8WK0x8zJsflyk21G4WvP4S9thPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gJfrXZq7eGxxS0Fpu9E1CQavE7dDvRx55TLth03cBxeGVm4ghEvxYg>
    <xmx:gJfrXUC8GiazWL3Zak_Cx8DV8EdPMEcA1cgDx4e-ZbPJf1AqdpCAOA>
    <xmx:gJfrXSTdEUb_jwjSdgYRCcS4L_k4uBHJ390dx2AD9XTrw7DvHWFCKw>
    <xmx:gZfrXaVtvU3XOekaUVLjhkuDAsq94Q8GJG_d7iKAKv_J3Q2NygHylQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6EFD48005C;
        Sat,  7 Dec 2019 07:13:52 -0500 (EST)
Date:   Sat, 7 Dec 2019 13:13:50 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     bfields@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "lockd: fix decoding of TEST results" has been added to
 the 4.4-stable tree
Message-ID: <20191207121350.GA375536@kroah.com>
References: <20191206212455.ADA2E2467A@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206212455.ADA2E2467A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:24:54PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     lockd: fix decoding of TEST results
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      lockd-fix-decoding-of-test-results.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 66c45912a1133ed5483e1559bad8a5d6bd2f4275
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Mon Nov 26 11:36:52 2018 -0500
> 
>     lockd: fix decoding of TEST results
>     
>     [ Upstream commit b8db159239b3f51e2b909859935cc25cb3ff3eed ]
>     
>     We fail to advance the read pointer when reading the stat.oh field that
>     identifies the lock-holder in a TEST result.
>     
>     This turns out not to matter if the server is knfsd, which always
>     returns a zero-length field.  But other servers (Ganesha is an example)
>     may not do this.  The result is bad values in fcntl F_GETLK results.
>     
>     Fix this.
>     
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
> index d3e40db289302..4fdf8dae0db28 100644
> --- a/fs/lockd/clnt4xdr.c
> +++ b/fs/lockd/clnt4xdr.c
> @@ -127,24 +127,14 @@ static void encode_netobj(struct xdr_stream *xdr,
>  static int decode_netobj(struct xdr_stream *xdr,
>  			 struct xdr_netobj *obj)
>  {
> -	u32 length;
> -	__be32 *p;
> +	ssize_t ret;
>  
> -	p = xdr_inline_decode(xdr, 4);
> -	if (unlikely(p == NULL))
> -		goto out_overflow;
> -	length = be32_to_cpup(p++);
> -	if (unlikely(length > XDR_MAX_NETOBJ))
> -		goto out_size;
> -	obj->len = length;
> -	obj->data = (u8 *)p;
> +	ret = xdr_stream_decode_opaque_inline(xdr, (void *)&obj->data,
> +						XDR_MAX_NETOBJ);
> +	if (unlikely(ret < 0))
> +		return -EIO;
> +	obj->len = ret;
>  	return 0;
> -out_size:
> -	dprintk("NFS: returned netobj was too long: %u\n", length);
> -	return -EIO;
> -out_overflow:
> -	print_overflow_msg(__func__, xdr);
> -	return -EIO;
>  }
>  
>  /*
> diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> index 3e9f7874b9755..29392d66473c8 100644
> --- a/fs/lockd/clntxdr.c
> +++ b/fs/lockd/clntxdr.c
> @@ -124,24 +124,14 @@ static void encode_netobj(struct xdr_stream *xdr,
>  static int decode_netobj(struct xdr_stream *xdr,
>  			 struct xdr_netobj *obj)
>  {
> -	u32 length;
> -	__be32 *p;
> +	ssize_t ret;
>  
> -	p = xdr_inline_decode(xdr, 4);
> -	if (unlikely(p == NULL))
> -		goto out_overflow;
> -	length = be32_to_cpup(p++);
> -	if (unlikely(length > XDR_MAX_NETOBJ))
> -		goto out_size;
> -	obj->len = length;
> -	obj->data = (u8 *)p;
> +	ret = xdr_stream_decode_opaque_inline(xdr, (void *)&obj->data,
> +			XDR_MAX_NETOBJ);
> +	if (unlikely(ret < 0))
> +		return -EIO;
> +	obj->len = ret;
>  	return 0;
> -out_size:
> -	dprintk("NFS: returned netobj was too long: %u\n", length);
> -	return -EIO;
> -out_overflow:
> -	print_overflow_msg(__func__, xdr);
> -	return -EIO;
>  }
>  
>  /*

Breaks the build on 4.4, so I'm dropping it from there :(
