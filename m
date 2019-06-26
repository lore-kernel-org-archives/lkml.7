Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA12133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/6m2AfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFZPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:30:18 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45254 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfFZPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:30:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id j8so1539095ybo.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI9aIzSar/H++pHo3ABCXgtera7zbPDWP79XUKeGSqA=;
        b=A/6m2AfUaM8FQfjzYV679io+ByPmpGSlXSf8l939ZgeZ4V+EEHgPMyR28xn++Wf0dQ
         hEIpEFtpP014wQNNZeQJeIdLa6yb10Y/uQLedsc/IKSWEjPDt3jquHQg6LkpkhrrxDDi
         JavlllZi2a6edul2TGTs3BsRDCdack4eMNSn0Mnhy0QqEjeXPYTq2G3ikRs2qa/1dM8E
         6etoSXroQYjEPAFX6eSgAksfSXOxe6Tq/uTMLLl0cuSg1cMzX71dAdELISV2+t63Whk1
         5imOJXTWVsH3RNIEIJP73rmithlBhIcbcm2DBfsBm1UIhCRCVgoPQ3YvI6VmowgP6+WS
         G1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI9aIzSar/H++pHo3ABCXgtera7zbPDWP79XUKeGSqA=;
        b=eA/Yxcnn3qEmuxEvspnACT27TgxkNgHPaNEsLfkqbdNCeNzASdKsydRd+Dv9lFtNmH
         mjE7f5Rawfzdg+iCIBeepDMiSLzAL3vARaogsE7JOVvPc7BjBTnib7QKZTwOB1nThdz4
         IAwvjkBxXlKRAI8MBkHF213qQAwMFLfj8rHbTR78F3IZruBDhfyNk9WklZU8FZgoKNp/
         PGKoJt4yl2sJv38G8jVczNHZUCQY/f5GKBK25w43d8IzpjpM0gbkJUqNxkkys7ULxrtq
         NQDgL8icwuLlc9Xb7Tk/JwT6j08XXWx14jm8d7DyyDhkoy9do/lwn/JAxciU95AO7mDY
         G7sg==
X-Gm-Message-State: APjAAAWfrdHW3qPnU079Tj6FcClEcRGWhDkMr+p+sl7TrdkOa24v1ejL
        6uuUCwjbXWQVmjtgTg5DCQWuvSRh
X-Google-Smtp-Source: APXvYqwGAPMRrUQg0mR71gpPD43wz7H1tE5V0WKPhZh6XKdbapw8lvDZumBrEMkYdAVT93e3VtuLaA==
X-Received: by 2002:a25:738f:: with SMTP id o137mr3173027ybc.438.1561563015105;
        Wed, 26 Jun 2019 08:30:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v192sm4580635ywv.40.2019.06.26.08.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 08:30:12 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y67so1556289yba.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:30:12 -0700 (PDT)
X-Received: by 2002:a25:aa48:: with SMTP id s66mr2818152ybi.46.1561563012097;
 Wed, 26 Jun 2019 08:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626102322.18821-1-jonathanh@nvidia.com> <20190626104525.GH6362@ulmo>
In-Reply-To: <20190626104525.GH6362@ulmo>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 26 Jun 2019 11:29:36 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfWnen_t9r=BghkzzBwy=b_wazvtjPwg0ALtq30Cv-BGw@mail.gmail.com>
Message-ID: <CA+FuTSfWnen_t9r=BghkzzBwy=b_wazvtjPwg0ALtq30Cv-BGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: stmmac: Fix possible deadlock when disabling EEE support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 6:45 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Jun 26, 2019 at 11:23:21AM +0100, Jon Hunter wrote:
> > When stmmac_eee_init() is called to disable EEE support, then the timer
> > for EEE support is stopped and we return from the function. Prior to
> > stopping the timer, a mutex was acquired but in this case it is never
> > released and so could cause a deadlock. Fix this by releasing the mutex
> > prior to returning from stmmax_eee_init() when stopping the EEE timer.
> >
> > Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Tested-by: Thierry Reding <treding@nvidia.com>

Acked-by: Willem de Bruijn <willemb@google.com>
