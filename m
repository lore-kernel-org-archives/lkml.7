Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C6820815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="hNvkh34T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfJHKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:48:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46548 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:48:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so16154852qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9dOR5ybxdZ3vkLtlkE/T6EaQDxHi/m2Arj6fLpPQj0A=;
        b=hNvkh34TfnYtYaNn9nlDXWqrhe7woXNZWSY/PpmYejF6Z1TsPqG4mRxLyFbDu7XtT/
         YLR3vQIsdb6geG888OPFE9AS0S5oK2rFWNNcid5rq00jKtCIK1wa7Hs5Yumb6I+xAhG7
         4se7Hugr2E2QceqdyRv1qRV9pYAUzGmFw8stqkGCfbPlbZYGWbHvcn+85/4zb2GdKj1O
         S//NfdFaMxhgrmxbwGF2UO/LMSb12E+xqYrv+P6NJuAAUfw4afqNJV2n1fqpEcxlrmG/
         UMRqoG0yEQg5D23kITdVP6ePvD4xT30skeWg6FVMY9a2rLGPZA2xKVM2tTHPxd2DQwp5
         d1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9dOR5ybxdZ3vkLtlkE/T6EaQDxHi/m2Arj6fLpPQj0A=;
        b=lnP+u7sa4qe8kBNCi7K8mJX9tiGZUIzTSHnUeJB7NvZtetxtud+DpD3eWsy3EJ/39n
         IWbxn79cB8cvxX7TOiYtuKQaiBajIn1cKV2DoYupMbdB+lOORVgBWbtazvVwQYQSC0FY
         rOIMTmAZL0lo+06DRHCKwhzpdYU+2TSKMUvog1rnLPNEYKfC95jxNCKrvHYiXCnl2SRu
         j85H/cj211yCxgye9yWO+Uj8L+BSveIh5jb/TxLaWJqHJWwOnqFtFuAFLwvJqzZUzhHM
         E6jvXCmN+sNzjMBBvdcFAp1mEROwGi25TEyKJo+Oy0LdEGIwIGOCUG5JKCBMKrQgL1H0
         m0oQ==
X-Gm-Message-State: APjAAAUFNw5gCifuGpFCRtwJEY+uGQ+ovSKv/K9N/lP9Cxp6VhNhlTLP
        i/kyMuyy9CC0a2n6bbL1LgOmCMF+Ws5UJGSH1f5i5w==
X-Google-Smtp-Source: APXvYqyUpgMVcdxWQ9ocY27UceWx0cqLx3rvHg0Py2JuLJ/7WsHwqQcemd1I74Q36AbnB/k3qWCStJjiyuUU8IibVQU=
X-Received: by 2002:a37:7d82:: with SMTP id y124mr28193701qkc.264.1570531706073;
 Tue, 08 Oct 2019 03:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191007115009.25672-1-axel.lin@ingics.com> <20191007115009.25672-2-axel.lin@ingics.com>
 <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com> <20191008104407.GA4382@sirena.co.uk>
In-Reply-To: <20191008104407.GA4382@sirena.co.uk>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 8 Oct 2019 18:48:15 +0800
Message-ID: <CAFRkauDq=6X9LRj7APwKOV+7CVZN5OSVuWXmwBQ3QQPWD9Nauw@mail.gmail.com>
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

Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 08, 2019 at 06:41:21PM +0800, Axel Lin wrote:
>
> > I'm wondering if any issue with this patch?
> > Note, this patch is for da9062 (not for da9063 which is already applied=
).
>
> It doesn't seem to apply against current code.
I just test apply it and It looks fine to be applied by linux-next tree.
Or which branch of regulator tree should I generate the patch?
