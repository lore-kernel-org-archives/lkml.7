Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B14120838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ef0Hr3tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404773AbfIFPgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:36:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44720 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404705AbfIFPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:36:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p2so5497532edx.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4FYq6BYAh9kLfOqN+BJBL7FeQsVNJ/SlbY8XN9CwA8=;
        b=Ef0Hr3tJqLTPZXz5nKn/QZlVlv/EccVcAXv+2/UUOF6Mg5R+fHj87YhuLGsxjwYppU
         W3/rHKML8xuucTp2rSpU2M2xqVOAPB2zE2P5SzCfGRnmQUckNHc9bFtZKPELKdLRUP2f
         JG+u003rO5+i6SD1pmAO0U6edTrVhdAnswlfGrKlbFjZaunsV/07suyfBhpVyRaKAqPz
         kgoeUTaq1QPmlw+R60+UxKe7BthBtS34DA2HkxeU86dVp7bcstmFCe/Kk5FE9Q+vkfgM
         O4sRgA1GIDIYLWe3+HSMgP8M/j2LiKmEcd/yTovL3oK0UfXa3QpI0BHSrg+ZS8481Rrp
         O53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4FYq6BYAh9kLfOqN+BJBL7FeQsVNJ/SlbY8XN9CwA8=;
        b=pWtGaX1jqiSrNUq0LtJzZ5nNHZHH3/aGdTkMAfuWR9ZHzrUFoMw4uEsTZLN8uVq3k7
         YWUcRocBpjFk/v4vfDHPGpB10dLDemJoQAe9+cHnsveBW/jGEt0EgodpBWn3Ipc0Pdl6
         Cl4/COR1avOImO7qNDfizNKDeUufBmi4GSf2nrB4LjYvnzoZPo0itWtyscDJbUs28TQl
         hf2sUF+utJgVeqeEph4kbqoPoc1MY8F3UNYdr/iVKhZSiFkJxeY1Xg+mJABmcGkwpzxN
         d1C0Z59aDXRoK63hKiQaNA7BxgrThuQ/E6TbIVFOwDJdzvdUmCHmanmXZyXr7HhnyHhW
         lHBQ==
X-Gm-Message-State: APjAAAUgzFXjPL0oqo30ho4xUKeuVIjzunDP59dNr+sPXzKc89s592Cn
        +/m1O0csaVxx6liXEWv6FXPH/w3F3ZextO/2tp6Yaw==
X-Google-Smtp-Source: APXvYqwSiKKOKWP/h3a0ZsF+Oo9rceIyMqvsTBtnjeEonE2/Oyyhql11Q3k8Zm0qLFs0EuLz3YWma2Khwt65rF7/etA=
X-Received: by 2002:a05:6402:17ae:: with SMTP id j14mr10209564edy.219.1567784158621;
 Fri, 06 Sep 2019 08:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-2-pasha.tatashin@soleen.com> <0f83b70e-2f8f-aa05-84d8-41290679003b@arm.com>
In-Reply-To: <0f83b70e-2f8f-aa05-84d8-41290679003b@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 11:35:47 -0400
Message-ID: <CA+CK2bBzCnxk8X8R=_70ECT=kn8QRm7OioZP4LNJioTNXYDhXQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] kexec: quiet down kexec reboot
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Here is a regular kexec command sequence and output:
> > =====
> > $ kexec --reuse-cmdline -i --load Image
> > $ kexec -e
> > [  161.342002] kexec_core: Starting new kernel
> >
> > Welcome to Buildroot
> > buildroot login:
> > =====
> >
> > Even when "quiet" kernel parameter is specified, "kexec_core: Starting
> > new kernel" is printed.
> >
> > This message has  KERN_EMERG level, but there is no emergency, it is a
> > normal kexec operation, so quiet it down to appropriate KERN_NOTICE.
>
> As this doesn't have a dependency with the rest of the series, you may want to post it
> independently so it can be picked up independently.

Hi James,

I have posted it previously, but it has not been picked up. So, I
decided to include it together with this series. Is this alright with
you, otherwise I can remove it from this series.

Thank you,
Pasha
