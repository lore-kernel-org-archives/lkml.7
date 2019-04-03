Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486CC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822342146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554264731;
	bh=FUSQdHW2cY+HsJK59/OelZv2lPe/9EWjI06yeppzL5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jlsKcAZuaMmNgZF7fKNz1Bdd23ISrgBr3jq1sb0PqP3DoJO2HkxAYwksZNdjH28B+
	 WJdJ3VGO4/H79jSeBAWgJQogUyo1dgDvpIePHWsd4yfEySmITTBIy8dy2g8UJfdNI4
	 a2jhp08aLU4w2BuWiMlBpB7mdOBGoIRrlUCYBDJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCEMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:12:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33192 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCEMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:12:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id v14so10621532lfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WCReQR55pPe/llH/69hyEYnqtFJYkx2Jn+mQLwZfNg=;
        b=KZ25Kb77yMZ7rbbU6nnZ/qy0TswIWE6e44CCtswJgINgeal6zmkhWS1o6c7fzY4GU8
         lOY/J7ZJ+fb0Pyb23YVX979/3z3J+MF67ag0RAFSOvQ0pnyWLZ8JLroALjCOtNmoBOOz
         ji5lgQzCwvc/Jqr63TFw43lQfAVOdKlbQwQr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WCReQR55pPe/llH/69hyEYnqtFJYkx2Jn+mQLwZfNg=;
        b=M5n4rqkmEy/bAcJ0fltuEMMSDxW2prg1iVrZPfssCNQ3cOwazOEHlupXRs1PGoOGdP
         jowsuCyNHRKw5oZuVRVQ/Y8RYyZu2urPShFIpsbvHhxRbG7D2ZmswmrreE4guTN7C+Zv
         it6Ltse8PWlXsyZPawATxsl6aGWMGNyXzFk5/nRqbXL8IuOvmnTcWersumm6MrrSPTJY
         kbpF3Br4lB2YqFbTanvbWctbIvU5UzZ9UIiynArhIhXgF68ZDUsU3qLw0woSYqTR+sfU
         e+W+4m9lkY0NGf66TQb23QHr/ieSL9uP9/FKBVmRk3S5MfifGhYvqZQbrLz2oXXxTZoQ
         Lqfw==
X-Gm-Message-State: APjAAAWOeVGdjlijSU6ruFx0m0VFGCJfQNXrPiLYkEc72Gp3Vfhg1CRi
        HhfHRqFC7N7iWpBN7NllYpPPWliGd+Y=
X-Google-Smtp-Source: APXvYqycKqOcpvar3eiGEeXS3jwIlV2GCO/1qgCYnmEZwqkFOmIsxRod4pT1WubIzKjyJjmInwCQrw==
X-Received: by 2002:ac2:5966:: with SMTP id h6mr25707179lfp.86.1554264726872;
        Tue, 02 Apr 2019 21:12:06 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i24sm3060220ljb.31.2019.04.02.21.12.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 21:12:05 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q66so13525193ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:12:05 -0700 (PDT)
X-Received: by 2002:a2e:8316:: with SMTP id a22mr3792011ljh.171.1554264725160;
 Tue, 02 Apr 2019 21:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.76.1904021315560.20244@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1904021315560.20244@knanqh.ubzr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Apr 2019 18:11:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiQq8UsV0cOTASUmsZyfm8E1BdfZFduxD0TZgOxXqXqqQ@mail.gmail.com>
Message-ID: <CAHk-=wiQq8UsV0cOTASUmsZyfm8E1BdfZFduxD0TZgOxXqXqqQ@mail.gmail.com>
Subject: Re: [PATCH] update my email address
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        nico@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 7:18 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> The @linaro version won't be valid much longer.

Generally I like seeing these come in from the old address just to verify.

But at least the old address is cc'd..

                Linus
