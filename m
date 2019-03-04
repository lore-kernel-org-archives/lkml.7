Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C90204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwV4bmBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCDT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:58:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43988 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCDT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:58:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id p73so3811361lfe.10;
        Mon, 04 Mar 2019 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elT29l8X5hVeGPNB6shy9LBKPe6vGAMd1PWsj3gyLFE=;
        b=XwV4bmBDkKLNrNwZTpfW6J68aUu3ZZnajWKIlC12bXJIhi8gdniy038v0u+9uvk12G
         wsboS89UE6p/0ujeVJlhFmBDiPohwWgo99NP25m8ibh2m0Cdlp6xAiJu4v3wcjxVMZSJ
         Vv4/+28tVYjYECWpDeSP/XCVfMlVS+F2Kx5ImLzj7SU53Vv5bE7l642rPRJoyAuUwLrQ
         He2gSD95oOyUKXk65+T6YzlbluJXZNOnrrS/DBCCCceK0nN5BLMuAZG/9zXoK47CIyLC
         Y5X7Oo6EfB1dlrQ3GwskkabTiETXpZ3UJpExe+vHAifRraKvqf7lRTeJKxhGmnwXMHq9
         Qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=elT29l8X5hVeGPNB6shy9LBKPe6vGAMd1PWsj3gyLFE=;
        b=skcQcO9PrEOS6ucdrfn+APNN+RvDcS00wMjAw03OIa1MOa/EPUgcoly+9ZW4DBUF8N
         LWy8uodM/hlx9ZCJ6B4SgBUZlFZuPDkkkvUJ65EsOOrJ9vmhPUdlmtV8lgKQMnI6M6ko
         S5N3LoWLqn9BhgDOvN9R6Agi7FsuUryN4IzK2z5UdV6HnBu4p880EATx5hqKezKetMzW
         gInrHLQzr9WTbezCmHgnWJw2CXOxgROsimfIU8grpJqqxiXbOPxoW1z4L87mb3kmWxhf
         wo9B/W6juVrt+BZgZTiH8bHraIFj8RIfAdSOAv5sXs3qa4kPT1+KAzaQyg8l+Bb8r98W
         HH1A==
X-Gm-Message-State: APjAAAXlL71D+sliV6S8zgjkJJ879t+uDGNazUy2CXFyTzWDRlR2IqoB
        +zUA9Re7hIJS9Lug7DPttKo=
X-Google-Smtp-Source: APXvYqzI+Xc15+oqxZDIcLsU3L9ErhdrzSo9xaFUtqYm1IygfhGcRFUkewyYhBJPjTDaOvu2FNUwhA==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr11053618lfg.72.1551729534291;
        Mon, 04 Mar 2019 11:58:54 -0800 (PST)
Received: from ?IPv6:2a02:aa7:4000:561e:3eff:d48d:3612:5c09? ([2a02:aa7:4000:561e:3eff:d48d:3612:5c09])
        by smtp.gmail.com with ESMTPSA id a201sm640497lfa.93.2019.03.04.11.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 11:58:53 -0800 (PST)
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20190304150419.GC13452@kadam>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a168eea9-5fb4-1f1a-c7e1-3966f3d79a64@gmail.com>
Date:   Mon, 4 Mar 2019 20:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304150419.GC13452@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 3/4/19 4:04 PM, Dan Carpenter wrote:
> Hi Tomas,
> 
> url:    https://github.com/0day-ci/linux/commits/Tomas-Bortoli/net-bluetooth-Fix-bound-check-in-event-handling/20190301-213647
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> 
> smatch warnings:
> net/bluetooth/hci_event.c:3986 hci_inquiry_result_with_rssi_evt() warn: potential pointer math issue ('info' is a 120 bit pointer)
> 
> # https://github.com/0day-ci/linux/commit/00305742c021794f147b348d45eb10ea26e5a514
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 00305742c021794f147b348d45eb10ea26e5a514
> vim +3986 net/bluetooth/hci_event.c
> 
> a9de9248 Marcel Holtmann 2007-10-20  3979  	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
> 138d22ef Szymon Janc     2011-02-17  3980  		struct inquiry_info_with_rssi_and_pscan_mode *info;
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 138d22ef Szymon Janc     2011-02-17  3981  		info = (void *) (skb->data + 1);
> a9de9248 Marcel Holtmann 2007-10-20  3982  
> e17acd40 Johan Hedberg   2011-03-30  3983  		for (; num_rsp; num_rsp--, info++) {
> af58925c Marcel Holtmann 2014-07-01  3984  			u32 flags;
> af58925c Marcel Holtmann 2014-07-01  3985  
> 00305742 Tomas Bortoli   2019-02-28 @3986  			if ((void *)(info + sizeof(info)) >
>                                                                              ^^^^^^^^^^^^^^^^^^^
> This is a pointer math bug.  The options to fix it are:
> 
> 		if ((void *)info + sizeof(info) >

Yes, also sizeof(info) should be sizeof(*info)..

> 
> Or:
> 		if ((void *)(info + 1) >
> 
> 
> 00305742 Tomas Bortoli   2019-02-28  3987  			   (void *)(skb->data + skb->len))
> 00305742 Tomas Bortoli   2019-02-28  3988  				break;
> 00305742 Tomas Bortoli   2019-02-28  3989  
> a9de9248 Marcel Holtmann 2007-10-20  3990  			bacpy(&data.bdaddr, &info->bdaddr);
> a9de9248 Marcel Holtmann 2007-10-20  3991  			data.pscan_rep_mode	= info->pscan_rep_mode;
> a9de9248 Marcel Holtmann 2007-10-20  3992  			data.pscan_period_mode	= info->pscan_period_mode;
> a9de9248 Marcel Holtmann 2007-10-20  3993  			data.pscan_mode		= info->pscan_mode;
> a9de9248 Marcel Holtmann 2007-10-20  3994  			memcpy(data.dev_class, info->dev_class, 3);
> a9de9248 Marcel Holtmann 2007-10-20  3995  			data.clock_offset	= info->clock_offset;
> a9de9248 Marcel Holtmann 2007-10-20  3996  			data.rssi		= info->rssi;
> 41a96212 Marcel Holtmann 2008-07-14  3997  			data.ssp_mode		= 0x00;
> 3175405b Johan Hedberg   2012-01-04  3998  
> 
> regards,
> dan carpenter
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

regards,
Tomas
