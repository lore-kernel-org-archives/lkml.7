Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F56C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69520661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQTvsbsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCHNnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:43:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38012 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfCHNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:43:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id h132so6648703vsd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTIozs4xlKsooIjkqlnazArX0Wcr+q0eafa5N3VsnRg=;
        b=aQTvsbspoFOCOVy4CSR+TZq7uqh/hq8wuvn/SSiuSOxhlWmpzfwlElwaiOlYX0/J0x
         pvTizv+El+jBmyviGV7PB906Rzuf7BdFnuaKY1r8AqqUfSkoSwlJbngnyii308A81B+J
         7rXMITcUAWA10CAMi5MD0r+fM0MdcJSPdgdqbrpER/6j0dXgQsEzvTzy+VsuasJT+BKk
         CaxbKYtOBl38zcoB6jZHVrbwdH5WH8B4UGIwGWGYPmCdmI1FJ5ICtsjUSearr1mloJdX
         LiW6KOJB+YGUBspvXukgv47bPZENiB/IJPVsBjeAbd60rsFoarQsUswJW3HJzirqYpDm
         rYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTIozs4xlKsooIjkqlnazArX0Wcr+q0eafa5N3VsnRg=;
        b=NA5SOqJnHC6aeUJKJpM6zL/cQPou2XNXsTE1scPIb7Pt6ayG75z/oWIyWVfrTSAmBm
         VYNP3PRqJB+Mf7TYoHc5PGIZpi6sPEuJ1xbr27aVpy0Y97KejFl/+98wuKzDeuYqvnzT
         vnnjmYhNJ0NTsjG3rpnHQKqdvvkb6iKfNxGoVy+PVYL00Pom2DIeeohSwzVz7xU1y8Mh
         78zBCeGY40AdGUur1RFXfiYxwgUSHWUZ1KIS0DwYpBsbbcmbo0/n7jA4ZnZJcaX23AHa
         R4Rdxlm2CULFUbCm2pQ4/VIN6qMBF9VjH+uHkUgPKfCCEbEDFSNG9dUutC9/nTgFS+oS
         k1eg==
X-Gm-Message-State: APjAAAWagyBe0doLe0IWj64o3Ta3NB+fH2nXLwE/upxB2eurYmY3vJFS
        BTXe/HfjJ0l1PW1GWU5FTOBLs4oMMVz3W+zU8d2cSg==
X-Google-Smtp-Source: APXvYqxJaVnv0Iacy5SPPgw1ZocQkHmdT2WphgpiPLmA62cWfdf8mHKTx5hUaw5bSEeFjKq6slGfdeMmWEQTJ+k8LM8=
X-Received: by 2002:a67:768f:: with SMTP id r137mr9636990vsc.35.1552052617375;
 Fri, 08 Mar 2019 05:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com> <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com> <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
 <20190308131723.GA30600@e107981-ln.cambridge.arm.com> <CAPDyKFpf_SHO46x-7tYU3ouWbjQ9+r_wr6qx9q3ofZoDAtEqfA@mail.gmail.com>
 <20190308133132.GB30600@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190308133132.GB30600@e107981-ln.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Mar 2019 14:43:01 +0100
Message-ID: <CAPDyKFrvcTb0FDf5tcvdenDNSS_o6RX+Uxb9c5XprHQUnW8waQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 14:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 08, 2019 at 02:23:26PM +0100, Ulf Hansson wrote:
> > On Fri, 8 Mar 2019 at 14:17, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Mar 08, 2019 at 02:07:51PM +0100, Ulf Hansson wrote:
> > > > On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > >
> > > > > On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > Instead, my suggestion is according to what I propose in patch 4 and
> > > > > > $subject patch, which means minor adjustments to be able to pass the
> > > > > > struct cpuidle_driver * to the init functions. This, I need it for
> > > > > > next steps, but already at this point it improves things as it avoids
> > > > > > some of the OF parsing, and that's good, isn't it?
> > > > >
> > > > > I will take the patches Mark ACKed and send them for v5.2 as
> > > > > early as it gets in v5.1-rc* cycle.
> > > >
> > > > Actually, may I suggest we funnel these through Rafael's tree, unless
> > > > you are expecting other PSCI changes for v.5.2, which could cause
> > > > conflicts?
> > > >
> > > > The reason is, other PM core changes, to genpd for example, needs to
> > > > go via Rafael's tree. Those would then potentially block us for
> > > > applying any other changes to your tree (arm-soc?) for PSCI (as there
> > > > is dependency) until v5.3.
> > > >
> > > > How about if you provides your explicit acks for those PSCI changes
> > > > your are happy with, then Rafael can pick them?
> > >
> > > It is fine we can do that, I would have not sent the patches Mark
> > > has ACKed to arm-soc till -{rc2/rc3} anyway.
> >
> > Great!
> >
> > May I suggest you just reply to the cover-letter and provide the acks
> > to the relevant patches, then I can then collect the received acks
> > tags and re-post them to Rafael once rc1 is out.
>
> Mark ACKed the patches that we consider ready for upstream, tag them
> and send them out at -rc1 there is nothing left to do on those.

Right, I add your acks to them as well then.

Thanks!

Kind regards
Uffe
