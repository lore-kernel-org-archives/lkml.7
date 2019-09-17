Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E82C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A8A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jMhRGNsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392002AbfIQCn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:43:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34242 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391292AbfIQCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:43:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so1230452pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 19:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aQrXVTNYPD93A+dr3PQzbCJpCjMJXTuJQlMV8r8hKjE=;
        b=jMhRGNsPq4gN9mlEaZ/AEVKbtiBbP49Nk000CTIHRAT7Qw5Sm5KXl30UtOnKNEXgJG
         BBcf0/EzePXZhMAXA1Ed+Hu3czD1Ka2KVhgyxemKS+eS5LZobAJ4B50wLjVdUSE8YD2L
         puiSTTu61AVk3VP0aa7iYu1y1ask/Hk4D577HbXvPrxwqtz/ggUfUxHMnx56eZlbifHi
         n3SLjkQco+K4dPH01qWh3ysbYuyTdJeI/9PwYRJwxPeSs+LnLSGR+qfHqzVXm86KQ7Mc
         3SbrrAQoBk+vCulD8t3H4OO+kGMpKJOJRPWi9tpwOTB56Lp1/SaPjcaAtLoBuSDZ8/X2
         4AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aQrXVTNYPD93A+dr3PQzbCJpCjMJXTuJQlMV8r8hKjE=;
        b=O3I9EeTZE1kflXhs8SjGleUr539j4vG49DwjkPWC2bYnru8VMA1FQO2uuUS3qeREtk
         8xbxxTwhn5FqoexMIP+kc+exRyuI7UvxgMtcw5BKUhSiw27IG+qE+Z73VPmqckg4dBTM
         Y0njqxEPWRqTfG0ZmkOOodweNMZ2KpZkqno5hf0hQ5CLYHyoofuXsd7n/M3mfLwq/Xqu
         ynEYnd805NqgYTYB/EICtckDf8Sa4JqmbE0rr+FgJKgQyLKiK/+nHVDbe1HA+GQPgeMg
         7QFONE+csQ/Gsku6I080of/bq3M3GMKYDEsuOVXa7s15vW2tYuW8iw3QAVRR6SEX5jkv
         +V6w==
X-Gm-Message-State: APjAAAXqNu7El+bpwLC8vmTtDIoMMzDtR8+2/fjDxWuLOze63MNse9MK
        G+CzcYHM19U4qv05y3/iMH1j7ZESIpg=
X-Google-Smtp-Source: APXvYqzJsHSwaJsn5L+NBbiv4QM7roesrFufWYU2XCHXrcTHzejh6DulwYsZREZeSRQpa4cfz+9Jdw==
X-Received: by 2002:a17:90a:e290:: with SMTP id d16mr2606067pjz.86.1568688203384;
        Mon, 16 Sep 2019 19:43:23 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::2])
        by smtp.gmail.com with ESMTPSA id x72sm450247pfc.89.2019.09.16.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 19:43:23 -0700 (PDT)
Date:   Mon, 16 Sep 2019 19:43:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ixgbe: Use kzfree() rather than its implementation.
Message-ID: <20190916194319.712d81cc@cakuba.netronome.com>
In-Reply-To: <1567564752-6430-2-git-send-email-zhongjiang@huawei.com>
References: <1567564752-6430-1-git-send-email-zhongjiang@huawei.com>
        <1567564752-6430-2-git-send-email-zhongjiang@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 10:39:10 +0800, zhong jiang wrote:
> Use kzfree() instead of memset() + kfree().
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 31629fc..113f608 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -960,11 +960,9 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
>  	return 0;
>  
>  err_aead:
> -	memset(xs->aead, 0, sizeof(*xs->aead));
> -	kfree(xs->aead);
> +	kzfree(xs->aead);
>  err_xs:
> -	memset(xs, 0, sizeof(*xs));
> -	kfree(xs);
> +	kzfree(xs);
>  err_out:
>  	msgbuf[1] = err;
>  	return err;
> @@ -1049,8 +1047,7 @@ int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
>  	ixgbe_ipsec_del_sa(xs);
>  
>  	/* remove the xs that was made-up in the add request */
> -	memset(xs, 0, sizeof(*xs));
> -	kfree(xs);
> +	kzfree(xs);
>  
>  	return 0;
>  }

All the crypto cases should really be converted to memzero_explicit().
