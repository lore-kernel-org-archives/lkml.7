Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD250C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BFB2196E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ogzoHyRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfJIPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:37:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43295 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJIPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:37:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id c4so4002111qtn.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUNfLAleMFPrXh1g9AlL/HXf+KzBa24+32lZoJRogsk=;
        b=ogzoHyRC5FmWYvDlOk/VfsqIVMnJdIMHQkZi/zXpm2QuuJRyB9lxBzeffHMceTQRMX
         UfzjEdp1qAgOLknlFjQ5KV3rbvEWQQpskd1OKVkgWNBbEwCQB5ehcoGizKxWnhQYv1K5
         vGZ8w4IUaTdp8gtHVxGWBhCKLOqLQd1pEwFsX3v9AVAXLBNutTmByESboVfjFRnB/s/v
         7knfMt3lD/qJOUNkxvG32ssoLp4/IHvrSpD7PZK8qT7xOKnndf8vM0HBqJ6FutiVh2Rx
         44tLkWoXYntii9RlqpNE8NfZJ3ZlCAu+KXmJ9ujyJhGC1G8IvYyAJFEBxZ6Ya38xbIWe
         UNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUNfLAleMFPrXh1g9AlL/HXf+KzBa24+32lZoJRogsk=;
        b=ImN1ZCk177g6QkDsDhK3FJ2o0L4ENyEJBUdBfmU7r4e3ZdRctSQcLJUW4/IUZFXrna
         wJvblvxhdgmg66/uNC9xiBtt6SX/BuFdK0SxiUaN1ZaGEDkgdae1Z8VZrivsurdHQ9f3
         Do+ZjBr0yMLcSBCOaMNO17TtjYEf4cvYd+6dNA0h8iuepV/Z33QqnA7/ZtR8FDfzRHPN
         fJpo/JS6gyEm2rn0nHw9etM7oPCLHNqm1783MtFNBvFxcxH+F3mYRKs2m39yg7z2VcbA
         Y+KH8JL90GEcNC4urB4Phel3q2I9hRkhBRphiLJhH/yLtivaSb8md8ZZWnatkOHYOX/K
         nCEQ==
X-Gm-Message-State: APjAAAVVIO70+iVSJdn7Tj+vN73MiggZKTdUti1aDdS66T/a0BtIhrfe
        R1HahCSG7MXScwMmwSED4SzqWA==
X-Google-Smtp-Source: APXvYqwsi5MbX/CB3BTsjjkedSx2droh4RRaoPB2/RkDlLEsT9tOzEGuMtRRXh22Iu3znpUKwufpNg==
X-Received: by 2002:ac8:30c3:: with SMTP id w3mr4412411qta.164.1570635460702;
        Wed, 09 Oct 2019 08:37:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q200sm1063298qke.114.2019.10.09.08.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:37:39 -0700 (PDT)
Message-ID: <1570635458.5937.15.camel@lca.pw>
Subject: Re: [PATCH] mm: include <linux/huge_mm.h> for is_vma_temporary_stack
From:   Qian Cai <cai@lca.pw>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:37:38 -0400
In-Reply-To: <20191009151155.27763-1-ben.dooks@codethink.co.uk>
References: <20191009151155.27763-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 16:11 +0100, Ben Dooks wrote:
> Include <linux/huge_mm.h> for the definition of
> is_vma_temporary_stack to fix the following
> sparse warning:
> 
> mm/rmap.c:1673:6: warning: symbol 'is_vma_temporary_stack' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

It makes sense.

Reviewed-by: Qian Cai <cai@lca.pw>

> ---
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/rmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d9a23bb773bf..0c7b2a9400d4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -61,6 +61,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/migrate.h>
>  #include <linux/hugetlb.h>
> +#include <linux/huge_mm.h>
>  #include <linux/backing-dev.h>
>  #include <linux/page_idle.h>
>  #include <linux/memremap.h>
