Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D83C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ier1/HQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbfILOVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:21:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33826 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbfILOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:21:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id h2so17278764ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFMQkxTl4u1uDIPdWtzBBws4tnK81QKk4aIpoP8Wl4M=;
        b=ier1/HQ9wGA5OvIpZxEX/nq1XaK93pORQit51CSERGbvPQVVMZxU2LE7dq1kUbWZBK
         DZfxDgXDt06m2hz0f6EQdEhzZKMpsmTQCUvegCbnLkvE2n7UQGCYY4DrKmkWTbUQ3gU9
         rCWK7Mq7e9XB65nDGKTG8Vd3f177H0sXWfhuIaNyg+GIPMGcrfGD8Bv37JTuO5xCw/4e
         UKNfok63Ewt6nLhV/05ot7ZN+yiBQymDEPmeOwtJboDaF2ilZnZvS0RFoiG73MjLh/6J
         utc7GvSpVntuPNbjtmYK/01BWw8VLzIUfkPBWS8WHS8QG+rmkOHDp/MgYvuaqArEivi0
         uTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFMQkxTl4u1uDIPdWtzBBws4tnK81QKk4aIpoP8Wl4M=;
        b=lRL5Lz6HzUAvPY5N0AnDK086CNeTY6K8F/w7JSBduDMjrTN/b7Id8hskvIEGLMVa7R
         i7V9Q+zE0SaUV0REbxnnFeT7fALxEPFHTvi3MnjOnMWHJRYWsvYy5sph3LKv5fgjCbcl
         Pq/DRE9rOnCn55R0foVVbfx577jPjuoHgR9z8Fqy8jN8ajdbam5xC1FbfsZ6ZFA6CXr6
         6ujoZrGetdbTnqQJv9jNRor7gdgkzNgWVZ193tCZw6UVDLlr1/1CtttLvxIgdcQq7NzH
         jg167uJDN2HwrDhJ9FUSBL4tNkMN5ofnN796FAqcrjIwbCiQG+9GcA2CapgXf/NU/fTk
         oRfA==
X-Gm-Message-State: APjAAAWFtq5Ka0CceZdT1j9BkAmP644qI3RsjPaajuv7RC3aZOe9uKLb
        6p5Bj46cDexLc8/Ya+F6ZvYkN6E3P0dkSzZn6YY=
X-Google-Smtp-Source: APXvYqxc7Jor+XgK0qvsYhR5IbweDk6SR2yQ1TSzQPa7eM1/62+Oel69slNeS0cXOPPeiOS4CWyEidK9RBjUHSY+Zgg=
X-Received: by 2002:a2e:87d6:: with SMTP id v22mr2778028ljj.195.1568298109407;
 Thu, 12 Sep 2019 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Sep 2019 16:21:38 +0200
Message-ID: <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 4:00 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Joe Perches <joe@perches.com> writes:
>
> > Rather than have a local coding style, use the typical kernel style.
>
> The coding style isn't that different from the core kernel, and it's
> still quite readable.  I'd rather avoid the churn and the risk of
> introducing regressions.  This will also make backports to stable more
> of a pain, so it isn't without cost.  Dan, is this really something you
> want to do?

+1 As soon as you get accustomed to have formatting done and enforced
automatically, it is great. Other major projects have done so for
quite a while now.

If doesn't think it is good enough, please let us know and, if it is
close enough, we can look at going for a newer LLVM to match the style
a bit more. Also note that one can disable formatting for some
sections of code if really needed.

Cheers,
Miguel
