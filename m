Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2897C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994FC2238B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="TOwnZ4Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfGWCSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:18:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33033 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGWCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:18:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so36228386qtt.0;
        Mon, 22 Jul 2019 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcC4RShVO4GBc+sW4MyK+3YODcf2RJ2zchY27GABnL8=;
        b=TOwnZ4KgvqrleYyt69kjA8Pa9iW5g09uAt5QjslSfRRn8IKi1esZ7HH1t1kr3eWn62
         HwvE1GIGFI6YVmc+kPriQ5kLlktrExjmXA39je9MWxpYWvJ3WHlYOp/XPt9YQGPAzJDw
         l8DiX0FJaHPr+AY0jKpkagQRf57jvHPnKWM58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcC4RShVO4GBc+sW4MyK+3YODcf2RJ2zchY27GABnL8=;
        b=sEQ8IKOsITG9M/T05azNU+ADDh8volKGrX3Um4AeOYAwBQeeZfEV9B7VXO++MangrY
         eb3KzP4ITzlIlpLqK5wSmlgjmzaoULwrwtd8agoKPmteEHX4aUCoLVMeNKgzfzxGII2j
         oNxOIjg+MFALQqlelgUJeH+WmHZEd9wo0SL8c8GcAHyki7DeYWFe/+xhTQCpEQEn0WqR
         6I8lhVmwnsYCa+Q5SzsGFbTKNx80CKrQnRt72IuaiMcik5qyx8MZ/rgKX/JsMq4YEIZj
         MLUCFLL29w5PkE09SJo0dIrvy6XV36artiojy6l6ATN9t+YtNDkRNh4BM0D3RVirpaVB
         RvnQ==
X-Gm-Message-State: APjAAAUpuw/ZM+WGY5tGObmjNHN6kKQsNuPlSkftErncWZN4nEZTweXX
        WRurB+ykNIaoJOnv3RUsgHc6DMam2vrY6wbrRkM=
X-Google-Smtp-Source: APXvYqyKa4qglKbb1MdjCrqmWrNbSYFG/mfrDWZwOC07dy0d8FYB/4HTZQLyEyfhsZkvbBQEqQWHNxVW+HOmbCsiWG0=
X-Received: by 2002:a0c:afd5:: with SMTP id t21mr52827407qvc.105.1563848321880;
 Mon, 22 Jul 2019 19:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002052.2878847-1-vijaykhemka@fb.com>
In-Reply-To: <20190723002052.2878847-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Jul 2019 02:18:29 +0000
Message-ID: <CACPK8XfGxUpBU4iNG5TwE=3J1aEZAZ=nnVvrT74LQ-F0kqkw2Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add pxe1610 as a trivial device
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Patrick Venture <venture@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jeremy Gebben <jgebben@sweptlaser.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org, Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 00:46, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> The pxe1610 is a voltage regulator from Infineon. It also supports
> other VRs pxe1110 and pxm1310 from Infineon.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Acked-by: Joel Stanley <joel@jms.id.au>
