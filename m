Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84089C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584232087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="haQ6q1Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfDPRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36008 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfDPRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:55:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so17759911oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rggm1Kxj05oLW+KL1Dix3OtkMuVAkLzMX1FlGZIH8ZA=;
        b=haQ6q1Ao7eAttMhzROptXuOk6UCHBp9JLawViZNxngHGb80kOGxmW1IxoEoBYKyKNO
         T3EB46aTrzEyWNgQu8u70h3DVUo3HU+qbEtJT7oYTiQ25S7LxDQ5ulOd3eVd+tVrx004
         1RYHxryN4wfRutFTo9bd+68a1AGDfMLEeZCxYlYtCEx9xoTQ7+EcYxHy1ho59/pdXj1P
         pC+Me5o62B9Za8dL1uv89zGHJ6tozpALgcDBo7mgQaZPzKe2n4TVkbn1lin7illoHKgW
         kbU2yYdCqzMq4sgW9yVmYOPNqS+aoSXAlVoBIEBzz+6nnIxfwUecxP6A93VPAb+tcDin
         NGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rggm1Kxj05oLW+KL1Dix3OtkMuVAkLzMX1FlGZIH8ZA=;
        b=ZCg4G9PN1YTOlM2rb5cJj+FjkWrN1m0H4hoFHV/ohQA2WqRY8TKHwRc5CXTzyloqgq
         OUbQTmKQVFYSSAoCxFKtR/oyYJmT/D0INLNpI5AdKwYIgwuhSlVL6za62zc7Z/tnhc1d
         bADpjZzyk2gDq3zk4pKP+bpszteTN3I8cyVhoUkvz0z0I0PCp10EJKS7hJhM1or1g62Q
         vUusRFIj2PrfkFeRLGUuUeMmlrkYKf9xQynb2JNUaHIDNx8Aja/csIQwieCi2glXaJD6
         5sLtR1vjdF+tFnRWNoSatFcaaFb44Xk2ZQ4ZbFal6LmG9z+BjOpamfaOKl9nKOga6n/7
         1DwQ==
X-Gm-Message-State: APjAAAXBT5rPj8KQ+gv0CVNha8X7aOOI28nJqcEW0RMVmNu/mCjvp5Q6
        28QppdxkspCpn02RgXzMvIBiST53ZtBMfmVzGHelIA==
X-Google-Smtp-Source: APXvYqyYFZypH449B/ExTKV2GpUf5HF/8jTIQoEX4L0LNHe2Jk3bL0Ar20kmaYYm5163IdcoJFOJ9qTmlHiWTeEVG2Q=
X-Received: by 2002:aca:cc8c:: with SMTP id c134mr25211836oig.172.1555437326583;
 Tue, 16 Apr 2019 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190415142229.GA14330@linux-8ccs> <20190415181833.101222-1-trong@android.com>
 <20190416152144.GA1419@linux-8ccs>
In-Reply-To: <20190416152144.GA1419@linux-8ccs>
From:   Tri Vo <trong@android.com>
Date:   Tue, 16 Apr 2019 10:55:15 -0700
Message-ID: <CANA+-vDxLy7A7aEDsHS4y7ujwN5atzkGrVwSvDs-U3Oa_5oLFg@mail.gmail.com>
Subject: Re: [PATCH v2] module: add stubs for within_module functions
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>, willy@infradead.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:21 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Tri Vo [15/04/19 11:18 -0700]:
> >Provide stubs for within_module_core(), within_module_init(), and
> >within_module() to prevent build errors when !CONFIG_MODULES.
> >
> >v2:
> >- Generalized commit message, as per Jessica.
> >- Stubs for within_module_core() and within_module_init(), as per Nick.
> >
> >Suggested-by: Matthew Wilcox <willy@infradead.org>
> >Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >Reported-by: kbuild test robot <lkp@intel.com>
> >Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> >Signed-off-by: Tri Vo <trong@android.com>
>
> Applied, thanks!

Thank you!
