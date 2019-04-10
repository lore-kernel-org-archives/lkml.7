Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE61C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5430E2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="oP3PRsaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfDJJR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:17:59 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39912 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfDJJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:17:55 -0400
Received: by mail-lj1-f175.google.com with SMTP id l7so1412127ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ID6XPzG2MmfoFKHRThuc5MXUtsCkXKVWeH8YUFlCGPE=;
        b=oP3PRsaWBHUV3dltNkexKYxRaONV6R3FwrSMBe3y7+54qSALQVCsp2oG8+5uz1hu4G
         n7h0Ul+sg30TPHK0rZdjvN+GDJ6u0+kP6hFWyFPgDRb2ISMWG6u8JW2x1RT5QewSEpcr
         K8mmzBoSYO2ooTNtYpjO98Va9Te4EXUI6OANplB/MnrIz5BVykXke6WYdVCIhqXXGXzV
         +2iz0DoUfGs2jc8WRGvaEGGH/0QO6zWHwsXMCPvG2FP5P9yTOu0NoopVcpUQcWKY0fZY
         0BLgQhioV1Nh9MKa8OIfe+NjE7DFAtxDxHte868/dwEkWjZv3PI6+zUIfFpeLl7b8CvE
         BSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ID6XPzG2MmfoFKHRThuc5MXUtsCkXKVWeH8YUFlCGPE=;
        b=BGNdCCkAzHdD6YP22pWYDSf0xeBJ/ltPQTUyHxKy6JteSxDqfN7nAWpfX7tMWpy0ON
         MM+tmXf0pCpHHya1tYd03a1XqGa7LO8sxjJWUDVbXQo4hQJeEW0LXmSzre5WjUly9Y3j
         qil16cJRol3lPy/VLXZERuX99lcGH0FJ4WmK0o96OzTXgkhhsh4KBR8dmOSt14Fy0x99
         F/fVUHTdvjs1Xgqs+suyy/FY70fXVprg/D7aPOYr738LBWso7kYv6wYidp+zovpZvbGl
         mjL871LOak7lAucxNO23djx7WmA0QXpDV9LYpdi8CKE4JhqmG/brB9DZurDAjQPkurGn
         FCSw==
X-Gm-Message-State: APjAAAX6GJjLFSPFQVlAc9FSH/tyrrkBCsB6SogM5/UCxPkWdxtdYOV9
        7KhcirD5eToEo3ntjj9h06ERiZMhSeE=
X-Google-Smtp-Source: APXvYqx2tocWjRIdlcvj+15sXwP9Fw80PJM1lCElkDWIWPrcsXBDE9yLx995DjbeiSQZQFYZgrYJsA==
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr5800176ljk.38.1554887873181;
        Wed, 10 Apr 2019 02:17:53 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.86.11])
        by smtp.gmail.com with ESMTPSA id d13sm867441lfa.40.2019.04.10.02.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 02:17:52 -0700 (PDT)
Subject: Re: [PATCH][V2] brcmfmac: fix leak of mypkt on error return path
To:     Colin King <colin.king@canonical.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190409114333.24342-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1cf38a7d-ddc8-bfe2-3c6b-8298facc6d1d@cogentembedded.com>
Date:   Wed, 10 Apr 2019 12:17:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409114333.24342-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.2019 14:43, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the call to brcmf_sdiod_set_backplane_window fails then
> then error return path leaks mypkt. Fix this by returning by a new

    One "then" is enough. :-)

> error path labelled 'out' that calls brcmu_pkt_buf_free_skb to free
> mypkt.  Also remove redundant check on err before calling
> brcmf_sdiod_skbuff_write.
> 
> Addresses-Coverity: ("Resource Leak")
> Fixes: a7c3aa1509e2 ("brcmfmac: Remove brcmf_sdiod_addrprep()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
