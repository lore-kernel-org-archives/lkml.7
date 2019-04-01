Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7031C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A960920857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="US5Sx95E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDAUBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:01:30 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34421 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDAUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:01:30 -0400
Received: by mail-pg1-f182.google.com with SMTP id v12so5317533pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuN1qU6xl68as+Pe5bYgtZi/E8Qmv9Vsu+iBh6qnSvM=;
        b=US5Sx95EAzn1FQzPgAl909gvu0GwAhNohdp3kdZrT7kOF1KXOlrYJSzabIdZbO6W+B
         XO59V00OSv4hCc9HCsjpfOu8GqLmInZnNndI2BtN4G0TatFfmdij821G/TTmqww0Nr4I
         0y3LK+ugUEAEp6FDoL2xDD9sSOzEFnhROGPw6xlJQbUXC/6YNURVqqJ+M3+mN2qh5GEA
         qf36eZfIHRFNlF98lVWf3jPGSayEaxPIM+cKcPl2bw084kRz07vmgrbjrpg/zTKaZj5u
         8BL+t4ykqCacnhlo6P8n45gu4IsuUAQqc8fWSzHwgJGOfiJMUmqduCWJ0Dz75QCQmVX/
         CYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuN1qU6xl68as+Pe5bYgtZi/E8Qmv9Vsu+iBh6qnSvM=;
        b=rZczqesR1xRzgGD3pgpFCfQR7903giBGEd/ccLAdNkWrJlHrG7kblrn8/owvKAJwDc
         sKmNwdFs1cjcnuAZp3vVEjrse05bgeYrr92JipXv47G6LtWzuAO3dsLWHS6iy62N0bnr
         NRRvWrmWXGzndVmo4NI8VFqOtXMOArQoebdz8/GDuizHU5duoHNCa7RoYKVQbSTgrp3E
         Bm9s1JhZPgXs0amlKPe88Ujt54OzR/3U2bLKfhnb2K5lpoSBNrlZQMpzXfzO1vgWvo20
         refnkWHJt5c6mJmr6fZxF2befXqnGR1D08dkKcVaIAPixwyKmPECdrqWLGUmENXl3hsL
         HWNw==
X-Gm-Message-State: APjAAAXuESzuhde96zQB3+5uZaJAum5/pAtkyFdorcwX8WyyAmrF98kI
        iFinwHfrtOdaH7I1bIiYHsObCSN/1hxPGtIvqERwDQ==
X-Google-Smtp-Source: APXvYqwtDPJAbSeuYqCVuuyItG6YjrX9jti6BDONi/B2GcoRMHZJa2ty/ojL07LM0Qa8TPFga80pxBbzZ7I22WiAH74=
X-Received: by 2002:a63:4542:: with SMTP id u2mr61761148pgk.291.1554148888993;
 Mon, 01 Apr 2019 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=VMJ5vK9aXcZ7AgC7f_dx+5ebKgwz68mV3=m6pOA_syA@mail.gmail.com>
 <20190401194513.e3ck3ze5peyvvfam@breakpoint.cc>
In-Reply-To: <20190401194513.e3ck3ze5peyvvfam@breakpoint.cc>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 2 Apr 2019 01:30:52 +0530
Message-ID: <CAG=yYwmzxYAJvaBiPpj4=H=Ou+y8ZcSTEBoYqK+qyzwJs_7kug@mail.gmail.com>
Subject: Re: about selftests/netfilter test related issue
To:     Florian Westphal <fw@strlen.de>
Cc:     Shuah Khan <shuah@kernel.org>, pablo@netfilter.org,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anyway thanks for the reply. let me look on what you said and learn

On Tue, Apr 2, 2019 at 1:15 AM Florian Westphal <fw@strlen.de> wrote:
>
> Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in> wrote:
> > i think the script nft_nat.sh  is assuming devices eth0 and eth1
>
> No it does not.
> These are arbitrary names given to veth devices.
>
> > Error: Unknown device type.
>
> No Veth device support in kernel?



-- 
software engineer
rajagiri school of engineering and technology
