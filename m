Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A863218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xc7zTmH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfDXHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:25:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41191 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:25:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id f25so10403631qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pfqdDA/DLXpI/bggWWvpsyGISKASmzug0Oh+C8IK0E=;
        b=xc7zTmH9jjq9wzyJqfrKAzTuIXdohIjldPZWkCfzBq6q63bH5loLoe1beNDLgKpEMP
         yRQYqNj2GTPpmzDDxfBjrOovmanT5D/PzOWPhLXXP2Np9jovutOp0SrTPfGn5N5yB/Hy
         OkWUiJCwHYPu5fWmy1OseZZM57W7vk0bHOdY/qCA/L2DDa69laaqBmZFrdzvOERrmaVX
         jqRga5O3im7TFQWzkj3kOiJzUmvJlwmkr66KdLz6DzBDYwekK0qcek0+9ywzWDqyrXkX
         ZVLWzDKpUn0YmQW014eGr7qKcfelyC8sJ9Jy7wFKCzyjWUEkXob1C7+8L3cT6GpNZa9F
         7Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pfqdDA/DLXpI/bggWWvpsyGISKASmzug0Oh+C8IK0E=;
        b=SNAGR6hk9QeFZSVdeOLDJF1/TJ+xtdt/X2ddN1wH3gXAPou3FdirmuJcRN3YahfeEo
         2IXASbct7Mhq5bPQnuaF8vHXWS2/yHnoiDeHrEKcs3PHJZPAt0/N+pS1X/2Vh0H5JnOB
         28XrXGz0sapOiZTPKaRIIBpt7+RIkUzJrZMu+kOtZ+B8kMdiKBeFC0SSl7LBxlHRlgZs
         +pDnMrJ8gsGlCc5wpMsBkFOfCdxtGgbnKncVdv2zDVi+PvpM0IaCOyNUIisSeVL/wjiW
         pEk8N0+wV90O3ZOjqFBOx1oTxSNBYeNf7EeRKTX/vwNFZdGTYLF3g1UV9lXhs6dlTjNm
         rdkg==
X-Gm-Message-State: APjAAAUT1/kVaCmkt58G4rJiBsL9op9jKfwadX7prl/3FqEyPcpaQ2NZ
        kyXj7lhvaYRwS3QtwDe8XzBpuGa3cidHpMYPP6baQg==
X-Google-Smtp-Source: APXvYqxDBXTDvhZpqufiiaQBW6Bgne7X8U3LnWQlMdCbW52r8wb8A+xQ0ANs9SEjedHNEj+erbBCjK6ed8FouovBHzg=
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr224705qvu.98.1556090752449;
 Wed, 24 Apr 2019 00:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
 <e25b2626-231b-28d7-93b0-004a21a3685e@st.com> <CAOMZO5A6A2sYzfPgjsqQxWcc4Z0YW9-sENW21KumO_XkN3WBYQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A6A2sYzfPgjsqQxWcc4Z0YW9-sENW21KumO_XkN3WBYQ@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 09:25:41 +0200
Message-ID: <CA+M3ks7LPEpEfOEqiOZ4q2-We-8BjK0FZfeKts4hBzL7GRRHSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM errata 814220
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Hui Liu <jason.hui.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 23 avr. 2019 =C3=A0 19:46, Fabio Estevam <festevam@gmail.com> a =C3=
=A9crit :
>
> On Wed, Feb 27, 2019 at 1:21 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
> >
> >
> > On 2/14/19 9:31 AM, Benjamin Gaignard wrote:
> > > Implement ARM errata 814220 for Cortex A7.
> > >
> > > This patch has been wroten by Jason Liu years ago but never send upst=
ream.
> > > I have tried to contact the author on multiple email addresses but I =
haven't
> > > found any valid one...
> > > I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
>
> Adding Jason's NXP e-mail address.
Thanks !

Russell, can Alexandre push this series in stm32 tree or you prefer to
merge it yourself ?

Regards,
Benjamin
>
> Thanks
