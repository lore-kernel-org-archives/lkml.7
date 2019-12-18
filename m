Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A03A206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SG25oBrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRBDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:03:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44449 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:03:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id d199so209730pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 17:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FQ2Atcla/gG61WjI4Nh254M/cUJyWwhUItuzr65oh5U=;
        b=SG25oBrE2Q0kw/yDz5oUNev8WTNQAGZYf/ADzD/Q5WC77ON4JibKYSHl+sN6AEA05R
         ncKVW9BkI4YsW6NjDBxe3MLVKw8wZLuQ7EpBHMtU+mKR1hn5eHKAU1tb9U6su++7K5U0
         oaM7dHm5DItaPzBnVbmnSZ0HQEuwHPw9KNIbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FQ2Atcla/gG61WjI4Nh254M/cUJyWwhUItuzr65oh5U=;
        b=XwF5ViLBy0BymGx5pRyBewxlpVNcUHClRxlhKrq7dv0f0KdtWMj5dP+LQfPLdTKg1n
         X3bjZZipXTeUTkUUzm9XV//2WXDUzKBW9yrZWqYSttj8+mExK6uV0mvxu4bY6aq5OJz/
         tpNx+MbqCYCy3da6EmgjBwVmpW47ASsZAkOQN4HSbM7ALNGcZirS/ByR4nlVf1ogoPaW
         esxJOTJnxf67/3lO5G0inI523mqR+3slXxx958CuYJAXXiW6H40v8YvYwS25LQNb50pt
         cO+svynJsDOs2EkdeOJ25X+l/xZBi1tDwaAtrVUTUTp0l4zBAw9tJe9ZEX02ZGKIdQ5S
         B8yg==
X-Gm-Message-State: APjAAAXkd5N/S4VEbPHQEOMsCvRekWabIoXwdeRhtBuy9GrmrjacimdX
        kVhYpcIXA4yhRZdprCNUaP8reVcXTiPGYCzp1qGSMDUVQbmcTCygKkUGzgvQC4hFkuwJqdTfBfi
        Aa0NrG/91QtKAd+FlqbrNCIfl3ojB0O9GOD3QbeHECmSe7lGp8LezSymQDg2yKCTI2iEuY1FxMo
        FJhJ2FAX0EVQ==
X-Google-Smtp-Source: APXvYqyBR0QbZWva7oPJuSIpzB+wr90yUcvYMKbCa8R+aXg2XYLW+KZ7Y2s7CSBj5UO0yZpgqDjY5w==
X-Received: by 2002:a63:cb48:: with SMTP id m8mr981142pgi.128.1576631000275;
        Tue, 17 Dec 2019 17:03:20 -0800 (PST)
Received: from [10.67.50.49] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k101sm180402pjb.5.2019.12.17.17.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:03:19 -0800 (PST)
Subject: Re: [PATCH net-next v2 3/8] net: bcmgenet: use CHECKSUM_COMPLETE for
 NETIF_F_RXCSUM
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1576630275-17591-1-git-send-email-opendmb@gmail.com>
 <1576630275-17591-4-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 OXY+VnhOn2EcREN7qdAKw0j9Sw==
Message-ID: <47b1684c-2025-ca80-0950-2696684038d2@broadcom.com>
Date:   Tue, 17 Dec 2019 17:03:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576630275-17591-4-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 4:51 PM, Doug Berger wrote:
> This commit updates the Rx checksum offload behavior of the driver
> to use the more generic CHECKSUM_COMPLETE method that supports all
> protocols over the CHECKSUM_UNNECESSARY method that only applies
> to some protocols known by the hardware.
> 
> This behavior is perceived to be superior.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
