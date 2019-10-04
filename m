Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2502084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NbrR9cDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfJDS0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:26:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42262 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:26:17 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so15539296iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zZ6KISfo14kOEL5Ieq+NQ6dxv0EXjT7PvLg26kcxeKI=;
        b=NbrR9cDXdXXj8NLCbdZebA/XHymI2ZV8JNrZi82vyS6yNX64HDkBmL3dHU2O9pMZXd
         3LLoGfU/NkijXnsJuEROqNWsrS/DXjNbrPh0ZxItTdN7JNiCTJIdvi6yQJWxD7lgKLga
         3cIEYvmCSebCu1xfIcZiWmgbyh3AEYy58zrQyurM5PTA1ZLsgMRD6tp7BY9nKy0RLb3g
         kBLxjv8BEFrmpOqqIkoLo+D/2i3QRiYMtiUQQt1z0baBpLuXXgSGHnr4ZH9wX88BzFiV
         fRME8q8VKZRI8oi8yZ2MvvHHV6itWhxAVqUh5+bqWGjxTx1xeOvNVUKF1eSv2otoL4LS
         G2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zZ6KISfo14kOEL5Ieq+NQ6dxv0EXjT7PvLg26kcxeKI=;
        b=uMurLV5FXwIf5fX3ayz5YFQIbmYuYyFZzzO8XLH6pjCgpfxjqCKpOzftwvPprAtAc8
         L94uFV7DdLY0Zez3VFGoQu4XyBXjqpYaKkRthfetgHdcNBZA1pVeH5ybPRwg6FTXl8zf
         Fl8qUOSiKN+LNdYm1dWPYr78E8LWaaDcOsMQO1al8JL5LvM67fTExYlak8CUpBC0otF4
         mrdqKwdu+quaRKsoC4VgAGeokd8krcK4xh07VZy95qFa3P14IpGw0+48iBEvpZFoYIge
         WDd6WzBqm4yH0wsHja30KCLsHWBdHCyzFvTNYUUctwjzmkfKMIkdVSTFHlxpM0nNSSzf
         /IVw==
X-Gm-Message-State: APjAAAU604LIM7whTmdo+Ge9yHGICsx3AMR7Qegfzax25d+0hZXVtIZN
        OcEx9V1Z8VY+MxLz/ji+4aqLLA==
X-Google-Smtp-Source: APXvYqzlMOzXdKo6exiuWQJn4vxBDEZZE+59ZX+HRMzh5GgIqvHwN308u9wUqqNwO23xAYGepTM41Q==
X-Received: by 2002:a02:93e5:: with SMTP id z92mr16325106jah.8.1570213576916;
        Fri, 04 Oct 2019 11:26:16 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id i18sm3602473ilc.34.2019.10.04.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:26:16 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:26:15 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: avoid kernel hangs when trapped in BUG()
In-Reply-To: <1569199517-5884-2-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910041126030.15827@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-2-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Vincent Chen wrote:

> When the CONFIG_GENERIC_BUG is disabled by disabling CONFIG_BUG, if a
> kernel thread is trapped by BUG(), the whole system will be in the
> loop that infinitely handles the ebreak exception instead of entering the
> die function. To fix this problem, the do_trap_break() will always call
> the die() to deal with the break exception as the type of break is
> BUG_TRAP_TYPE_BUG.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Thanks, queued for v5.4-rc.


- Paul
