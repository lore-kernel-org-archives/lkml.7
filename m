Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6CAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4373C208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568367008;
	bh=DkbKPLd98o2D2jlg/SusdIF+USUESXyjosrHoIfXz9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LoZJ/J3xqjWtn5FZqjaX+678OoP3hoVtpAn7+kCBwHA36pJh4upvW/IuQxKDoDoQu
	 UH9Y186/GdbHf68DXHDkADiOuiiMgqAvKY4zFKD3O76tqykbgVb08CKo9bZP7xOC6j
	 IUIWIH+S54uCs/o/3Gs98cCv9JA5cwFncHWjARCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfIMJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387770AbfIMJaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:30:06 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06CE9214AF;
        Fri, 13 Sep 2019 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568367003;
        bh=DkbKPLd98o2D2jlg/SusdIF+USUESXyjosrHoIfXz9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jdRFTgPhjhReuG/k949iM5v9sLI5ZgcQM5pTB4haEdx0G5S39nJa0js/STzxHkeXo
         O4/st057cFiVGF0AohwEfD6n5S088itbJQK1j0gqusXg0D58+xWfJ9PAjHNk1IS2oj
         Z4x2PqGDS6PsRvJKAGuVAn2kAPtNy7OzM/TKsWH8=
Received: by mail-lf1-f45.google.com with SMTP id r22so10304445lfm.1;
        Fri, 13 Sep 2019 02:30:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWjuihriOxzxfcIKzKDokXrEIttlY3rbiWk4rawwENXUAVhfCXp
        5XJUUOuC+z2D7NyArGiTcBoqg+MlxCoOTKNL1+I=
X-Google-Smtp-Source: APXvYqz5bssj8Eu7jmoWxgT0sHti6vv0ZODfmt2/e3kFzQQKbrpBz8lWDHX29tZkUIoK34EqGiyBjSpjvMVB0yXPqrA=
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr11900825lfl.24.1568367001114;
 Fri, 13 Sep 2019 02:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190912093315.5744-1-m.falkowski@samsung.com>
 <CGME20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a@eucas1p2.samsung.com>
 <20190912161538.4321-1-m.falkowski@samsung.com> <20190913062945.GA10283@pi3> <e082996a-743d-807a-38c0-dee65b490771@samsung.com>
In-Reply-To: <e082996a-743d-807a-38c0-dee65b490771@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 13 Sep 2019 11:29:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdSQJ4CR_0BQjudx1NdaC0E_rU8ZDtFVSB9XwcTbxSdUg@mail.gmail.com>
Message-ID: <CAJKOXPdSQJ4CR_0BQjudx1NdaC0E_rU8ZDtFVSB9XwcTbxSdUg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Maciej Falkowski <m.falkowski@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 at 11:15, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 9/13/19 8:29 AM, Krzysztof Kozlowski wrote:
> > On Thu, Sep 12, 2019 at 06:15:38PM +0200, Maciej Falkowski wrote:
> >> Convert Samsung Image Rotator to newer dt-schema format.
> >>
> >> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Just to make it clear, Marek's signed-off should appear for one of
> > conditions:
> >   - he contributed some source code to your patch,
> >   - he took your patch, rebased, send by himself (not a case here, I
> >     think),
> >   - he contributed significant ideas, although for this there is a
> >     "Co-developed-by" tag.
> >
> > If someone made just review - add Reviewed-by. If someone suggested the
> > patch - add Suggested-by.
>
> My signed-off here was added to mark that this patch is allowed to be
> submitted to the public mailing list, as I have required company
> permissions for such activity. It is not that uncommon that a given
> patch has more than one signed-off and still the main author has the
> first signed-off tag.

Thanks for explanations. If I understand correctly, your SoB appears
because some internal Samsung rules. That is not what SoB is meant
for:
https://elixir.bootlin.com/linux/v5.3-rc8/source/Documentation/process/submitting-patches.rst#L431
If you do not contributed to the patch, did not touch it (e.g.
rebasing) and you are not sending it, then your SoB should not be
there. It looks like the same madness with Kyungmin Park long time
ago:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=for-next&id=6c6cf64b16438eac6da9a90412a82316ad196e7c
Every patch was marked with SoB even though he was not involved at all
in the process.

That's not what kernel's SoB is for.

Best regards,
Krzysztof
