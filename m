Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C86621835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXTrpHqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgACLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:24:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:24:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so42137419wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f4uy8lOdcOoVuyd+snt8YgLp9UWra3ptR/kO1GDDjUk=;
        b=LXTrpHqvOGicZo1fP257hKvhT0AG9T1ZNADvlaeJezVFBZun0SQhhzXT3NIY11ARrp
         gZudynJhBW9I9bSizyJU+iPP6TXqyfrQ8Gq8Sh8hl/0Z/9Sr+JZ9hGAeGMNKYfA9SS+h
         X0FYKab1NmNpj9EU7ANeClQkTp/GgT9x86KGDDoFNHM8ESOX4BO0q1wfb/kC7psxs+bo
         WUc7S9/xrGOwbpMye6aK/0nYyxHqkFBy9RBfWKwKRJGY3BOfjE5bzprrU2sIp1PpeSbs
         ey//5LX8BKUCfajVuB773g1XylcJrJ8fshHmO3uL4ocZAlBgkW14C6izyW8t8Hg2Lit+
         kX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4uy8lOdcOoVuyd+snt8YgLp9UWra3ptR/kO1GDDjUk=;
        b=i+y3GtH88zeKsa7FZEoNUu3wfsYOIxaxz0rc0AGvQK3A2y9ylP4NAB8PEM3knGU1Ty
         y+JRZO0RndPmCupprChTvMMFYErAg074yjuA8hKIj6waHKic6K9+v1tqsOh7fgmQaBtM
         Wacf0NkyaSOkcjIbMCf+6/MR1CdAtFxdApFBLtQT5TjSw1x/GGjzmbYWmE3x3CcbFMdj
         5fAwuHrDH3rWna0Bag5/Y7TIJXE/EnfSpctVKbweh8vD8DJAEaSwKIjazmkoGUpQqAHq
         +jHMUG57M+kDtXIS8j9/8zX+X5ExZHf9+tZ0tXoMaA5flu3VN6uLZVP3T8s2hngUcx2I
         G0Ng==
X-Gm-Message-State: APjAAAUfPj9ShBTHtEJqOxcDk73hkHa8e0p63/MXkkVB5KLrVNo5lcrR
        N9VIsS3BTxaaRdD01EL06QYoxw==
X-Google-Smtp-Source: APXvYqyBBcWpunBOcrjZdSkeaZ+vejG6bSZQUILQh6vB8i9EhQ4NHBo9qooLXFHXfsKbyuievTsZTw==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr84776373wro.234.1578050641679;
        Fri, 03 Jan 2020 03:24:01 -0800 (PST)
Received: from apalos.home (athedsl-321073.home.otenet.gr. [85.72.109.207])
        by smtp.gmail.com with ESMTPSA id x11sm62015316wre.68.2020.01.03.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 03:24:01 -0800 (PST)
Date:   Fri, 3 Jan 2020 13:23:58 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     brouer@redhat.com, netdev@vger.kernel.org, lirongqing@baidu.com,
        linyunsheng@huawei.com, saeedm@mellanox.com, mhocko@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v6 PATCH 0/2] page_pool: NUMA node handling fixes
Message-ID: <20200103112358.GA45778@apalos.home>
References: <157746672570.257308.7385062978550192444.stgit@firesoul>
 <20200102.153825.425008126689372806.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102.153825.425008126689372806.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David

On Thu, Jan 02, 2020 at 03:38:25PM -0800, David Miller wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> Date: Fri, 27 Dec 2019 18:13:13 +0100
> 
> > The recently added NUMA changes (merged for v5.5) to page_pool, it both
> > contains a bug in handling NUMA_NO_NODE condition, and added code to
> > the fast-path.
> > 
> > This patchset fixes the bug and moves code out of fast-path. The first
> > patch contains a fix that should be considered for 5.5. The second
> > patch reduce code size and overhead in case CONFIG_NUMA is disabled.
> > 
> > Currently the NUMA_NO_NODE setting bug only affects driver 'ti_cpsw'
> > (drivers/net/ethernet/ti/), but after this patchset, we plan to move
> > other drivers (netsec and mvneta) to use NUMA_NO_NODE setting.
> 
> Series applied to net-next with the "fallthrough" misspelling fixed in
> patch #1.
> 
> Thank you.
I did review the patch and everything seemed fine, i was waiting Saeed to test
it

in any case you can add my reviewed by if it's not too late

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
