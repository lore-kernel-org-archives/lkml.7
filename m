Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89075218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="bQjBs2w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDWXPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:15:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35983 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWXPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:15:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id m137so6043201qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mzS8NJXvXhvwkIeuXh0JKOU1NhCCN8QIQnCColypfAo=;
        b=bQjBs2w8b+7lG1hnKi7/rJAfsmtxi5qNS0kAEx3RTh8TTH/IcHN3qQlE5SL5klCktD
         IndIHMYr0hV1TwIusyEwzeoDn8TL7qlcCot6iUzbDv4OVqJdtq9BMrHxZ1dBHaMGmktd
         hZDdVwBwFsCD9btMP1FCvwViNtNK6VxLIsm4RBQNhua3Pfj6NQafb5se9yA7sSSFm/p0
         5tuuVosClhPbEGjraDqaIx6SGpvCvNZJQ0ZwXgd5eoY0jsGDo2kUWxuYSGYM6YCsw+88
         5Pjf8Oo5dagqdcehClrCY6V5waAg04D19VOdNz/kfD06WO5jUx09yoO1pL2eFC49U50/
         Q5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mzS8NJXvXhvwkIeuXh0JKOU1NhCCN8QIQnCColypfAo=;
        b=L4KsR/l4lxuLIzSbF4hbsOKPt9fjN2Ozjs0SWPjHg9+M+bl9JezaoTUpxCvNb2xkb+
         ViYOdY2zZrOeJSjzVbDEbb0zJox6cmNDlFMSENM2EwjAouI5QPbtaNz8BdKshIlnIjLa
         AP7aS+GpEs52t1V4rHZFWyyRVS+Wd+tSLMPSisqYxojHrauA/Kti46oJ8xookXi95LAp
         SBq1brSupAovNygUFOW6UnRku8PWkwIofC+b5iP3D++X9AbkZrZkUHWwM8Z8bmvHOoSZ
         bkr73zUjHgneuxZgq21vUwaf99nUrvINDepNmBbN+qvjENZlZk/s5VocHNGNxblLEDU2
         qpWw==
X-Gm-Message-State: APjAAAUgmlWCiBZ1i1G1GJuVE9dXbzgGTz2tFei+4+02fbxEVU8BfQKg
        w8FBJgOoeq9wB3OMdikO5Ewxsw==
X-Google-Smtp-Source: APXvYqwd8K7MCxleHfm654auOFJmB3DXSFRb77QgcFWAYdwoYOpjsU42LX4a5HfCpY8UAdVjv7Vgfg==
X-Received: by 2002:a37:7383:: with SMTP id o125mr22353307qkc.56.1556061306558;
        Tue, 23 Apr 2019 16:15:06 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q5sm6961125qtb.44.2019.04.23.16.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:15:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:15:02 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tao Ren <taoren@fb.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Message-ID: <20190423161502.5d3e9c36@cakuba.netronome.com>
In-Reply-To: <20190423224138.1295-1-taoren@fb.com>
References: <20190423224138.1295-1-taoren@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 22:41:56 +0000, Tao Ren wrote:
> Add eth_addr_inc function in etherdevice.h to increment MAC address. One
> of the use cases is in ncsi stack, where the host's MAC address needs to
> be incremented to get BMC's MAC address.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

Please squash this patch with the next one, IMHO they form a single
logical change together.

>  include/linux/etherdevice.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index e2f3b21cd72a..d48e3a724c54 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -448,6 +448,19 @@ static inline void eth_addr_dec(u8 *addr)
>  	u64_to_ether_addr(u, addr);
>  }
>  
> +/**
> + * eth_addr_inc - Increment the given MAC address
> + *
> + * @addr: Pointer to a six-byte array containing Ethernet address to increment

Please see:  Documentation/doc-guide/kernel-doc.rst

Here we need:
 - "()" after function name;
 - no extra line between function name and argument description.

> + */
> +static inline void eth_addr_inc(u8 *addr)
> +{
> +	u64 u = ether_addr_to_u64(addr);
> +
> +	u++;
> +	u64_to_ether_addr(u, addr);
> +}
> +
>  /**
>   * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
>   * @dev: Pointer to a device structure

