Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D7A2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btNPRTX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfIFEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:39:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44459 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfIFEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:39:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so3200469vsw.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNQgvJus44isgBUbflx8HHog7li6lUOHX4TC2Njqm/s=;
        b=btNPRTX3nnznq32vQdTdQoy95jwKcYCgYGqbltpQl218xaDIiC88JjzKGHOMapuLtf
         CttPx7/CmjnyakXM1QC+tDISYvGJlkFH488gPVWzIK+3qzkff4ot226ALB+UfSoNPG3c
         0owFEQV6rr45L7eDYAMk4eXx9ey1ejHyS5fRdMofpW+RwWEoyGdbjZ5A1wPHLR+x4/kd
         1xMjYWpe6SpYPlpSAxFq4uoJwdU2Ze3dzRjusSXdvBqSWCqVOjyHQwiUDvXNduwillTj
         8qH/vFzW6GsVt2gntVybCfv38MEDynB6FriG/TTHXpbMTjGbzn4YpauWJ+qPpql1DI5j
         CeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNQgvJus44isgBUbflx8HHog7li6lUOHX4TC2Njqm/s=;
        b=GDjdQTZvbCjC/LEhayExGkwqppPk5Z0i5ITJGxOxF9vyDmDfRTxh1o7YCgVLHothL+
         wYnd3hCI+6mgG1OXBebV1NAZ/cb6OG9r8MM35iI079v+0nFbdHdo0hMnAxHvbfUmWXBi
         0FgNbgOzf6JjncGcTGEpZJlH7AMASyxOQatnxt2wmPCd6BV/ocCzYhHpzgbjjmARgnSU
         0taZDAYcIqRLUx7+p0p7Qshs8Fb3YIb3m9VU0Ii4NKcRXDHwK94qbYxfRrBcuBLJg0+a
         ZGc/UOKGoFIQx0Z9b7eB+VD/aiSercigVJOBTg5k8b0VPo/HfCMr4YzVRVVjhiIgVcKG
         1dPg==
X-Gm-Message-State: APjAAAUC+aDyvxEwxVa6zJ7HIs3CUmrOeVsT4HWG7AaZjTI4Aq8YAx0M
        5uqcAG1IX1ndUw1uBpibv7PtvAyhLMvyoIb6hq+yi+sp
X-Google-Smtp-Source: APXvYqzPIoPFAGW5H+SEFSJ4qj/1tBTRXAmVLAr2doCfkRMMHkJPVVmeo1T7n8XY4Aydw1Ai8ASLpCrHhXCb7BfA3z8=
X-Received: by 2002:a67:2483:: with SMTP id k125mr3867309vsk.236.1567744739977;
 Thu, 05 Sep 2019 21:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190905121934.GA31853@ogabbay-VM> <20190905205017.GA25089@kroah.com>
In-Reply-To: <20190905205017.GA25089@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 6 Sep 2019 07:38:34 +0300
Message-ID: <CAFCwf12VtkZd-cd7A+dznWx70ydjdxX7ahi7tn5CSGPoEcjexA@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.4
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 11:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 05, 2019 at 03:19:34PM +0300, Oded Gabbay wrote:
> > Hello Greg,
> >
> > This is the pull request for habanalabs driver for kernel 5.4.
> >
> > It contains one major change, the creation of an additional char device
> > per PCI device. In addition, there are some small changes and
> > improvements.
> >
> > Please see the tag message for details on what this pull request contains.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:
> >
> >   w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05
>
> Is that a signed tag?  It doesn't seem to me like it is, have you always
> sent unsigned tags?
>
> thanks,
>
> greg k-h

It is unsigned. I have never sent you a signed tag.

Thanks,
Oded
