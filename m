Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A601C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA21720748
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OEtVeEEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKXXh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:37:26 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:35622 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKXXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:37:25 -0500
Received: by mail-pl1-f175.google.com with SMTP id s10so5595842plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=6we/MzgfhyrkDi1CPOUTtTgeIKvvzsxgig47t8jJM8Y=;
        b=OEtVeEEsQDSTgHMJqp7VqvE8uzd0KsJDG/6U5B9xDGR+tD3BkP+zbNLwz1ZiWmA00Q
         yy4vDEjHrvDB4haPaWtrGoYi2e2c2JY4hbX4tS3m5zNc5les6QcVrWZNGuRs6PoNU1cQ
         1gZnTLtuN7c1lxQPrhM6iBLYPZ/Ka2ZkPmQY1fU7n1vpXsny1fTXFEd8ApPNT+HjGOu4
         jAdWLxV5D+rtihHjDK7irsel13mbrNwxnCF2N00XBgKXfpJPqSPhbWWLmlCxKPVxpBeK
         65sXZHduK21B32XKwpPGhgTLjiZAHHCrllwOzZ2Bp46wTa5IwugxdToCN4W6+kcZ2z4f
         d7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6we/MzgfhyrkDi1CPOUTtTgeIKvvzsxgig47t8jJM8Y=;
        b=NakO+50fQti4nSZBfG4DPwOPoBOnem7XITl21Szpj7MVM4bmr17JKJrcC85bEV25dR
         pJZxkHz+SdNt85h/r4JJodhgYeo5dBA3mjYHKt69qlc5OyiIxn2fQTiAWTV3x9x6I1AO
         lNtwG54GFwf9nYx5AFl76I+nUQ9mqlzxGY8xOiFj8zgB98ovnzDsjGUBsbMVG8ZrxVeI
         pHx/Egryi70+4yut0TwtzaIQYHS2PU7aBfYyP+fXgFaowNIpd6HNL5n40l45NHJBSzyc
         AgL5sIgVlaWv0t49/MYikgC5mJYFy/59lmUdVIM1d5l3qtWa1yKdeqG6F1Aij/whRLMd
         ea3w==
X-Gm-Message-State: APjAAAWuJ8fCPtRjWJ6PiL6GZUYWzwnN7Pn23d3A8GN3WBllMfzavxGf
        37AVAOaCTXDEFEgvQMzvu+uaWA==
X-Google-Smtp-Source: APXvYqwrsOTKn/ZZp7dWj0yzsZ5TxKqoMOSF7LaZ9WDKFYyqpdHlEzTYHdnWDOaTFkZWffSFTohBdw==
X-Received: by 2002:a17:90a:a612:: with SMTP id c18mr35029024pjq.49.1574638643235;
        Sun, 24 Nov 2019 15:37:23 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id e7sm5525228pfi.29.2019.11.24.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 15:37:23 -0800 (PST)
Date:   Sun, 24 Nov 2019 15:37:17 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Julio Faracco <jcfaracco@gmail.com>, netdev@vger.kernel.org,
        Daiane Mendes <dnmendes76@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] drivers: net: virtio_net: Implement a
 dev_watchdog handler
Message-ID: <20191124153717.6edefa85@cakuba.netronome.com>
In-Reply-To: <20191124182426-mutt-send-email-mst@kernel.org>
References: <20191122013636.1041-1-jcfaracco@gmail.com>
        <20191122052506-mutt-send-email-mst@kernel.org>
        <CAENf94KX1XR4_KXz9KLZQ09Ngeaq2qzYY5OE68xJMXMu13SuEg@mail.gmail.com>
        <20191124100157-mutt-send-email-mst@kernel.org>
        <20191124164411-mutt-send-email-mst@kernel.org>
        <20191124150352.5cab3209@cakuba.netronome.com>
        <20191124182426-mutt-send-email-mst@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 18:29:49 -0500, Michael S. Tsirkin wrote:
> netdev: pass the stuck queue to the timeout handler
> 
> This allows incrementing the correct timeout statistic without any mess.
> Down the road, devices can learn to reset just the specific queue.

FWIW

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
