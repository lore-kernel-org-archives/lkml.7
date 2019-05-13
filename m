Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C457AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F6820879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4xxK9Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfEMPCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:02:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44689 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfEMPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:02:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so7343501pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C7voGvIz1Mro50lqBnPKKj2CWBhaokOwzo7P+5YBsm8=;
        b=p4xxK9Mtx+xg5+k+hZu9ZBOfd0Sf1jrR3sIiWSG/lyTOQtD+Q8c/mSfXlpRX2UHFdx
         IWzvaZfGuFsrAnS7jAOduiso+wNQMqNnL1JHU9xHIHWl+r9+i3gq5FNFyD5lAtKkJ84J
         6smJ66yf9FEYk0amnNLRgUH0DNsD1qapxtA3Uw6ONaMrJy3WvxAVUfOK5/Xu4fUsEgqC
         rB0bRzJeq+givqfupC5xMLgzkxhWs21s6FIvoDneGMyLyeDps0M8d6N40uUjanpgwFgo
         Kg6FTMpYwOEraKAnCnTzyh0Odeojfvqg0ytInx9P3zVTC8C5K8fvWWSAKnLyklmL5Hnq
         wuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C7voGvIz1Mro50lqBnPKKj2CWBhaokOwzo7P+5YBsm8=;
        b=ZBvVS9Wb2L1xNeBTAZSVvm7ZS30d2YBOTR6lLiy+q31L8h6PeuFgXpWxfWABQFQ87/
         jRp3mM+ad0xCL6pr6QjMfkqBODeY98+onfc9FeqoGVo6z12T8KQNh4O9MOkZlIgrVR1u
         bju/xWszAruvTFeHu+DuzBRU75bypxLCBktEB+k+aK8MUnk4ARD99UQf+Xew3O8QdHXh
         rpWs+tAj6y7JcAXVc8eXq7ms7bzOYh7Lr9QsHmTxF3cbkL23u9pUZiMkNaN6nhheVNo/
         brN9yGhS37CzzvKj3ZLFj4+aHud8glvlboqlYv+oRhlFcvY1rhjPndgBxZHNTIfZ6S/O
         QXSg==
X-Gm-Message-State: APjAAAXor1HDBQK9nJfTHSgQonQZOTMZd7XUmFaJbRDIGh9BX/B3T9qJ
        Fql+VJ2A56ZZcVOG6xUbQeg7B2ZQg+LWkpVdbfc=
X-Google-Smtp-Source: APXvYqzp9FkkuUjdWmn0w1KnmfDMwzRBLLXx/D3EzBYNrlWhBjehcPBiILMqNMEjQjfhBB4PZXDGZJog/qYs8AhyIs4=
X-Received: by 2002:a63:6988:: with SMTP id e130mr32026855pgc.150.1557759722780;
 Mon, 13 May 2019 08:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com> <20190513140246.GB24840@lst.de>
In-Reply-To: <20190513140246.GB24840@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 14 May 2019 00:01:51 +0900
Message-ID: <CAC5umygobKcQ4NacG7cGkuqXR1qLUFCRBovWu5n=EOs=mu=esg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=8813=E6=97=A5(=E6=9C=88) 23:03 Christoph Hellwig <hch@=
lst.de>:
>
> Usage of a scatterlist here is rather bogus as we never use
> it for dma mapping.  Why can't you store the various pages in a
> large bio_vec and then just issue that to the device in one
> get log page command?  (or at least a few if MDTS kicks in?)

OK.  I'll try to use bio_vec and see how it goes.
