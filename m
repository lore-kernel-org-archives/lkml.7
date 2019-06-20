Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2142075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMD9yr5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFTWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:00:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45926 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfFTWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:00:50 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so862357ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1L8uRv2O5Sf9Nnxuq5fcmvqea9J+FoKGX/eSZPI9YI=;
        b=nMD9yr5qiweWh1Lj7LZj1ylEbvr5Ei8RKKNYbfaQCHbkH8r3fxz8fbn3+I3TC79oT4
         K7ubsATwWtEbYTngqJDoZ7gqd44WiCWyOHJ49UY3o7Y6CFjBnlkppSuZX19Ax30cmibc
         r7KZYTqrIwkBaSK177hShJ/kwf6fzypVpcF0LB5FsrfkPC25ZVp7dKdy/Cc1Gs4pV1WY
         rXobPmwDjq8RhCh89WNhuUeb4GsTsN2On5UtX/xLHzugz3cnLg0MatEJ2DT3+QpeK9AH
         5x+2UAq4KXYjTNSLV/gEkxi6TT9NreFJNO/6k66BmKK8Eeyslb90Dmj8TORHWrG8nKyp
         plRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1L8uRv2O5Sf9Nnxuq5fcmvqea9J+FoKGX/eSZPI9YI=;
        b=p4WShSaIalypp4WRZQNTrQVmx8lKDvLmlrgTwYgx9b+V+97qCIO9dQMmSpDCdapydt
         Yh+AkdD69X0T1jrH7KTWqrdYuJFPJV0gMKnGPoVrSlZrtUAB2HWPg7EAIWcsWnGJz8at
         1+Exw+pOnpoBRfpPCtjcYQKKNZRnyattD3YMbQc8QKmJcMIg8zrr3hA0A1IxP9rNu4/b
         wWIXsRBHE1hvSPcbGr4Jwsv/zHy0d4bAvOBr9+hooLoAMz6gr+JnGQCKcKKTxWwlm7pv
         pvTr2wCAHDMn2mBIBtqF+ivn5zYGkqY72CbcbVRtss5aKq6N3GmYinnuwjB5/RVIwJum
         l6fg==
X-Gm-Message-State: APjAAAUqS4eDfPbWIrs1ZkcCLu7aJtEEd9xWlaHEKcHY6wt623afLZFD
        /s2mq6Zm/ECZuUYyVlY3kTcfmAInKyBc1fXPkcLzJw==
X-Google-Smtp-Source: APXvYqyrvNV0TAI2T6wKLb6CUaIt2peexavbbYTFmWo2/dmMyrc6AdQDx7XOB8ftB7s+gWh0AQgHtNlirFETQ42BIJM=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr13392720ion.104.1561068049041;
 Thu, 20 Jun 2019 15:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545> <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
 <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com> <20190620213722.GA17841@linux.intel.com>
In-Reply-To: <20190620213722.GA17841@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 20 Jun 2019 15:00:37 -0700
Message-ID: <CACdnJusDaGkTAEWJ41+dGQxRWqxbgk8a_iNq5pCuGp=NsdEXgg@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 2:37 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Right! OK, I squashed just the fix to the earlier patch. Master and
> next are updated. Can you take a peek of [1] and see if it looks
> legit given all the fuzz around these changes? Then I'm confident
> enough to do the 5.3 PR.

All looks good to me. Thanks!
