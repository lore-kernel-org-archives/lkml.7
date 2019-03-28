Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E1C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C77220700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Hrfx+TVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfC1Sib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36649 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfC1Sia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so978559pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HgwLPeP0qqBX11bWu5yNsHrwRKeRYbfEdwOA4/zC80=;
        b=Hrfx+TVXtP1YJ63SWkJ55zSFAxpNSAyIYL7yJbEKf92yCTm4GH3qbX5ggWeF0nizrx
         /nJnrvlJ8323hu9UyTRjbDjHHn/OVzkMqBEYXjzi5vxAavRr+SwImmfsxLe0JZnF68Rq
         I6kQhT1ReaQriWi+gvBO09pPpaFoWfiifIrqOOLNyirzPMlzYdf1JiKwzS1T/vnn/umM
         yHKYCEEVjiRNDCwG+zXIRGYb1iZnl6e60uXYH1C0DNS4l+E5sg3qbGzdnonFjr6tMZu9
         OK8ZYNPrlTkB8o+lNWmxiKcsa5nyVcLsc8Wn2OR9f98Ike9A2ZDDDC/iu58hCBMAz3eM
         idMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HgwLPeP0qqBX11bWu5yNsHrwRKeRYbfEdwOA4/zC80=;
        b=DssvetBRer0nb6eDDU1oIw4Ro+rhwOW/09z901tjd+fMRXekXkF2u+qk1erbhY7sGL
         kwc9ufC+ncP6V6r0efjZw3vf4BJHk3vxhTdB0DGOSwjQKZLZpy6fxOZk+FrsZh5EiBDp
         eZL6iJMk4j9fr5QdmED+Pt+hl0aPLKBZF3RvM0bgDtI00zm4y/EsMjIIGUnvBfq5QIH8
         RvykwT3Gjk2v2YJ8Z/BLmcPd4Z/AMEn3bmXs55Wu83FtKcYGCCPUfqk8Q4O9cO6oypdv
         MH6z6nwyNQVe5uac2Tm7ePSdosU4t6YwtbzwbXIBkf6fvr98I/soBeRqm5SSR2I9HVQH
         DgiA==
X-Gm-Message-State: APjAAAVpQzG9NS11AYbnwi7CxaXDWzEkVM3Df1jsb7oo3NRxtL4w8VbO
        AaP2qimNnD8lkRGr+CziNmL4jw==
X-Google-Smtp-Source: APXvYqx6nRklFUwe7sou9TUHY57Ksq3AeQythrMrdXdTXNrlId1MD02ctcp3Jrz6RJHVkP3mR52G/A==
X-Received: by 2002:a63:4b14:: with SMTP id y20mr1366619pga.15.1553798309455;
        Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id g67sm39468578pfg.94.2019.03.28.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:38:23 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Message-ID: <20190328113823.3c9b3599@shemminger-XPS-13-9360>
In-Reply-To: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 17:48:45 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> +				    struct net_device *ndev)
> +{
> +	nvscdev->tx_disable = false;
> +	mb(); /* ensure queue wake up mechanism is on */
> +
> +	netif_tx_wake_all_queues(ndev);
> +}

You don't need a full mb(). virt_wmb() should be sufficient.

Could I suggest an alternative approach.
You don't need to introduce a local tx_disable flag, the only place where a wakeup
could cause problems is after a send_completion was processed during detach state.

Instead, just avoid wakeup in that place.

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -720,6 +720,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
                struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
 
                if (netif_tx_queue_stopped(txq) &&
+                   netif_device_present(ndev) &&
                    (hv_get_avail_to_write_percent(&channel->outbound) >
                     RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
                        netif_tx_wake_queue(txq);
