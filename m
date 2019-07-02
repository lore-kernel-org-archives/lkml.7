Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D8C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EFD21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S62756i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:46:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40465 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGBRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:46:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so28099972eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62xeVPs21E5ReOKr0PeNYmMpHFedVY8IfymEZkh+FCQ=;
        b=S62756i4kfBhwvThdrp/bluvzbNlIQhGr2N54PhVXSt+bW0Fi/DqOASwTjFn0iK8pH
         O4scfXJPkY3GXcYQW2rzoHqJyot3S894FWcAdSIEqZk4YStXK4NAY1qtHaa05VSYEVQw
         ypFocTubeKx4UpSHTcIfHAVwLY+DfTPdFB/QPPA/6io5p/bC36vp16JpzDFaICzTEYpn
         pUnjF49M/4lXBLlpaUm/pUbCp3kS/HQu191UUJFGzCeemFPZg40bEiZ5sElzpVhhBUto
         Ii0pKGfpV/f83Cx6GZSfpDb78rXAwFs7DvSh+JbVnTg2ezwdco08A8C/48egMrQr6M2O
         knkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62xeVPs21E5ReOKr0PeNYmMpHFedVY8IfymEZkh+FCQ=;
        b=CTcux4h5+YefOZyi+iCiMT9o2hXimCOuA+/ostzdme2XD85nDERe4u7qVQxPs4tBO7
         smtb0SefHW1uT/IRCXAyx7cY/rJ545+tKkfG4XDRzhE78zwWpaTAT6ZCyKAVmr77k5po
         iw/g7uYLqgMxeMQE7J6Ua/P0vtelodj0f8xmEqPYpgvh8ZWw+H07rYu9bG5kyPW7NF98
         JswlSh7okanqqyVLQha9MsK/Lb5HrSl1wJRZg4BnnKTtttqqQnS9LicHie+pQ6UijTLO
         GwSKSd1ZkHrD2URZeD4EU1dC9nxNdIXg46qUpfYFfRNvdWtRxsY+Y5Hbtrxiqw4osYiT
         R4gQ==
X-Gm-Message-State: APjAAAVPGf0vz8F09IPVEIVW0Hi0YLBdgp96K1a4fZzvSFxhO70qD9Gu
        1dsz7CdgE7lZ9p8RbJJcasdgM/D3sCoaKXV04bJl+ZLHMcw=
X-Google-Smtp-Source: APXvYqx5heTU3G2wcqJHU6kEnhITccuBT2in9TxF+0f1OMcZoamtL9MEX0jLGTQHsk/kPYuoYfPBgiTBJt5KlB/HUw8=
X-Received: by 2002:aa7:d845:: with SMTP id f5mr37202330eds.78.1562089587822;
 Tue, 02 Jul 2019 10:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
 <5D036843.2010607@intel.com> <CAOyeoRXr4gmbBPq1RsStoPguiZB8Jxod-irYd3Dm_AGVcQRGSQ@mail.gmail.com>
 <5D11E58B.1060306@intel.com>
In-Reply-To: <5D11E58B.1060306@intel.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Tue, 2 Jul 2019 10:46:16 -0700
Message-ID: <CAOyeoRUy6R0YzcMajRAhzss321p6G=LMrR63oPQCYFwaK6SMvA@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually I have another thing to discuss:
> probably we could consider to make this filter list white/black configurable
> from userspace. For example, userspace option: filter-list=white/black

Works for me. I'll include this in the next version.

> Probably we don't need this field to be passed from userspace?
>
> We could directly use AMD64_RAW_EVENTMASK_NB, which includes bit[35:32].
> Since those bits are reserved on Intel CPUs, have them as mask should be
> fine.
>
> Alternatively, we could add this event_mask field to struct kvm_pmu, and
> initalize
> it in the vendor specific intel_pmu_init or amd_pmu_init.
>
> Both options above look good to me.

Sounds good. I'll go with the first suggestion for now since it's
simpler. If other reviewers prefer the second I can implement that.

> For the fixed counter, we could add a bitmap flag to kvm_arch,
> indicating which counter is whitelist-ed based on the
> "eventsel+umask" value passed from userspace. This flag is
> updated when updating the whitelist-ed events to kvm.
> For example, if userspace gives "00+01" (INST_RETIRED_ANY),
> then we enable fixed counter0 in the flag.
>
> When reprogram_fixed_counter, we check the flag and return
> if the related counter isn't whitelisted.

Sounds good to me.

If you don't have any more comments I'll send out the next version
with all the requested changes.

Eric
