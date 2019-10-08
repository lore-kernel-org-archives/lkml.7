Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F26206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="B7wDgQ9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfJHKle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:41:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46190 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJHKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:41:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so24409110qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tk6htHWDZvZCH07nwYndLGD24Vgw/DSGreBenVs56Hs=;
        b=B7wDgQ9ge4X2R3aZQ0cISLoy2ririBZnyzt6LQBMUQQL3VSzWRQTcgxBfREY49npby
         L3BuN9zZzzprT4et05jJ5Jg477G8ZsJS3TmroAcUMqOd69UVfySDBdCOYizq7FlXmrYJ
         LhinKCRXu4aM3ntw+7XdWVddYXCMPdB6Ic+9l67e7pzIqO5Yrir357zi8wUlIXlIQv5e
         POUudyGvMDW812m1+5wEgcRoDxD4dJRFM+7fJgXGYTiV3Uyj/K93m/GHQhioCLqVxwcJ
         N1yj+WaUV6rvMm6Mo/yzq965X/YMq296nrwD57+PZCicYC9L4rZ32Z+oTOi1SlQU7MhT
         iHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tk6htHWDZvZCH07nwYndLGD24Vgw/DSGreBenVs56Hs=;
        b=FEo9KCoSTutW7fbytVtsQ4nOJ5y4/vBFfXUUKWLlqqs4Q9bLjPGHIGbGnxwEqGzBdF
         uGJT+lJNWThVR7eg/RtVZxz1AaF615uB2GjFJ+M7KYgfZb1X1zEnDswlzj2qaKEScEeN
         5Dg3p5r8WieGSnYXvi34JxdReuQ6Tr4E8dVRwZhn55NaAzEmRZNkjn0MIIDEm3Urtopy
         8efrMYzHECH2/Q1xxd/Mo45rFh3ZJ9JqFiZjogySSHhfIyhotKfXQ8eEZ0MtLBD9v+6q
         0m4P3/0fjjDAj3fsj1eL5GmRR8Lquws6VIdJXGUZv3zll1TGx9M659Wbm4XRNsJ5T6BC
         N4wA==
X-Gm-Message-State: APjAAAUm2QQZeCGs41cwCeNG2Zcq3hlFd5AaF8izq0Jzoa6VXaV+q3+J
        JUw/5yTVRRFQddAA29EfRGFDwKVRcVd7dzOC4q9xvw==
X-Google-Smtp-Source: APXvYqybpf83/dqFUb0/N890BX6HKINavzfHrhqTBPjVu8aLdmYYDq13WEqW+gZuiOgtWtQgcRKFfoSM9V3mUdK0i7Q=
X-Received: by 2002:a05:6214:c4:: with SMTP id f4mr31270966qvs.111.1570531292882;
 Tue, 08 Oct 2019 03:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007115009.25672-1-axel.lin@ingics.com> <20191007115009.25672-2-axel.lin@ingics.com>
In-Reply-To: <20191007115009.25672-2-axel.lin@ingics.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 8 Oct 2019 18:41:21 +0800
Message-ID: <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
Subject: Re: [RESEND][PATCH 2/2] regulator: da9062: Simplify
 da9062_buck_set_mode for BUCK_MODE_MANUAL case
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Lin <axel.lin@ingics.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=887=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
> the logic as the result is the same.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Hi Mark,

I'm wondering if any issue with this patch?
Note, this patch is for da9062 (not for da9063 which is already applied).

Regards,
Axel
