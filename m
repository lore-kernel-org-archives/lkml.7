Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0388C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D66E206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZnhjKMzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbfINN6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 09:58:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52588 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbfINN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:58:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id x2so5460763wmj.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xeo1NeXkitHOCMx0+mNiWwWG6fFr/hiP/k5Dg78CY+w=;
        b=ZnhjKMzfJ2eq1eLUMTf3kqITmmadfrXWIUNMx4R15sbG8vdFwhVr+7O110Z/9OuBgj
         G3a7VLVsvmAOAnrPyKEiEP8LVDajZ9F88VQjI51uEmOex0dc6YtD4pzP6wko0pKSSkr8
         q6oqyveZL5bJSDQxSWZzEknTCVVWnQH60baLUIyL0QTX0UA5jvhY+4EiRYEnfMs8rjRs
         XlezleSsdbLjfRGf4NXM/5pg79LOOjKtPxEwt/zdOr0hNodPy34XA0HmVTqBcBGL5RMP
         dLJGF0s/c0p5GgzYsUJYV1TrU4ddrSfaHclBqfo7tMY4H0QGBxa6LYkHcODAHGOWfwyK
         FLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xeo1NeXkitHOCMx0+mNiWwWG6fFr/hiP/k5Dg78CY+w=;
        b=o4ZouPKDTRAsKRXgCGWclI44qWoJ9lvfl52fjeeCA1NJpxdU+kahdInUPmoEyl5sdR
         8yd+r2l4neLRGzFbQe/p4qWtpjxLed+SmwqGBi6BVF6Mm3ZODkyI7h0243W6lBXabmkj
         CHzqAAIYHBONgfpnxUpRxTVIt0EkKAu4+y0ckYwdEAvUjzXFf53iFMMrmKJUw85leATq
         Ac+6g8Xshz5a1OycNrmj1nOA0Ek78cBN9ZCrJhul2GUjcXAKNOUtRyXxwvdyeeLSStWy
         Z22/umZjCwPi4tmFqX5aDahj6SqvE7YTPynzM88h08TTfzqzeyeHfcoz3nkk1O4uEhl3
         q4OA==
X-Gm-Message-State: APjAAAVRx3j7rumhl6kVzW2GuwhK28tBoCzjvxL11Kr7MyuyZQgPIemi
        4rAch0Py9Rs5E9Jg4OuKuH5ILhn0bjs=
X-Google-Smtp-Source: APXvYqynT6tmk0Bp/RtMhx53/YTcUp8rnpQPanFoCs6PDLI+3NKWwpJ+Eey/g5k8pR2ud2lzrT88gQ==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr7930021wmk.161.1568469495784;
        Sat, 14 Sep 2019 06:58:15 -0700 (PDT)
Received: from localhost (193-126-247-196.net.novis.pt. [193.126.247.196])
        by smtp.gmail.com with ESMTPSA id g15sm4626153wmk.17.2019.09.14.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 06:58:15 -0700 (PDT)
Date:   Sat, 14 Sep 2019 06:58:13 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "merker@debian.org" <merker@debian.org>
Subject: Re: [PATCH] riscv: modify the Image header to improve compatibility
 with the ARM64 header
In-Reply-To: <2e697e9c7966cf1a6cac415b6a247a8ba9f4de29.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1909140653070.10284@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1909132005200.24255@viisi.sifive.com> <2e697e9c7966cf1a6cac415b6a247a8ba9f4de29.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2019, Atish Patra wrote:

> Thanks for the quick fix. Is there a planned timeline when we can
> remove the deprecated magic ?

If Linus merges this patch, we should probably start the transition in the 
bootloaders, QEMU, and user tools as quickly as possible.  Probably the 
key element in the timeline is when we remove support for the old 64-bit 
magic number location in the kernel.  I'm told that U-Boot and QEMU have 
already issued releases with support for the v0.1 image header format, so 
dropping the old magic number from the kernel is probably at least a few 
years away.  (This is to increase the likelihood that anyone using the old 
software has had the chance to update them.)

> I was planning to send a U-boot header documentation patch to match
> Linux one anyways. Do you want me that to rebase based on this patch or
> are you planning to send a U-boot patch as well ?

Once v5.3 comes out, please go ahead.


- Paul
