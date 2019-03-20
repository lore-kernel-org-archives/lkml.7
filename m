Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD48BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B67A2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsW/CmrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCTPXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:23:23 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44827 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfCTPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:23:22 -0400
Received: by mail-ed1-f41.google.com with SMTP id x10so2309377edh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaTRsPgD93EBM2P9rUHFzk810YBXTEkzv0DKoFZPbz8=;
        b=SsW/CmrMVMa3DiQxhw1+l59lhpiP7/P/WllOoz2lqNTAjLeRKgEBt8aMiUb88v/8c5
         OiV0QGNVcOlALHX5lFzLTMS24fEH9xu7b0NKIb/McHMrvLkSed6iTswkRnk2YzjGpIyq
         x3lwPGFc++D6X5bh5iDbdB5OQyQV15PySq0d4MSPJdr+qaqm2mg9+IZ4KCafSGVBfCNi
         erEdFbrVoLHf+6f3kR3zPEd1hqs+vnIdj9Gu1DQ/TCvOyims8a5xRvspgr2xODU7Zf/U
         PIRIiUEmFjSWFEMGIwPczaNNmb2h13dC49NoTpi+otCbilF0RVKPXfCkQ79zQTd1l+uN
         RKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaTRsPgD93EBM2P9rUHFzk810YBXTEkzv0DKoFZPbz8=;
        b=OD3j43dRtlx+YSaWKtBmrX9Davemt/rN0OUOTAs+PiWdAit7BKfT9DVik8o6kHhr4W
         Tp4S+oIpu/Xk749duxYP/GUSiB4o+lgPXPunSCq+XS9AZs0pHvl82lP/5g59ueBaCwC+
         5kH3Y8SEJIzS5idMENPZY0JhWYjyvqFFjMMvtgyB4kCSznsF1Eg10glBWUtOSdaH0kS7
         xFKO9ntNEPrr6d3xT8g0v5cB52fjZZYKyyY2cdbJdmY5gH8UQvDexca39FM0J7UDNQbt
         JrBt9Kzap3GkhkZVB/5IH/ba5KzNfn3D+/PZsuQtY9UqTAKeRpvjftdLvepO9LKU4D13
         209g==
X-Gm-Message-State: APjAAAVKa1dXgC6Hc+ChLlSu65kNnZw5rWEubgbNfjhIlLpqcAbPGkqe
        eg5FBnBwpnHc9p8Hgub1LEmLbmIiz1aiREgdAuw=
X-Google-Smtp-Source: APXvYqxxTddD6tQ1i8xAW2FNd0Sw3axQ5BK1ipur7PWlq5PDB9pguv14eSPR4C4my/z+puu4JpA2BqWh+FYexpdsCnU=
X-Received: by 2002:a17:906:828b:: with SMTP id h11mr10999202ejx.1.1553095400849;
 Wed, 20 Mar 2019 08:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190227042454.GA29535@embeddedor> <480940a4-1b7c-564e-2921-37c5b7e0a5b9@embeddedor.com>
In-Reply-To: <480940a4-1b7c-564e-2921-37c5b7e0a5b9@embeddedor.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Wed, 20 Mar 2019 10:23:09 -0500
Message-ID: <CAPp3RGpDZ1oNBOCfizjyrQvp6yGqS89iB_QkjRRqL4FAfZRTXg@mail.gmail.com>
Subject: Re: [sgi-xp] Missing break or false positive?
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry for my delayed response.  I missed the earlier email.

On Wed, Mar 20, 2019 at 9:37 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
...
> > I'm taking a look into the following piece of code in drivers/misc/sgi-xp/xpc_uv.c:
...
> > and I'm trying to figure out if the following warning is due to a missing break
> > at the end of the case, or if this is just a false positive and a /* fall through */
> > annotation should be added:

The fall-through is by design.  The protocol previously had a windows
of failure where a connection
could be in the process of being established and a failure could be
detected prior to the
handling of the establishment message.  I added the new open complete
message and leveraged
the fall-through to mark the connection established.

Please let me know if you do not intend to submit a patch for this.

Thank you,
Robin Holt
