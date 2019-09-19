Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23889C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5D320882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lkBxEenY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389560AbfISMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:48:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33336 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfISMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:48:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7114989wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MYdRvcf8Wu6iYU4KZrqesPzUMUB/hNH+Kmue7l+9/nk=;
        b=lkBxEenYPb1crgWNgulRmMTbLuL0WwnuqjTIsDC12hH2kru7EDSQgmhOcjfLsS2Jk3
         ABgD54lhrYPwJ800Z35+fP8QMtRKZXHuqqeXwr2cbCjhBMjtfSlu6AfMDeC1g0phOuKo
         47gyysY/XiECljEYQd9XP864CMiha1mPLGIkeYEnk56uFbDwkMQ6ayn9oS1mH4+dRYdy
         lN3VMU4PgKtpMpOdCooXonokznRv/6vO0xAh38wTDy+EXLyi+OEDKD9yyW8DEYOFbGfA
         nqBY3bwn3D/jeQwGX7fQ4W2tt5Kf9zwXK7Aou6Uv8EIY96Pp6myOfVEzMHnb2EONUSQq
         +tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MYdRvcf8Wu6iYU4KZrqesPzUMUB/hNH+Kmue7l+9/nk=;
        b=oXJEbj09PGFUr/OD+YATKH2zjMOnVix+zYdf+00ya4z1hl2VQLJytNJ9zArk3ZoJRK
         Mt6Uh4SX9nFGoPHHc0HID6TClTLXgo9JsxwCUkfwCublQc0XUX6BGVGOz2NJ+HRCPtXl
         q9tiB6VbhJVICnRpeyQwLpOoMuZerE5KXG4/jDRWW/8pLVy74riOkoqJHjKhtyHIED+8
         6r04WQIQtUzzOj8RwyjMfPt/9OWx+repPMdBaICBkwTXUqr8cPfiNfvggxCig0PFkEim
         pQIv0R1O7DTGjV7scJPKpmsOAc4j7GpOqNElH14HwZDAgMaoGGywV7jUU42KkEqfJwdu
         FybA==
X-Gm-Message-State: APjAAAW0DYpnVtTO+j5nsvAkiQCbeBMmzWRugL23l2vJkC6T2HCFPTA2
        xX598zyADElgyPDrWt918R1LTg==
X-Google-Smtp-Source: APXvYqydehwYm+ahwWpH/f3NBX2IBYskx/Tbnvs3t7TW+OqeIpe325S9YIiHJ4OAPKbXggjNHdT+XQ==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr2864034wme.96.1568897282781;
        Thu, 19 Sep 2019 05:48:02 -0700 (PDT)
Received: from localhost ([109.190.253.11])
        by smtp.gmail.com with ESMTPSA id p85sm12581592wme.23.2019.09.19.05.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:48:02 -0700 (PDT)
Date:   Thu, 19 Sep 2019 05:48:00 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bin Meng <bmeng.cn@gmail.com>
cc:     Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: dts: sifive: Add ethernet0 to the aliases node
In-Reply-To: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1909190547110.12151@viisi.sifive.com>
References: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Bin Meng wrote:

> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Thanks, queued for v5.4-rc with Christoph's Reviewed-by.


- Paul
