Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71934206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQeJje85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfDDUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:44:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDUo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:44:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so4932213wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdUvK+kr5fGH4KrHsnY6KMtlmI5F7w38coTO7hfcBV0=;
        b=vQeJje85goqZSElGVAvLOso7o21hEI0NokhxzbIuyP4/MTUjRpWMpRWrAW5jNIzPeD
         eltHNH7Y0YLJPbgee078M3R0aFed+2UZ6yVbWHbLWMHlbQOuS3uC/7F+OBu33zjvCBHy
         oNwfirwj8Y4DrUAf/eoUYa+EG4zZBeyxpd4VuPpu3UN+5wAbDVKRbrSHgmYxRA+NRFRC
         pqaLqbawfdzY5L2N1TJVRAte39qCnmmWJaZv4Rb+Kqz/qLNCu5EjD6meQiguxAQ3Qwez
         8TLrYlBWFoU5oOtFLReEkHkmZHLVXJI1FjNJ80R+ldEprVbrqPT8KJt8WH4XxZ0zgFH2
         mwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdUvK+kr5fGH4KrHsnY6KMtlmI5F7w38coTO7hfcBV0=;
        b=WK9Yp0blStFyQ4DUSgR6y5qEytPcyL7Do7ZZP3vCOQfAQWR7FbE5vo4ujqYZVumDmW
         el4ie5Myfcn02nPCVHsrouda9i9if//oseR4mormoxe7a5zuW90qfK3AczY+2ymcLZQx
         q4FpGn/OkdkAQgl5ooDL20aCdQ9HSR8BGSOmv/jjQ41/tWWnK25H+6PZCJd7jn3XRuEv
         8y9rqif2LacoNy7+zrbJ7TL7KahtvcuyrzdLaxj0NYqWrJ1MjO3VXfn+SdmBv9OCvpiE
         O7Ovpfeh2pDwMsa45n+omU/aKt1GVwU8YtUeCRdguRSlh6osgdwqvN9pHa4vEYka2/gt
         hOnQ==
X-Gm-Message-State: APjAAAXL9ovDH2CPz3fl9v73dFvmxHnqV78gDi7AoVgCV0HIH/kTvBgs
        YNPlvUk5DkbJfDb3Wo+BQT0=
X-Google-Smtp-Source: APXvYqxfysW6STNPV5cQbBlGseDo1jGhrJJ6XTFdcNH00Xi4o4so8tShvsvcSE2mFtMB31ceiU9/pA==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr5273616wmc.98.1554410664898;
        Thu, 04 Apr 2019 13:44:24 -0700 (PDT)
Received: from [192.168.1.82] (host86-171-79-21.range86-171.btcentralplus.com. [86.171.79.21])
        by smtp.gmail.com with ESMTPSA id 61sm69077774wre.50.2019.04.04.13.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:44:24 -0700 (PDT)
Subject: Re: fs/adfs - keep or kill it?
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ben Dooks <ben-linux-arm@fluff.org>
References: <20190404103521.pklwk4efp2zccjzc@shell.armlinux.org.uk>
From:   Stuart Swales <stuart.swales.croftnuisk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stuart.swales.croftnuisk@gmail.com; prefer-encrypt=mutual;
 keydata=
 mQENBE+b/Z8BCAC4wh3pWD4s6t+9GYpQd7RAFfH4M26UiIA5tmkOgH5GE0+YLobNGoMKry08
 mswa5uwdVkZkBJYwWKLiuFQvE7qY3dEn3ToRTkWkkETBHVdwQ6TK8Q/Ws6kuViPR/IxDNQXR
 bJQnrFhrrTDaSxa1YYTXyXsVXXEuvWyBEFkbSFJ6jsNKNZ8IFm4h/aqh9PNo7t/TKM0KliXI
 +QaroosuqPsvfKeDAA7G4crkLJ51mya0Qf7phvltyt3QK2uZwmuJil0ISBlu6uto04Rx6Nps
 iNIjeluDEluQiN3EqFFIDI84TJvMiKhk2iDVZvfmAsaGGOiZGtLBifBZR0TEmvYDhzwnABEB
 AAG0MlN0dWFydCBTd2FsZXMgPHN0dWFydC5zd2FsZXMuY3JvZnRudWlza0BnbWFpbC5jb20+
 iQE4BBMBAgAiBQJPm/2fAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCKDdl+nvt1
 6QPjB/90xUHMEjQfkJaelexlRGPOV10llvfWm9NrxCajWuYGoOAh9Ba+TtzNAAOCCc3fzIov
 vSRvmWmOSaE+6BcSy2i3YlbUPEPf/Cv+uqRPlO4pnYg+Em7vnaXSfdgdcY4cfAhRUF2kn4Gp
 ogis9zJHqWudSh32bBlhR0a4ILNf6rcSt0wUzl5E5qKf0iKghShg567S8ffHgrfIccRht/pn
 N9yXqsiiwPPlYeubDbBkJumdFYHMZZkMMWFeI3ItenQkxnr5LrW2g/+AUnkk/1BZ9iyYGI80
 cPp2OhCXO4PDqduqJxARAIXvAYRdyR/txlwx9wq9X/A2+PKNLr6PLSNdEoVRuQENBE+b/Z8B
 CACt2sbqqG/cK16BMrC0dm5thV6h8xapxO4mqPflurVQGhfDXYvl50Td5DreZ4y+8YExPlji
 hUPnfV4qxyHy/Kflqi9kTjbPpkzLqvzV7hNLNzqAXioEOqInUyspfYfLUh21X5RX30aIcOwS
 X9pcPpave4u2rxAgPGKxWZtk18sSYYiFxGl3U53ecVbuIsQWKpnD8F5eSjNaGLFCuJGMYHtU
 uRTvah8kFKhR3cxLSyaFA2jn8ELpJy9n4me8Nhio4W1fIa9JNwGZvdFR4Ghb8XK7A4G1XDy1
 hL/c/Ean8cb81U2OVQ5Ws8HHVNkXS+tqLU6DxZypExP2hOH4ArBD7guzABEBAAGJAR8EGAEC
 AAkFAk+b/Z8CGwwACgkQig3Zfp77demfcQf7B4KuaGFxHFupqRu70RDT7ruc5E2BaXMxVvcY
 feCJ02mcm/mZsBLAyeijMz+MGylGsNcMqLEW4QabKt4Gp/waKZMyeMBZnm+zINWUJ/HwBKIU
 JRNCNjMN51W0z7dq6LhCCCMcg1lINGf08He0x3IgiPF0lvVK121jpObLqfqFZOEw590RI0yT
 ZmTVNVDA2PPRL5E5qCQvoSrVA92wbtfvqNi1B0aLvjeVvF3m62gmetV1BGKZ64AFR+bmQmEu
 qp3Q0acb60f8o1BdSOi5QCvG+Nu5HbPis2uTXTUInb2O2LEKp5q00WMlEChn0+Bju9vAm7np
 3543unQvLtxv3kwgjg==
Message-ID: <0b7bcf91-500b-e25a-4a71-f41f3ca8c292@gmail.com>
Date:   Thu, 4 Apr 2019 21:44:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190404103521.pklwk4efp2zccjzc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190404-10, 04/04/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 11:35, Russell King - ARM Linux admin wrote:
> Hi,
> 
> Recently, a couple of issues have been identified in fs/adfs:
> 
> 1. Filename truncation may not work as it should, and Linus has
>    apparently expressed a desire to kill this off.
> 
> 2. Scanning the ADFS map for disc object fragments may mistakenly
>    find free space fragments in addition to real disc object fragments,
>    leading to chunks of free space appearing in files or directories.
> 
> No one has reported any issues with the filesystem module, so the
> question has to be asked whether there are any users of this code?
> 
> I'm aware that there were some users about ten or more years ago.  I've
> only touched it when problems have been reported to me that needed me
> to investigate something, otherwise I haven't used it myself - so the
> code largely just sits there, mostly untouched except for the odd
> cross-filesystem patch.
> 
> The last "feature" patch was in 2011 by Stuart Swales (copied) adding
> the filetype suffix to filenames.
> 
> That leads on to the question about whether this should be fixed in
> mainline or whether we should put the code out of its misery and remove
> it from the kernel.
> 
> Fixing both issues is fairly trivial, and I already have some fixes
> available, along with some improvements to the rest of the code.
> However, I see little point in pushing that upstream if the code is
> not being used.
> 
> Searching the web, there does seem to be some interest on some forums,
> but that dates from about three years ago, but it also seems that more
> functional solutions (using fuse, with different format support) are
> available.
> 
> Posting to Linux lists probably isn't the best way to find out whether
> there are users of this, so if there are people involved in the Acorn
> communities, please pass this on to more appropriate forums, thanks.
> Please ensure that replies reach me as I don't monitor random web
> forums for example (a reply on a web forum that I don't see is not
> helpful.)
> 
> If I hear nothing positive towards keeping it, then I'll schedule
> fs/adfs for deletion, probably for 5.3.
> 
> Thanks.
> 

Thanks Russell

Have posted on the RISC OS Open site. I imagine some people will
complain just because they can. Can't see a need for it in new kernels
myself; people can always use old systems if they need to get data off
old ADFS IDE drives like I had to.

Regards,

Stuart
-- 
Stuart Swales

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

