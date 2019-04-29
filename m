Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E62C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7166D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TeDqsy9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfD2T3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:29:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39720 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:29:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so5634426pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=z0SbUdCmljVej5WrouVvowNPCwLdyoY/7i4BqzA7D8w=;
        b=TeDqsy9XMhyATE2qQx9WlzpgVVq0T7CVOONq967YT3CvH0mEmtolvjGE9kJgU/cgYU
         775P7gEHPzjxaK64n/BHIPsCEJ8FXrjBqGL2pORt1p1ksc2ycBk/GwyBhFi2ZYhlpMnh
         i4ZBzRRY0nCe7ZzT3UUi1Kv9ORMZDABigBBC0H0FscGeqNWREoXs9UC8ZR+bT0gwdOI2
         x7STEigDlhJOH9LelrVMkVs3Eg+LPIB+J0vR8Kl2xU7xAwiRDUCiqjk0AIbkJTgdL2DK
         ykW0Mu9p/0VL9Rjj28erwH0qI2qERVwEtc6GxwlpWeic9CAO/etUy8h532Td7nbDZ5GV
         FLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=z0SbUdCmljVej5WrouVvowNPCwLdyoY/7i4BqzA7D8w=;
        b=H3tPGwLj0tVpmdANAi+xHQu635ApIdyxHsNB7wUhDSXczOvoa5WnL4kx/v/85ZHZfL
         2r2eQUz6rX2Kztjvuj1ZBvezQ+PdezhmqZrchw3qAosysxvehpczz5lUeOZm/CukpQXx
         HxDXMe55cvM7D3G2TlTgl+vPG4p5jH/9VJ7aislsSa0GycGI5msRD/8JmaBcV9jquFit
         I5+zrJNGPXYimIT0Eg7h6/pk3IOMNe1a5dNBbpc+PcsG6WKi2FoUGxPdkH7Grgd0MPLX
         G3b+u/IOrZG5wboJmgcRchULEu8nTOaOL8PW3a9Hsi1iB9J5CewkjoKBLBkqaNmBpVsg
         wlRQ==
X-Gm-Message-State: APjAAAXjJ69YA4cq7F6GAR+MhTaJCgHy2X/IYWSfKFoVca+el+U7dV0F
        E7NcGArDrmoGoOjLJrdoc3SsRQ==
X-Google-Smtp-Source: APXvYqyJ/3gFDTs4WKhkkP16+/x0+Z8V973+ij74rc3U2GEZqUSyAhQFGBn+SQVCvvPBz9VMRhFvxA==
X-Received: by 2002:a62:864a:: with SMTP id x71mr3258049pfd.228.1556566158309;
        Mon, 29 Apr 2019 12:29:18 -0700 (PDT)
Received: from cakuba ([2607:fb90:cd6:ddfd:e8f2:447f:e2a6:2cf0])
        by smtp.gmail.com with ESMTPSA id 15sm5496317pfy.88.2019.04.29.12.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:29:17 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:29:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Change devlink health locking
 mechanism
Message-ID: <20190429122910.668028b1@cakuba>
In-Reply-To: <1556530905-9908-1-git-send-email-moshe@mellanox.com>
References: <1556530905-9908-1-git-send-email-moshe@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 12:41:45 +0300, Moshe Shemesh wrote:
> The devlink health reporters create/destroy and user commands currently
> use the devlink->lock as a locking mechanism. Different reporters have
> different rules in the driver and are being created/destroyed during
> different stages of driver load/unload/running. So during execution of a
> reporter recover the flow can go through another reporter's destroy and
> create. Such flow leads to deadlock trying to lock a mutex already
> held.
> 
> With the new locking mechanism the different reporters share mutex lock
> only to protect access to shared reporters list.
> Added refcount per reporter, to protect the reporters from destroy while
> being used.
> 
> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
