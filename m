Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E3CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38F72067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UWxTNpUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfJ2Int (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:43:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfJ2Ins (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:43:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so12648460wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U88yheObN+4ggJffRHrczNdJdHrli+5k282weA3zmys=;
        b=UWxTNpUj0SpmspSoeCVT8jWoJw3f34L0dLvZYLStfybqEFBCPn2e2AlgHmO0xhvKGm
         grjbzGyIrKbP7lal6JDVcB+aInE+hHfT06WpRjlM7fFAlIF2Hjh+x4p92KBB66jvpE04
         +QZSbvcAXfUbscunom8hd1nr1oMy9rEwVVEZaa4wTytbntlAryf+Yw+XNmBWbVIDLVzC
         /oCHObbo6+47ZgaTp7NhAQMTxqfzgpt2lC6UqRUX7Sm23lwPVXJ9VMs/mbtKCxIH3cGk
         XUI/fK+UDK79JK6ztv22QRiRQOMI6Gwa1snOn8g5PAIH4B1k00fs+fo4MSZ6ZK7/G+T7
         v2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U88yheObN+4ggJffRHrczNdJdHrli+5k282weA3zmys=;
        b=gc4LxweHV2wjise3WUj8dXv2tohpqMpROqkf+WmEHYh5ILrh16Oowkm2vpLdO22mFF
         CyKAt1BGDmprJ6Gy84Hek4qIB3y985Z9Ig1/Ea9Od6mFvztMMrnvkM0FhJTtsuUTJ3o9
         btJcfE78AjIbt6Fe5JtTqGi+PubMmh176CcVtlvrA7SQvrsg3hNN+4MmLoDuBVL0sB6p
         VXjq7zJUgks/YZYfOqc1Voxg7biecEb2qL+Zh0Vu9zrunEgKFFBDdtU+0XEy5aAmFTTx
         G8Hy36od8pv8YpKn5SLWGsjcwMnN9MbQBQQPO3dfReUsd7L5m+lCLTTdp1wUMOWyi3v7
         4LFg==
X-Gm-Message-State: APjAAAUnQt5+Ez+SrqcCM4uy12k8SA6ROqNDwJOqRJ2hq3xXCypbf9fo
        HycEQALsEw+6tTcztHck4957PA==
X-Google-Smtp-Source: APXvYqxRRsQAmnunlnuxpBCGvAUEzg9Kx7yBGFf0A1pBDmvOd/v+CXTq3tGGCyX6dcNLA0ezvj2JBw==
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr19959327wrx.171.1572338626088;
        Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id u10sm2793363wmj.0.2019.10.29.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:43:44 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Joe Perches <joe@perches.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        kvalo@codeaurora.org, davem@davemloft.net, swinslow@gmail.com,
        will@kernel.org, opensource@jilayne.com, baijiaju1990@gmail.com,
        tglx@linutronix.de, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] b43: Fix use true/false for bool type
Message-ID: <20191029084344.GD23615@netronome.com>
References: <20191028190204.GA27248@saurav>
 <20191029082427.GB23615@netronome.com>
 <055503c8dce7546a8253de1d795ad71870eeb362.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055503c8dce7546a8253de1d795ad71870eeb362.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:30:34AM -0700, Joe Perches wrote:
> On Tue, 2019-10-29 at 09:24 +0100, Simon Horman wrote:
> > I wonder why bools rather than a bitmask was chosen
> > for this field, it seems rather space intensive in its current form.
> 
> 4 bools is not intensive.

Thanks, point taken.

> 
> > > diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
> []
> > > @@ -3600,7 +3600,7 @@ static void b43_tx_work(struct work_struct *work)
> []
> > > -				wl->tx_queue_stopped[queue_num] = 1;
> > > +				wl->tx_queue_stopped[queue_num] = true;
> 
> 
