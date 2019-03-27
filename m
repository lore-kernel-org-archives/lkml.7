Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD273C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718972082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="KObLylx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfC0F3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:29:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33678 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfC0F3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:29:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so539427pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=onJCl9JbHvAGDKE2nntWOowFWWdzQk48dF3hmrDvys8=;
        b=KObLylx+2ouYzD5oC/vd5zSi0s/at+b5t9Vc899hnndZuDda30qhb+5E03rubefc/1
         QbebhBz6rqc+KXWc8nUs13QhpotdWqgq4BPJP0Xpio7Ds2wH6mITBnLtI2opQFZZ6tNc
         BKzj89Xj2zskMokb7GLMh2lGRSIKNlnIab6VruaC8v5xZv4RVQQNF1bjcktvNagKTi1k
         E4ZbINMgEb+oa/2qMWM01IBVYN1RipFq7NDGemmItGOOSBzrOBCXDrMd67NzujoQSqz9
         EJs/UkFJ1r+iS9tBqc4auso3Hb6h6my56Nrcvx1VegN5zkBq+mS2qt2Q6rGa7Kia9QqB
         AL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=onJCl9JbHvAGDKE2nntWOowFWWdzQk48dF3hmrDvys8=;
        b=hOU9exTXzskiX85ibdDj/J1tjJ3G7vlW1FoDUvlTOTg4Pbyi8D6D1MlvpMAenr7Uu/
         YvB5719jvAGClfoLlOt+9gQEcy8miJWqTrpYGGF14H1rnfTuwtP+H0gBN8y7P6GwdL+t
         C9tMmAddZFi5vZf7yDTWJB0u1Mfm/T9H7eKuuosqsEG3a0GAzqgZAUtYI5beDD4j8sTP
         GgXpCX04XYp9g0RUBHSeTIrS8fUHsqA+QTiDTJu8AaSkaknESjdfic9m0Y8XrjDKCPUA
         PuugH6fi7Px9Pe3CsGb2x/lLZR57FhGlUhuMIIheTzJVh8D6amIzQPZnraz2AhJXLKSr
         Q2Pg==
X-Gm-Message-State: APjAAAXQGwgXtHfjtc//95DhOJ74rtfunqQ1/aodiyJnVtsXvC4JJp+i
        kBpvmC/Fe8lC0V5hXMrhsS74Aw==
X-Google-Smtp-Source: APXvYqziA1UyQTvdCl8fKaQgMJHaPeM48luw2LS39X5RqxSeetiK9LgqDBY99xrdfsF+DEnrwA//OA==
X-Received: by 2002:a63:d015:: with SMTP id z21mr31835257pgf.215.1553664583157;
        Tue, 26 Mar 2019 22:29:43 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c5c0:7bcb:4a38:a44a? ([2601:646:c200:1ef2:c5c0:7bcb:4a38:a44a])
        by smtp.gmail.com with ESMTPSA id i64sm30385333pfb.112.2019.03.26.22.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:29:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190327050615.GA548@kroah.com>
Date:   Tue, 26 Mar 2019 22:29:41 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com> <20190327003057.GA27311@kroah.com> <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com> <20190327050615.GA548@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2019, at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
>> On Tue, Mar 26, 2019 at 09:29:14PM -0700, Andy Lutomirski wrote:
>>> On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wro=
te:
>>>=20
>>>> On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
>>>> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
>>>> <matthewgarrett@google.com> wrote:
>>>>>=20
>>>>> From: Matthew Garrett <mjg59@google.com>
>>>>>=20
>>>>> debugfs has not been meaningfully audited in terms of ensuring that
>>>>> userland cannot trample over the kernel. At Greg's request, disable
>>>>> access to it entirely when the kernel is locked down. This is done at
>>>>> open() time rather than init time as the kernel lockdown status may be=

>>>>> made stricter at runtime.
>>>>=20
>>>> Ugh.  Some of those files are very useful.  Could this perhaps still
>>>> allow O_RDONLY if we're in INTEGRITY mode?
>>>=20
>>> Useful for what?  Debugging, sure, but for "normal operation", no kernel=

>>> functionality should ever require debugfs.  If it does, that's a bug and=

>>> should be fixed.
>>>=20
>>=20
>> I semi-regularly read files in debugfs to diagnose things, and I think
>> it would be good for this to work on distro kernels.
>=20
> Doing that for debugging is wonderful.  People who want this type of
> "lock down" are trading potential security for diagnositic ability.
>=20

I think you may be missing the point of splitting lockdown to separate integ=
rity and confidentiality.  Can you actually think of a case where *reading* a=
 debugfs file can take over a kernel?=
