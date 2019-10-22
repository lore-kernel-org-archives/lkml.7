Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3421783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAxGNxcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfJVHbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:31:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37440 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbfJVHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:31:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so10667296vsr.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GHssV/Yve2NWXUqk9yky9VUTeh7DYWhG9mR5jeyp4s=;
        b=wAxGNxcQLDVJS5VWzQGWIRZT3fniTE9O9s88eLwNFU6svDtKOiImJMBL5MyQBKqvP5
         vYWnonwgYt2zzdXpD+FDhU/FIdqpPDgzYpxVISyYDE1Oxd3QQRp5sstqWhqtixe6Jm9Q
         R0fDHSNLTRe9u2u9t5mg/DwLiNwAX019JalmRZfIe1P0CfVGCjAwi0Icol4ykU9GhUpa
         pMprGRbr88upFgq1a+JURX5DqY0viQ4vAjRfBk5/AXxJQs5uLfGkICWvNYG4hQvh6JBj
         uTaFaNJC6QLHGv6mWKPCucLqiTJWldIObd4u/fWAoih0Thcqw1CEHapgM/68XLlKKAt+
         CgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GHssV/Yve2NWXUqk9yky9VUTeh7DYWhG9mR5jeyp4s=;
        b=HdgmwwsuusQ08tCgUDff5JcwdObd30x5Wvxuplmzu4HIFUeVDkF+tvw9sKPcgsR7tZ
         9zsL8hcjbKRcHe2ZMwIsq9BilZRBM/qBLObPI+GbyjYijVNfDle491U+rDWWkAVFIWlD
         Wad5rhrT9tAbhDaZbs6lWAs33Jnl/1KKukkD38fNjSJNS2WZr+IfEQa9QDjggz+VV6xm
         KIj6ieVGY1ZyLa2d5JWShA77YQ17aIlRId2hLATWp6Ea3xItHVGezZJANGKq7fyVfBrB
         NEVLJ/Z9ZUWJbijLUv3RzJTcpfzbWHK5YMNk1XUnxBnCGADSUHc5terDgZo+k/gm1OwK
         DUKg==
X-Gm-Message-State: APjAAAX7edZx/vMPhofytjK60/8RBywG5ZsfzTqYHHzIingwLAwOOnjH
        qyrQN9fQ43F0mlsGYF2pOc08qJlpk7oKfGIsmb+RFg==
X-Google-Smtp-Source: APXvYqyjktYOMyc+jP5uoVEavfXqn48tybAcMjlwZHZslluIstQu6d6THHRIHpFnK1Fwyb7XC4ggGQSO5eu7A4o0SfM=
X-Received: by 2002:a05:6102:104d:: with SMTP id h13mr1022352vsq.165.1571729508862;
 Tue, 22 Oct 2019 00:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191022114737.0fd6211c@canb.auug.org.au>
In-Reply-To: <20191022114737.0fd6211c@canb.auug.org.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Oct 2019 09:31:12 +0200
Message-ID: <CAPDyKFpUEXzcSN-eEDRNcRWWp8P-yveBirwerhrYh+WMdswnqg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mmc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 at 02:47, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the mmc tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> drivers/mmc/core/block.c: In function '__mmc_blk_ioctl_cmd':
> drivers/mmc/core/block.c:500:6: warning: unused variable 'status' [-Wunused-variable]
>   500 |  u32 status = 0;
>       |      ^~~~~~
>
> Introduced by commit
>
>   05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
>
> --
> Cheers,
> Stephen Rothwell

Thanks for the report. I have amended the patch to address the warning.

Kind regards
Uffe
