Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A986C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B5A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OSfT1aqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCVNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:40:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfCVNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:40:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so2239019wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAXsKLINYQnWHnO2xINsKg8DYXMFqMDw9bmGrw6VwMc=;
        b=OSfT1aqPaD7krmSpzE7vIezLOBPwWlnYeYcQ5JKMCAqsxgjCL3Olb6OIQDqiNYREWm
         Ky3eigtLSy7y9JphOOa7ktvLfuT5GrrDkYYfAAsfffbt8R7eOZSdtyqwZKUb5g7X3/wL
         3TFvb0oPm2OzWWIrqdvYRDwcOgz3UpsFeeDQnvHcc7qJS7J5+6i3QO0ZHHdsOKXN2Uzv
         DZpCMZVQPX+7+5ViuFlc6j75QUBydmMWxDBb7/XK6sesPV8jJNDt/ktGcBT3hCAskNVo
         0+hSY5QmurDUqtcEBfps30LGpS2eCGf4N7DeY6DLTOiFFR/4M3UC8ro8XVNaHRdfKAmw
         nyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAXsKLINYQnWHnO2xINsKg8DYXMFqMDw9bmGrw6VwMc=;
        b=WxelK5lCdEFPCmK3ehNMica6LIG9LWaxtUJhSoGMP1JzdRHnF7OcaAI+yqLHXzrzLD
         eTj9e1j4jTSKlKQBQ37l9uS4z9xtPEKEK0+JK8TP3RP3D5TIlTlXGKWynIWjZYjeqVTJ
         QL9FeRAx/Fkg5tKzoeX3w9ZPpRtvf0arOvkSrGxvudWXJ7x9k3KBMZw6kFqXsvpIsqDc
         ndvJrBPo4rE8vl4Blj9j8rXoJi3XuuW+BngMTyuwcedFS8Br60S1mGObjwoESsXn/TxB
         xeon+RGLfzunAZARuOWae88gQ5zZby+TrT8JjqW2otYxc91xzV9EYwGvXhqwF2QCDIbH
         9F6Q==
X-Gm-Message-State: APjAAAW5HqaXjDEPjgwRf9Vd5duUpDpoNZmqGI16NVouWExIKnwRe2Gb
        ONtLXRitRbGGwmg6zwhITqbIK+LENCZiM1I9DFXDbQ==
X-Google-Smtp-Source: APXvYqxWFySmTB/zNfod71hfyww4/mgf6ZWgGJsJpNqgE6ons1K1YLUmhnhTa++fSTCuxFbPTN3NicaxdgplgSgPHTU=
X-Received: by 2002:a1c:e185:: with SMTP id y127mr3328829wmg.76.1553262034639;
 Fri, 22 Mar 2019 06:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190322100414.32221-1-anup.patel@wdc.com> <20190322132509.GA19263@infradead.org>
In-Reply-To: <20190322132509.GA19263@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 22 Mar 2019 19:10:23 +0530
Message-ID: <CAAhSdy1dtRtkO=hriiG48U2JF4WRPzvg6JB1X64AEVAWM3nNcA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 6:55 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Btw, what is the 32-bit test vehicle of choice?  qemu with the
> virt machine?

Yes, for now QEMU seems to be only the option.

I am not aware of any board we can purchase for RV32.

Regards,
Anup
