Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD23FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43C824125
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fdu/Dh2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLMXUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:20:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36629 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:20:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so479473lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KMei8lYNXb0UTYHgEyCRfOWiAP70N/PbnvVS+aFEWFM=;
        b=fdu/Dh2m1ylz1omUQxD0S0JP86sdDn6nMCnnvflTW8c1CYwvL7wIkICsyVdGYbkgIg
         /bc3tKQcRpI9VuyCu3Q4s2ZU6MCCN1+RqN1Jbfz1x7RFs/aHWw/OqLB6qONf1e4g7vtx
         KFOiC4xpMCoAVK096G5pFfAukBpGYxx3FyqCatPU3D88nrWgKUduEf6Wocxo0VbNh/Ee
         8TYQ93d1JBJ67u7GS353y9GhrVbXdSPLvEfReOgGU9/uJ9d1RBJlNb9GFr8FMObg6zSZ
         552CuuuL/t3oMgLsHxE09cjHLpZG3LJDocHwYOG8+TEEQBDVqmJhWnWI2/MUOz6Lp/vp
         rWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KMei8lYNXb0UTYHgEyCRfOWiAP70N/PbnvVS+aFEWFM=;
        b=ZwAefOrqHL10Toaw7cLOAjdVqkwH0sViv4FhO1PTuwmfyMKONUNDisT8kVMZ0znx35
         kZ9DqAcxxQOqmFQzsnoIxDAYif87YbWwvG1QPeEBjh2rL0SvWkhvaNzEZ+qwUkVl5HEZ
         RMIzWt/feVfqLUXbTsQ1RqyoYlMxa77BK5gNBzH46c5STpIdcNxEszxbCtYB2pDpTKOi
         YIqbSqdVWlxe/0IXa1oFt4AaWnGyClgSZpo4QhvzXu7AO5MjC6mnsUs8iS7knsEp/qIF
         RvujkkUbLVt3YrIovXseufud95QD5Y/6PUDJLDcQmrqW5tSVoZ32Q29NYwS2gfc2AEq6
         QHOA==
X-Gm-Message-State: APjAAAXBLCd0GgaeVA+osnXqRMKMFdheRwzHWJftTpzbumV0Xg2iMJdM
        Ey/eCijzfvajCpVh/luTwbQJxw==
X-Google-Smtp-Source: APXvYqw6L+MMfJsKX67uPTGekmvZTiWrUu038dbRym8HtKNQf5aLcb7+/do6yCDqOACRzyWVFo0UoA==
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr10181128lfg.117.1576279220067;
        Fri, 13 Dec 2019 15:20:20 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q27sm5626442ljc.65.2019.12.13.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:20:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:20:14 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: add entry for myself
Message-ID: <20191213152014.365c70dc@cakuba.netronome.com>
In-Reply-To: <20191212175908.1727259-1-vivien.didelot@gmail.com>
References: <20191212175908.1727259-1-vivien.didelot@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 12:59:08 -0500, Vivien Didelot wrote:
> I no longer work at Savoir-faire Linux but even though MAINTAINERS is
> up-to-date, some emails are still sent to my old email address.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

Applied to net, thanks!
