Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59D6C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9C2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDX1N1Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfGWO6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:58:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45258 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfGWO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:58:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so19273147pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YN0dWoQn0cKjt0et/r7MLvGQvysSwKVg2iDfI3VIAug=;
        b=fDX1N1GjQFD1BWJWAk6igqdluO7njk7OuXzx8ck+v97w9ccMK8X08shux9jgn1Vp7T
         iYuGxNxrLEAlLCeq4rTV67s3pwfM7XEDUFi5OLQ98iGQrLg0xZQszaHnsudPOT/MyR5t
         RVen+W+umhyISvy3F+Qpb4kb/wvXI5yYjeFeOUp2WuDMvopoO6yolE0By2tJFXmDPy2G
         1BFUGPJJnS2QABMmwSVdeQhTmEIOGxN5DWgrB21LufscKC7tXHzaBiZyLtbDpxwdZLOR
         qpY5sD4D7fND4/roICiqD+6tk33oAyO/5k5w6a/R9OJQwuhro5KjQcb3RaWXnb81CT9p
         Z3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YN0dWoQn0cKjt0et/r7MLvGQvysSwKVg2iDfI3VIAug=;
        b=TUCkjCRbf+mvo042eP/ZzF+6R0OuZwh0PxGwpNa5HpYYw7y0ODpUyFR9wwD4sfN5it
         U5WJVlaynfcuA/2CnHOpIKxegMU3jV+m9oK0ZD3uQHlz+Zx54Tln62cLvE0vVcmY8qOz
         dcncCgMkrws57X3zb+cReyv2MA/B1rqqzrnPGRaRXjlGsk8GCQ0dUILkvtQoh+Z2heVA
         9YKbupMjyiPeWVEukuVjqxSQxN3nJV9YS5badtJZfFZm91o+0KQwjjWnqIqzPlz3oNUN
         v4IvGIN+vtbZ9AmlWT8CHabX1DA17j7z6jxu1xza9s4H4WzZ495k+olm99fNojQtv0+v
         foOQ==
X-Gm-Message-State: APjAAAXaJR8sW65Nu4cLGVPqoqiydbgOIOx3njCNJ2l9a0mbhAmOZAQ0
        ZxefNPETY2SzMVuXUhP2R1A=
X-Google-Smtp-Source: APXvYqy+YHV5DSBChNbQ0BuXE9Jiuq2+C+ncXEEOWAG3jHF3oOoJUD2PHmwqZSsWb/jo2PCFjzPmHg==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr78076038pgo.210.1563893888028;
        Tue, 23 Jul 2019 07:58:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm33095984pgw.3.2019.07.23.07.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 07:58:06 -0700 (PDT)
Date:   Tue, 23 Jul 2019 07:58:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723145805.GA5809@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <20190723054841.GA17148@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723054841.GA17148@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:48:41AM +0200, Christoph Hellwig wrote:
> The fix was sent last morning my time:
> 
> https://marc.info/?l=linux-scsi&m=156378725427719&w=2

Here is the updated bisect for the ppc scsi problem.

Guenter

---
# bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
# good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-v5.3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect start 'f65420df914a' '168c79971b4a'
# good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix request object use-after-free in send path causing wrong traces
git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
# bad: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take the DMA max mapping size into account
git bisect bad bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
# good: [0cdc58580b37a160fac4b884266b8b7cb096f539] scsi: sd_zbc: Fix compilation warning
git bisect good 0cdc58580b37a160fac4b884266b8b7cb096f539
# bad: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi: core: add a host / host template field for the virt boundary
git bisect bad 7ad388d8e4c703980b7018b938cdeec58832d78d
# good: [f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc] scsi: core: Fix race on creating sense cache
git bisect good f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc
# first bad commit: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi: core: add a host / host template field for the virt boundary
