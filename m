Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D12085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSdZeSA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCNMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:42:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37197 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfCNMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:42:16 -0400
Received: by mail-yw1-f65.google.com with SMTP id w66so4258417ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnqsGPbVGYiomLioUW40e7z+mOF1pXFzyj/t4m1GGgM=;
        b=WSdZeSA7u1y03lamOy133IVEAyD1s6lVk6NxGzg+DDbC74KT1gn2zP2XydatIHFJoi
         cAtgWKnRGztqSiwoapmxaKzq/ehuT0nN1IlXQqhC8J0PaXjTkct0QTAE6z2AqPZ9HOyZ
         mn12tJSbpoyGdeGK6rjKaKInq4CETkXLHg3AMYIPZx/FY/ntRATDuljNEUso5mRBrbsO
         mghhTnH85kFnBxmPeli83kfeelznMEuf8I5998y753oRM8ARRJDs/1pOYB4VvtCGyhEY
         w08kO5BU5kniSwDRLSXPhrzkIP0V8f6+0mnpmHfMx45LTylubpaRHyTmV1DxunXHNYEs
         T/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnqsGPbVGYiomLioUW40e7z+mOF1pXFzyj/t4m1GGgM=;
        b=Q3KKMivpWFDLobSP5cplQ1lQog6qkURK5zmGaMAysjivFKsZLx8m1DMkuypqVlL8lB
         cABfHZWkyOp4ohwKTzfZWZM7fw+MAEWa5IrSdOqkGf36z3AVvp+jfLkP4hBl5cozY6C9
         k3TXMhXQ5RIEaGw0gAnFlmSmE/qXHhAwNjom/aErTQxEy6EKmCwj9joD0UovuZeOX+rn
         xzJ2ke3TOm2eODNZdnBAK4k6h7MU9k8vx2VnjjQE5XivDycBzTzzFUJRH+fmR3ZV5+PC
         7yeMeGvfvM/TlnUjH68gS/V1BIlyU5JGDeQKEgWTyKgfeTBuvJ+gS0PQb0koDqv8+sm8
         gmoA==
X-Gm-Message-State: APjAAAUWJZWJziAaxQAJdAYne03pTV9PKIJQptXyeYY+pBqtl0MT/Xin
        xvUPEiZDYxKANV6TYF8rFLpoSQ4vNScUjtxyKYqYcA==
X-Google-Smtp-Source: APXvYqyp00q9k7i0Gj2A8FhzQSDavmaS9OqG5c7xHkuVo+AgK/+ZA7BN2J+/SJZo/goJtaZ4JWZe1R4mHwI9N3byL1k=
X-Received: by 2002:a81:550f:: with SMTP id j15mr2202894ywb.83.1552567334682;
 Thu, 14 Mar 2019 05:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 14 Mar 2019 05:42:02 -0700
Message-ID: <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:15 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> A trivial patch.


Not so trivial...


>
>
> cpu_to_be32() is capable enough to detect __builtin_constant_p()
> and to use an appropriate compile time ___constant_swahb32()
> function.
>
> So we can use cpu_to_be32() instead of __constant_cpu_to_be32().


I dunno, this is uapi, this might break user space for some funky compiler ?

I do not even know if cpu_to_be32() _is_ uapi.
