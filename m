Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83808C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E9A206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Fukoas/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436764AbfIJQL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:11:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38848 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:11:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id p9so4107785plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PCOjORMglX/qkee1zhY9yzG86fMrqn79cYKHDfbxgm4=;
        b=Fukoas/aiFXsXSqO9jiSNlaFKUU7FW8jY1D3OJSr6RQlfRgvud5eXId+jG5KC9n4HF
         AEHRodVgj88bP9FIyWIWhQfzTcXwkgUqO31wLB79JJcxopV4S3SLSegeJddKjj8ZynUD
         GLW0KsZITehr9NhvVRex3A+SBSLMKS9IKNQNvsHjuo4UmTMBiZHOTOgBRem8LPebVEmT
         KIAG/hk99dE0ajGpL6jGgZ2zfAK8nqnoi1/khkiYaJ/hUfXIdehEf/97L+CkB6lt+qmV
         PsGFQxVjInYHAd/j26L7J7i1DPLWWGwRGlWYovI409QnbQVA+XNEZOnsETzd7a3s9tId
         j/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PCOjORMglX/qkee1zhY9yzG86fMrqn79cYKHDfbxgm4=;
        b=WCW348PIHrNnuodNhS0V/swYhLFtHkHtu/8qSbPci3PoyxtoqLaqxKCAwSaW0KtER1
         6PQlCiTxUKAmBnnq60Vl707W/MMFUlQ39eakpULUwvYvSNzKBrcujVlBTfi/2RECJ3V9
         zD/hgaIl8a2SQSK2F+pWgl2j5FS9H5pO9AcvSAjsKfTaK1MCgiGDH34hM8kmN4xpAkFI
         E6/ukn41vp05EVm55RJr4HonSQxyIT4AIwfD5diocojT40HYh4YtCKYj1gqLr6VFHFah
         d4OrqeOOvlo9YnzBjeXQjDumUQjGXzedR9tKXr4WVNi+7Sm7Q4q9DESbIJQAfjSzA80l
         KNfQ==
X-Gm-Message-State: APjAAAVUafGfNwafWsnPV5H5ZM56HojAlazns5UUVCkokawncVkIvzY6
        /gxTXi86iWU0H3EqZ7C9Fl5UaQ==
X-Google-Smtp-Source: APXvYqy1hYECFs7BVtotklHHDYIL/TmJfAakj9Nzp+j1KyE062UY9TtvRBu0Or7XXizIQMjfK4wV5Q==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr27429815plb.136.1568131886488;
        Tue, 10 Sep 2019 09:11:26 -0700 (PDT)
Received: from ?IPv6:2600:1010:b019:c7e1:4181:8648:504c:5cf6? ([2600:1010:b019:c7e1:4181:8648:504c:5cf6])
        by smtp.gmail.com with ESMTPSA id x13sm19964075pfm.157.2019.09.10.09.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:11:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page encryption bit
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20190905152438.GA18286@infradead.org>
Date:   Tue, 10 Sep 2019 09:11:24 -0700
Cc:     =?utf-8?Q? "Thomas_Hellstr=C3=B6m_=28VMware=29" ?= 
        <thomas_os@shipmail.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
References: <20190905103541.4161-1-thomas_os@shipmail.org> <20190905103541.4161-2-thomas_os@shipmail.org> <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com> <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org> <20190905152438.GA18286@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 5, 2019, at 8:24 AM, Christoph Hellwig <hch@infradead.org> wrote:
>=20
>> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellstr=C3=B6m (VMware) w=
rote:
>>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>> Hi Thomas,
>>>=20
>>> Thanks for the second batch of patches!  These look much improved on all=

>>> fronts.
>>=20
>> Yes, although the TTM functionality isn't in yet. Hopefully we won't have=
 to
>> bother you with those though, since this assumes TTM will be using the dm=
a
>> API.
>=20
> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
> branch:
>=20
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mma=
p-improvements
>=20
> they should allow to fault dma api pages in the page fault handler.  But
> this is totally hot off the press and not actually tested for the last
> few patches.  Note that I've also included your two patches from this
> series to handle SEV.

I read that patch, and it seems like you=E2=80=99ve built in the assumption t=
hat all pages in the mapping use identical protection or, if not, that the s=
ame fake vma hack that TTM already has is used to fudge around it.  Could it=
 be reworked slightly to avoid this?

I wonder if it=E2=80=99s a mistake to put the encryption bits in vm_page_pro=
t at all.=
