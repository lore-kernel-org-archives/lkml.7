Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A332C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7FD229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYd6aqj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGZMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:24:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35651 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfGZMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:24:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so24478561pfn.2;
        Fri, 26 Jul 2019 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+R2zZKTl/YMcL4CXyg3nPB3Iu9dZMVGUmu1TMD4nDu0=;
        b=YYd6aqj3a0e5mvYH3OmfY5esMyuKpfhswOP7Crovzj9fpaYWFXW64T0QKGL8Lk5OkD
         FCBKcDQXqLSiUMRVu2k7D/xeE7SQiLT1gls840gD0cGOje2k9CV7D6EKHuQm76cmPpPs
         zjtw2tJYVwDZmjSfPpy3vtjNDyzDC6s9ypzmLKk4CZ4xtr5bcTp2eqL9vHiHcjYJAnfR
         +aDwJkP0fs0Jyu5qbvpRxVmRtnO+SqhSZ0Hghm6QvsBwki6u21qBI+pLPlF/ZCu5Y24D
         6Y9kiIg5JCMQXBhK7zzm/bcXrAXnvUMA1RQ2moBdEDdaXptwhZ9j+6mGFb0pGxZSeSLa
         DbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+R2zZKTl/YMcL4CXyg3nPB3Iu9dZMVGUmu1TMD4nDu0=;
        b=P9zHN22qoqOtFaV4GpBC6GUYYR0ppdEyzEXTiA3+EgjfwtMW7JCdmO9b+kvy4YaebB
         ROUqQBWmjMJ+duLqjRDczIHcF9pAhVL6zLRR2t8C1dci6v82Y17IkqJfcWjjL7wKeFwq
         EkNNu/SzFO23I9ABjxFN49Tj/UDVuXa8RLfPltUY23dapxCof9Zg5hrenMZ+9r4MrLAg
         plmkJc8icWL2ITFCbGBQhHqY94flrIWR4Iq/LBiq6UKWfFW3porj8nA6r2PBJKmYRs+e
         tTrQ3xv7Hrz/dJD4ERzjXvHVpKwCDxD7SEZlEt3FEb+HktiJE2+HklLCDa8zk0lbDTPy
         j0kw==
X-Gm-Message-State: APjAAAU9xS2uyNcSMqD9fjAWrhhi4r0/x5ifcKupODtyL6/bsUYZEP5t
        B+eh+j48dE2Qp43V80/2ozY=
X-Google-Smtp-Source: APXvYqxurNTQi7/ISb1RvHwUloq2GBJl3lN6Suz+Bw4M/F/3rUm9r/E2ANKD1v41xzbM5w0uOGwyqQ==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr21580688pfb.210.1564143898266;
        Fri, 26 Jul 2019 05:24:58 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id c26sm55673229pfr.172.2019.07.26.05.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 05:24:57 -0700 (PDT)
Date:   Fri, 26 Jul 2019 17:54:51 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
Message-ID: <20190726122450.GC4348@bharath12345-Inspiron-5559>
References: <20190724191735.096702571@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built and booted on my x86_64 test system. No dmesg regressions.

Thank you
Bharath
