Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2B20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5cgxXBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfJDGFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:05:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39694 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbfJDGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:05:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so3595228lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EU9R+5FiiHK6S3OotBSx2d3JfkCttfp0JrSBfeNFZw0=;
        b=E5cgxXBoyb8zX4QHuz2jpJiJdjkmfhiPf/UhRcJhTWcvhFZgsCHhIG7wvWGbfV4Tjp
         tlvfGq1CLfDKjW4LYCSFNua/12JLIHfZmeolGQm4izmsfj4MckCXFe1scuUE+LKqGUFo
         xdoIa5PqJiOVQxSX2gXYPoSyf3vEdYcemX3cVLdX72A4jL+bUtd4HUO6Hw+G+uw5BgJ3
         5OmDbr+ZKnLqQvxHBOU1h7/4eCMI33vmyK2NLwMzTdFGOfj7+CZFNvrpXtSRDOO9Xcet
         /e6ikm3bUq9G2HQ0KIltjbt3c90iRJMOb05eqRPfbhiWQOEr/iSAhWpcIB1WF3rslfvo
         00UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EU9R+5FiiHK6S3OotBSx2d3JfkCttfp0JrSBfeNFZw0=;
        b=BiCM5T16JRrJ3EYEDLOQJRbHiCX19GA024EnxiNdU/hTZ1sAlFW/4jj1aGjddv0RsY
         ucILoek6qfMH7zBIv3ZUyrTtM/jHn6p5ineEkf4EN1cbJlXhbBIL0x8XeFi27rJRVWWU
         zw1tBGrc+l8jiVC6DDuh/Lhx/Zi0IFdCV1+qTco4ZhS2vhgG5eUTiDF8uZhugcell+D2
         wnqyEQ1eqsSsPhzFyKxbwHts9V3sPnACEJXtbf1IuGs2xKN5PvOfD9k4OPPfqAQCppiD
         HsPTlQdQquJ2+YZSszYWOOSBATUCtGCXwA3uD5ByHKxXAAPd1cO8DKrfXAxZD9lNSguo
         1sQg==
X-Gm-Message-State: APjAAAUEo4i2RLDPncYYMe/MK0AP3OkKeik4cnJpBRPWITEFM7ZXZlBd
        Gf5vWUj4VwMOobixFSPRzDe9E2hOkwCY/OjmA/uMgg==
X-Google-Smtp-Source: APXvYqyq2FvAZvTgBm3+gpy5P/cRr2HwVYDfJso9MydHHmgwPIYW710QEgz60hWhE4T18Hf3DjpERdAgdVudsGS9Ufg=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr8069346lfi.0.1570169140928;
 Thu, 03 Oct 2019 23:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org> <20190917181415.GA8472@linux.intel.com>
 <20190917181507.GB8472@linux.intel.com> <CAFA6WYMbUGQ6+-XvR9_qSc=oVe1QSTg4kB-+y6rBmQLq+B6skg@mail.gmail.com>
 <20190925011115.GA3503@linux.intel.com>
In-Reply-To: <20190925011115.GA3503@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 4 Oct 2019 11:35:29 +0530
Message-ID: <CAFA6WYObsZnTptYg1Qorxt0FMaxHKoZ6D53Wjsj05OEGNhpckg@mail.gmail.com>
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Wed, 25 Sep 2019 at 06:41, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 18, 2019 at 11:53:08AM +0530, Sumit Garg wrote:
> > No worries :). I will send next version of patch-set.
> >
> > FYI, I will be travelling for Linaro Connect next week so you could
> > expect some delays in my responses.
>
> These patches will go to v5.5. There is nothing to rush.

I am back now on my regular schedule after Linaro Connect. And I see
your patch-set [1] to detach page allocation from tpm_buf. It seems
like either this patch-set needs rebase over yours or vice-versa.

So should I wait to send next version of this patch-set until your
patch-set arrives in tpmdd master/next branch or would you like to
rebase your patch-set over this?

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2119910.html

-Sumit

>
> /Jarkko
