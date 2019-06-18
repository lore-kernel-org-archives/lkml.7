Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B58C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E5A20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQhSpRvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfFRVv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:51:29 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39747 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRVv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:51:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so7633453uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYYUQ3e7ONlVseVSNvQlJ7x1YpG18Xt9WTuVNuLCobA=;
        b=qQhSpRvb5Kvqh7fFh1aP152lsn2HY6VLkvsHO6s/bMzpVnI0c30FB7HrI8Vg7DnN5U
         Qa3bqSAgpQMP0SdAO38n9/WniD8wRYqi97LDsaL/QXHwZ2MCCLfPzGG0HrkKyO+G33HR
         splQ1lr4TiCc4MlvGm5HyNg+SLfdtLu1/fFh/BRg/T8EO6QpZ/SXrlbNVGvvtUr2ZE2p
         TMIArJMEjVyNuYsH0EWjZKHex7zgiRpxu5d8isiAzJ+3yn6m6k/QaMfvMhtCZrXGs3SO
         lhkBVKqg/Jz5YBcBIQdLmcdd2K7my3VetDLzrCMYwP8AiQw7iC1ALOVucH8O2vFSzgOt
         mUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYYUQ3e7ONlVseVSNvQlJ7x1YpG18Xt9WTuVNuLCobA=;
        b=AhAgArY1Y+3kwLypa+/1KGmWd7EAmqjMUsdNemppyBLzABkzQ+s1D1thukuUZhE5Xy
         hgdxb6fO/0gbu5EHHGaZH4Msr3MvSeRgZBvjOHxP5n+UAngw2z9eS7JpI7mx4WvgsioJ
         v3ssMHG2II4wxfhkj6GSNy22rEZgRvumSKxCBRvENYYcZy8Hg+dAaOroNukubUAa8dLA
         Fg5piZqA86Hessp1PCO96Ocvhhv04wMHAYOzsNkYlX1gB8RJ5ZDLXKufjEP6Us/SJN8I
         qlw/qXnJ/z+8GUHCCfpefp/s3s7rGc/D9Gn8tugCSKi+6wIKzPkljiGhk+7NrCFgiFHw
         E7Tw==
X-Gm-Message-State: APjAAAUTrI7rpXLM9bXMnf1g+wjk36pqTZvvWOj704e3uj69Fw+HlmTM
        g7CspVZkXcrPzXSDaDgQ2hNnT6VepXw6d28Hd4g=
X-Google-Smtp-Source: APXvYqyDelhTfDEa4jc4T+QXKh2CqnygOwHY3Zf/VM9l/nU/fn1P+SUkyIh9Rlb4jtppJOEy/4PiW1XR65IIyxMOyok=
X-Received: by 2002:ab0:208c:: with SMTP id r12mr46741116uak.27.1560894687847;
 Tue, 18 Jun 2019 14:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607073957.GB21222@phenom.ffwll.local> <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
 <20190607150420.GI21222@phenom.ffwll.local> <20190618021944.7ilhgaswme2a6amt@smtp.gmail.com>
 <WQuF2MGabt8DxA1rdWhTcZIGSaXav-5XOae4hkdkxq51gom6tklMqrfOLnyN6WSm9TY5sLXp_fxoNQhtC3E7zY9A3dLEpfZ1phdw23m0SI8=@emersion.fr>
In-Reply-To: <WQuF2MGabt8DxA1rdWhTcZIGSaXav-5XOae4hkdkxq51gom6tklMqrfOLnyN6WSm9TY5sLXp_fxoNQhtC3E7zY9A3dLEpfZ1phdw23m0SI8=@emersion.fr>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Tue, 18 Jun 2019 18:51:17 -0300
Message-ID: <CADKXj+4R=J0mEs3hYGiMS_iK+yhAZyXi_xOg-nRMtTAvSuCz2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
To:     Simon Ser <contact@emersion.fr>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 2:18 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, June 18, 2019 5:19 AM, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> > I made the patch, but when I started to write the commit message, I just
> > realized that I did not understand why possible_crtcs should not be
> > equal zero. Why can we not use zero?
>
> Hi,
>
> possible_crtcs is a bitfield. If it's zero, it means the plane cannot
> be attached to any CRTC, which makes it rather useless.

Hi,

Thank you very much for your explanation. I'll try to finish the patch.

> Thanks,
>
> Simon



-- 

Rodrigo Siqueira
https://siqueira.tech
