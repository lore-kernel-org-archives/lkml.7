Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC9C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05697218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHvP3Qc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfDWW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:27:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43762 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDWW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:26:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id t23so9248910vso.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wd3juuCyGv6I7aWGEczXK2I2MkaE+Yk5Y+BNpedQc0=;
        b=JHvP3Qc4kkkwAoF/0QYHWGplc3qsgSmh5NdB5v8VmADIDIKfxm29Zl03JyD4XVG9cK
         yzYYTUn+efgCCTi0FS+KzNAIgDktxEMhu5YO/Tot5RTlhcmQOOsrOxBqmB7so3nbTEBw
         AtVJmduRKOPMSxBxaCpYNVHVhvuORHcV1NhOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wd3juuCyGv6I7aWGEczXK2I2MkaE+Yk5Y+BNpedQc0=;
        b=c2vv5OpVt7arVwotEd0XQodtnV8NEuxnmovvMtXYBnNOHYlKglWy7Cl0HBKYXO7E8j
         gB7hewBpa3rmjmsJVaTu2oEPFi9+emsXUGg+q6y+c3FaeaiJOYCLhqMN24z8cRWFu/y9
         5an1Yuz7pMaVpMWAia3gw+lK8wDwJpSO4T/O9pEdXvrwEl8GfiJPoqBteEJw06dcMPej
         KyeJonBbHyfkq6IxWIHC5XR5BTZm/90Scm8mxrboQAN7CdNds01cSKb+ZrsDEuMuitPb
         IALw+gPY69v/HqnbfHD5Y0KR3cCYtp8Ry4akxxqi33ffdFKgZsj1ia8Pn0st9psolnxw
         bjUg==
X-Gm-Message-State: APjAAAWd2WospFOyg8bmiTA2d5Vuh/V4cZPhTo1HM4g6e6Cvcb6wVZ/Z
        fQ8axhX6HonqEgCHoyuafkCDFmdOUOY=
X-Google-Smtp-Source: APXvYqw+k7uKJtyQC+6PR5gOXERmKhGKziuLKsp2BEg9NPXlNd2K4iFKMrKwd7Vn8bzlXmKF0PnCnA==
X-Received: by 2002:a67:ea8b:: with SMTP id f11mr4441619vso.64.1556058417008;
        Tue, 23 Apr 2019 15:26:57 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 2sm19181004vke.27.2019.04.23.15.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:26:56 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id e2so9236481vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:26:56 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr14894109vsp.188.1556057966875;
 Tue, 23 Apr 2019 15:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190319030722.12441-1-peterx@redhat.com> <20190319030722.12441-2-peterx@redhat.com>
 <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
In-Reply-To: <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:19:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJbgmq1QS-+FO7Oe9KLrAmT+ivUjSochmHBgbvHkuj+VQ@mail.gmail.com>
Message-ID: <CAGXu5jJbgmq1QS-+FO7Oe9KLrAmT+ivUjSochmHBgbvHkuj+VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add vm.unprivileged_userfaultfd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:02 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 19 Mar 2019 11:07:22 +0800 Peter Xu <peterx@redhat.com> wrote:
>
> > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> > whether userfaultfd is allowed by unprivileged users.  When this is
> > set to zero, only privileged users (root user, or users with the
> > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> > syscalls.
>
> Please send along a full description of why you believe Linux needs
> this feature, for me to add to the changelog.  What is the benefit to
> our users?  How will it be used?
>
> etcetera.  As it was presented I'm seeing no justification for adding
> the patch!

Was there a v3 of this patch? I'd still really like to have this knob added. :)

Thanks!

-- 
Kees Cook
