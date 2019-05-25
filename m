Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D05C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8C217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFXINTg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEYCDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 22:03:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38685 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfEYCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 22:03:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so6319843pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G6O0Sas8lBJuyEn431+Rs5xpmoWk5tFF1phh4Kv0UMU=;
        b=BFXINTg7r3Z8E8euEm7haR4A7qqhJSLm7KQ6iqEcqFBrUDIg0VUgZakI9M+yWwkAfF
         14fMDvv2aLgNsjOXv3mnZWzRCcoeUdLOH8WAUsSvXmXdsJZpYtal5b3mYL3Ovbu+d/FQ
         3QEsq7Dwyh45RO1ALWJnnMJI7Vd/PnUyxAlx/xJ1in/iVoV510apnGOnp9bVtAHou9vZ
         FRJsmHY7uwEZde3GM6tdyebr/clu44UzvWaAqx7pyMwz4Abv/4Q5tWKpVH0o26voapS1
         fxVDAqIvFq8YtdbM2DMTfPnNK3Fbogt3gXkRGw2NEUwoHQOhMGLXMejVEJKJ6+nFd7K0
         tYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G6O0Sas8lBJuyEn431+Rs5xpmoWk5tFF1phh4Kv0UMU=;
        b=JghEwKTYgEoiHDojqEVtohBEDODbJ+dqmxQoRE9Bo4kG0K1gruZ1+ymlbtsxvlacNl
         IVF/T0fBpQ48uK6Y5m5UrDEOr0anNs/GIcvoYPSFejStK7BvPdF5U0k1h3Lu67yyuk3t
         z8Dw1WAfocDFU3wDcIONWyXOePEJTgS5lGnknoNljHzlEEHs2WVSUpNj1ZoU33UJ1xa/
         MAC2p6DYStcGKF1WLvMxbngoURFmeJeMd4mCguzqgY88Y3J6LrhNTpG8yJOHywUKGn2n
         f5FPoCsVwrVkH683fFvNPTWyJeuduI8+6f4R1GIRxcKgHGIG54i4GZaQLwPi48hizVhT
         wjGg==
X-Gm-Message-State: APjAAAWCy+h9etSfSHbTuAvQV28J4klCdBF2xgimwIBNXK5NDNRkRNY/
        NWDwI5juBlrdPtDg3/Dzf/s=
X-Google-Smtp-Source: APXvYqw65nbWnbdgvMIvwULij18wNBNdl9vjwH5luRXLOUXKgLjASuOfq3fOY6XQIzen+15G/zb3mg==
X-Received: by 2002:a63:fc61:: with SMTP id r33mr2251680pgk.294.1558749800415;
        Fri, 24 May 2019 19:03:20 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id b23sm3844777pfi.6.2019.05.24.19.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 19:03:19 -0700 (PDT)
Date:   Sat, 25 May 2019 10:03:05 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     rafael@kernel.org, gregkh@linuxfoundation.org
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org
Subject: [devm_kfree() usage] When should devm_kfree() be used?
Message-ID: <20190525020305.GA10933@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kmalloc() is used to allocate memory for a driver dev. Comments
above the definition and doc 
(https://www.kernel.org/doc/Documentation/driver-model/devres.txt) all
imply that allocated the memory is automatically freed on driver attach,
no matter allocation fail or not. However, I examined the code, and
there are many sites that devm_kfree() is used to free devm_kmalloc().
e.g. hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c.
So I am totally confused about this issue. Can anybody give me some
guidance? When should we use devm_kfree()?

Thanks
Gen
