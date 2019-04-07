Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C6C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB64220B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="QjqC3P6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDGOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:30:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37257 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfDGOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:30:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5779113pgc.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/LXkBOuFHQD+I89OT5yXPIOT2onkPr4yHk1fRDooJXg=;
        b=QjqC3P6la2hsCbhxmAZcxKkjPHENJ7nTKl8VMR1BzFAlnBqoQcfJevnIiAjQg9M28g
         8jqO/PxYJ+sfEd2bdVaqPAV4eXHzArJ8MjSsMF/BipXKizKwG9XahY/ME/PGM0x3lN9H
         rfXZguFD8eFT7QAdu/4wufZF9FotdqoYfiymI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LXkBOuFHQD+I89OT5yXPIOT2onkPr4yHk1fRDooJXg=;
        b=UyT+e+XskJI9Hk2wjtYQ/VasmH4CMJ5MgcznhxFKjkDvfiV1FJGIi7/SR261/KGHJ8
         FvV0M/O6+PkMXnjw2ZHkSfXcAifabphuvnzZFFO0dZT1RYbkbV6OXY6+UVPI/rXfM2Ng
         V/wkmBe23CnAjQ+C7BbMZwg+KaFzf1hE9FuFwD5Ih6M5gS47nXP3crTqLmqRcsXpKbky
         36s2ENLiAJwRoNGDdTQHHdUteKWn8KQ0rPqsFlkkmVyrSEluqSdQ6PqjP4K5YLRwBp+R
         mkrQT63ssRivJaLvla/yxP78cFkAbiOZsVrgtJnVro6O4OQGcGSPzFct+IqSdCv3UtFo
         Du/A==
X-Gm-Message-State: APjAAAXyGfbhKE3W+5QYPxIPRR1FN8ZZ6jXRyXIIMviVu60UjCian4Bj
        EXopWZ/8agvhMI7lY7PbTEtFLw==
X-Google-Smtp-Source: APXvYqyzbf99AGImJSZqCeVc2Q3qZ7zsODVgiapfc/d6Q1VOUMKz4xVJzdDOrOPsDacWpVSlDbe0uQ==
X-Received: by 2002:aa7:92d5:: with SMTP id k21mr24292026pfa.223.1554647432539;
        Sun, 07 Apr 2019 07:30:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4801:fccc:a013:4dfb:78ce:7a4a? ([2601:647:4801:fccc:a013:4dfb:78ce:7a4a])
        by smtp.googlemail.com with ESMTPSA id w10sm14289584pfi.126.2019.04.07.07.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 07:30:31 -0700 (PDT)
Subject: Re: [PATCH net v2] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     linmiaohe <linmiaohe@huawei.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <c0ee938d-479d-5c92-93ce-e06c24057b62@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <18b082d4-cef9-bb39-0680-8187f6951bbc@cumulusnetworks.com>
Date:   Sun, 7 Apr 2019 07:30:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c0ee938d-479d-5c92-93ce-e06c24057b62@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/19 11:46 PM, linmiaohe wrote:
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 7c1430ed0244..4d35d37f225a 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -43,6 +43,12 @@
> 
>  #define FIB_RULE_PREF  1000       /* default preference for FIB rules */
> 
> +/* The MTU is really irrelevant for VRF except for odd cases, so limit it
> + * to a reasonable range which both works for IPV4 and IPV6.
> + */
> +#define VRF_MIN_MTU	1280      /* same as IPV6_MIN_MTU */
> +#define VRF_MAX_MTU	0xFFFFU   /* same as IP_MAX_MTU */

Since VRF does not care about MTU, there is no reason for VRF specific
macros.

> +
>  static unsigned int vrf_net_id;
> 
>  struct net_vrf {
> @@ -1274,8 +1280,8 @@ static void vrf_setup(struct net_device *dev)
>  	/* default to no qdisc; user can add if desired */
>  	dev->priv_flags |= IFF_NO_QUEUE;
> 
> -	dev->min_mtu = 0;
> -	dev->max_mtu = 0;
> +	dev->min_mtu = VRF_MIN_MTU;
> +	dev->max_mtu = VRF_MAX_MTU;

Set these to IPV6_MIN_MTU and ETH_MAX_MTU and add a comment that VRF
devices do not care about MTU, but if the MTU is set too low then the
ipv4 and ipv6 protocols are disabled which breaks networking.
