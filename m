Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D321874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+EGbYmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfIBJSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:18:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfIBJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:18:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so12188293lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1rIwTW5lY/ZdGEW/DCIV3Xef5lpoy5aMvxo+N6YWuI=;
        b=o+EGbYmWbClNVOF5FrfiRarkq8u7O/SOv3Tqc8HkxefKvGTGFr5yGmFVZgVzF4KJHY
         CHWra0LbiNkLT9xHmuLijrXX39KORN3ID3deC6FQ8DBGcUlMsoylij+E3Jx5ovn6Qffq
         ESR4bM00UWCteTkh8wKjV9WwNnCcnb5zGfLlkWI74rNHuJTi08vQQDOz74v72j10ac5a
         HGo7STadP+l4EVP5N6AqjX9AzXHpTcHyX5GXakjEyolT3/DBI1YYXO4vwfFcBr4+7Wab
         3J9M8fAoicdMhwOFJmU/PvswQOr+a32eGmNT5JUTJKfG2h4jAdGqx/HmMuby9eUVAWuk
         3lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1rIwTW5lY/ZdGEW/DCIV3Xef5lpoy5aMvxo+N6YWuI=;
        b=XqxAbal3QVRJPEpWzMlt73pvS84onmBzKbz24DmNNNgwzc8ccinbvR1z0YpUxROyVt
         lmkRbKpWnA/rgILkDFc4T0l9AkL2MiRZrJPSVOBxHqT5Fq44iR2jQxYQNF4w+rCIXokW
         QP9N2gr1USwI7/fAuoFKKesHaen8eu0LGx+YiNfd0RtzklddEiQKq2j33VUKQ6sWXo/P
         N2w22em0xJEay3wKGl0bmq2lxhvb6AAZRWFbfDmruBHmlx4MsAPTfBfMA2JX1206AcH+
         19/ir/vYRbu1S1/QfmpLDL0ushwhb9cvMhw7LGIWfJZRT5OS0LvcVmnV5MdAIfJuON0H
         oXZg==
X-Gm-Message-State: APjAAAWWGM/H4MdZ70QMd7mvIwdXKy6M/KNcPBODxmb0cIqxi4rwLEEY
        weIpPE+D85HwzItTgsPU5wzI13NCnvibdvShczQ=
X-Google-Smtp-Source: APXvYqw3IH/Qq0DvUycRxdd2c9I/PiYamSvqRnuCLhc7IwJvnx/RN2GPGtuCDma9RE3PFwTSCTchx21P+MgE9MXvuro=
X-Received: by 2002:a2e:1648:: with SMTP id 8mr1242618ljw.194.1567415919395;
 Mon, 02 Sep 2019 02:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821162320.28653-1-codekipper@gmail.com> <20190830114457.GB5182@sirena.co.uk>
In-Reply-To: <20190830114457.GB5182@sirena.co.uk>
From:   Code Kipper <codekipper@gmail.com>
Date:   Mon, 2 Sep 2019 11:18:28 +0200
Message-ID: <CAEKpxB=BnQNraPmTtqj0KWi982OWe0bGQ-6F4N5owPH_OX67=A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 13:45, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 21, 2019 at 06:23:20PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
>
> This doesn't apply against current code, please check and resend.
This patch is no longer valid and the fix has been done through the reverts,
BR,
CK
