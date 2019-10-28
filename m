Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11BCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493AF217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="c+7MiJOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJ1Vcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:32:55 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:46110 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Vcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:32:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 60A11A8F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KK3pOkEL3AA5 for <linux-kernel@vger.kernel.org>;
        Mon, 28 Oct 2019 16:32:53 -0500 (CDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 240D1979
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 16:32:53 -0500 (CDT)
Received: by mail-yb1-f198.google.com with SMTP id e11so1808541ybr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uDrG/QB1ocWufg3nTBk8YzO1SgTVOLO8yEVFY7noWh8=;
        b=c+7MiJORtn3YKb0mSwFTeEdXKtUvilRAKh1VTFbPkjpMdl+mV5jBttjErVuEGc/++L
         9dtSRGlmYbeHgdugfIOqHAGoo+Fvx6HKJpKe42hIw1gcETN53H2G5T4x91xcMfbEYdxP
         nEZ6L8OBNzQyXgazjtC3z325Xx++ypQpvh1R3C+ioAulRptUTjZu1qG7CJkBZBONlSuv
         kUvqAp8VOvSQP9jAv4/SAEBjpXPODp6OlChhR5IBRA+29D6Z75qIdbHLOsPNxsm4USm2
         4RkcGEWIbdAg2yqA06Ti99bR9/ySmFsyftr01BcF2KhBp4OnH/LAgSp9OZLm8HLtWk9c
         LXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uDrG/QB1ocWufg3nTBk8YzO1SgTVOLO8yEVFY7noWh8=;
        b=HE8iWtapeIo5Bq3ZRc3o5X2oWW+8H4q1g4ESJzmQvc9UgzwfLdzYfCkQED3oZGqXel
         XlekyaTAumHOkd3RF+1kWtu8dCUnYWBDQEmFFFYXqZ5kQlpvUxwf7rEWFo4115BVhy2t
         Dq4fHl0qUL6LnRRSyKeCSRhHzeNvXxE1kDvHEueaPATFqo/luG6tVS24ww5uhO0jA/gA
         P4+/OmSF2lnwUAtMxEOnhyGpSec7S23m/+qWKFF48rOiEnW5Pti2PpDRTIxmZF+6ALqa
         LsJxFuY25TXiy/Q/dr8CC4Lbcv8cWTlVb9wjEehhbKr13mVTM+t0i+tYOfjbZXkA2yEA
         mHcw==
X-Gm-Message-State: APjAAAWaCmZhtS5FdCxBaYAZaJgvfTQ21V4VMx/o7ZZaxpthxXO5O5F9
        6rB00kFIcujSZJ8kcQzufxT5YYVCyoTrHPrm3CDq+8IbuIXFY6vMaZQCTMok2VBAFs3fpWbemId
        fB+5TgeDkiaRLxRxm6cXsS7MLokER
X-Received: by 2002:a25:6e86:: with SMTP id j128mr16049088ybc.456.1572298372542;
        Mon, 28 Oct 2019 14:32:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySBqBnJ6JLt6df17vvOfF0xSZaO8QeQoR74n0y49rqiBCzuspIHKzsSa1ZGSaIKuCPe3RtKw==
X-Received: by 2002:a25:6e86:: with SMTP id j128mr16049055ybc.456.1572298371957;
        Mon, 28 Oct 2019 14:32:51 -0700 (PDT)
Received: from [10.21.9.107] ([173.46.66.82])
        by smtp.gmail.com with ESMTPSA id 203sm6083714ywp.76.2019.10.28.14.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 14:32:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] acpi: fix potential race conditions bypassing checks
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <3605712.hsAW26GfSv@kreacher>
Date:   Mon, 28 Oct 2019 17:32:26 -0400
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AEC2592-C58F-4E27-9C12-0C6E92136F5C@umn.edu>
References: <20191028183114.15709-1-kjlu@umn.edu>
 <3605712.hsAW26GfSv@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 28, 2019, at 4:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
>=20
> On Monday, October 28, 2019 7:31:14 PM CET Kangjie Lu wrote:
>> "obj" is a local variable. Elements are deep-copied from external
>> package to obj and security-checked. The original code is
>> seemingly fine; however, compilers optimize the deep copies into
>> shallow copies, introducing potential race conditions. For
>> example, the checks for type and length may be bypassed.
>=20
> How exactly?
>=20
> What compiler(s) do such optimizations in this particular case?

Tested on LLVM. The deep copy is indeed optimized into a shallow copy at =
optimization level O2.


>=20
>> The fix tells compilers to not optimize the deep copy by inserting
>> "volatile".
>=20
> Have you actually analyzed the object code produced by the compiler =
with and
> without the volatile to determine whether or not it has an effect as =
expected
> on code generation?

Yes, with =E2=80=9Cvolatile", the deep copy is preserved, and =E2=80=9Cobj=
=E2=80=9D is created as a local variable.

>=20
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>> drivers/acpi/processor_throttling.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/acpi/processor_throttling.c =
b/drivers/acpi/processor_throttling.c
>> index 532a1ae3595a..6f4d86f8a9ce 100644
>> --- a/drivers/acpi/processor_throttling.c
>> +++ b/drivers/acpi/processor_throttling.c
>> @@ -413,7 +413,7 @@ static int =
acpi_processor_get_throttling_control(struct acpi_processor *pr)
>> 	acpi_status status =3D 0;
>> 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> 	union acpi_object *ptc =3D NULL;
>> -	union acpi_object obj =3D { 0 };
>> +	volatile union acpi_object obj =3D { 0 };
>> 	struct acpi_processor_throttling *throttling;
>>=20
>> 	status =3D acpi_evaluate_object(pr->handle, "_PTC", NULL, =
&buffer);
>>=20
>=20
>=20
>=20
>=20

