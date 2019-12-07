Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87EC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43214205ED
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0mgtqaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLGAcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:32:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44977 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLGAcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:32:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so4182156pfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 16:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nA6TLXHYl8v79peg3VhVosiUxmffdmpQbw61XmrrVw=;
        b=k0mgtqawhqQauqAo6Xm6Y0XzZGm+X99KsWdAV+KuEkGfXAz/WbV5qUCiTIVMIqFkwk
         7YChpnQVxjemzb+1wlbUjYOprUtpKjXvqjRtjpw7O/Vsf1oTijwu+Po2hmkkgHo4rHWL
         yYy8ypWJhdy/D+TdRYSMxI5LAbmxsNoON7lZOBvucAOTj9ehPhvWT4RVSHNtjtSIpE7M
         IMfHqeUxooqAdCRdoVmiE+LDBu4CoMo7vw/OkUMVo/Wh3sR9MReIZOODRP+FVe9E2TII
         OgsKP/VB4cJYtHkOpR697qiXPFqarvTCZK58ExPs4sJ7HRe6kUR27yRcsJiWMAnTy6XZ
         VuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nA6TLXHYl8v79peg3VhVosiUxmffdmpQbw61XmrrVw=;
        b=ojqVrEoJF7w61EjBx+RbAxnAe8T3JOzyJ61HYqIOkOHnFvVHv1kZ9NwcxO5iCg1Knp
         78C9Zd0jbl5Nua8pFE0vJRTCwaOF5sLfHzs+8fsrdgBHGp3BVvzRwmtvAX5tPvxWmwno
         XBUU1/gtKcI0OHeGf/x/qRIIP12uLrgMcbkI9ud5DKoDa9z93gscUnvzYpXZrrtlRTM4
         LpGeqjUDX8/EMLelomyEU8yTm/b4yOFC5XXc0Un115NNfxrKNOp99JOwdY1mj0l4nQh1
         9DwlGlT2RdMF49gH5cOe0L1B2F+7Kc9svaWjqo5cQIyFhIUBWGRiTGt7flQW0hXa7SPz
         MO3g==
X-Gm-Message-State: APjAAAVP8MZZcBFrpZeJF4hosYpW4HNu0G/nlmeTJVPwgAxPL05ryJSc
        A5kjZK6EmcErcJZDOuWrGEgQEnJqKyK4tA8JByFsFg==
X-Google-Smtp-Source: APXvYqyAM9UyYZckbr97n8v5vv5QX+O9jWt0njXHGztaN/fZMNU2oZVIVd2VtftBNRvnLjGxsuqS4BrCMBIKw6qyeGk=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr17493808pfg.23.1575678766044;
 Fri, 06 Dec 2019 16:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com> <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
In-Reply-To: <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 6 Dec 2019 16:32:34 -0800
Message-ID: <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:23 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
[...]
> 1. There is a proposed patch for the build system to fix it.
>
> 2. We should be removing all old drivers and replacing them with the
> vector ones.

Hmm...does this mean you would entertain a patch removing all the
non-vector UML network drivers? I would be happy to see VDE go as
well.

In any event, it sounds like I should probably drop this patch as it
is currently.

Thanks!
