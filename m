Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B700C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C46216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMTWIHmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfE1Psv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:48:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44468 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Psv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:48:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so8507185pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=2ksREyYQk7jUAmxjj6kKAaOfKzWITL2u9MpABedwwuE=;
        b=mMTWIHmtpHW/kCfVi7P/cdu0cX26em5nK45r/zhOOcmUvWoS6ny5gdVUjARVj1qqNK
         4+4OFcJ5R228v+wDVhBxn94cnE44EABCId0UFIwIP5SDEzNR6bv9isp3KRyTQTY/A2As
         GpyW8tWMC2sAGjRODK86Fqrn7XUvEVXYfts90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=2ksREyYQk7jUAmxjj6kKAaOfKzWITL2u9MpABedwwuE=;
        b=JjnnTqTudGOhuhbZI+UfDInAl995oNHjszu+yzmoc4Gpk27H0RuVJ3crjHTbcb96BB
         QX+Tw+mbQRV51YhBmM3V3avQ83c9t8mrK0cFwIdDRIOH/8jbxikPeCKhdkKaFL3gNvzj
         1rcnbN6ZJVC0cu7eOrbTU7x3ATiuuW9VQMWXErXGfPcrSgaPyHseKmPkerGG3vwZM/2r
         skVK2B7rusVr7TrKQ+pkLnqFeOwOiYoSqxYPzFEyCbRhJejDu0FBcXCp6OB6fOoCKyss
         4iNwUEtCySOItLrsLzZMXH545U46AIjw4GDIDAhaMD9092s8MnwiCGG4A2n62Mbxus3x
         v1Sw==
X-Gm-Message-State: APjAAAVYzhQG4E1kehcP4m9eY6XmRw9z22zYrafGTsHaIKR16Fp9OGTx
        nqufmuIcLVewQ4DodDmnM/wvpQ==
X-Google-Smtp-Source: APXvYqw9Crknxqe7+aih5W//k5MSZWoQ/ebigbuqf3onineoNwCYYi5TbTQA2Zp87VlgT8TB+Rekmg==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr55060624plb.189.1559058530522;
        Tue, 28 May 2019 08:48:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 206sm14582069pfy.90.2019.05.28.08.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 08:48:49 -0700 (PDT)
Message-ID: <5ced5861.1c69fb81.956d8.5fb2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190527043336.112854-1-hsinyi@chromium.org>
References: <20190527043336.112854-1-hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/3] arm64: map FDT as RW for early_init_dt_scan()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
User-Agent: alot/0.8.1
Date:   Tue, 28 May 2019 08:48:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2019-05-26 21:33:34)
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some codes
> (eg. commit "fdt: add support for rng-seed") that need to modify FDT
> during init. Map FDT to RO after early fixups are done.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

