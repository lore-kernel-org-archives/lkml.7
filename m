Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D83C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB64206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yNmSUGT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLOSwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:52:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34074 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfLOSwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:52:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id l127so2583154pfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QnNY+Mw+UVdVWeKYYvlKA4C+OdsBsnlX2ZtfFoGOHL0=;
        b=yNmSUGT9fXfYeBddmaS3QYt97onm53IgZs9RKXw8p+RDGz63GBsW5QbRrVqI2IIbvb
         LdBeq8l9SBnxJiSnCu6vtyEioBuYPj29AtlfQ4dU0hgEJdQ6qgG5EysdLgB4QLmaSUe1
         Rm7wckgFqz16+opDRLkvd7zHNivq+jWKwAKMtgvNdimevZcFnEJZTQvkO6GeOLbSqrpf
         ypLZ3TzN5zqjVRmRAxSo3Xo72FT0oHuLNt5CNg28zX565RK1AOykg7PcLfjmqmU8TXXH
         2CCJVDc64gFBeeVVo2K1fPjqmSDruJSX8bIwHvBV7z2RrAOnNVgqtdndVHxLEwCzLa1v
         T8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QnNY+Mw+UVdVWeKYYvlKA4C+OdsBsnlX2ZtfFoGOHL0=;
        b=Gx0P3tRN/QX8B+htoy+q99TSb+vi7KTNGGbk/b1T5UEUTUHvqLm5af0bpl2TwK44nI
         qln97VeN5ZJoGbVPdN1+xSwMjoHN7czGZcfKNM47tHc3icq+VEdfjdmrn8Nci6hH2vfB
         zC6qlpeNfpikICdfEXTPXpbwQyhEYQufd24wtsnOcQEpKikwRpjXe64f7piITEyv8lDn
         pt/yVm5SkzCcTMW/e3zEXLP7rYUv91s2F3KQBSwqGBQjMQcIpgvGG9TYpFcfMX7JidxK
         HT/V7yyIARPX/5yCCGKDq0HvrvZKOHpI+QeCfPl/7RMoAMhtHT5+VdRR0XC9C0brXlXA
         tWqw==
X-Gm-Message-State: APjAAAXP14moVcoEtsvEcrO7lnGC99OMbFkPdPlR7M0OW64CulQgfqtE
        3EpVbR7t4faPgU7DN8bUkSiuIw==
X-Google-Smtp-Source: APXvYqwIHaYLj97P+Ar5TEr7VF035L68ohjENGS5/kMDH7RlupJAWbewR6YVVDvvHMi6tGhZUN51vA==
X-Received: by 2002:a62:b418:: with SMTP id h24mr12095255pfn.137.1576435940673;
        Sun, 15 Dec 2019 10:52:20 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id b98sm16829404pjc.16.2019.12.15.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:52:19 -0800 (PST)
Date:   Sun, 15 Dec 2019 10:52:16 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2,net] hv_netvsc: Fix tx_table init in
 rndis_set_subchannel()
Message-ID: <20191215105216.4a4f3fad@cakuba.netronome.com>
In-Reply-To: <20191215091120.24e581e1@hermes.lan>
References: <1576103187-2681-1-git-send-email-haiyangz@microsoft.com>
        <20191214113025.363f21e2@cakuba.netronome.com>
        <MN2PR21MB1375F30B3BEEF42DFDB3D39ECA560@MN2PR21MB1375.namprd21.prod.outlook.com>
        <20191215091120.24e581e1@hermes.lan>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2019 09:11:20 -0800, Stephen Hemminger wrote:
> > > On Wed, 11 Dec 2019 14:26:27 -0800, Haiyang Zhang wrote:    
> > > > Host can provide send indirection table messages anytime after RSS is
> > > > enabled by calling rndis_filter_set_rss_param(). So the host provided
> > > > table values may be overwritten by the initialization in
> > > > rndis_set_subchannel().
> > > >
> > > > To prevent this problem, move the tx_table initialization before calling
> > > > rndis_filter_set_rss_param().
> > > >
> > > > Fixes: a6fb6aa3cfa9 ("hv_netvsc: Set tx_table to equal weight after    
> > > subchannels open")    
> > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>    
> > > 
> > > Applied, but there are two more problems with this code:
> > >  - you should not reset the indirection table if it was configured by
> > >    the user to something other than the default (use the
> > >    netif_is_rxfh_configured() helper to check for that)    
> > 
> > For Send indirection table (tx_table) ethtool doesn't have the option 
> > to set it, and it's usually provided by the host. So we always initialize 
> > it...
> > But, yes, for Receive indirection table (rx_table), I will make a fix, so 
> > it will be set to default only for new devices, or changing the number 
> > of channels; otherwise it will remain the same during operations like 
> > changing MTU, ringparam.

Thank you!

> > >  - you should use the ethtool_rxfh_indir_default() wrapper    
> > For rx_table, we already use it:
> >                 rndis_device->rx_table[i] = ethtool_rxfh_indir_default(
> > For tx_table, I know it's the same operation (%, mod), but this wrapper 
> > function's name is for rx_table. Should we use it for tx_table too?
> >   
> > > 
> > > Please fix the former problem in the net tree, and after net is merged
> > > into linux/master and net-next in a week or two please follow up with
> > > the fix for the latter for net-next.    
> > 
> > Sure.
> > 
> > Thanks,
> > - Haiyang
> >   
> As Haiyang said, this send indirection table is unique to Hyper-V it is not part of
> any of the other device models. It is not supported by ethtool. It would not be
> appropriate to repurpose the existing indirection tool; the device already uses
> the receive indirection table for RSS.

I see, I got confused by the use of the term RSS.
