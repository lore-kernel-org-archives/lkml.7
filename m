Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C63C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335C621743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLvx8Ql7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfGQLnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:43:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42095 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfGQLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:43:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so11030720pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r3Ml7V1jVOjpVicYo+8xmXVJRWMwMaKAxLz7i3aIxcU=;
        b=kLvx8Ql7yjMVtnXgT7lkSlJON5KotFThqQzMHYj4nuHJeYBPzo6EXiQOXgiTxxwMEE
         Oymy9XPr9/7c9loG+9vlkD6kgEnX33ofacYDsHBlUFQuBneI/6zkYyLHCPkd/t6jHJYD
         pU6z8ymfmGYydVRRlhtx3NqTEGVcAUT5J/JvRYpOfBR0Wb0Gt7b1VyS87s7SxWO984nl
         NbOuyqMZkp3i85laXYdgYEJiZ9HkVuEN9Wg5KlVc7fTNBiag1ffkn+GK9/ebcFope2LD
         HLpyEqVzZ/xQfViI/2btIeUgALqDKGOl4fQXCI9/YmYxaFUBL6E8tXK9t5MqhI6W5xhJ
         /+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3Ml7V1jVOjpVicYo+8xmXVJRWMwMaKAxLz7i3aIxcU=;
        b=q0QBlDYRHwSXn6ISENkWhOvPH/wH2tX/ycNsGiPvdCqII8T15mEzhHzGwBGmybgVu7
         8Sep5xT12Ed2VXrFjBPGpso+KsvYTo5xG3B6iuSTKggdG/nwJvNrD0yB9Q9dB4LELcrs
         PdH7uwuzOeFE30uI3dAbSsRt4fBFifyiuuaAXeOmZWUx3VOmIvJvvAqAIM5OiULsJTbp
         /hRBieWnNAx0MxqYXefFufatlqkExAza/h9FQsfyHSRnYU5NWrhB1OOmm49K9DVFMQj9
         Fgx5soo+uxuYEZaO7SlIhOLuolrEw9ZkjbYvHMMoQDBoquraEfwQIcpTma1698W0FY2i
         eUtQ==
X-Gm-Message-State: APjAAAVB/mW4s+eAe8QYaoyrJf3jJ8qmVSOi2viohDtfS5OzAa8KZl/l
        mFWqf3RNhPgpWuypEfaWMfs=
X-Google-Smtp-Source: APXvYqwTOudt5MkKo1EUflsGLzGNhX/iJMR7JxKsdRYwmfSUNdnjQI/NYWp7wefj7l4DNGsZKFqOxA==
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr43530851pja.118.1563363781452;
        Wed, 17 Jul 2019 04:43:01 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id b16sm36927719pfo.54.2019.07.17.04.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:43:00 -0700 (PDT)
Date:   Wed, 17 Jul 2019 20:42:58 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v2 1/3] nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
Message-ID: <20190717114258.GA10495@minwoo-desktop>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717004527.30363-1-benh@kernel.crashing.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-17 10:45:25, Benjamin Herrenschmidt wrote:
> This will make it easier to handle variable queue entry sizes
> later. No functional change.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
