Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQoq6ewF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfFLOOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:14:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfFLOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:14:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so15278892ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrZRBZ+fTVzOD60YpXMCtNMDQp8xUpglI3T4PqZ1xJE=;
        b=iQoq6ewFHVpyIoDhnuVIMEt466uFR8oeyFn04Zxht7sPg500vpcoSoRLRMWHlxI074
         lK4yA9O7hI/AZtptbr2St4Ge8sEiFFVxWfRn6RZ/sXF24AkuMw7p5osOdyyBdCSj5N7a
         a2s7Ple48FAoCUCfybc/PHAjgaCUFzVhASnY0HaeDf800cx0/h1WRO/nhl4yfVdmtoaG
         4ImoKoyBD7uMSPJEQOxgLDwxc3Y1xwup3Iwtw4TFIW3EAejyX3k1pVKRf8/m4u/hQpjK
         +WrOL0bwOzkw7Knf8jhq9QLU0iZTSFAnnC4qfsTmEN0Phb0ugUiX92WR95dXOQm7cHAk
         L50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrZRBZ+fTVzOD60YpXMCtNMDQp8xUpglI3T4PqZ1xJE=;
        b=rrgV6BvLDIeZHTSVGueVCCo0i2rWW5kJQNC7ocJmPfcdJjdE+2gnofG52o2L0YDiin
         xu/28V1PL6/SASx9wbTCIuc25p7cWBrNnpV5Uhi5aeq7uqcPe4+JDM56HK83jxNJe7WY
         vhrP/DiRPr3LHGLGZ94E+YspKF+mT261+bT4sKo0NPxE89LB27fJ0HNixEfqPII9ws2N
         3uWFMJJ3CRUPaN91AOO/2AqM+IdRTivr8oMSQP+LU/fkDJ1Jx/aTGXNVPA5PpAr//HkS
         MaAB4sGOaZZ7SUvbu2974OtEBq6ToUZg0ZpaBpMNjHx2KgjPbBr1xIQmgSmtt63Plnwa
         4KMA==
X-Gm-Message-State: APjAAAVZMGBDpyd83lFDhMhmuBlzD5MqvccCfdmvTKypmpEqtaAJ9+Qu
        MqwC8WqM/g/k5ztL8iRe8GKfpMDBa1vkbUoW8fT1KQ==
X-Google-Smtp-Source: APXvYqyyJKjiDY1zcAFBCGlJm1REfuo6zRrAEJWgIY+2YVRUfCeSbgOOjiKtsWTzXYR3ug3e/VffGC99MQFZrokScf0=
X-Received: by 2002:a2e:a318:: with SMTP id l24mr31830233lje.36.1560348890308;
 Wed, 12 Jun 2019 07:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190612081158.1424-1-anders.roxell@linaro.org> <20190612122114.GE5316@sirena.org.uk>
In-Reply-To: <20190612122114.GE5316@sirena.org.uk>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 12 Jun 2019 16:14:38 +0200
Message-ID: <CADYN=9K4WZQf4jy0Tk-kkVqwHJQvVBToH7ZOYq3z6gK94vR8ZA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: regulator: 88pm800: fix warning same module names
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 at 14:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 10:11:58AM +0200, Anders Roxell wrote:
> > When building with CONFIG_MFD_88PM800 and CONFIG_REGULATOR_88PM800
> > enabled as loadable modules, we see the following warning:
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

I should have payed more attention, sorry.

Do you want me to send a v3 to fix the subject line for this patch?

Cheers,
Anders
