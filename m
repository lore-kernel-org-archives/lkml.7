Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0910EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D092620673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iSobbUTa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bBHZ95mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFUPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:40:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62277 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfFUPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:40:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB8AA1519F0;
        Fri, 21 Jun 2019 11:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=eCa0cXPi9XBzBUPuF5chpLC+AgE=; b=iSobbU
        TaPTnL33ve//0JDpgGuPB/VlUfriSDvRfPb6IEQLX6zPGtnjxrqeZMaQVDnC8WLf
        jYwylsxFo4udYPeNEPJ2ZqDfHJkUqv+p6TKVmtft7jhofwhhdeayaJorc8ynz40R
        2ylUq62Uw79cCBu4hnM8aHblv5O/0HmZX21pg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B189C1519ED;
        Fri, 21 Jun 2019 11:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ujoz+ORkKpXgxxOrhRvcnrsHog3Km5DX+cabVH6dv1E=; b=bBHZ95mC8tnpMvvlCHQ4nDFQMAFJtbL5X4Lo9cAu8SWAwx1mcI/5RR9tPG+qQ+zfgim4fq6bHegCcRhS3lFGwn0epu4yxNcHuRoMmB/bY1mK+z7uEwLUqGXFI9otS93wDASBWzb7AvS7MVOYcJ980GkETtu9lQZ95YBztlc5688=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D5FF1519EC;
        Fri, 21 Jun 2019 11:40:39 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 464DC2DA01C8;
        Fri, 21 Jun 2019 11:40:38 -0400 (EDT)
Date:   Fri, 21 Jun 2019 11:40:38 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Puranjay Mohan <puranjay12@gmail.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 RESEND] fs: cramfs_fs.h: Fix shifting signed 32-bit
 value by 31 bits problem
In-Reply-To: <20190618163352.4177-1-puranjay12@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1906211139330.1558@knanqh.ubzr>
References: <20190618163352.4177-1-puranjay12@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: EB870A3C-943A-11E9-AB0B-46F8B7964D18-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019, Puranjay Mohan wrote:

> Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
> 32-bit value by 31 bits problem. This isn't a problem for kernel builds
> with gcc.
> 
> This could be problem since this header is part of public API which
> could be included for builds using compilers that don't handle this
> condition safely resulting in undefined behavior.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>



> ---
> V2 - use the unsigned constants for all flags, not just one
> RESEND - Added Nicolas Pitre to CC list, added reviewed by tags.
> 
>  include/uapi/linux/cramfs_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/cramfs_fs.h b/include/uapi/linux/cramfs_fs.h
> index 6713669aa2ed..71cb602d4198 100644
> --- a/include/uapi/linux/cramfs_fs.h
> +++ b/include/uapi/linux/cramfs_fs.h
> @@ -98,8 +98,8 @@ struct cramfs_super {
>   *
>   * That leaves room for 3 flag bits in the block pointer table.
>   */
> -#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1 << 31)
> -#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1 << 30)
> +#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1U << 31)
> +#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1U << 30)
>  
>  #define CRAMFS_BLK_FLAGS	( CRAMFS_BLK_FLAG_UNCOMPRESSED \
>  				| CRAMFS_BLK_FLAG_DIRECT_PTR )
> -- 
> 2.21.0
> 
> 
