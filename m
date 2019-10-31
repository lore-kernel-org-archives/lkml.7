Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60FCCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BCF2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSsGQbER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfJaPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:39:17 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38258 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfJaPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:39:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id s6so2270086ywe.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDNNf3dZzdejekmw1xBvnSNBpR6LjmT25tUuR/dKBac=;
        b=XSsGQbERj7XWfLg0CXg722U7VWuezLjYGTs2K7pzt8rO8QzLcMqOZ4f9zW4TWMrInW
         I6WVUc3XDdTWOZAXVBWXRkcnp4jkVdbA7nGkpxYFewMzVI/8Ix9NVTEchD0/HJuphGCU
         pMYYwUVFvs/0BDZxQQkfeAe49F8hMF/WP3PQzjKYypF3e3Sd6y189lrA0T0S5DPmpxKj
         eANRKdXsbAaIo1RjwxTIJdAlGnDsxapxjlCC5gGc9tzy5zjqIM1N37A7YQw3MEYtIIP/
         p2X1Q1Hrr1J4/QqexOAP/1yNnzfUVnVcqf5HE3H+WpaL4pGbHGKxbF4OV/lDWa5sFbfS
         Es7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDNNf3dZzdejekmw1xBvnSNBpR6LjmT25tUuR/dKBac=;
        b=d10enZPgwtxZzvgYEcqjeWs3mXg/kjZcAOyTNImMmAkKKFerf2saFXEmsi0+KQEkxj
         jhRIWu53psCMKtpeGR7FPI1UO1EXAZQxMfrD2Q2pfXXZAhwnHaA/Y5ZNRi4stKMLeTsh
         RF8vwRFc4pAyxCOEEmwJ+gj7TkNRNP4NDxHjN+1MUuRZooEdRP+B9BLl5N9/wXo4OJx/
         few1v7WwsscMZsVH4ULKuqPNb30/LiXqnjtwucbZMQco3w3SgWZ76Lx/BC9/4AKSoeo0
         +PFxFepFfCdNUgLW2dw4vObdlfz7R5/wmiJO4aQv+igNRLvbkNSW6ALwD4Mz0NYBO/6Y
         /KmA==
X-Gm-Message-State: APjAAAXY5CZJy/I/ZLO26xxidggtyeKUuNfg1hqjqdD2o123iAvQbANu
        mswDFxNZvk918MxWHgv3FDhfK5sY1P3QsUrhAJM=
X-Google-Smtp-Source: APXvYqxCMFbl8T6DK0NLkjyTPPHvhHf7jPsbsx4zNSpUUxZgB7EUfreySyi2hBaMYT+u1aNuG57axkj1Xo3MsrU60i8=
X-Received: by 2002:a81:6d56:: with SMTP id i83mr4367544ywc.138.1572536356094;
 Thu, 31 Oct 2019 08:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
 <CANSCoS8rN6g7u6iG4SRTcXjdj68cbimvX1n1Ex+FBAkhAAivJA@mail.gmail.com> <20191031135904.GA5180@lst.de>
In-Reply-To: <20191031135904.GA5180@lst.de>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Thu, 31 Oct 2019 08:39:05 -0700
Message-ID: <CANSCoS_GtDm2=FR8grhWHwm5-Aqvqb=4u+z=auY4e1y5eS3Q2w@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 6:59 AM Christoph Hellwig <hch@lst.de> wrote:
> You might like the idea, but it fundamentally is a bad idea.  For example
> you completely break architectures that do not support unaligned loads
> and stores.

Would you also be against the idea of memcpy the u32 array into a u64 then
passing a pointer to that local variable lower?

- Charlie Scott Machalow
