Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49147C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2BD21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="l2RkWdfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofHtS47+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLGMO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 07:14:59 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37629 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfLGMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 07:14:58 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DA7D227E5;
        Sat,  7 Dec 2019 07:14:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 07 Dec 2019 07:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xo9nv5GHNxzS21HY1WRSKm/BbC4
        Ky7aRmHGdiOlp7Ek=; b=l2RkWdfqRJzgOv4HbLm3cUF5XCEwRNrboYMjPOJYIJy
        Bhy2U0+VRM33f8bp8IDlDkNbv7E1MSzSpbx5EUXUiRRrQLH0pLlOCbumYSe19vBq
        MFRL/HDnX/OuIX8U0cj6RfX7fLYn0rQXQEeGR3XovI+1TTrZQXQlPk4b4svx2CMn
        zXT6lEoEiSA9p0pwcryVlaKtZYqqsD5xBJCayrThxXTCFkusPsmE7i32Ug1u5gbi
        D7qTgcW5dmOurgwWZn6VJvxqjcFxJ4Ei9mQBBgCppdvAe7myR/x6pB+EkUWtqUjY
        Pem2gsdyUsZtuF4HUHOT6eAOw/C1MHk2B67wpr3WV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xo9nv5
        GHNxzS21HY1WRSKm/BbC4Ky7aRmHGdiOlp7Ek=; b=ofHtS47+/YEV1kjZ3yCp1t
        8M7d746R6jT1mcnuBAZGqC4TXKMGXrR7oDiRNx8DjwbqUnTYr0S7Pcac7v0extC0
        ZmcD82NP6KhqHll4ARViV4gLbAiiW85uaKqjcMjVjexdgaCg+3VFoCFr563SUqRO
        LyM3T5StSK+zjIewHLUECxAoUjeGzuu+zj8csHrniS0xvIqQJYenBNdT5qUPCznX
        gO6VW+i2Vcb6pCW3ZrNsCq+AkrKH9J/axoSfjgMV4k2Tqm29/aTSuhqcZLz22iAS
        aYWhE/Sf3XUqHTvjYFmIkiIQm6TE5AL5DoMikaUl4Lol5QvPd6+gP23VJltt5uow
        ==
X-ME-Sender: <xms:wZfrXZkBhjQJ-adzKCtURNOOZPuNbna5sJsUTe1X8hhiauX0GNOKig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:wZfrXZ8Y6QMFIxGRXy2V_NaIsy4d2c8EcKuAi_aIE_JBRp6t7uMFqg>
    <xmx:wZfrXSktxCeiPexV6uHlZPkqCWD0l3DUUtk8ZaT-SFUMfo3GmtJgNg>
    <xmx:wZfrXflYMpIX426iwEkqr9nh0yt0utBTWtvEO5iZVmqmqb9yn6vWQw>
    <xmx:wZfrXQel6pH_VeAO-f-hGLRptFf_bPb5DDLIm7lCqKqDqoweyuPRRw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDC6030603A8;
        Sat,  7 Dec 2019 07:14:56 -0500 (EST)
Date:   Sat, 7 Dec 2019 13:14:55 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     bfields@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "lockd: fix decoding of TEST results" has been added to
 the 4.9-stable tree
Message-ID: <20191207121455.GB375536@kroah.com>
References: <20191206212329.497CB24679@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206212329.497CB24679@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:23:28PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     lockd: fix decoding of TEST results
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      lockd-fix-decoding-of-test-results.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 4873f938c9da1e72e69a7b6f4351597de9631af7
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

Breaks the build here, so also dropped :(
