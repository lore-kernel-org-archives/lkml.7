Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C442C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D10206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pdPSpxfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKVBD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:03:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39691 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKVBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id p18so5365907ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=m913jDXRVfEU7lrY83rHrp6DULNdfWEGAoaZqXDkLTA=;
        b=pdPSpxfBL1Ad/3JxV2mSmO4/6BOLjdGP/pkx3d6hs6QjMYWgNGmqybdAf8cVPb89MZ
         7iy9H6Bwou+6jSwmM1TkH0C9Mb3il/QOlSAbnUqSfnXx9R4E3u4GoTFqXkAYmUgbtWG/
         tldohmrkjSlw5hFcoW0L9cq3GjjCoh3i9UnrYfAl89Haytv6HBQTb73zmL5Nk1fmEdxY
         H31lfYB9925iXHbcDYjLF1RNJTiR5EYdDBnU0AAQfTpg0fiXE0TuYDdFNdeBB0waW0GY
         jKh67f3p7oxgyRw2uOMO5swxmrTiGZHbsFXZ73I5CTvbVBFrzxOtnpwyrzVggFornKH6
         tDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=m913jDXRVfEU7lrY83rHrp6DULNdfWEGAoaZqXDkLTA=;
        b=e6fljJZPdXe48LnKcHFbNBszS4ElqY1pOjPrRQGFDVzVT5TzxhNJXkBgEns1lGOoRE
         H0K9JtPxB9v1S3lYhLq0GRabcyFLB6TSI1jn5H8yKOicbvk050K4MSw2DggsqRXPLXQW
         QOgngdRpaQRZrGzAjUQwI+fDz4beP/btme6Pa3Wzy1/cMqF/iAV8hgZ/H80dKUSQfF4h
         zmYm+/Ax4D/E5eIfUz/nABjlCgWnOUhnIoxnKuHQTtuZO5uHofLKqa1hY/OB/QkNSKHm
         FM99u/TTOu1jQ7WvHqNhW5EmYOzK5jNN7abBIpfEjR7HrPzHQNPDSO6Zvw/t8VIwqZ+Y
         WxrA==
X-Gm-Message-State: APjAAAWwUnlBNGB41MxcWV3MYD3BPofVpjLGjUA+CRLneOj6w2St2Sh2
        2mBbPNrbS2gAbs8RTExFqBD1ww==
X-Google-Smtp-Source: APXvYqwnfSXY9PpKVzQQhCKshLxwXTVie+X/fnKl31b0ZdToCRb9i101bmYL66lYSpv5fqV8f+CPAQ==
X-Received: by 2002:a2e:575c:: with SMTP id r28mr9849257ljd.245.1574384626222;
        Thu, 21 Nov 2019 17:03:46 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s27sm2253515lfc.31.2019.11.21.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:45 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:03:35 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net,v2 1/2] hv_netvsc: Fix offset usage in
 netvsc_send_table()
Message-ID: <20191121170335.2f73792d@cakuba.netronome.com>
In-Reply-To: <MN2PR21MB13750EBD53CFDFCBA36CF1D8CA490@MN2PR21MB1375.namprd21.prod.outlook.com>
References: <1574372021-29439-1-git-send-email-haiyangz@microsoft.com>
        <1574372021-29439-2-git-send-email-haiyangz@microsoft.com>
        <20191121150445.47fc3358@cakuba.netronome.com>
        <MN2PR21MB13750EBD53CFDFCBA36CF1D8CA490@MN2PR21MB1375.namprd21.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 00:54:20 +0000, Haiyang Zhang wrote:
> > >
> > > -	tab = (u32 *)((unsigned long)&nvmsg->msg.v5_msg.send_table +
> > > -		      nvmsg->msg.v5_msg.send_table.offset);
> > > +	if (offset > msglen - count * sizeof(u32)) {  
> > 
> > Can't this underflow now? What if msglen is small?  
> msglen came from the vmbus container message. We trust it to be big
> enough for the data region.

Ok, it looked like it was read from some descriptor which could
potentially be controlled by "the other side" but I trust your
judgement :)

Both patches LGTM, then.
