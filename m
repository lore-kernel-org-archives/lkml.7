Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF52206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrMT7Pcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfHAHkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:40:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36838 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbfHAHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:40:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so68363448ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2DnLeysC51Jmq+BwRcdvsefRXSYiI2YJl6s9A/zlto=;
        b=qrMT7PcgSqQaPkhDNxMbADKheyhBnSC+xpb7kKF54VBYkSMPossLqpaZCuNtF0lDMK
         qXMEZEB3PZU5mAOOK9m7rgG41ScrZQmYocuw/IlarqJeVGqi35sAmjysYfxFyzDpdwrE
         q0o1/fC76kq7sPI1X42ApVVwfrkAaLdqAWBgpE4pkfS5OjtTTBWyOF0eCL4MZjZx1E5O
         hL8RRxrqjhZmDoasT8A3YGGN8527eUUnk+H3CroOjZQa0hqO8N1YZkTAY116z0aFZIV/
         b8i6FslmwUzzoFlRmDqExDGN92AQOqj3haKzc3fHcFHkDuqot0ElZe4/3d+LWlRDtHx3
         44jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2DnLeysC51Jmq+BwRcdvsefRXSYiI2YJl6s9A/zlto=;
        b=kwRkST95e1HgicnlSh/CN/aA7K/TIQB8w1M1EkEDZUBVlZvWlmhDUoIhvoPUt4FIif
         hhxsxRcaI/z48j65/xvagSiTREYdWgzVJEDX6mkW8H4+FEO0mnc5EVeqgmpJhThBtPIb
         JhdrFonPcaPDrLAR9tAWspN8l6Bli8w7mqQ2g1t7wDj4aYJ06Et/Lre4bH2rGzJJmkXh
         AeKj13QBjCoT7XBGo5NLky0XQI84nZE9N76L2W7Hbgjr8IqfEvx0vTAhgwIGp6ZGV99j
         19+/FNuyUblIrZV6fLhChZe4Gj7LMNTyp/uPTDSCGmEVDkY16jBDfGo4lXREhcSCXJJB
         hhkw==
X-Gm-Message-State: APjAAAXK9l+U2uwiZvOh5TLR71jPTJQQSysLz4wiAL04DOLMULEw0wPk
        juqGDuIL+RLUOkVKA9KpWexG2oi8j9RjwHst7BpTWg==
X-Google-Smtp-Source: APXvYqzq0IJ9GtmcxYuyJWtDtzNwkmT4P2unALVLFpkxdrititI5GvPVtJgr09S2tzYu63OXgUbjTzql4hcILCNGdOk=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr63101245lji.115.1564645250122;
 Thu, 01 Aug 2019 00:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com> <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
In-Reply-To: <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Aug 2019 13:10:38 +0530
Message-ID: <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 at 11:51, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 4:58 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > To clarify a bit further - my thought was to support any type of trust
> > > source.
> >
> > That could be very well accomplished via Trusted Keys abstraction
> > framework [1]. A trust source just need to implement following APIs:
> >
> > struct trusted_key_ops ts_trusted_key_ops = {
> >        .migratable = 0, /* non-migratable */
> >        .init = init_ts_trusted,
> >        .seal = ts_key_seal,
> >        .unseal = ts_key_unseal,
> >        .get_random = ts_get_random,
> >        .cleanup = cleanup_ts_trusted,
> > };
>
> Which is basically the same as implementing a new keytype in the
> kernel; abstraction is not raised in any considerable manner this way?
>

It doesn't create a new keytype. There is only single keytype:
"trusted" which could be implemented via one of the trust source
available in the system like TPM, TEE etc.

> I chose the userspace plugin due to this, you can use userspace aids
> to provide any type of service. Use the crypto library you desire to
> do the magic you want.

Here TEE isn't similar to a user-space crypto library. In our case TEE
is based on ARM TrustZone which only allows TEE communications to be
initiated from privileged mode. So why would you like to route
communications via user-mode (which is less secure) when we have
standardised TEE interface available in kernel?

>
>
> > > With the
> > > user mode helper in between anyone can easily add their own thing in
> > > there.
> >
> > Isn't actual purpose to have trusted keys is to protect user-space
> > from access to kernel keys in plain format? Doesn't user mode helper
> > defeat that purpose in one way or another?
>
> Not really. CPU is in the user mode while running the code, but the
> code or the secure keydata being is not available to the 'normal'
> userspace. It's like microkernel service/driver this way. The usermode
> driver is part of the kernel image and it runs on top of a invisible
> rootfs.
>

Can you elaborate here with an example regarding how this user-mode
helper will securely communicate with a hardware based trust source
with other user-space processes denied access to that trust source?

-Sumit

>
> --
> Janne
