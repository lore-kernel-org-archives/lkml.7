Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C7C33C8C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A25E206F3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbUR73oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNALP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:11:15 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45024 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNALP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:11:15 -0500
Received: by mail-ot1-f45.google.com with SMTP id c19so3291652otr.11;
        Wed, 13 Nov 2019 16:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwQe7ttqRrl/0DFYkdah3hasupJxW4zYjkHbDJRN7MA=;
        b=gbUR73oLA2i5hjNAw3ZR8RAa2lh2MSjfRlT9w5zqCmUIe40qpFiEnXof+2SXPtKV6i
         HmGzOtzdiPw0juJ6wbjz01Fr0lD2ns++Z+pjOCtu7RBnWmRUYHIiE9qJuvYUbUjz1kBl
         xdFzGhg0t97CqcrsTQJmsCcQBEL+jE5g+FqLbsXyKMi6ydYHwydgyvxlyUCGOVBSFKjr
         yD7/ejlxmme1ZlnBmQrIKYMASLjomq4sBQmEytUKEVf77VUmyZpqY0fEc+60f/+K5vF2
         688leDW8RBmnfUcaLPhPbezegaigbjkCHYZNLMU4npAwjvdjfs4igPEOM30eKP6MbQqr
         5rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwQe7ttqRrl/0DFYkdah3hasupJxW4zYjkHbDJRN7MA=;
        b=MgWIPoPOi5Y/QwTu/Z4iR0V1cCyR7WHUrjtlA5K5WEupymHCpfzk5ksEeoqYEd0e4Y
         pD4p9khepm3F2u1iFVe/K70haqdTLYbm9RHD0bigUn0hMQOMLQOAQRuOF2Qw9us+6Z4T
         C2ym2q5fhoCwdhn+230wwViXcJYt5gL1FW0kjDEC50iJD8ey22mOTDESAFTPbfrskXH6
         dhQ+KZlolOTOPzZTWBmVLAeH2N+3lPEtyYtLhA3PixCM6aH+36985zSrUMtDoghpF9DF
         Jd00Huq4RrTZ8+9u5W69hi9wDNr7I4tn7p6ivGLIPZdDsTBS1semN3Qzz8fflLTFmtQ1
         GgnA==
X-Gm-Message-State: APjAAAWNKWMRE9Fvj1DIVY2ArNWrvCyhO2wAJZGJ+nPpOPyETALILLXW
        isgowzx0ov+5g1EDufbQQtwUl4jtyHcvC7abZ0Y=
X-Google-Smtp-Source: APXvYqyQaXNsVNIH34kITq3TgXwMzDRIHWu0sO1TZj4MP0TAq+CqBiSuHk1ZclHRETZt7eVnPNlNPutVd+SLT/GQiYs=
X-Received: by 2002:a9d:4712:: with SMTP id a18mr5742915otf.49.1573690274313;
 Wed, 13 Nov 2019 16:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20191106225527.9121-1-mihailescu2m@gmail.com> <20191107091657.GA1828@pi3>
 <CAL_Jsq+b_7ELTp+cShPJWwAv3arJ-Fp3C+Eor2dX3O_d4pmUvA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+b_7ELTp+cShPJWwAv3arJ-Fp3C+Eor2dX3O_d4pmUvA@mail.gmail.com>
From:   Marian Mihailescu <mihailescu2m@gmail.com>
Date:   Thu, 14 Nov 2019 10:41:03 +1030
Message-ID: <CAM3PiRzO9Xz7=2brSXaCsRTLfSphbgf+C=7-X0vG8Bt8dsyf-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpu: mali-midgard: add samsung exynos
 5420 compatible
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I would prefer to order it logically/alphabetically, so after 5250 and
> > before 5433. With that change:
>
> I didn't see your comment, but that's what I did. This has been
> re-ordered to be sorted by Mali part numbers (though partially to
> avoid a conflict). Good thing Arm and Samsung agree
> newer/better/faster should be higher numbers. :)
>
> Rob

Thank you.
-Marian
