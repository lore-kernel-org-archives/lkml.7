Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB053C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271A22CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfICSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:48:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38313 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:48:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so8300382plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pVDfotd4+mwULNcYBfwZPb3QNstzNQ7Yt+TJQtciNHA=;
        b=MQEIeYFTUx+JIO0IAp6Z0e/o6ZuckATJYCqYrYVsPhNWxdwFVbbuYbtWf9ayJijgki
         BNsKl9kC74Q+z8mLmOQ5OxYDgjzWkcy4hyMUvkUtbiC4RRcbOhBMVqm8wd6x/oKlQHjs
         VD2nKSDwoCdq5Qc40TX+fF6svUjNBwmxxieP+3SfgNX+DTb3WJOGwC9nwt1grbg0mSiU
         ukQRnPTTj1AFOTDcymHuPaKeEfFAQxQAsGjVgReW8S2xpY1W1kyxNOA7/rLhl5v++iYJ
         LZvA1uGauNTVa6QDpjlrwkGbQtYgpfIWBtTzIBEskKNI6Urnw7T5GXOwoJ2iSN8FdfNZ
         YuuA==
X-Gm-Message-State: APjAAAWHMJxsb8HXQ/oGLL07TzzEO9QHsSeiTZhmpPErFInSZIUKrPOw
        gQSf8LkUsLOw4JBT084QR84Jk8NsEr8=
X-Google-Smtp-Source: APXvYqwtoRP54sGdEy4OpTdOgUHkbVNMvMEjJcBT5t9TYgg5UIoQdGr9aaZjO0QECWhIJF3SEFni1A==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr4432102pls.94.1567536533041;
        Tue, 03 Sep 2019 11:48:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r187sm11696625pfc.105.2019.09.03.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:48:52 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:48:52 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 11:48:19 PDT (-0700)
Subject:     Re: [PATCH 08/15] riscv: provide native clint access for M-mode
In-Reply-To: <20190828061146.GA21670@lst.de>
CC:     Christoph Hellwig <hch@lst.de>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-e03fb9a6-73ee-437e-aee1-e30427f5d644@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 23:11:46 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Aug 27, 2019 at 04:37:16PM -0700, Palmer Dabbelt wrote:
>> clint0 would be version 0 of the clint, with is the core-local interrupt
>> controller in rocket chip.  It should be "sifive,clint-1.0.0", not
>> "riscv,clint0", as it's a SiFive widget.  Unfortunately there are a lot of
>> legacy device trees floating around, but I'm only considering what's been
>> upstream to be actually part of the spec.
>>
>> In this case the code should match on a "sifive,clint-1.0.0", and the
>> device trees should be fixed up to match.  We match on "riscv,plic0" for
>> legacy systems, and I guess it makes sense to do something similar here.
>
> IFF we decided to change it I'd rather separate DT noes for the ipi
> bank vs timecmp register vs timeval to support variable layouts.  The
> downside is that we can't just boot on unmodified upstream qemu, which
> has used the "riscv,clint0" for years.

Like I alluded to above, matching on "riscv,clint0" seems reasonable to me as 
it's a defacto standard -- we'll just have to make sure that if we ever end up 
with a RISC-V CLINT that the DT entry is something else.

As far as splitting the memory maps goes, I don't have a strong opinion but it 
seems like that'll introduce more complexity than it's worth.
