Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E822F22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h571lOuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHUFwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:52:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46116 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfHUFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:52:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so817902lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TIxCfXD2eyh6zMqJFg2GtypILTlpE+TvhurqKYvOlo=;
        b=h571lOuE9rlh6jokPyR7zPtOUmcT0wb5cZZZavJmW/PBnp3LZfPhHObeuyTdEe2dk0
         +SLiwrZFafrspkXS1P35VzI8s1XqPU4YgJOGJ84d7cOsBPlHLhVIrpBJHnYHuad4tnR9
         LC9W2mth3VpWn5RAy56inC04YRNfLAsAYR9E5dzK0xOfdKYvmgM0cOSSZVIGSc7cNb7Q
         iUC8Ic/r2Gqw5H92RKoLhMsjYdRT0oSSI74UyH6Jg6gfMKeBpAo+DYhFw3aWoSVjNQoM
         mYxRyV89+I3hQ0Vl/CZBaKw6KFpw/fmpwyezY9AWSe4VTQ/F19fwdVuhfH+nETxh5Rv4
         8bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TIxCfXD2eyh6zMqJFg2GtypILTlpE+TvhurqKYvOlo=;
        b=rYulMqgYMohW/OkqaqUl4Fb9xZFZuEH1Iz3qhwkt0tvM337Z6w34x4sbxPbJ3AYHeW
         jyyuciW1TlH3y5FwVCPXADDo/btznkZEgKET5aMxL4SumQmZZBeznwSA2mGJqC8XuoFk
         3CMkCVBQOzrsFsJ7A3fpvc0QLZrcMMmA/6ro12BvKfEmtS+YXw/G0olMJRfXNGL1AVWN
         6piHuxkBCMD5CEKHMGFtasA4IbSUAJm/5lBuDo1+Mf/9gaHFe/aLKDHwgz23QgHRnnjF
         V7DVqcixXbVCYFhPR0wn3LhN3pzpDfPZHHyXRDacZJ9/b39AaPc1NXC3FDet/lLGi9WC
         lqhQ==
X-Gm-Message-State: APjAAAVnTByGTijPymGpGz9Rmh4akaT9fRi5zBmTGXg16NwfoUhAh7J/
        VAlPRykfYoX0l/CZzhGMnHmcXqmqGd6aoBtnyJY=
X-Google-Smtp-Source: APXvYqyD9sge8d6nZp1df6LdnHet72hp2VogL583tm9cg6fYFMjjAZbyS0l7gUXxlDHmk9VAXZ4ToWq94s9ugar1QmM=
X-Received: by 2002:ac2:4644:: with SMTP id s4mr17334296lfo.158.1566366755409;
 Tue, 20 Aug 2019 22:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
 <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com>
In-Reply-To: <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 21 Aug 2019 07:52:24 +0200
Message-ID: <CAEKpxBnxf=iejk887A7qFkzt3BXVxiRS1PeA45aZYR9DsBAU4Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to
 change parent rate
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks....I've added to my next patch series but if you could add it
when applying that would be great.
BR,
CK

On Wed, 21 Aug 2019 at 06:07, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Aug 14, 2019 at 2:09 PM <codekipper@gmail.com> wrote:
> >
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > I2S doesn't work if parent rate couldn't be change. Difference between
> > wanted and actual rate is too big.
> >
> > Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> This lacks your SoB. Please reply and I can add it when applying.
>
> ChenYu
