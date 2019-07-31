Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636CC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AF8206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PNBn1vWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfGaQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:01:20 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37095 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfGaQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:01:19 -0400
Received: by mail-ed1-f51.google.com with SMTP id w13so66214887eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOHNaf/9zGja9offVGntbMakWJQ+ZGc77yJFGDwH+JY=;
        b=PNBn1vWg4YbSeIowQjqpM/X23ksXLc6f3T3CgQCwNd4mt2cTyo7ZzHCzFOd5K1E4Iy
         v4pzf31+LzNF9jhZ74VoLjDAEniolM4dYJ+UpfPPdEAH5TbYVVzHXfBlV66rIU0gUfPM
         zXZCAUoX/jNc4sONQMGRGcYLTOFVAvx6f2ztMskDsa9mZz05W288TyU311SRl1/Qk+jN
         o3QsrCKdgzFmQjIBIJerB/AjhVzS9O5yeQK/EnRHuNWXFMBWK65A+iIVESBIMYXjk92a
         E3loxdrE0PaHqIuCD95gAksQsGy7FbeKWPF1CvNgm1zmfkOVtwlh5lRNyxxrsPzpkM4r
         NEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOHNaf/9zGja9offVGntbMakWJQ+ZGc77yJFGDwH+JY=;
        b=AkYNpGHEhlmhBs8kigw+OklelxNwcvLKbK9j2TO9LAcrMOJxgtB8gOpa3ptLBKbFLF
         pGyv+FucsTvWK3o38ibE2i34/cgshKImKg0hqdGMbmgsBKY6I29+0rjL3DlZpKutEh4n
         UGTmQLXF2+rxX8pc/b8vprq2Y5zqT8YB/AHJlEPWSLDIEVIV5lgFneeLdG64FO/y0qr8
         gpXdYCKxjt+xIfM98YLM6YhVXcF3W4C1nd/tfNYWYM9UDQjUQnIosC8jiPLkXZeWu+CG
         o4j6alwp7gX0hg1khFY1JMB9y1Ji7X9tCnJdNTRHfuBJo1wV5IHwORFUCaw4Ount/EjK
         OHgg==
X-Gm-Message-State: APjAAAX82b9IgJF0BeL74/esCbAC36Q27gF00ejp1/Fzeggi6NT6WHoI
        L1CbK9sqJqKuK4megbtg+xGLOCpWe2jamXMGR7eYzQ==
X-Google-Smtp-Source: APXvYqwueLVfu4t2A7GiLdjDq8PdZifweEvG9mIYGEKN2rj55OFqd4HfaufMCDSjY0DZ2kfK5Vn500PtEux8jGZKWu8=
X-Received: by 2002:a17:906:9447:: with SMTP id z7mr29744336ejx.165.1564588877876;
 Wed, 31 Jul 2019 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
 <20190731153857.4045-9-pasha.tatashin@soleen.com> <20190731155042.GF39768@lakrids.cambridge.arm.com>
In-Reply-To: <20190731155042.GF39768@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 31 Jul 2019 12:01:07 -0400
Message-ID: <CA+CK2bCBxff=ZcCMw196idR-1uvryACdzREebqrZeJ2JPwDNFw@mail.gmail.com>
Subject: Re: [RFC v2 8/8] arm64, kexec: enable MMU during kexec relocation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For various reasons, one cannot safely use Set/Way operations in
> portable code. They only make sense for low-level platform-specific
> firmware performing power management operations.
>
> If you need to perform D-cache maintenance, you must use the VA
> operations to do so.

Hi Mark,

I see, thank you for letting me know. I will do d-cache flushing by VA
in the next iteration. First I need to root cause/fix the bug
described in the cover letter.

Thank you,
Pasha
