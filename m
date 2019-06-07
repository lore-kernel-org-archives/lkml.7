Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB3BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF2D20684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mgDqnIZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfFGPca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:32:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39591 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfFGPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:32:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so2726403qta.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPHq4OxP074Oynm5k40N1pEDJSRTgbxUT/ySAPSAN/g=;
        b=mgDqnIZBA6Gyk3/0NfMutNIfj1G7UuL9197sMB2o2zLU6maboq4TpP6AkBdLmlwPhJ
         20J0LzfYGqZASKtqrboNa9WLrIpQf/uHbUz0DkQ46tWXymwGRAQ0ZMNOFEC6xc5UVCDC
         BPK17IQDb02K2wwmyhdXlmsQ4sXpngtWcr8UZwHLFjO/FH0tICMK86B9c3Z48gFCeJTj
         SOWpKsFFSJnngDw1Je440yV/vA8RwkZHNlhOzcSn7gAA4ZCZjrD1p7whYqppnIMn1bhq
         ZayNNP6pIqAjwMQxZ8KkV9Kb+1JhyNuKUimtV9S53FBMTg4jF1+nJ8SZYRn1SB/JSwf0
         A/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPHq4OxP074Oynm5k40N1pEDJSRTgbxUT/ySAPSAN/g=;
        b=gudmzRJCoozYB5Xz4x/Gw8aXsdj88E9EonQw4PnpdznwCPelnhwi9+/4EH2JcyoM8S
         dO8Lq3ELwXdt7dRbrxd9squv09ZSz6Bl3SDoDO0GeK1h17bC1aG7Kuio4QZG0h+NDm94
         ueKVHcRvNT7VypCDwm2l2bIhddvcBo/y8NHYWNh41EGFayCNea4YFK/EuSz8D76FA4+K
         JuJkjzTObu4eY3L6MeixK6e3pG76EL1X0l6JwntKQ1Lltp+LfY9ZljEXv8ezCrb8g3YD
         /MgvNZB9rhy631HxlGx8OBQoqE/mjJV+E/gEINjvtT5PqgVamIObGB5ZvT1Vhf+8bb9j
         K7YA==
X-Gm-Message-State: APjAAAU9AH+YVCIeuRYMw1qhBMzRO1GGpulW/4sgR9x/5AbaJAfrOpAY
        JaTHlhsmzMVzAY2W7+15dTh2Wg==
X-Google-Smtp-Source: APXvYqwEftljuOnjBWqRLIWBJyHK8pMOwSajpYXoDYal/be+IwViGPGypV7PqpotWIkVRwrSZXx3fw==
X-Received: by 2002:ac8:2cba:: with SMTP id 55mr29893254qtw.260.1559921173712;
        Fri, 07 Jun 2019 08:26:13 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f34sm1359441qta.19.2019.06.07.08.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:26:13 -0700 (PDT)
Message-ID: <1559921171.6132.57.camel@lca.pw>
Subject: Re: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 11:26:11 -0400
In-Reply-To: <20190607152517.GC19862@fuggles.cambridge.arm.com>
References: <1559920965.6132.56.camel@lca.pw>
         <20190607152517.GC19862@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 16:25 +0100, Will Deacon wrote:
> On Fri, Jun 07, 2019 at 11:22:45AM -0400, Qian Cai wrote:
> > The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
> > breaks clang build where it screams that unknown option "-Wno-psabi" and
> > generates errors below,
> 
> So that can be easily fixed with cc-option...
> 
> > [1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-ema
> > il-D
> > ave.Martin@arm.com/
> > 
> > ./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
> > `install_memreserve_table':
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
> > `__efistub___stack_chk_fail
> 
> ... but this looks unrelated. Are you saying you don't see these errors if
> you revert Dave's patch?

Yes.
