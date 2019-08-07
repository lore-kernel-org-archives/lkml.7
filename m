Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A924205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K76IQ8Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfHGBjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:39:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37800 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfHGBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:39:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so78246218wme.2;
        Tue, 06 Aug 2019 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRGHhYFTRmS6ThghCzMlHBCCluvRIS5WKEjM9Zj/Oi0=;
        b=K76IQ8Uckf1ZSmTdM0fjpVm4GXZbhtGAQtHES1wlaPV9imsJRJX1pFQCvDaZAVkOoQ
         sur/mJytGkWLtj+2qFHOulrszTQfnmogSlbeIzROwwa9actS/uIFSM7d7sc5bROU8VKR
         ogmCOQM2dw40A5p0hijAetDrfeZcmeKv4ILKmW69mNyVo8VfqwN25Vl5zGXip/aOUP/Z
         qnRdq9ULFEQ3WtdpTrYCFcWCzi3Fit/e4x0XdPMlTO/dUYHTvB5xouGHiBpTKCtWgMyc
         2A12s4KsfrT67t3zreYh7+kocTyvgYik5EX/ex/wIoidUtYJt94AvVFU9tJlA/Z87gZY
         TmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRGHhYFTRmS6ThghCzMlHBCCluvRIS5WKEjM9Zj/Oi0=;
        b=Zi95dvSSb+NxKLmbcyM7+n60H0lttpMgffOfjpkr0SCkY8XUtum9zIFq1BZoOQQbWW
         gim3NM0/AFAjvXw9hRIiK00ocZc2Puimx2IGE4IeYne8L940hveIyjcvc5XuN2gQNvBS
         tf7leu+epXTkwa3Di9y+3rWjiuIg/xxxGuzjINXIrmXSzJMXfVhJJC+LvTCVq7J9ASns
         NWmZzOp8dinuIXiaBSLWPzT09AP/A2tDQjoSbDVoviwNLFgzEO5sHlVL2jFpTHJFWTHB
         Ivc8tmwz5T1wVvDvZMYqdGb3zROixZJS6RTF69I9lZrSbvUehqo0D72csmkulI4NV/cP
         +0lg==
X-Gm-Message-State: APjAAAXo8tACwYmehLYdTfOK3ZntBUnc+PsayxPenYwFskSumUwPSl2D
        FY9v96Wpp5yhWDGos3zYhMxb8BQpEdiDi92EscOTBAF1TavoaQ==
X-Google-Smtp-Source: APXvYqx0acCsydZ58mqegE8RiOYTsCCQ1bEgdXz6IJYvIOmCYhJ9OaK7eAh/VmI8XcJ4D+a87XOBayZLGwIFu9IHLDw=
X-Received: by 2002:a1c:a985:: with SMTP id s127mr6914821wme.163.1565141981380;
 Tue, 06 Aug 2019 18:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190801220941.19615-1-jsmart2021@gmail.com> <CACVXFVO7vmGJj_N_MT7roZDmWNHbEGR=MsOqkpb7NTptF3=DOw@mail.gmail.com>
 <227b2bc2-9778-6d38-a68b-26a799a0caeb@gmail.com>
In-Reply-To: <227b2bc2-9778-6d38-a68b-26a799a0caeb@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 7 Aug 2019 09:39:29 +0800
Message-ID: <CACVXFVM7sdY_rHZCsi3uTkyOme4rmNERk41754kW-yjNFN4FXQ@mail.gmail.com>
Subject: Re: [PATCH v2] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     James Smart <jsmart2021@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 1:13 AM James Smart <jsmart2021@gmail.com> wrote:
>
> On 8/5/2019 6:09 PM, Ming Lei wrote:
> >
> > I am wondering why you use 2 * num_possible_nodes() as the limit instead of
> > num_possible_nodes(), could you explain it a bit?
>
> The number comes from most systems being dual socket systems, thus a
> numa node count of 2. Some of these dual socket systems can be high cpu
> counts per socket. We did see a difference, on different architectures
> and where cpu counts were high per socket, that more hwqs per socket did
> help. So if there can be more than 1 hwq per socket then I think that is
> goodness.

I guess it isn't related with CPU cores per socket, what matters is number of
sockets, given each CPU core in same socket is in same position wrt. RW
preformance on same shared memory, so looks the following way is what
we need:

 shost->nr_hw_queues = max_t(int,  num_possible_nodes(),
                                          nr_processor_sockets);

However, I don't know how to retrieve 'nr_processor_sockets' in kernel.
Maybe topology_max_packages() can be used for x86, not see how to
read it for other ARCHs.

Cc Thomas and linux-kernel list.

Thanks,
Ming Lei
