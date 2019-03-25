Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87452087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553537111;
	bh=4FfAId5Jt2m7NC12LyCcQknvv8gBCgPhfsHIiFzc45s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HCHt/oBITCADHmLeKO7k6C2AN3OzAQ1I5MU3Lc1XQRpe9+dqmGEgfMNjU5SKYEb4y
	 VoOp+q7uWqwD6KChvPrqsv1MA760fjR6VWXeoJcveK5eDZNNGjb6h08zgGfwIph1O6
	 mJlKtp5VO8Nh3gYNXet8ubf7inQ/Do4QTC12mO7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfCYSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:05:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44190 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:05:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so4232407ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THNsugLIDEb049X2tCbafcOg3rxUagtZyA8wEVMX6iQ=;
        b=R4JuBkKzvBo0SfqzDBqnwWz87B35YtYD9eefk5hNtnhOkBV6+LSxSr0t8yFefgLJtu
         39EteCpWij5hgZhdF9ekNNs6sxy00mJD1d6yurXXwT2xPl/Bn98S1qsyU11dEYLYBxRx
         UeZjxFCXHOM4AOyurBuCRJwlSh1NkJC8mkd4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THNsugLIDEb049X2tCbafcOg3rxUagtZyA8wEVMX6iQ=;
        b=ENDSUllBZqwNr+qOvfPYRJSSpGbcFR3w3tjj3I2gloHKf3enS6IXuviR5hKLAMD0KI
         U8upeRBGlG7ww6PvMeXuulnV7+AltgaGKGjc4M2kUWoFtBlYuYs5Bbgw/FZqf0aklTfc
         05zPOsVTG0iqPpsfkTbvtily4lYuNZhspdCwsyRIJp1ViGs43B0HDLL4Eo3b5v9yg9Of
         YHYKzgW06AuCfb2I2ZqmYVU1kSNLV9kbAAsQMKM15fX2nWaVmC0QnDNmjJcCvm7Q+Jee
         BjRPK45fpFmchJ7c7ISp9Y0jucxrqYWDkgj7gpBxQ1/3d2D3A/3QKnTTWyKqMdcLmUWp
         hFUw==
X-Gm-Message-State: APjAAAUHJwMkIbBWhxVD3HRuZm+QDCHOC1s2gFqpHbXz2bBRMbRdh06u
        b+DPtkVHROTHzycN6jDzybQaYcPi9tA=
X-Google-Smtp-Source: APXvYqwPIvUJw8z6IDPr6hKSF+aSp/B1BLogphfX/VyMVzwTWCtB3s5dNPL9re1I6Lhn7Fnsy5fwCQ==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4032072ljh.135.1553537107093;
        Mon, 25 Mar 2019 11:05:07 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e18sm3267806ljb.12.2019.03.25.11.05.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:05:06 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id v14so6797414lfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:05:05 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr12971014lfl.148.1553537105688;
 Mon, 25 Mar 2019 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190325113650.56f596f9@gandalf.local.home>
In-Reply-To: <20190325113650.56f596f9@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 11:04:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyLkyu3b6CLkeBBCq+584Bi_ukaGbVsnMtczJQUWJDVA@mail.gmail.com>
Message-ID: <CAHk-=wiyLkyu3b6CLkeBBCq+584Bi_ukaGbVsnMtczJQUWJDVA@mail.gmail.com>
Subject: Re: [REGRESSION] failed to boot: commit 1aec4211204d parport: daisy:
 use new parport device model
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 8:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I bisected it down to this commit:
>
>   aec4211204d ("parport: daisy: use new parport device model")

I was confused, because no such commit exists.

But it turns out you have the right commit ID in your subject line,
and you just dropped the initial '1' .

Anyway, that commit does look odd - why is the daisy_drv_init() done
by parport_bus_init() rather than just as a regular module init? And
as a result, now when daisy_drv_init() blocks, that blocks
parport_bus_init(). I dunno. It seems to not really have a good reason
for it.

I think it should just be reverted unless Sudip can come up with a
trivial fix. Greg?

                   Linus
