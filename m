Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383292084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Q+2rooZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfDXQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:19:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43862 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbfDXQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:19:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id k2so3205032lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SErjt3k8dJrgmkQ7SzuxzkPDnc28XAvYQh9MmP9g7vs=;
        b=Q+2rooZf6ZEfzYXrsnRG2kZRRWMmc2zlDfkjckmohzR7oOkLWtnwN86qNlK/jx1e9g
         31Q+vXkrVIoe8Lkh5UuAamqL9BwUUTVJIsvsn7XdjMEgYuyeOagKlbNJFADUR/46LG76
         WnfZrevOc/gp4C1UJ9CJ7MXuzetayNMspDAt8vra56D2cbXGVcY2rFUSX8kB0eZoEeeT
         y4Omv4fEkMO23T7/LeBP9BMzKiBHOh1qbVfGFfObzulxsQeZMn8MQm3gsOlJzxDDCi9Z
         ytoEcdn117WoKWJw2FCaM8Sm7Q5N0gaRfEXXfImQcxp0K7UpfNymclUS6Zg8YGWC2ZEZ
         t6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SErjt3k8dJrgmkQ7SzuxzkPDnc28XAvYQh9MmP9g7vs=;
        b=NumTuELMDx70/qSy8bizKJmzo8bbYtPSl7O5cXBibTqfxkAmIQjLV4Q2jRYIMtFKa8
         6Xk8II8Wz1GXTNHKZ7Dra+zwkexgs51QLcb8aKSfCw+mwqVAmYbwzArFygI8L9o2irqw
         3VBXDLz/Y50qN3rFVC2XzWuz87H9aBjgmTr6Euq8ggeKF74LCclNeq+vZVbCzaea8FoI
         BRyZoxmO9DoWvtDAlTI/jBOlbyFd3tsXyuk3aPI3Don0IzmuMAn2CE8Rv1e+agAjRp6x
         bmzj8CMBY8pyuwD+cng8usfPxgzNWARaSkyqkLSoobq/YVMbZEmZXb0RlvTVmT/O9fjw
         wNPQ==
X-Gm-Message-State: APjAAAVzIarj/xkhJXZIlwEwNCSQu2AEQCorYV+o2BZWJ7njVsGRqYI3
        zAqchdWyhOuth2zwN0kgEMQaaN+o0CASKH2CV6aSPQ==
X-Google-Smtp-Source: APXvYqysfNVgCilGS11UsHDZ4ZAiwet4rq3Jn/UKA3xzQsOa7q3f/h4kHhffzX8qKzkvqA2oO8h1ROsNYc1ePsN+R6A=
X-Received: by 2002:a2e:380c:: with SMTP id f12mr17326046lja.116.1556122776886;
 Wed, 24 Apr 2019 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <AF4D908CC0E2A24EB308A26962C8C3BDEB1A2B@DGGEMI530-MBX.china.huawei.com>
 <20190424161641.GI16167@redhat.com>
In-Reply-To: <20190424161641.GI16167@redhat.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Wed, 24 Apr 2019 18:19:25 +0200
Message-ID: <CAHrFyr6rR=TMepEpFK0hQRQ-qMF8m4izf+WxdzGXEO7S_TVnQg@mail.gmail.com>
Subject: Re: Re: [PATCH v4] signal: trace_signal_deliver when signal_group_exit
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     weizhenliang <weizhenliang@huawei.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:16 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 04/24, weizhenliang wrote:
> >
> > On 04/24, Oleg wrote:
> > >On 04/24, Christian Brauner wrote:
> > >>
> > >> On Wed, Apr 24, 2019 at 08:52:38PM +0800, Zhenliang Wei wrote:
> > >>
> > >> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > >
> > >Yes, but ...
> > >
> > >> > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > >Hmm, really?
> >
> > Yes, the kbuild test robot says that if I fix the problem with the third parameter type,
> > I should add this tag. What is wrong or missing?
>
> But this patch does not fix the problem reported by robot, your patch
> (which introduced that problem) was dropped, the problem has gone.
>
> With this "Reported-by: kbuild test robot <lkp@intel.com>" tag it looks
> as if test-robot has found the problem you are trying to fix: the lack of
> trace_signal_deliver(SIGKILL).

Yeah, Oleg's absolutely right. That tag should just go.
The Fixes line is all that we want, I think.

Christian
