Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F65C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DC720818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fzjigQQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGQNev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:34:51 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32006 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfGQNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:34:51 -0400
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6HDYYnl026015
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 22:34:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6HDYYnl026015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563370475;
        bh=DbcjCcTo7q5MXqcF3EQmUtqhOVUs0jtmtfCZktcsvnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fzjigQQlHNjrd5V6cj6G+JEIGBoRT9Y81xb8EMuLxkflI+HEm4LW6bNGgN0O/H82d
         3/8hRVHazfqtnmc+TU7NgpNS7pqK2NoJsvKKQMtpZvZW/VNAIAM00BkaA0hd2Tznno
         7Pp1S+FeuM+Fbui/G4MYShzuAkdUAGpUjRUKivQU4urG9CpcUkgauT06upzu3O+GNO
         rdU3i/vHPYp5PnMfLvxDElccgX1T1Z+NiiJi2by1M9S8fuWKwzUeSTonIN3WVbjeWY
         dyRNQbl/HL0rgiSEj7MuFWV8UVc3GQgATXzfMdezzQwH5PpCWoxezI2p4+zoGfYjiM
         1iM4KRWZwaWYw==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id b69so4961579vkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 06:34:34 -0700 (PDT)
X-Gm-Message-State: APjAAAWgewQ2Yq/jwrsRn8jSNG7tSa/UVmx8G6eEqoMnjfL5GcGSj3Lz
        VMaE6lN0fKiTePq+jVo12xwlhaWgrXRuAlyFnoM=
X-Google-Smtp-Source: APXvYqz5qo12SvTOLtPIj4Hj33lRV1GblCWxuto1QdVi8RX68rNTxn2F6sPwhaaR6whs/dkClwWjloKyqDuY7Md4wWY=
X-Received: by 2002:a1f:ac1:: with SMTP id 184mr15427703vkk.0.1563370473636;
 Wed, 17 Jul 2019 06:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190716055222.7578-1-himanshujha199640@gmail.com>
In-Reply-To: <20190716055222.7578-1-himanshujha199640@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Jul 2019 22:33:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQH9HSiW=K9=jX+PZFy9+x2wh9QOr-jf5h9-fkE6UzorQ@mail.gmail.com>
Message-ID: <CAK7LNAQH9HSiW=K9=jX+PZFy9+x2wh9QOr-jf5h9-fkE6UzorQ@mail.gmail.com>
Subject: Re: [PATCH v2] coccinelle: api: add devm_platform_ioremap_resource script
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 2:52 PM Himanshu Jha
<himanshujha199640@gmail.com> wrote:
>
> Use recently introduced devm_platform_ioremap_resource
> helper which wraps platform_get_resource() and
> devm_ioremap_resource() together. This helps produce much
> cleaner code and remove local `struct resource` declaration.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> ---

Applied to linux-kbuild. Thanks.

-- 
Best Regards
Masahiro Yamada
