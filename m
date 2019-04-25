Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4650C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A0206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="stuDzc79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfDYBIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:08:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39895 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfDYBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:08:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id h16so12307281qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Ktw08zRDx+QQau1FKIeHNlSkfrFqudj3H5cy4OpKOw0=;
        b=stuDzc79VhOvnwxaGUOHX9xu6OEgQVP8t9NubRl25IfAnWrmInLFBziPrORSXb2gW2
         6gy6tQj4J5nCB9Uj208QCdrWEmMzkjKstE5r/k6JyycHoAXjN4HvhDV5EtPcbaGDibvG
         qzmg9sndgaCy6dAa8h9iI+8+FpyR68BosU+22Gy7DvI4dSfNcyImFNBrEzr2pgpSIOb7
         Q98AkXhJrxhpfW57La7t1hlHlcg5FB9XdelDSJRVIeYMEzJI4ku74BO/l9N6HojjPTsz
         qMwDY05baWkQRbaYTyO31DWlLWVpv/67N5sD+pRCj/S48vlxolkCe7NkDpuuu8ZjjdpH
         YyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ktw08zRDx+QQau1FKIeHNlSkfrFqudj3H5cy4OpKOw0=;
        b=NQ1TrGM+3AVDgar3GbiGg/v6BVSD4EnddO5qm6kd6Y2LXOnt79LERXwGsG2D72zbQV
         vFABKGQypMWy98SCxATYo/D05ozwVFXhWf/O+5VD9e/E1BGUm78lVkXTNKOCurZcGS6d
         nb1P4Evaykhdv3QTx0lZjKjf5LMG0PE2YKsGEbMDQC8luEL0weL7A+fw5T7j4TtIb/mF
         jtn2TW6XD86T0gkVkyja5DgRvq50sTYRX24HfxTV0pHr28Xtneoq0FbO1XkxImYr9yVT
         lLmnrpfgBSlUBSiI39bX6sixdlRtxJkMAF9sXOv+7BknxxqP2k+PKrbehcHGl6Lvk2qM
         SRyQ==
X-Gm-Message-State: APjAAAXd1ok6r+wMH4ZZqOSYUGLl5MTARZKSdI3cIsT4ZkLTb/LyWCLW
        LeBl0joTO9dYDdz7naGrUE6HYA==
X-Google-Smtp-Source: APXvYqwvD5s8lyUGcWFDmcFqY23dFFFbbQFKvpiGrKKv74M177G8YlvecwoECjfeZ+cvb7z03LtBMA==
X-Received: by 2002:a0c:9804:: with SMTP id c4mr6516016qvd.129.1556154525486;
        Wed, 24 Apr 2019 18:08:45 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 11sm13757470qtu.5.2019.04.24.18.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 18:08:45 -0700 (PDT)
Date:   Wed, 24 Apr 2019 18:08:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:NETWORKING [TLS]),
        linux-kernel@vger.kernel.org (open list),
        Vakul Garg <vakul.garg@nxp.com>
Subject: Re: [PATCH] net: tls: fix a memory leak bug
Message-ID: <20190424180840.515b88af@cakuba.netronome.com>
In-Reply-To: <1556137087-25814-1-git-send-email-wang6495@umn.edu>
References: <1556137087-25814-1-git-send-email-wang6495@umn.edu>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 15:18:07 -0500, Wenwen Wang wrote:
> In decrypt_internal(), a memory block 'mem' is allocated through kmalloc()
> to hold aead_req, sgin[], sgout[], aad, and iv. This memory block should be
> freed after it is used, before this function is returned. However, if the
> return value of the function invocation of tls_do_decryption() is
> -EINPROGRESS, this memory block is actually not freed, which is a memory
> leak bug.
> 
> To fix this issue, free the allocated block before the error code
> -EINPROGRESS is returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Did you find this by code inspection or is this provable at runtime
(kmemleak or such)?

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index b50ced8..22445bb 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1445,8 +1445,10 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
>  	/* Prepare and submit AEAD request */
>  	err = tls_do_decryption(sk, skb, sgin, sgout, iv,
>  				data_len, aead_req, async);
> -	if (err == -EINPROGRESS)
> +	if (err == -EINPROGRESS) {
> +		kfree(mem);
>  		return err;

Mm... don't think so.

-EINPROGRESS is special, it means something is working on the request
asynchronously here.

I think this memory is freed in tls_decrypt_done():

	kfree(aead_req);

Note that aead_req is the first member of the allocated buffer.

CCing Vakul

> +	}
>  
>  	/* Release the pages in case iov was mapped to pages */
>  	for (; pages > 0; pages--)

