Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F5C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8324648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUA+lKNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfLEHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:45:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33258 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726059AbfLEHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575531918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLzWEpcaGa6wr1EPFEAf/c8lYv/KcVaU9tGJq04LnjA=;
        b=EUA+lKNkIagWML+M0hHUB3cfhQ0vd6hy9uz2fCrGrDv3u3FtkAx90OaYVoqsif8VGhfWKj
        ysIJKaRGJbhAAYbM51v5djcWVnMFaVM6iFBxkh+szMg27W5po73r8SFpcbQ9L+rlvY3Xld
        iH2/Teqw7zSKHPXfnYzvjFaP9Wolekw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Iccz3oRfN4WrtdVh7VYCZg-1; Thu, 05 Dec 2019 02:45:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id b2so1155489wrj.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SLzWEpcaGa6wr1EPFEAf/c8lYv/KcVaU9tGJq04LnjA=;
        b=r1KCHL/A8gxeKgXXE8tS171GncmY6QqRNmmNFgEONF0MwkIQE3qWFxY48EAsV15snV
         mzTN5ox5ITeogSaTLFz/lYjYA20XlzDflX8v1KPvaL83BPFIiOUpo+M1l1B0SVhQR0Uh
         2A5fSrQo9Ndkz2nzpQImxjWq3HlFf4j5ShrIIrxqZ0njcVYFDOmbQbbSNQ1k94ejhQE9
         NtXt3RaSJJ9YMgrXwfDX581wqV1TkpRIiVRDEVb8Hz7/AGOXgeDswyiWZ0bxvceCYYx7
         aTEoKugHf2T9iNc/ubojzBuAJfXkhOmBRPTpXqoa1VXAif5BF0sHr+e2Wzf5lEzY9s+b
         Z9kQ==
X-Gm-Message-State: APjAAAV+6FwGIiQZ0kwLbOIis0g+Rhb/zQKXMTpth3dNQJxiUNvOVYFn
        /vt0akBJUeC6THiSS8glMM8g47YNhqIczjyJZqcbxyWwLrWKlq6yd7v30cVYdGzJI6+7+NCOQGQ
        XPy+mcaONtK0wZKRCOq8GzSw2
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3499786wmc.81.1575531916746;
        Wed, 04 Dec 2019 23:45:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyblt0LQhJu2lbPkXSi/NOLkFJ0Nhe+YL7hP+cdrXAjP0Xv03YzI+OOYAz1OuW7MJuzWvri9A==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3499774wmc.81.1575531916543;
        Wed, 04 Dec 2019 23:45:16 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6028.dip0.t-ipconnect.de. [91.12.96.40])
        by smtp.gmail.com with ESMTPSA id t5sm11346030wrr.35.2019.12.04.23.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 23:45:16 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc/pseries/cmm: fix wrong managed page count when migrating between zones
Date:   Thu, 5 Dec 2019 08:45:15 +0100
Message-Id: <478F1889-B2F7-4866-80E6-0128EBDAEA86@redhat.com>
References: <87h82feau2.fsf@mpe.ellerman.id.au>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arun KS <arunks@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <87h82feau2.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: Iccz3oRfN4WrtdVh7VYCZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 05.12.2019 um 03:59 schrieb Michael Ellerman <mpe@ellerman.id.au>:
>=20
> =EF=BB=BFDavid Hildenbrand <david@redhat.com> writes:
>> Forgot to rename the subject to
>>=20
>> "powerpc/pseries/cmm: fix managed page counts when migrating pages
>> between zones"
>>=20
>> If I don't have to resend, would be great if that could be adjusted when
>> applying.
>=20
> I can do that.
>=20
> I'm inclined to wait until the virtio_balloon.c change is committed, in
> case there's any changes to it during review, and so we can refer to
> it's SHA in the change log of this commit.
>=20
> Do you want to ping me when that happens?

Sounds like a good idea, we have time until 5.5. I=E2=80=98ll ping/resend.

Cheers!

>=20
> cheers
>=20

