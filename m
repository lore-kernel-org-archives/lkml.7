Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBBEC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF602206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ABd2KxBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfLOTlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:41:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLOTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:41:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so2399888pga.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Lji5rc5oRoeIVgFMKgJ1S6HCLAhlBppwFI0mo3XGwLs=;
        b=ABd2KxBCvCtitidd4X4lyO6QmLU1Kn3vuhoxh34gkyCub4ef0LpMK0y9bF6EjUThTr
         lSFSktVMOlEGp+3Xv+04QrPZrToUoHTATF3iPyji9FtfF/oIHSa5sBmNv2eVYyw80p3o
         usnhp7w9qrDytJVz/d+DGB74auilmBYm9Q3HFxDWyu/WDHvMeJm4tzRFGtS5RcJuijQp
         ELg8hRXW0Xu/5dPhVik09K81H+uoPi7120FYTPFckBcv7fdV79BDiLRxlfjd7jUDriyu
         vdgX71UqETiKAAqUfF+jhjYxe65wsWMfDOXE37lum2s2xVktdVZjdWjx7sII6CEw4fE1
         CDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Lji5rc5oRoeIVgFMKgJ1S6HCLAhlBppwFI0mo3XGwLs=;
        b=Et2+iowfNCKIgp3yGpUgZcmc3Xp3HaBgqVydfJK0ngCFZD2RysrTbJvXVGbDV7I2zj
         AOZxQkfmQvzOzMLEhK1eNwrGARR2uPXUDTRS0MhILhD2Tib9Ou5qw9ZuuXjKiU/AyyEd
         tzl+gttjr7e7MGwTts10KctAZe+PnWDauBhqZXavxxNGE8PmVibP88BsPSjj9OoRhy2b
         Mi1ns6OCWBBsGmg23Nw5of7QbdJKPfTJFN3CISTREHAr+MIIhTk72/SAQNEXH2Zco3E7
         u5/4sgjXrPiVM7sdrimXXqlKz4HzX2RCXuhIRgN4ONjlT9GmR+OGfkQrKDNBKEdzc7rQ
         MQhA==
X-Gm-Message-State: APjAAAWYvev7lmcBjDiO4QVkKVozoKEZG4WWEPYOEJaOxnQfpfKSWw4j
        tFw4y5ZZI/5ETLoKtXmpswbHsQ==
X-Google-Smtp-Source: APXvYqwO1kxy24gYDG8jZH6lc+wfwsq1T/YgDVVyLVhgAtpGNCuID54ncQaY4dC2vFzHwxjn0oPlwg==
X-Received: by 2002:a63:cb09:: with SMTP id p9mr10771521pgg.105.1576438903199;
        Sun, 15 Dec 2019 11:41:43 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id j22sm16335515pji.16.2019.12.15.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:41:43 -0800 (PST)
Date:   Sun, 15 Dec 2019 11:41:39 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v2] xen-netback: avoid race that can lead to NULL
 pointer dereference
Message-ID: <20191215114139.34f0d24e@cakuba.netronome.com>
In-Reply-To: <20191213132040.21446-1-pdurrant@amazon.com>
References: <20191213132040.21446-1-pdurrant@amazon.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 13:20:40 +0000, Paul Durrant wrote:
> In function xenvif_disconnect_queue(), the value of queue->rx_irq is
> zeroed *before* queue->task is stopped. Unfortunately that task may call
> notify_remote_via_irq(queue->rx_irq) and calling that function with a
> zero value results in a NULL pointer dereference in evtchn_from_irq().
> 
> This patch simply re-orders things, stopping all tasks before zero-ing the
> irq values, thereby avoiding the possibility of the race.
> 
> Fixes: 2ac061ce97f4 ("xen/netback: cleanup init and deinit code")
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

> v2:
>  - Add 'Fixes' tag and re-work commit comment

I've added Wei's Ack from v1, if the code doesn't change substantially
please keep people's Acks.

Applied, thanks.
