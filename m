Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8519C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FCD206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UDqOhAUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHMToy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:44:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45843 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHMToy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:44:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so23843738otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p47PwVKoksn0liVhm7v0oQg8NrkOxD3xJNcrZ+nyPlg=;
        b=UDqOhAUmWsxhoXM3Ktz/M2KjSMsXOPr0TRyb4J+cn/J1ZPkk2nsiybN6VB6dlTy1Qu
         xlPw+1EubYnnOLk1q0TQiQccVFFTn6lbqGXV0y5z2j6CekxQ8BU4zlYO2vJX51Qfiq9B
         D4XH8+udwtohWS2Pb8UtAWfjji2kY4RhbmVXWL63P+zKi8UDf6EZ2JLlZAFoRMPm9Gfo
         YwzXzQjWpBhY6FY59sgL4lr//33Xb10M3fqmob6QGSk5n08L4RC89BYe/9wySsxYE2ft
         BhMYjioMirs0KltnAjrKfXgPZco2vRqzGlrvwj8ZqxdYEqL5dIVVOtg/uiexfIXYaO54
         hQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p47PwVKoksn0liVhm7v0oQg8NrkOxD3xJNcrZ+nyPlg=;
        b=oNIaDpDulkfV178L6LPvjZKgZ7kt0jmu+fbzqN4hbDfym3hAxM9fbp/cKTaca+4COH
         rQhb2Xibd+09pZW0jODiFaSicNdeYYOXlj42qmF9vBLmefvJAEYm6VF8DueD7o9JVrZv
         bt1mIY+85ysrDa863qpaeVcE/hTTwQafc8CR9D2uiq3hDOv/zlSJvHr486PmHUSkSGc8
         Rf5oNGIGNSnCmmCP3BV7X+3CHR96pJwgL8AyeKhL2kVbfpISmDhtSSee4nthFb4xYISr
         g5nxFoA2df5fgIKwbF9VwQ3ORm1etPomMb0ofwunDbbDzGgruotxuKg/jS/oKQGspbCX
         gBrg==
X-Gm-Message-State: APjAAAX7FNbCn2aoRpvXmtlMXqeEhMlHbB3Mz+9hdug0v0wc4LpYDr8Y
        CsvTIeTJfN6AUYUECkOedUoT4Q==
X-Google-Smtp-Source: APXvYqwRLyo8ghmNRoiDA4+UL1VIuVeDBkLpXRbHFQqqPUEL0Ay/P830JUbmn+iLP9nQwqUH74Yabg==
X-Received: by 2002:a6b:fb09:: with SMTP id h9mr22018379iog.15.1565725493314;
        Tue, 13 Aug 2019 12:44:53 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r20sm15192013ioj.32.2019.08.13.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:44:52 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:44:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 02/15] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
In-Reply-To: <20190813154747.24256-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908131244130.5033@viisi.sifive.com>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-3-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Christoph Hellwig wrote:

> Switch to our own constant for the satp register instead of using
> the old name from a legacy version of the privileged spec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Dropping this one in favor of Bin Meng's patch per 

https://lore.kernel.org/linux-riscv/20190807151316.GB16432@infradead.org/


- Paul
