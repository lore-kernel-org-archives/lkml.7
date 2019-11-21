Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1CC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B83206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Nc6/mbo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKUXE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:04:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45415 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKUXEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:04:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so5073499ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ujSnirx0MMYk1nWbIfrsLRgvcTHBcDKnqPSTu0uZhPM=;
        b=Nc6/mbo0NU7TqyfZ0KlcWiAFlSVLQv17ZroqrY0RRWkOLd+EX3M0YN/8CWH1eoWDxm
         2XpNdcx5yss6p7g5w7yowMTkhd7PhLgYbpaqA/BdiMguJHL7uZ8TFq9ct50g3xAb9MKi
         uhYApgEyRVoNYA0UGHawQt2+EmxOwKrQGWpeHVB9t/hau3ZCsCa2P8QRC9000TmAfAaU
         8WzEu4NDMYH1F3s30mvOmIRvbIfbo2uSIU29VSXlubGOa3SYWiqK5xXIvi3A7I0iz9Ix
         VUVSNyhYKiy8s/u9kOjcbbaUoswVrPIZdGtdLvMJVR6nLYyPFZUKK98OIX58Vf1LFTdr
         8P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ujSnirx0MMYk1nWbIfrsLRgvcTHBcDKnqPSTu0uZhPM=;
        b=f/JRs6d0uIeNJJiAxu76S2S+Ujg9SANn/aqv5tj8d8sRU5uhazE0YdJ01jhioMBT+F
         Hqkw1NIPZ+Mq31y9iZ+vyINusgpMELcKgZP9r/i0yCfhX6X0Fl8pX5F7lfE4Ex3LUhoK
         w8eMJX8S6Ro2ho8vQ/bsudX/dNzxSq84BASFhRqAQ20s3hu9ox5u8nofcR/PodC/tfLA
         EkWn3kT5W+aYrA4rNggjNiSSON72vD+uAi+xlSodfJCbngZi/CngMYppcNcyYZ0VTwmx
         3SMfmDLphYyDDdsNjZEUY6E97ZyAjeRuxG1mBquwalsVUOO2ilGvA241qhl7TL3BldeX
         IsIQ==
X-Gm-Message-State: APjAAAVnhgb1b0yGIxtNlQQBVpJpimfZIyjl1sDh1zelSPWJKTnEBbKi
        JvBbwO5kCONrkCmOk4u9qmQgyg==
X-Google-Smtp-Source: APXvYqz0mplj+GIU5C+xgkex6FnLpZY91dYMJ1RaB5pMlahZp9Gr58LPzTcEQ5ePObyFharZ/pSU9g==
X-Received: by 2002:a2e:8857:: with SMTP id z23mr10180706ljj.50.1574377493540;
        Thu, 21 Nov 2019 15:04:53 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i6sm2129075lfo.12.2019.11.21.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:04:53 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:04:45 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2 1/2] hv_netvsc: Fix offset usage in
 netvsc_send_table()
Message-ID: <20191121150445.47fc3358@cakuba.netronome.com>
In-Reply-To: <1574372021-29439-2-git-send-email-haiyangz@microsoft.com>
References: <1574372021-29439-1-git-send-email-haiyangz@microsoft.com>
        <1574372021-29439-2-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 13:33:40 -0800, Haiyang Zhang wrote:
> To reach the data region, the existing code adds offset in struct
> nvsp_5_send_indirect_table on the beginning of this struct. But the
> offset should be based on the beginning of its container,
> struct nvsp_message. This bug causes the first table entry missing,
> and adds an extra zero from the zero pad after the data region.
> This can put extra burden on the channel 0.
> 
> So, correct the offset usage. Also add a boundary check to ensure
> not reading beyond data region.

Please provide a change log at the end of the commit message when
posting new version in the future.

> Fixes: 5b54dac856cb ("hyperv: Add support for virtual Receive Side Scaling (vRSS)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

>  
> -	tab = (u32 *)((unsigned long)&nvmsg->msg.v5_msg.send_table +
> -		      nvmsg->msg.v5_msg.send_table.offset);
> +	if (offset > msglen - count * sizeof(u32)) {

Can't this underflow now? What if msglen is small?

> +		netdev_err(ndev, "Received send-table offset too big:%u\n",
> +			   offset);
> +		return;
> +	}
> +
> +	tab = (void *)nvmsg + offset;
>  
>  	for (i = 0; i < count; i++)
>  		net_device_ctx->tx_table[i] = tab[i];
