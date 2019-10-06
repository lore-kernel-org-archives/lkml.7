Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B58C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4D2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4CU5YWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfJFEoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 00:44:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35038 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJFEoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:44:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so14589418qtq.2;
        Sat, 05 Oct 2019 21:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=kB/2w61oZEEDGxbrCbsRG0VuZG0GVdwPCxnFggz0cLA=;
        b=M4CU5YWvaVJ944N26oDgpXQsy2aR1zNuNwSiJtdycs06E1qlNroM8+Qeizdw9sG1cd
         9MkYCVd3d29lrb+w6Ip7E7CaJWw6qspTZy15Lg3gFNHjfPAckLR3mehq5HVjgXsRMkRj
         T0ZVTBL1Q9HhVhE3t11O0nIHoWMEC53CnTX0gCep+Z+u7ciFUW5AavZhCkiYJ3qT6WzG
         PJA8SqBkT9NwxauIXg9xzIyicFVRLTyHIgqaaGbwTQ+khF2dW5mucxqG4bGQIkwHjx7N
         prlw8/yya69BJsP6d6SAqzJ5h+62sScye2BONrjzdwcnWXoXTInPv24tbOVGuHm9NcD3
         t8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=kB/2w61oZEEDGxbrCbsRG0VuZG0GVdwPCxnFggz0cLA=;
        b=emmG2q8OjxazTTls3q/I2+Co98T2hS2FrrPQ2Vpec43dVHskuNOaq9qqTSVoOrgOTe
         4huuzVyJihuDO3Iap/g9RjBtC2nsVwHHOZ+3PKhJnSe/A+D17igh6mJjKxEfi4FIiDvF
         h78lr5bQnbKQD7j+IAnL5hdvaSuRSHdn8e6DbD9rnVqy6sGxuuS0eivOFWKJyBU99eqi
         5AFKngZ/KpvpyRFKc0oxL03reEf4FiUybhwy2ihHO7Sme4oTeoyPTaHjGkTfCtP+zS3M
         jvU5BzPqCzc9Jm+HEhNxiCyWH2ZDQzqQZFvIXxNzC8NVWrWxhQL4+x6ozCyweepBw2kh
         WkjA==
X-Gm-Message-State: APjAAAUWZFsNLg63lx8jrG4YPtUUQlTUbSDiK6Hn4O0zJFuchglHc5yU
        dRQdYVDuK0WFyep+++ftU3E=
X-Google-Smtp-Source: APXvYqyiWBhEDCgSLul9zWwJiBJzk2MCHTxnFgnSxR4sGrmaoMdKyQJD58Gz+hrhZAVkr4kgPmczKA==
X-Received: by 2002:ac8:1099:: with SMTP id a25mr23919221qtj.308.1570337045549;
        Sat, 05 Oct 2019 21:44:05 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id 199sm5890955qkk.112.2019.10.05.21.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 21:44:04 -0700 (PDT)
Date:   Sun, 6 Oct 2019 00:44:03 -0400
Message-ID: <20191006004403.GB709015@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Hubert Feurstein <h.feurstein@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: b53: Do not clear existing mirrored port
 mask
In-Reply-To: <20191005220518.14008-1-f.fainelli@gmail.com>
References: <20191005220518.14008-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Oct 2019 15:05:18 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Clearing the existing bitmask of mirrored ports essentially prevents us
> from capturing more than one port at any given time. This is clearly
> wrong, do not clear the bitmask prior to setting up the new port.
> 
> Reported-by: Hubert Feurstein <h.feurstein@gmail.com>
> Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
