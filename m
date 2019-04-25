Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36774218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJQqtsxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfDYHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:10:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38974 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfDYHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:10:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so19250004ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyBXHdsRDXpqiQ1wImOgmhvmQy1dJwW8LYuF8EyisPw=;
        b=KJQqtsxHQISphq4uUoQ0YwQpBaHkBHKjvZq8ja8JolhAGzd78ZOZd6lXskoppuTsPF
         YIZdPepXfD0ev8v3jF20QNaoEpHwNMiyFNlmX7SX4p/wDEc9tZBbXKykqWZaHRZckVbX
         k9RVDwgey4TjsgrLTBCp3LPFqF7OOkGZxmaoiLyE+M56g+avo12TqJxfOkk4VCeBtE9U
         0jkw1DTyAuUcAcU5iFJBsJUXNMiuDk7N7qZStX0PGToql99Pkx8YuyqVfA7ngM8d0nbh
         lybONcpCNLDaGzYICpGxKbtQ3ECdRj2S5zGCZCthWHN6WPJAOlKElF68efRmQL8w1Wmf
         t4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyBXHdsRDXpqiQ1wImOgmhvmQy1dJwW8LYuF8EyisPw=;
        b=KEvwJ/33Tk9HDN+g+PIir51dki2XsLo04SJnk6/bkFgzuX8NcKvqgUHF26kqes0/m0
         xf8+T/BHNTKq9g1jomhLnFQA3FpHqDE3DNT9bubukYaxUCZLwOSle5MX33fiIWNrjwad
         wUhQ1o+59WexSZ1qpaST9orQNSK64TYiUxOJ4+/wmdZ+ctwzQw8l4AVe654reJ2I1Yil
         R4fOnIWfYOFW8GkgNWBARq34HF2ShqLW+ygR0E5DCWzBUl3Qjc4lGBB/PSjl3ryauAY8
         xcbK+6zVDAyCezkJcWUH9bUmJl+OV2iHwCHPrnNEAY32yN5Zfa9PFLQ6vgIbhtRXOg/+
         gyHQ==
X-Gm-Message-State: APjAAAX9xK0xAjPu07D5ps7eEHrXUuyAXnLS0I4v5gSKCjDdTjoTyiZS
        w3Krcbtbyas5pEPRhByHYw62/4iHeAXj7fXwdZON0w==
X-Google-Smtp-Source: APXvYqyX6nuRgUTdqSUMq0wPF94YKtUuYkoyJkIFqUAr5E10IBWxL2Q7lCgAl196OfDrlxbxUSAGFZR+YxZqX4w1fUE=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr9937717ljd.153.1556176249185;
 Thu, 25 Apr 2019 00:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org> <20190424120224.22660-6-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190424120224.22660-6-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 09:10:37 +0200
Message-ID: <CACRpkdaM6HsBWNGikAG-KFWWJFOtejZV4n+KWVQngdg-U6rNUg@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: Add entry for BM1880 pinctrl
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:03 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add MAINTAINERS entry for Bitmain BM1880 SoC pinctrl.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
