Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2F20665
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shkZTmaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLVOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 09:51:15 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50690 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfLVOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 09:51:15 -0500
Received: by mail-wm1-f43.google.com with SMTP id a5so13415846wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 06:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2F8zCN/M8ngdZG7YujfUJxC8wgfVDGf5RsKRHlDmMg=;
        b=shkZTmaBXi4Fp5T38gHGZbTZZpuJ/r1jWTjkcY4iv72TmHvBgwEh+ECAA3zDX9hnta
         fcidzhBL5fdd5/jQRyEulx6QGupGQnb96kkUpY59c0yKYom3O6cBztEh7mBlp8olNxeh
         cKo4AhZ6L5ZsPVE0ov/zIV+c4nQocWAHvSlGUIDQjtF5hICcfzBXxMb2H1SKxhRaRv8M
         43OKIigmgunrRuK+yKjy0px40h+bTxMXZNOZtQ0E3XIuntx8yF7H7kz87Cr2rNUSIOLj
         W7Bw4mke9Av4y5cuNJeODbJUtv28RwEAYpXKUzZa+NbQ5MigsdmuutBXVPCyDJwnFlSk
         HQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2F8zCN/M8ngdZG7YujfUJxC8wgfVDGf5RsKRHlDmMg=;
        b=LUB8oMnpru7K0nNImBbYdYnziWBdUo31+yJaE5enzLrTdUNAACSB/WFX5N21BLj0Ai
         56gvnSScCaxKEveuVKVfc9rbTq3QkKMHCpCf8pN+iLr2qLBgyQNkvHR+0P0fqqJ11lZc
         xSppqLnA4hIuHuOk8NivdK0kUnxktgMArDkAUo0KAw/JsjK3MaPm+x+TB8jq5UUbgmch
         KVHT9zuqZ8hpoUDYP37SeStpEErL/OzT+l216tMb0pBckPnSaFSj+AZdKArv344uF38f
         rAJ5TCdGLab8a//Me5fnJSCVxFEXyJSxsz3DVPLs5dPoXl83V49zZ0lP328Lg7aQCaq6
         TiAg==
X-Gm-Message-State: APjAAAXJ0mzQv0KBRAOw1KNT4TC+n2ysj2WxTujLcR7TRQKP2pSLR0CJ
        cF6bW/fCn+oS1ybRAMcnFf/okK4=
X-Google-Smtp-Source: APXvYqwRMWR6czeUMuXJ+VCTqYVldKYfMwN8pFNCsilWhIfiTfi9BucpZsk6c8tlxNZB2OXelojQAg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr26453301wmi.149.1577026273381;
        Sun, 22 Dec 2019 06:51:13 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id v22sm15883818wml.11.2019.12.22.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 06:51:12 -0800 (PST)
Date:   Sun, 22 Dec 2019 17:51:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 3/3] ELF, coredump: allow process with empty address
 space to coredump
Message-ID: <20191222145110.GA895@avx2>
References: <20191222144421.GC24341@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191222144421.GC24341@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 05:44:21PM +0300, Alexey Dobriyan wrote:
> Unmapping whole address space at once with
> 
> 	munmap(0, (1ULL<<47) - 4096)
> 
> or equivalent will create empty coredump.

>  tools/testing/selftests/exec/Makefile            |    1 
>  tools/testing/selftests/exec/coredump-zero-vma.c |   38 +++++++++++++++++++++++

Oh, disreard this.
Test should fork and wait properly.
