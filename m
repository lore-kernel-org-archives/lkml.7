Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA001C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70AF20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QoXQysgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfEQRje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:39:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38735 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEQRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:39:33 -0400
Received: by mail-it1-f196.google.com with SMTP id i63so13299859ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sjlzL8sYzuwHRaKiYXlCL9BHKp701p8pybnhyPt408A=;
        b=QoXQysgMhGAQhTO1LjXz8Ww4aJB4vAaO5w19dLg7CJHuNGCNkFQaHGo6RXZq259AwD
         5nPkXc2b7LBEnTtOOrI+WLOp+5W0xiXJ0rP7H1H1dxERDC6982aIH4sObvHmRwdokojd
         KIw8ZLBZHmqTpNMzajYjFTGD+cYXryXtJn1sGNI6pCEICSkG9oP1Ro96TNLaPerwlJuS
         joPFC7DKURMrOVCYXjkJSKemvJ1sUtSL0ISluneoSOehPdly8ykqRrmSR2VyCYjLRn1V
         rgOnrVQtLQb30diSBsABdhkRYVjVlKhomzbH/5Z68i7jnaw6LqMLE1G0aWjZhKe5l1Eh
         G1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sjlzL8sYzuwHRaKiYXlCL9BHKp701p8pybnhyPt408A=;
        b=Cg+8bn3xOE2AhAyvL8fcw0PhS6S6cqThBf/+a4IJFk1CDsDtINvzGWzElVE2FQBYEF
         7lWi1ZMh6gU+o3qal8BDDLt3uzuYE7eJJFTcII2h9Zyfg3p6MCkP2FuUZk/f/YNy52m5
         uhw5ViXePlgzMiKsQjRhVA/u6662nxDmsS3wUVqKG2dJVJE25DlDp1nv4VjhS9zE46uZ
         agP8gOjvtzxBtjnRCd+jRbBJsiTfE7QOeJKM9iFvJUGnmbcaw/hxAAoesvks0tpfRU1R
         0sH64kKOFPbny6AbMAJ7bCE+7fHYp3fG4mfToFkZNDbH51nSofG04qtEwJGHsCbYctER
         Q4EA==
X-Gm-Message-State: APjAAAV4l4H56QJBjVEpSpzLFy3GbVtaZRuBZZfjaKBzPiW1a1nAlpJB
        /zlnObXHcL2CTbeoFcmLIZH9qg==
X-Google-Smtp-Source: APXvYqz3C1G85l/Iijqw79DjIedtJARC46pAFcwSo2FJ+khWMuvvNQiU0ee/YPbw0XfRYFsR2ABxbQ==
X-Received: by 2002:a24:6588:: with SMTP id u130mr3713595itb.138.1558114772807;
        Fri, 17 May 2019 10:39:32 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id d7sm527923itd.32.2019.05.17.10.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 10:39:32 -0700 (PDT)
Date:   Fri, 17 May 2019 10:39:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>, merker@debian.org,
        linux-riscv@lists.infradead.org
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <20190501195607.32553-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1905171017510.9104@viisi.sifive.com>
References: <20190501195607.32553-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 May 2019, Atish Patra wrote:

> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
> 
> Add a PE/COFF compliant image header that boot loaders can parse and
> directly load kernel flat Image. The existing booting methods will continue
> to work as it is.

One other thought: as I think you or someone else may have pointed out, 
this isn't the PE/COFF header itself, but rather an ersatz DOS stub 
header, that is apparently quite close to what some EFI bootloaders 
require.  So from that point of view, it's probably best to just write in 
the patch description that the idea is to add something that resembles an 
MS-DOS stub header, and that the motivations are that:

1. it resembles what ARM64 is doing, and there's not much point in 
inventing another boot header format that's completely different

2. it can be easily converted into an MS-DOS header that some EFI 
bootloaders apparently require, by tweaking a few bytes at the beginning


- Paul
