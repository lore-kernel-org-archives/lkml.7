Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF88EC32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951F62072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WX7N4eXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgAAVQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 16:16:11 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37606 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgAAVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 16:16:11 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so6573597uah.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 13:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcCF1rxq2Pk5WTtIE879sPZ4spchmlqFWlGadt2tei8=;
        b=WX7N4eXBYo8B4Y/qw45TKK1fBOA03UGCzBkKH0DOYphDG7KdePyxbYAzDAeiqIGGkU
         lRc0/8KrEefOwe/TOXds6249+PxHVd0P/nZNYtNcHGaZlSu9lbFRc+uJJ/lPrKDhcpby
         Euk8Ka8N7Ikkpqk8AJjO6s2quZNqWXcUWQNejhgqSF0BiohaFol038E3nlMcK8faLpsv
         IXo46d2Iim7HkEw+SVdmdjgbgJBGjt2fEgxFP9SwM+ZdfDNIQQWVqSIqFtkh/SdTPN60
         0697oZNB4/+HbKlZFhKlw86fVGYWO300F4wFJMQ4y+lEcAd5hzsETlmE8NvdmnXckeSp
         MPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcCF1rxq2Pk5WTtIE879sPZ4spchmlqFWlGadt2tei8=;
        b=ddslk77h96aQmKYsJfjCiG+gvUsRszp1kBeX71VD1uEIYPbarsceF9azKKkR/5q3LC
         mTEuAZ0lCd12OsQ5rOtlMlfkw8D7ajskhIfD9Z9I0isX5BM0FPHMKXk3Ie/5A5ZSvgKt
         bjKwWg8suw3cgsYihw7YL2xyKZb2wQmCBd4OP5GPZz3AEolsDNl8+/JmRFkk3qOVBdEi
         6lpRisNr5XdzHTj3euuv8Une5pGfzlkx8zC/fflEFRcPG5DoOvrJw4441DYfv3eOj2Vu
         cBEP0fWtWODIlbMSG5FhG/qBB9EgujLQr/AdKhfMbvJdDinLXA5pCq9wTId5b9Fhcb/b
         Y6EQ==
X-Gm-Message-State: APjAAAWHfoTuA+6Mepl+W8aKPOEOTm8JaxUDeXtmhjIrzgQ50keQlaFF
        0+dSo+f0HIAMde5RRzxDcKnTI18oIe+hMSWJ9WpTFA==
X-Google-Smtp-Source: APXvYqzfUap7PPa4Ci4VcLXoV15qac7sY43uAqaI29GOvH6BmNigjds4Fe4HtOfWU09OaXLR7dEm+FndCbPAoJAP0oU=
X-Received: by 2002:ab0:634c:: with SMTP id f12mr41911073uap.48.1577913369830;
 Wed, 01 Jan 2020 13:16:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576146898.git.amit.kucheria@linaro.org>
 <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
 <be07b05d-421f-35a7-0582-a04a226c8c2c@linaro.org>
In-Reply-To: <be07b05d-421f-35a7-0582-a04a226c8c2c@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 2 Jan 2020 02:45:59 +0530
Message-ID: <CAHLCerMYkEBs7HfYV0WNfypNPCRBEeU3w7ye=4+VxiiXVZT9GQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: thermal: tsens: Work with old DTBs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Olof Johansson <olof@lixom.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 2:58 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/12/2019 11:38, Amit Kucheria wrote:
> > In order for the old DTBs to continue working, the new interrupt code
> > must not return an error if interrupts are not defined. Don't return an
> > error in case of -ENXIO.
> >
> > Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> > Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Applied.

Hi Daniel,

I haven't seen this fix until -rc4. Do you plan to send it?

Regards,
Amit
