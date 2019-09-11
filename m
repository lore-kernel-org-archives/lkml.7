Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD2C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726DD2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8BDKJ3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfIKRj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:39:56 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45782 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfIKRj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:39:56 -0400
Received: by mail-lj1-f175.google.com with SMTP id q64so10288379ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZ4bkMZvPLT1/Opm4QEPQHR0cQUQ8Cpe6sY/FCCAjMI=;
        b=Q8BDKJ3DdYjGlgXI69cvGQJzrbAPvpSd4xRgsKeI+qMffujhmvMwKSEkU5pWb2aEgK
         qmpUX/grcxYWXnZ4B58oIl8a4ChOPpsZoNYuA9R5C2JfdBxm2nWd8RtERWbCaSbrUgmo
         bVKvz5pnVAXkIDuorb82kF4NMB1gTrEREpva1GiKoQs6qBJUBW0H8X4RYUECdbOzO48v
         ZUJrAXrMAvmhoOnskAZNDzyNVC8ivxJlqmJRtkew+4sUS5Du9js0kN5GKPceiT7dHM80
         /HZxUsCAkI0F278//twmhpCYJjTcFaIgI3pxo+KW63SoDLsblQYNLGPUr0QoziDiu8jd
         goCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZ4bkMZvPLT1/Opm4QEPQHR0cQUQ8Cpe6sY/FCCAjMI=;
        b=V+Vvip7twW4b/6lOn/fXMvbfubjXDq68sOwFIaZ2tp17iO2m0Uu2LIsMS7wcBerItj
         0gr1OhcEKG4RxfOlHbMsm2dkZMWv1oja5i+7uqt+G/J3d6XrwUZU55DZ/Mx8JxkMcLMb
         lF46EDgxkU2rUKDv8eABwnZP+FkZpIgbj9YXaZJl03rNiBIlSZI3w89R8g+LkESahtBl
         b+Mt5KnxPZtwA5zegLEAr3M1SHm17bx6txPKjhz87d9BcvoTWbOt1su9r5a2fiIRXbt4
         StLe7WkeEgY53wibu8q3OdLAQKw782ouzX6IwdvlRjmKULpc3TNz8kgahdhjXj5hcLm5
         XRNg==
X-Gm-Message-State: APjAAAW87KiuTIPkFY6Ny4jRQhqwkTUbFUfU5OU2zRbHEASb8g0pXRBA
        sZC3cjBpa853cHDsWLNaq+Hxnx9WHVbQYuyvGg==
X-Google-Smtp-Source: APXvYqxcEcaGL0kpZ9AoRZdVstIXRl31pitmLJg80TtGS10CvByWqy2SM92NjYkIfrzUKloNxit7KLak9j503SvALSI=
X-Received: by 2002:a2e:9114:: with SMTP id m20mr23592932ljg.103.1568223594710;
 Wed, 11 Sep 2019 10:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
 <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
In-Reply-To: <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 11 Sep 2019 19:39:28 +0200
Message-ID: <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 11. Sept. 2019 um 19:21 Uhr schrieb Sagi Grimberg <sagi@grimberg.me>:
>
> This does not apply on nvme-5.4, can you please respin a patch
> that cleanly applies?

Sure , just tell me from where to pull nvme-5.4 tree.
My match was against current Linus tree.
