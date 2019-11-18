Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A55AC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6447217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="dLIQEzcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKRR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:59:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44228 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRR7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:59:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so10722422pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EYmZ7NRTxHkOWSbSxQ0gywzZ0Cdf+FfUYZH7rtEdQE=;
        b=dLIQEzcwJz03sHkX/zkGpM9f5gUe4Ym6v3uAIwg37cDxKuvpfBDkJEaQpxzKHzK5fv
         PwiH8ZdFLgm9mi7G+FxOTJvbzKFvKbp0ZgvV/+/9eTdRu09rUCCIgt5Tijrm0oYfy6vY
         ae1TO3fwnzHwp3RD6ch5hUmBkvcD+bd+BIxgPXQNrpmYl0ys7jhvyb4EoYa0Z8UumCPo
         gh6FWfkUDYgGqYD38BJRkMEycx7slcYj7Jq8bjTk9qSQY/FFFun9JXxsrlxiyZ1WepyL
         7KFFRRVvozD2Fp1TqFeOS5wq0MPMFwO17JNiyIJpw+vvX/Dh4GK7wqmIU4GXaHYcgUuq
         WMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EYmZ7NRTxHkOWSbSxQ0gywzZ0Cdf+FfUYZH7rtEdQE=;
        b=UJYKkqJB98bCr/5+BN21V4zEeMMZWw1Ub65FewTABwMZvm61zTAIlDn9YPs9N+iloD
         YTcwqO7/+1rDnl0fF7Za2wRWzaC1+pVXhvMrPmCvRsKSp4jIx71mOgyHboYL8PTrOBq+
         WnyO4Q92ZvkhuqCmlqnkP5wBlP2p8hwKwXNfDNoXGgRWlOFasZc5htnoQuX6DxLUR8pI
         ImDSnNhtsLXRoOaH1WsoZBG5T2JrKY3ZQTusPv8x9Xg6lrJfMTOYQmjPvMpmoo4fkVDA
         XP4eK4N0Wuomp4pkfkJ5Gr+XkDOmnX8bHOhiAyyu8nE9Vs3qpvE4SeeHzb93RNXX+8uh
         A8MQ==
X-Gm-Message-State: APjAAAV3lf/Q1/wKgt0u2Vl3TBx93E/TpAagpgPjADIjPbYNYG7KC7oP
        vmsrL4bptL+0YahahDSM53+6P2usJBvKEQ==
X-Google-Smtp-Source: APXvYqwe244ck0Ha1OOKUd5dlfDyynPE9re1cJMR8bAB5hw9pzDlUwsH4z+WwCavWNf8pM4H24Z4bg==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr623031pgi.132.1574099953908;
        Mon, 18 Nov 2019 09:59:13 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r16sm18525557pgl.77.2019.11.18.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:59:13 -0800 (PST)
Date:   Mon, 18 Nov 2019 09:59:10 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net, 1/2] hv_netvsc: Fix offset usage in
 netvsc_send_table()
Message-ID: <20191118095910.3566c5dd@hermes.lan>
In-Reply-To: <87wobxgkkv.fsf@vitty.brq.redhat.com>
References: <1574094751-98966-1-git-send-email-haiyangz@microsoft.com>
        <1574094751-98966-2-git-send-email-haiyangz@microsoft.com>
        <87wobxgkkv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 18:28:48 +0100
Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> > +		netdev_err(ndev, "Received send-table offset too big:%u\n",
> > +			   offset);
> > +		return;
> > +	}
> > +
> > +	tab = (void *)nvmsg + offset;  
> 
> But tab is 'u32 *', doesn't compiler complain?

nvmsg + offset is still of type void *.
assigning void * to another pointer type is allowed with C.
