Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE8C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D09B2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VVVdSsSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDMIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:14:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34263 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDMIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:14:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so14902669wrq.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7iUcd5GfDnBPGNrzJN0CVYNv1oHlO8JYhgGPK1a+HI=;
        b=VVVdSsSLBrmbeo3thuXRuZG+SvbtF0Cw26oGfuk3jEWjFv1UutcWuoMduzh7ke5fZS
         CFBzyNWzF71y+81Y4CAePqjl4w1N1rw5sW+s7sGwPdU97eYDy0zacpmnrCzOfbWddYBG
         UL0diZBw+cyh5X0s9QqMWMHmgSRK//VFJTNBzOiL3mTOVtuGB8uZ0s7XUcqWRkTznShw
         AWkKY8urkEJ3+Mk/xh9pjxOmTIe6bkOez+xyqvZCnzk2a9GRDuFC1M2mNSQJy4jJoOYl
         Oi1UEdP/91cydFZmKBYwsk47NYUzhGWhSS1DTr1lV/gsAJlP+yaS6lCE5Nu1XcUsSG80
         cTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7iUcd5GfDnBPGNrzJN0CVYNv1oHlO8JYhgGPK1a+HI=;
        b=ZlG+Ga1X+htFs1uMN2TqX+Jf/JKNYDWBBmJIsiTyM+T9txQUtZ51pswJqnPwesCKEK
         5sYUlDOprb8eMH1p2HXUmKDXP/VCpIJ+6DjPmOuNz07Bid6hf+DLQztuWcT6KvNSsxoR
         tyRJ86tvSwzjqpfjcsim1GEs8fMcc/lDo5C6xV5yx5Br/OBV3/+WROqxFxc5oeyYapuR
         vptB3LsvaGNJSjYgIoIpqnIPZRt3W74ZmpjiaWuBSJ5oBg8mu1mBzfOQDrjp3RG1jQDn
         +tH4MrYQLqTKugwq/MlzZapm0wDFVG4vjoR0kSivvLSJYWSfINxquoE++Dkw2zLwfjSH
         MRWQ==
X-Gm-Message-State: APjAAAUTsE3PIUlWHozWc9BX1StjL9NpGNTz5gHrR0qxj4InWtcNzNVt
        H9KZTHIrWzJFAJ4YoCdxXWVItu7hFQzsYGm86eXykQ==
X-Google-Smtp-Source: APXvYqx5ds1pvx+nNW7dS9zI3DITTE0TTvRplQQnnXuaqeB4m0q4usNA+JuYmSOzoNhG04SSNM0Ce2RUwa2pYjLe690=
X-Received: by 2002:adf:e610:: with SMTP id p16mr38501808wrm.64.1555143297772;
 Sat, 13 Apr 2019 01:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190413073906.53676-1-anup.patel@wdc.com> <20190413073906.53676-3-anup.patel@wdc.com>
 <20190413075433.GB30428@infradead.org>
In-Reply-To: <20190413075433.GB30428@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 13 Apr 2019 13:44:46 +0530
Message-ID: <CAAhSdy2icapbjYc-VEaxM7CT_YA5B9p5ut9DMj1mdmTxDX-H7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: Add defines for CSR numbers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 1:24 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I think this should be merged with the next patch.  Also please
> only add the CSRs that we actually use.

Sure, will do.

Regards,
Anup
