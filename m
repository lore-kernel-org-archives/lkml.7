Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1AE20692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfIMUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:40:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41748 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfIMUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:40:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so18782738pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qU9A6qb+veDWW9PC+1djL9KV1hH5r1qd0AwYGNHfhBY=;
        b=lDGJzFGX7YqEj91tVEq2hdPAqXtPOluSYkEn1GCOR/9Fo3fbLQs+G1Um+N4Vhd8QJE
         qOmAV+Abg9Ecv+SSACDi9pas3+rU22DM7hv/B2PrSgHvY/P+ZISnl9L+shO5l33+mdJy
         J6EIrkyPHFKY45wW1uT1IvnuVah3lZDUqIJZiC1/aQ0d5NJ1Uqe+Mer9GrV/H9fl/ZQf
         HQmYmHkqAKCljbagZsdKeY3lHEdLgCGgiqtmDxuMTAy/RIxwTOMifCfbfiFCX/fw3snz
         IoD4t400oiXxzOtISwaO/0JZ9Vo3ytyZzEi6+ODAw+mr6tZrOe6s2Sf966/1kORRFzmN
         WQ8A==
X-Gm-Message-State: APjAAAVu5x3DkGTFdHyR8CHO0Aj/nanzHEmDETn3vubGviY0Wo3MDsap
        LtUH/sYuYQpcAPndFmtHOlc8JQ==
X-Google-Smtp-Source: APXvYqwRwn0c+PmiWsgzZC28IXBATIqtHCXXHGwwyRxHek1xZzURFPAkB8G4vkaL2qShC9KYKXBgYA==
X-Received: by 2002:a63:f357:: with SMTP id t23mr45980721pgj.421.1568407227922;
        Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id u65sm33355649pfu.104.2019.09.13.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
Date:   Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 13:39:43 PDT (-0700)
Subject:     Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <20190910143630.GA6794@lst.de>
CC:     schwab@suse.de, Greg KH <gregkh@linuxfoundation.org>,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de, Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 07:36:30 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> That functionality is implemented by param_setup_earlycon and
> early_init_dt_scan_chosen_stdout.  Check why those aren't built into
> your kernel.

OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.  I 
can't find anything about just "earlycon".  I've sent a patch adding sbi to the 
list of earlycon arguments.
