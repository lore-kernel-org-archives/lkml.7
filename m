Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A296C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5817213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kzTyf4tu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mk1oPrJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDFTDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:03:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:03:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94EE3607EB; Sat,  6 Apr 2019 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577419;
        bh=fh1H5KKwnjiRs9RsITbGDwGcMNJWE9tSssA6iIdHjOs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kzTyf4tungH+UAnF6O3lLTKuekX/Spvn5Ih8QiiO017ZprRErXjNFvriK3MuGvCVr
         hrcBp64vFmUa53v7QEKPZJNzFbnqY6EMDa9rudoxK54oKFA6prK8QV74tiibbKudqR
         DCZgyggiqw6V0f/EqZ0m6DqbmNzxLzPmC6v6yMtc=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 829986053D;
        Sat,  6 Apr 2019 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577417;
        bh=fh1H5KKwnjiRs9RsITbGDwGcMNJWE9tSssA6iIdHjOs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Mk1oPrJGzlKyRtUwlyOeLMebVCh/K1jVCRDopH0wTYycoylqx1eHsXD0C2oiGeXrN
         jDRkIHaXV4JprkzHQCJ7KFor6pTQFVQuLa8UeAczQxygTgm0ywgMJ7G72MDmmINBg8
         f3ob1wGf4z/0PhLsGJx8kqlLCZG3SP8HOE7m2hSM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 829986053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] xen: xen-pciback: fix warning Using plain integer as NULL
 pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20190406122912.GA403@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8d19e62d-11cd-91dc-6c54-d688d2d67d00@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:33:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406122912.GA403@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 5:59 PM, Hariprasad Kelam wrote:
> Changes passing function argument 0 to NULL to avoid below sparse
> warning
>
>   CHECK   drivers/xen/xen-pciback/xenbus.c
> drivers/xen/xen-pciback/xenbus.c:700:51: warning: Using plain integer as
> NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/xen/xen-pciback/xenbus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index 23f7f6e..833b2d2 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -697,7 +697,7 @@ static int xen_pcibk_xenbus_probe(struct xenbus_device *dev,
>   	/* We need to force a call to our callback here in case
>   	 * xend already configured us!
>   	 */
> -	xen_pcibk_be_watch(&pdev->be_watch, NULL, 0);
> +	xen_pcibk_be_watch(&pdev->be_watch, NULL, NULL);
>   
>   out:
>   	return err;
