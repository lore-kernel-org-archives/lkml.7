Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE35C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B462075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575154123;
	bh=PajkUHGTsIy7Xbudo3QuQfdxSMNiov1zEcimXthc9yQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dCBeZJbGkNZutZZLO4IQGWV/A9WyNKoCd7DZYUwJKhoAgs/AO4GnxkV7CNt6h0KI/
	 gF0WFo2nqddM8nQHLX2wxHllZ0kjeQwn97v+8Gj3sXhX3rqOd40EdesyaqXPRGKwgk
	 zjAhIlhUapVzsv0/uiLyAqSR06QF6eGoHo0FeDVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfK3WsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:48:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43678 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3WsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:48:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id l14so25134413lfh.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM1WaVRIUGvnQSzfAPiF4yttMdQv5XqK5t8psrz81pM=;
        b=HVYZEgMZkuP4zDHaNbbobY2Dz+xMbjfGWVrxpFaPaoOTTjncL6tHFib/8GEOBxPSuE
         bobVXDofhHspX5FipXsGJeCSgZOh3vVC1d+VZx3MOUIoHrkLzDvgFtBDLiqPgabxkxcs
         jH9TUg0Xn8mfAS8wZ5/5Psk8+LFvcFuRpB8sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM1WaVRIUGvnQSzfAPiF4yttMdQv5XqK5t8psrz81pM=;
        b=F4WcLUx8NaicvZIsoDbWzA3om2miZdF95AJ+hmHly1LfjTA0pKde76c/4ydbqDhA5C
         MdhlHhb6thI8K8Me5/SrNnawQqymvNNJLksY9ggzM9+nB3w/FiycmI2kYnhVyp/6P7NO
         vVFbArd38dT2LBKo4u95Vqg8MsrbYoJOM6bP1HH04VThnwqGBb0w65hETdVymEC1ywJ4
         jnKRL7DULqtbBDuwtLGOYjlmAYI6idhZdxjDeBh4ckuVPcpxWsmCf/3svPKpiLc8soYT
         C1TopU/2WeH3tE4ZVZ9HhkI+CvTRcFJIjP+8sptcu2j0uzrPrQ6fWQLL0GVMkDeN212x
         rSxQ==
X-Gm-Message-State: APjAAAWNlSRPoz6LVSKrmalR0pcLH0bKjObCe0VIBMLqy+7zNTz/rsP2
        0V0FxXSgNPjAZ/2VmWODSd3i9DOZPt0=
X-Google-Smtp-Source: APXvYqyZzUYNCzRHMUccU32/3nPRca1x5J8vw4L68AruDseECi/PZESEX17QhU+tMai7hCwx+iFFlA==
X-Received: by 2002:ac2:4a61:: with SMTP id q1mr29982023lfp.36.1575154100168;
        Sat, 30 Nov 2019 14:48:20 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a18sm12360827ljp.33.2019.11.30.14.48.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 14:48:19 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 203so25120393lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:48:19 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr39043729lfn.106.1575153781845;
 Sat, 30 Nov 2019 14:43:01 -0800 (PST)
MIME-Version: 1.0
References: <877e3hfxyq.fsf@mpe.ellerman.id.au>
In-Reply-To: <877e3hfxyq.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 14:42:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
Message-ID: <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     ajd@linux.ibm.com, alastair@d-silva.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        asteinhauser@google.com, Bjorn Helgaas <bhelgaas@google.com>,
        Qian Cai <cai@lca.pw>, chris.packham@alliedtelesis.co.nz,
        chris.smart@humanservices.gov.au,
        Christophe Leroy <christophe.leroy@c-s.fr>, clg@kaod.org,
        cmr@informatik.wtf, David Hildenbrand <david@redhat.com>,
        debmc@linux.vnet.ibm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        gwalbon@linux.ibm.com, harish@linux.ibm.com,
        hbathini@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        krzk@kernel.org, leonardo@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        madalin.bucur@nxp.com, Mathieu Malaterre <malat@debian.org>,
        msuchanek@suse.de, Nathan Chancellor <natechancellor@gmail.com>,
        nathanl@linux.ibm.com, Nayna Jain <nayna@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, oss@buserror.net,
        ravi.bangoria@linux.ibm.com, Russell Currey <ruscur@russell.cc>,
        sbobroff@linux.ibm.com, thuth@redhat.com, tyreld@linux.ibm.com,
        vaibhav@linux.ibm.com, valentin@longchamp.me, yanaijie@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Only tangentially related to the power parts ]

On Sat, Nov 30, 2019 at 2:41 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> There's some changes in security/integrity as part of the secure boot work. They
> were all either written by or acked/reviewed by Mimi.

  -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390)
  +#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
  + || defined(CONFIG_PPC_SECURE_BOOT)

This clearly should be its own CONFIG variable, and be generated by
having the different architectures just select it.

IOW, IMA should probably have a

   config IMA_SECURE_BOOT

and then s390 would just do the select unconditionally, while x86 and
ppc would do

  select IMA_SECURE_BOOT if EFI

and

  select IMA_SECURE_BOOT if PPC_SECURE_BOOT

respectively.

And then we wouldn't have random architectures adding random "me me me
tooo!!!" type code.

               Linus
