Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3612EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073902184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A04py3Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCNPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:23:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46799 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfCNPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:23:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id a132so3085448lfa.13;
        Thu, 14 Mar 2019 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TO12yM7WufkWFhciODab08c+uIiLHgK9xAYUtoPnjg=;
        b=A04py3QhidUEtRAHxPxTRn/F0L8fiHLfTcI3ptvIahJ4eXSUgKDbbwXsW91oGBQsfF
         S08CxrQDGCZasd03tij9Z3xNLDPJq3NpBSbEXuXr1bOTloe1Vfr1F/N8GNB1ZztJFcI6
         2Jwv7i5eR5SHT7+T2ToYx6LSfA7+20TDZL1usrloJSIhi/tkSKCN4uRmDIN7XWyxwn4F
         GrKafH9Ov6adDQ5sqRFjDIyx2w4EJ+eRFiSXwoeJi+yy7x0UgHF6UNGuR3Xf4AUNYOed
         2e0b982fIq3+EdGb3RynlzXo5hqDeuWVdGBZWVXhdZZsz8Y+Nin+76LA+ON3wpr1kHDi
         8D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TO12yM7WufkWFhciODab08c+uIiLHgK9xAYUtoPnjg=;
        b=mZyqy/tOIr8rpEbesk9OqUS5E8PsAU8OcPDki7aZaZVvajgl6+c0oPIF0IkXanmYxq
         lXDUxCIoVNPau3G5nRC6jr/Wn+wk3T9fjz5NzAIuMXIvj2UtQi+cHg6jOSIVTqYy/3vO
         EWDhjjyeEUefl6lu/B4g2nXW1xQODaSySFuCxkhGPzVy0OxF5q/almz85svJjxc0GOFH
         6eSmnvVBsff7DRg5yV5RPETcIMFsx4QSJL0ryuYd6YiCKnL3w4qjKto/6lHxo2gPMNej
         nu6vUUyjiREy79S6v0I1HT7rAPu5FGdTP/k2GUsAg2cbYQ4+UWeTYBvhnMb/Od2Qu6xa
         Wl+g==
X-Gm-Message-State: APjAAAXF8fcrB1maibkz+PhCtLi+NiSdVUaWp7NRpBvsNol6lpgQobLe
        0jA/4+ybSH/WCkGZvkD6/56KW76kQmaLOw3FXd8=
X-Google-Smtp-Source: APXvYqzRC8LBbbd9Z4o3g/WcEnkmCwELLtyDuivnnwdj+alwtyYDSvB1rYiuEwroOTFRphbRB16BnPKtUiqnNqtLyWU=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr8059614lfl.129.1552577005440;
 Thu, 14 Mar 2019 08:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093701.15734-1-peterx@redhat.com> <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1> <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
 <20190313185230.GH25147@redhat.com> <1934896481.7779933.1552504348591.JavaMail.zimbra@redhat.com>
 <20190313234458.GJ25147@redhat.com> <298b9469-abd2-b02b-5c71-529b8976a46c@redhat.com>
In-Reply-To: <298b9469-abd2-b02b-5c71-529b8976a46c@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Mar 2019 08:23:13 -0700
Message-ID: <CAADnVQLakteNHnoUZpOTVNK-ysbmqCRbPDM2XMgM9pWB-mGjhQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 4:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/03/19 00:44, Andrea Arcangeli wrote:
> > Then I thought we can add a tristate so an open of /dev/kvm would also
> > allow the syscall to make things more user friendly because
> > unprivileged containers ideally should have writable mounts done with
> > nodev and no matter the privilege they shouldn't ever get an hold on
> > the KVM driver (and those who do, like kubevirt, will then just work).
>
> I wouldn't even bother with the KVM special case.  Containers can use
> seccomp if they want a fine-grained policy.
>
> (Actually I wouldn't bother with the knob at all; the attack surface of
> userfaultfd is infinitesimal compared to the BPF JIT...).

please name _one_ BPF JIT bug that affected unprivileged user space.
