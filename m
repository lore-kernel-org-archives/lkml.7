Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0002068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="kvW9Z1ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0Msk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:48:40 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:33701 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK0Msk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:48:40 -0500
Received: by mail-qt1-f179.google.com with SMTP id y39so25211421qty.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGwyIKoVSTSDVQc5rcJNfdSD4C5j9jIXNWmLacJmp+s=;
        b=kvW9Z1cila5wlFeElHAI+CETLkXmJ7VqeVmmhGn2iVJPDivEWSRn6vyYDmf3wdvPO6
         jmWKNfeH8zDab2MYkCEuxCD3fJM3ir3uq+enaGlTmNsa2AaX6KHNnF9tqVCDmDqFJMWz
         C08/CtlCupR83nBD1jn8KjFnVK4B9Gwz9wiqDc9TEoF+Es0K2afYeYD74EPnvEc+0RCK
         tX85HhzEK+r240MSMCF+fH+l0yrizmjC7p+vlXZwnXpcCMnGycDzhkATLofgGqh1MSBL
         ufgDndRGl1aKkOyzuoJGs5yb6Ix8fppHJuhcUcTiUaMwH8nFf+6w98Epa7zNFWtYhpOv
         p3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGwyIKoVSTSDVQc5rcJNfdSD4C5j9jIXNWmLacJmp+s=;
        b=T4ZCpwyJ8g8qvHf4h6LamCXBRzeAd/JFOhmqgc+IRyzxBniEDCnQcRVY1eF+VVP6VX
         eU7QbS/u5BLy4YCqv6zIQunnkQB4lr/ZrZDU5puUuuTWkZSe8aygSL1EahEp2UXCwGSU
         p+z5FDHkvgaz8AZ7nrK92yG6rMD5EXN+FHBHQ0xyqlb4M4MLgpvSjd3hRLg4CPV9OBiL
         g1KYcRR/4XOFiR/0fjiMKlPPM6xZfIlkhJNGFsqrui7kX3de/ZhVb1vu40HBHERzrppf
         CslW6x6qWaMud8m45UBWJqwfPMSpS6/CSMN9av80bRWrsORk0SKlaamkb3okvtAExnG2
         juQw==
X-Gm-Message-State: APjAAAUh33VU6/8RhUtn5z0I1L0upB815cKSXqvWvwcFbM4Gex97EoRm
        E6bXcyErTsckK+4rndw/TN9bSnEzDw+HG7l7vSKHlA==
X-Google-Smtp-Source: APXvYqyQW5p1T+6tDo7Vd44ox6ytIZkKwYCSMkVhX3YfVzriqzbA4J3IQbGjaBsQr9PXiQodkruQ2t85s/zfmyyaSJE=
X-Received: by 2002:ac8:66d7:: with SMTP id m23mr30807597qtp.53.1574858919038;
 Wed, 27 Nov 2019 04:48:39 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtgEfa=bq5C8yZeF6P563Gw3Fbs+-h_oy1e4G_1G0jrgw@mail.gmail.com>
 <20191126155632.GF795@breakpoint.cc> <20191127001931.GA3717@debian> <CAG=yYwnm4vRLRpjT2VOj5fynPhBfhvpVjfbSOvPrs-bwv09mTA@mail.gmail.com>
In-Reply-To: <CAG=yYwnm4vRLRpjT2VOj5fynPhBfhvpVjfbSOvPrs-bwv09mTA@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 27 Nov 2019 18:18:03 +0530
Message-ID: <CAG=yYwnx9y3ph74ARdSocca1rqoDVz5vt7WBL=5Qhw1fVEnPNA@mail.gmail.com>
Subject: Re: selftests:netfilter: nft_nat.sh: internal00-0 Error Could not
 open file \"-\" No such file or directory
To:     Florian Westphal <fw@strlen.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>, horms@verge.net.au,
        yanhaishuang@cmss.chinamobile.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> > Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

"i do not know if i deserve Signed-off-by "


-- 
software engineer
rajagiri school of engineering and technology
