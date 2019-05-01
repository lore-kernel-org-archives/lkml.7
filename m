Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D2C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAC21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="TWaYcp2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEAGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:19:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37179 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEAGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:19:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so14235316edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 23:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=J2GbjoVmtwdXiYx5nvezdqJXizMyOlByYB4RHuyWMxU=;
        b=TWaYcp2MSY0Je+/PUW5FSyOx0PoX21CdXFT8znC8V1NJ6Kaclws658QLbGY5B0TnkO
         CIF/gzY7R3GfopKDxMDhZ1TFI5EdoRzmvDZ3h8Gzofw/aLkNOtVo9yfPnB/+iaRJu0Uq
         iAeVJDzfqr8S7HqJiAqQx/BciJxJkhSH63YhovtBQProN+XdEuLAfCGx/jdAfTBJQ82O
         uk83kbXHdvtviFenosJJctKFbRXScjKUdD6a+ju7PllvxJMTVp6ftoJuGiRzWoElvXlr
         Dtoh1pe26TY2JV7nJPqSzaMPcXfywqoCGd+2EookQdsSQvaJs1zl8EBZ16fO4QF06ujb
         HDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=J2GbjoVmtwdXiYx5nvezdqJXizMyOlByYB4RHuyWMxU=;
        b=kU9SqEu5V1BmZPFpphuGaB0AzdCFS9Avz+O9Pd+tLsFcOQqw+m+L8i1xtAyAr6hFYT
         hLpDP31L+/WYCDo+W0Ley6WqAoXYNPqcSlwqRcbLhw3U7pZBKkuz91ImG5s2zEHoypBZ
         5IugbEIEHLva9g/17zqeEPwCbSv1oHZzJVG6uPRd5eMjMTfdsV+Q/hLoNLlB5Gl6Wzux
         HUtAxH3B+cKWOBUx6djiMLsuLaRjpBwhRJDN0jZAsg2ry17IQTZ/hyig06RiBUA6Hsad
         Y83JdT5an5wnOb8oScMekT+gzVUiN7tQ9PPsGu3WBo36qpD7jDS2/sVZBfcpz/1ysLlc
         Fp0A==
X-Gm-Message-State: APjAAAXfct5UEV58WIT78fTQLmWuQXZCMzAgGz8sDVBxUe0NgdPDALDD
        eRsEhpCc5gpcJxLJvoHCXPAcvw==
X-Google-Smtp-Source: APXvYqzRLQvqTcZuzGRazPZen0n7hVK6DIh17TgZhBoyAJu7LAf1EPaQvg9INE3lvIk0jhjl5xmZ9w==
X-Received: by 2002:a17:906:bce2:: with SMTP id op2mr27567623ejb.105.1556691558195;
        Tue, 30 Apr 2019 23:19:18 -0700 (PDT)
Received: from [192.168.1.143] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id ay12sm6692373ejb.15.2019.04.30.23.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 23:19:17 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EEB51DDD-815D-4F0D-B860-9CF26CC161C0";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Wed, 1 May 2019 08:19:16 +0200
In-Reply-To: <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190425052152.6571-1-hlitz@ucsc.edu>
 <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
 <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
 <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_EEB51DDD-815D-4F0D-B860-9CF26CC161C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Apr 2019, at 18.23, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Nice catch Igor, I hadn't thought of that.
>=20
> Nevertheless, here is what I think: In the absence of a flush we don't
> need to enforce ordering so we don't care about recovering the older
> gc'ed write. If we completed a flush after the user write, we should
> have already invalidated the gc mapping and hence will not recover it.
> Let me know if I am missing something.

I think that this problem is orthogonal to a flush on the user path. For =
example

   - Write to LBA0 + completion to host
   - [=E2=80=A6]
   - GC LBA0
   - Write to LBA0 + completion to host
   - fsync() + completion
   - Power Failure

When we power up and do recovery in the current implementation, you
might get the old LBA0 mapped correctly in the L2P table.

If we enforce ID ordering for GC lines this problem goes away as we can
continue ordering lines based on ID and then recovering sequentially.

Thoughts?

Thanks,
Javier

>=20
> On Fri, Apr 26, 2019 at 6:46 AM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>> On 26.04.2019 12:04, Javier Gonz=C3=A1lez wrote:
>>>> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>>=20
>>>> On 25.04.2019 07:21, Heiner Litz wrote:
>>>>> Introduce the capability to manage multiple open lines. Maintain =
one line
>>>>> for user writes (hot) and a second line for gc writes (cold). As =
user and
>>>>> gc writes still utilize a shared ring buffer, in rare cases a =
multi-sector
>>>>> write will contain both gc and user data. This is acceptable, as =
on a
>>>>> tested SSD with minimum write size of 64KB, less than 1% of all =
writes
>>>>> contain both hot and cold sectors.
>>>>=20
>>>> Hi Heiner
>>>>=20
>>>> Generally I really like this changes, I was thinking about sth =
similar since a while, so it is very good to see that patch.
>>>>=20
>>>> I have a one question related to this patch, since it is not very =
clear for me - how you ensure the data integrity in following scenarios:
>>>> -we have open line X for user data and line Y for GC
>>>> -GC writes LBA=3DN to line Y
>>>> -user writes LBA=3DN to line X
>>>> -we have power failure when both line X and Y were not written =
completely
>>>> -during pblk creation we are executing OOB metadata recovery
>>>> And here is the question, how we distinguish whether LBA=3DN from =
line Y or LBA=3DN from line X is the valid one?
>>>> Line X and Y might have seq_id either descending or ascending - =
this would create two possible scenarios too.
>>>>=20
>>>> Thanks
>>>> Igor
>>>=20
>>> You are right, I think this is possible in the current =
implementation.
>>>=20
>>> We need an extra constrain so that we only GC lines above the GC =
line
>>> ID. This way, when we order lines on recovery, we can guarantee
>>> consistency. This means potentially that we would need several open
>>> lines for GC to avoid padding in case this constrain forces to =
choose a
>>> line with an ID higher than the GC line ID.
>>>=20
>>> What do you think?
>>=20
>> I'm not sure yet about your approach, I need to think and analyze =
this a
>> little more.
>>=20
>> I also believe that probably we need to ensure that current user data
>> line seq_id is always above the current GC line seq_id or sth like =
that.
>> We cannot also then GC any data from the lines which are still open, =
but
>> I believe that this is a case even right now.
>>=20
>>> Thanks,
>>> Javier

--Apple-Mail=_EEB51DDD-815D-4F0D-B860-9CF26CC161C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzJOmQACgkQPEYBfS0l
eOBA4hAAiRSOXP86jGznEHGGrCEGEICJ1zwc7E39Cfwsl3auRIQbWYu60hdlcZ76
JX91Wou+qTI7veRa9v9+5FMb6b5rc6O9wa2WTfD1HTnonrI7EfeDJeTGerAY7McA
8RP/EU9T19Z4CQwSxgSbPbdCAGUXcStVNkanfLJd3sv/Wb92sOsS9RVmf7FViO6U
8C0CiKAEB6YeQdtrBC8DHyYelMcEWnaT4Vm8nHmpOuUYqjWMPlAw7XEBlbRYnBxW
YKEog6Vc3247SrMfpEbAAaJQ+UpsgVta7180qf2y0lLYDdP/RXS7OAYUw5mbr5VC
5DvR+HH0I8kLET+0cNSb9UndHDglvvLrFBEL2MwpuuLSoc4TC10AJnrJfzD8egT8
u7ddk0zOzBHmxXfQlnS096VgVQl4ZQf9Eb0bxEWgR/txSCSWuLMUv2Zk9nV8qyEe
wibkxG45lqVVYsO7qUL1b/aguL6zmphysa/2jIivhVKfo6VEYDPdC9R52CdVyyv2
CIba8q3ztL4EqSIfSrYIo0C73ZykE/zutB6sgEp3IQCtszfC2XatT22WMXk8DXpp
jzjx0hMMtfBsuvNfzqgKOt1mze9wkXMHZuhLV+5vDrplJjtQSbcg9Qw9gYY8ON8Z
Lbu/QVU+4uqy6Q8jANE+wWXHbsRkyuOErTZ8AE3QZspVNf2lM2s=
=NvIC
-----END PGP SIGNATURE-----

--Apple-Mail=_EEB51DDD-815D-4F0D-B860-9CF26CC161C0--
