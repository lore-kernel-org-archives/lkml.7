Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DAC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90C21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eblau.com header.i=@eblau.com header.b="SphBacXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405339AbfIYMFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:05:01 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46795 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfIYMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:05:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id t2so920929ybo.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eblau.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C2MGL0G5gqLwqdPmozf6pVB3H1S7YNaLviYRQDFVzMg=;
        b=SphBacXs3QXD/zYpT8Sunv7dIGIVUd25y8bitmiw9/rsBQUwkNVGGN8w8VfFAJ2I4M
         v3tXQ17r350jR3UvTRrPCJIjlyAgyPwURiDzVh4keF6MNSJvorYr+vaixtERrD3pxrFl
         9Ef3WQAbyyIrwEyjL6S1ogtxpXCKsmFhNTQaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C2MGL0G5gqLwqdPmozf6pVB3H1S7YNaLviYRQDFVzMg=;
        b=GdG4CFF5j9Xx5NB6xni06zf1Y8jM8FIkwlLsGlAxBFvIuTLicHFjti9OnCIYwAbEPy
         L0UdmC5HDEojAme6q6YQx/RDQakHQnEs9pyBpTa6FJAmX1foe35T+lYLIc8+lZzk97k1
         3fxKUg7FHBMmU66sYnNygt5rtyBE2ESFp7GSx6KMQ4cMCSvTOx+L2bldXWOrkXOl8Spv
         pqU3WW4PVyrvk3SZdvYk45eV6c0ZHKtKdKR5c2PCpkNvcd7vHwkMXqrEQPr1IvgOcWZ3
         ysGGKtu4PV6ilwNdtnTMrhATW0fOgbiqu6GdzJcxLmDOismf09uw+3ZV/syOnmxRZIjk
         jIWw==
X-Gm-Message-State: APjAAAVLOdPQThs/f2iVmcleLOoreU68sUTWm9VVSa4m+lW4ItX3V760
        8Eqfc6AYlWLh4XZMUFI/f7JHo+B6azLdX1h4onoUi9co
X-Google-Smtp-Source: APXvYqzz/lSblwHZUg1bb3rIJeImjlJQsFjMk/qLBy9bxc/I2yMbBR07jw3bDMRnIyjEiakm0WCO5S/xyRydn4FpqQo=
X-Received: by 2002:a05:6902:4f2:: with SMTP id w18mr2478018ybs.112.1569413097763;
 Wed, 25 Sep 2019 05:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CADU241M42pe_vFD4QriuVm_CjnpQe0LyBUDihaDkxm5k6o7X3g@mail.gmail.com>
In-Reply-To: <CADU241M42pe_vFD4QriuVm_CjnpQe0LyBUDihaDkxm5k6o7X3g@mail.gmail.com>
From:   Eric Blau <eblau@eblau.com>
Date:   Wed, 25 Sep 2019 08:04:46 -0400
Message-ID: <CADU241PET6bV=FaDN=OiX=QF13PQywSWKbOSLBkamT-iMefk6g@mail.gmail.com>
Subject: Re: [Regression] MacBook Pro - suspend does not power off - reaches
 dangerously hot temps
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 5:44 PM Eric Blau <eblau@eblau.com> wrote:
>
> Hi all,
>
> I have a MacBook Pro 12,1 model where I've hit a regression since
> upgrading to 5.2.x. When I enter hybrid-sleep mode with "systemctl
> hybrid-sleep", the laptop appears to enter suspend (screen turns off
> and keyboard backlights go out) but actually is still on with the CPU
> fan powered off.
>
> When I first noticed this, I had put my laptop away in my bag and
> noticed it got extremely hot to the point of being dangerously close
> to a fire hazard. It was too hot to touch and would not resume
> successfully either from suspend or, after powering off, from
> hibernate.
>
> I've had no issues on 5.1 through 5.1.16 but every version of 5.2.x
> I've tried (5.2 through 5.2.8) has exhibited this problem. Is there a
> known regression in suspend handling in the kernel? I noticed some
> traffic about suspend and NVMe devices but I do not have an NVMe
> drive.
>
> If nobody else has reported this issue, I would be glad to do a bisect
> to help resolve it.

I guess nobody else has hit this issue. The problem still occurs with 5.3.

I started a bisect and was able to determine that the problem is not
present in 5.2 but was introduced in a later 5.2.x stable update and
is present in 5.3. I will report my results when the bisect it
complete but it takes several hybrid-sleep/resume cycles to be sure
the issue does not exist in a given commit. If anyone else is
observing this problem or has any ideas, please let me know.

Thanks,
Eric Blau
