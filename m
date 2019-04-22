Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AE3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C7120859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1VXDcldX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDVUjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:39:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44932 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbfDVUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:39:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id y5so7221484qkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=12fGXN1MFQ+YN+G4XSb4RzcfVfa/2mWdTJAL++9CrHM=;
        b=1VXDcldXfMsrHV8Pp0/Sk0toBAD+1gmbJC4HOzA+XvXapT92yh03vjSTDkaYZg9k5C
         WYSyk+IWPxwyecO4ddcZQr+TK4f4pG90GMSQVKo/5QNaUUk+rY9UnUZAHJ5Y/fHOACOf
         eDS0UmsjpIBdWwklgUIxbKQRRu4G8GD5eFwCSxBOJlOSPEOSZoO3Rkr9PdsdqPqQjb6N
         d3Y5BzmH0RNwZTEBcz//RUReSBXVfmzx9UyiNGXpWgugYI3g+JAs0UTVDh44jVVIbHnn
         NEWyHgCxELfQJdv7fqpKlux/uoRcnZbkHc4K+TUqZFwdNfAZldGJKz75M58t5E/F6I8b
         F7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=12fGXN1MFQ+YN+G4XSb4RzcfVfa/2mWdTJAL++9CrHM=;
        b=tE24Jwp5IWliOtrMAaNaOA5HCxpo6oinKOYaTnU3Adg7RYIsqcRGcjBPenHfmYlgX9
         IdSeUe04QzevpC+5q7Y/769g6hPIF9qsVwxbDebVeAFCH0BtItDtNfw7ihmndHYRjXba
         mD3DSLS6knkseyrUK9EunAL5eQ/lVBRtXNSaWEUTiXSLoyv+16Q7A0ZKfBgbzwebsckg
         NtmVuf+34HEjl9aLw56GR2cM++mwNgzZKGnOJdVPyhNwIcrSQ5fW5ToJ68K1RAbSyChu
         rRnBtgyj491Hq1/0gALb3Q5ds3MQDIjgtlrwDPRtmB0KdjIHNBCO/KDXG05R4TQv8bv/
         CawQ==
X-Gm-Message-State: APjAAAWDvJUUFlThu668M07/7BCWK8XB5dtv3eOs3+QeNO41Wgc4dtTx
        GhuAf+Yi4IJxsp0Prb8/H34NMQ==
X-Google-Smtp-Source: APXvYqzLnYo9jgh8YaoFBhDul8IRdTI5NaV7gRqh0pYzHDo9lvz5RB9w1HbMao/ZPjUJfucltdOxWw==
X-Received: by 2002:a37:69c3:: with SMTP id e186mr16173321qkc.308.1555965592828;
        Mon, 22 Apr 2019 13:39:52 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 13sm4529282qtm.52.2019.04.22.13.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 13:39:52 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:39:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     crag0715@gmail.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario_limonciello@dell.com, "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
Message-ID: <20190422133947.0b6aaf82@cakuba.netronome.com>
In-Reply-To: <20190422050344.24513-1-crag0715@gmail.com>
References: <20190422050344.24513-1-crag0715@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 13:03:43 +0800, crag0715@gmail.com wrote:
> From: "Crag.Wang" <crag.wang@dell.com>
> 
> Without this patch the socket address family sporadically gets wrong
> value ends up the dev_set_mac_address() fails to set the desired MAC
> address.
> 
> Signed-off-by: Crag.Wang <crag.wang@dell.com>

Code looks reasonable.  This must have been caused by:

Fixes: 25766271e42f ("r8152: Refresh MAC address during USBDEVFS_RESET")

which is still in net-next.  In the future please make sure you read:

https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html

In particular:

https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html#q-how-do-i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in

To assure smooth flow of your patches into the tree :)

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 4c63b40d5e00..41fb39ce69c9 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1225,6 +1225,8 @@ static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
>  	struct net_device *dev = tp->netdev;
>  	int ret;
>  
> +	sa->sa_family = dev->type;
> +
>  	if (tp->version == RTL_VER_01) {
>  		ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
>  	} else {

