Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA64C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB802168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njOq4WeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfEWUXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:23:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44636 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbfEWUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:23:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id g18so6624582otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW8ptGotkgtXFOQxEyNpjt0JP8BqcY4khRdBUzxGD9E=;
        b=njOq4WeSNJyHnSOnmQL4N4uTQMpHBzAatUAD+oVavwq6rVacXvEtD5vUhxBlBcF6jf
         +ih8vX49NwzraKpbDoGMeHatPdCEgN6gHPZurpnc4tl2Yznz+2D4D3ttCu8ZoSZfwAjf
         K13T88nBIUqFUe4JmKgngV2cOh3bEigXTXafE3a+FNNIl9M8pphoavj7i0ipuPg6dziF
         NyWQNAqz5ZdkRJEuyJiO2OZBBVWSahiduSIUWAyu49JG6rCxWRkh6VdVhXD+i5U/MEb5
         /IZfP+QFUGnjxajsWA3n2djzSpGmvEZ7TXJSlSdKT/ZsIBSo/KgDZBC8Ypl6qZXS263k
         mcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW8ptGotkgtXFOQxEyNpjt0JP8BqcY4khRdBUzxGD9E=;
        b=aaa5dIiHvOoNkrusZD8pZTClV72zVHm8UUj8tUXppzyGCUkNh1PesE7TF1ccFlFlCg
         /GUj0K59N35nKjrJzLI10M1D5p85tMsbEgpnd+GRuG+cbgfj1JKy+zaIJS+HUiKgpcS4
         9qFLv1atmvj+Xp5UgyTN8S39gD2Y/hMTj/S7RTMMfBSRMsGLLiUGeEcP7oP0VyfdAgSp
         SIzxSeK8A0nN4jzYEjBhSZb0SLHrgrcNogWmk6EeCH7fSZaelSVVg/pqQcaZYmSjAM8C
         jTmvxoSHyMDShuMrI9IHkj7BBrZzq+LqIRRxa9x7RMKRC5qKMvtMnZPJiVJQGcNMAyAP
         fWmA==
X-Gm-Message-State: APjAAAV4vQwi6G5UGnE/5wciRYuJV6QVjAMISdPA63qN6PM8SdUrzCnP
        yC5XFwSbh5YchQggl0t7qBk/gqnCjRoQplmtYnvuwXiD
X-Google-Smtp-Source: APXvYqwY4bYDr21ELI4yNLq57yMgWWRbeW0ntvJPrTjtaZLQ/U4ieoP23hDhanEefvTDKe7MynPZ+3Gh+sCZlqOZ/Sc=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr8582241oto.224.1558643004192;
 Thu, 23 May 2019 13:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190523195313.31008-1-TheSven73@gmail.com> <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
In-Reply-To: <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 23 May 2019 16:23:13 -0400
Message-ID: <CAGngYiUnRSSPLDhXeAg5E0pM_-ZbNV9qpOarSemDdpwLPRZeqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 4:00 PM Joe Perches <joe@perches.com> wrote:
> patch 2/2 specifically covers the anybuss directory,
> but the Documentation directory has no matching pattern.

Thank you for spotting that, I will re-spin the set.

>
> trivia: anybuss looks like a misspelling.
> It might be better as anybus-s.
>

This came up as well during the review process. When we insert a separator,
the include files start looking like anybus-s-controller.h, and the structs
become like struct anybus_s_ops. It then no longer looks like a misspelling,
but becomes harder to read?

An alternative solution is to get rid of the 's' suffix altogether. Anybus-S
is the only flavour we support right now. Although that may obviously
change in the future.
