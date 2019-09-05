Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC3C3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87D52173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I2t+igV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfIEHzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:55:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41204 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfIEHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:55:30 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so2651472ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C5c7K1Hw4FjCF2xV5vuGtI/cNoltJZ5oqSBi17hs6i0=;
        b=I2t+igV+hg/20Cs7tSHvQRhOdgxcKrBFnKFMkbgfAOGGLKQ5rD53Fyq8x08c4hM38u
         rQujPpaXuKkVSUOHjfVYjTCq8fMWUZMAxXQfjZ3g6Mpk2o38aAJEKPYW0v9nO4B8WITq
         ki+UPop151pYxHkpNWOg3HyrlfnXCyZ/41la7iMsOo3512dJvfjfLGEHw339fTc2xZ9J
         CLssR4wQHnqV4w26NYHbPTFZ2s2NShfg+5RHYHYKXAug6EZtEtTPSMb1JYElI+BptV2J
         wKT9lhhK0YFtImBGIKPryVgP7cdfdGw5hDLJuYGJvbzjKjXN95cjimp4Cndqiv7HYVMa
         O/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C5c7K1Hw4FjCF2xV5vuGtI/cNoltJZ5oqSBi17hs6i0=;
        b=Lu3sYSpY1qRkXIvocPpSVwImZwQS28bEOx02pwVh+PUs7Iicz12zpnlf3Vlad6iCeD
         wL/HvhieouiYSpJ70XCufUEZQ+Om6kU3pxy/mgZKy8DNegf2+53YfwioOWYPriBHHh4Y
         Eb1nNp6BKcRm7ma62sdIgg/nvX3LuQreSgwMe/QGvCoUrzjOzZAN147ihPiSTxdOwpj3
         B4JyOqE6JIwN/bD67gMioJC8Kv/LGI7/Mup0uaa94yVs1fTkLt/R5BEEKbLcyoyXX0NO
         CMIjjvqdhRD0Y4ptnCCMQCpztv4RbIzVjN7dZG9WTkbo5n0hogDYPi9jIERmWVgR5hpD
         ZEwg==
X-Gm-Message-State: APjAAAXBiVaTWo083OMlbK7405Ex+AeA5nx43b2LF0stVYGotOuf2L5o
        1N7M0/WCYwqWxX4Gbhu01YnA9RHMifA=
X-Google-Smtp-Source: APXvYqyFpbub+uXlwt/4a1kSj0KNHkUibFYHOqfSUlNcIlDIps2KWkPgcOc3xfU2wvTsHUeYG7GTrQ==
X-Received: by 2002:a6b:f806:: with SMTP id o6mr271583ioh.213.1567670129077;
        Thu, 05 Sep 2019 00:55:29 -0700 (PDT)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id z20sm1319236iof.38.2019.09.05.00.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:55:28 -0700 (PDT)
Date:   Thu, 5 Sep 2019 00:55:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V7 2/2] riscv: Add support for libdw
In-Reply-To: <e30754638a4eabce6f26ecca9d5292cc7dfa2633.1567653632.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909050054170.27305@viisi.sifive.com>
References: <cover.1567653632.git.han_mao@c-sky.com> <e30754638a4eabce6f26ecca9d5292cc7dfa2633.1567653632.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Mao Han wrote:

> This patch adds support for DWARF register mappings and libdw registers
> initialization, which is used by perf callchain analyzing when
> --call-graph=dwarf is given.
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>

Thanks, queued for v5.4-rc1 with Greentime's Tested-by: (since the changes 
from v6 to v7 had no functional impact).


- Paul
