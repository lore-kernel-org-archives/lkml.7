Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76139C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B75D208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559910391;
	bh=/uVptD9DcJup+qiMtcXMTHT2Na536gT/JYZIYtsnyjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=opMmAi1sZscoyk2MsFGUh56/b6KyNQq/SXCQwkpF1pNByo678yew8q+SfdckiqcBD
	 i9Dporgd7aQH81Sp/E/X8MveEsNhU+dRGTY4/lJC0/vLBEv76XGrr2+N+52OlcRZxH
	 HBv3B0dBGkDNY+Ch7ZPpBFPi9mKWMDXJMq+6iAA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfFGM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:26:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40978 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfFGM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:26:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id b21so1274401oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 05:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uVptD9DcJup+qiMtcXMTHT2Na536gT/JYZIYtsnyjM=;
        b=KJ6V/eJfbQetNWOMUOtCEMi/cJVsdrSi/DZL/XzSK3sp0lbBhYseojaRpEMD1UY5H9
         HRWjUs63uH/HuPvJI9tEtkcOqPmkOdJLe2rDwSx+sjrcwe/QoXZMbNKUyz/1xk/9BoJI
         4tW1iSoY3CWU3H+U3fErfRSPQhyyys7YjTDH76P+rON7Phh4zQtQvOHTtBB8BCX6O0dC
         OzFic1Eope1RNiTh73sWUVpnOBYisxmEp0pKWAKwdFuC6b4Mgv/Hr3TOlQzUwuv6W5C4
         VeilNB6gR4BZu1wv/B0ay9Hj99E5jW3dU/XdA4NCJSeHwMsNU7HxXImvWVf0LU/eEBdx
         HEpQ==
X-Gm-Message-State: APjAAAU/egj7ZCf9/xrvpPW0vtvMfZhrtccTFW7jt10RKAUZqNV6qSPv
        GitXiYAVG0FIdFeIJJJKNSNryWFUTrAgpMwyUpM=
X-Google-Smtp-Source: APXvYqysW8/b9CyGYI3vLHzrvXvDMjW29j7Hpw9RkMaoSuBWKAyRyRFt+ja8PL5ABbg2qvpacd4RK3NtKS/xH++/NZM=
X-Received: by 2002:aca:3256:: with SMTP id y83mr3721971oiy.110.1559910388928;
 Fri, 07 Jun 2019 05:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190604174412.13324-1-yamada.masahiro@socionext.com>
 <CAJZ5v0jXKNr3_W9B_raetj42UOdphA3GEE_Qh7nBSwDzwXfA1Q@mail.gmail.com> <CAK7LNASboJSJ969T_WZ041RTr1RvtARAyyxCg46zBu-vL0+jtw@mail.gmail.com>
In-Reply-To: <CAK7LNASboJSJ969T_WZ041RTr1RvtARAyyxCg46zBu-vL0+jtw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Jun 2019 14:26:17 +0200
Message-ID: <CAJZ5v0i-KsLpB-WgmqV+Uc7JNB5BdR_4NzDX40tSR-hWFKzn4w@mail.gmail.com>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 2:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Jun 5, 2019 at 5:53 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jun 4, 2019 at 8:00 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > This function never attempts to allocate memory, so returning -ENOMEM
> > > looks weird to me.
> >
> > And why is the "looks weird to me" a good enough reason for making
> > changes like this?
>
>
> Since the code is read much more than written,
> this change eliminates the question of "why -ENOMEM here?"

And you are sure that nobody relies on the current return value?
