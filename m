Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A388C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E139020673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578560833;
	bh=7ijlsxO5qpHVbbD9AH/UiDDCD0d1uP1ULQl/KoHVbKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=NcKqPCXJRzPFwRZR+Pd+HhGJs/ueF+gvgDZaHMluwxPhoW49gtlWIfFQxn8crzc7R
	 mB3Zvj+5rdrp44ncVBmf1bS4TiqufapFfRRrYgrCP5f+ceHDHdhrvXSjMwU0PmLram
	 aPmPSyxgL8C1IyOf6THPuVWTTBNgcex01DDKwtrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgAIJHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:07:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39265 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgAIJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:07:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so6372172lja.6;
        Thu, 09 Jan 2020 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7ijlsxO5qpHVbbD9AH/UiDDCD0d1uP1ULQl/KoHVbKE=;
        b=mbvN23WkxkzyAeGFGMmksrguPrkbgtLRHlUSGLJ2rjr+Tfv+gTdV7LfXta4iNLkyOz
         rDHnPfyWQArKbuHLsWLGxOnNh0E/Cu0cHVqO5/AObYI8LiqD4bNTgqGGQKREJ/I3krAq
         puX04Kgpz6Fh3lyosjFj86UyRUvc04x/IL0EvkLfacRRb9NQZ3Fb/SSlUYwTOqETsIOY
         o799IFfe9cGY1lynomvjgLdZYkhm/TpUYB46wAgy2kFXcVXxgTEw0Q6/xLyVuQyAlYla
         Ba9BIJEdBBMOZr+7aLONbfSuv57BbbwQIuiaUi+YD27mlpdC/1aDgd9x4CKWHTJpEVuL
         VhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=7ijlsxO5qpHVbbD9AH/UiDDCD0d1uP1ULQl/KoHVbKE=;
        b=M8La2w3CzR0v5Dsl6X7mUA++JS2+lDJBxM0CPYkiYnnCTcRasR3Mtkc4zRYb2jmJ3y
         SV9M9q7o4avSC/48lIyS6ViXpKzgZ9iwDisGf6oqAJWCDiwwGn8Sz2lS13xolP4XozKK
         UPY8leyPcsMr6XCWYHfd/HqniaHBX7PaD5PwcWGynLuef1zzfufENOLrtSZZOzBlQX9J
         OIsxmVfkM6Zq6RSWvRpR7fiXcaboNGikR0ed8mQQhX9IfkogkUKgEiE8cjfRPO+/YiW2
         LoZRxPSC0fl8c/8esqccuzYW5Pwo1FvsUWqrtCrT/DsM5nLIVpT6pFANr+14wqZXoVe3
         jqoQ==
X-Gm-Message-State: APjAAAWsAyrC6uHvu83+2UmW1tJKcI48ysjyIHPDQ3fEbwL1aT0rXakd
        hovbvkTe9iJ6OewdCfLPwihRPcXcq6I=
X-Google-Smtp-Source: APXvYqzjxyoI8lpPmUnidfRlJULNwJVBfodIWtKVM612k4LVbYMzVcl7WPlOIz/LFzq71vTKGKgbGw==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr5878891ljj.148.1578560827442;
        Thu, 09 Jan 2020 01:07:07 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id w17sm2691756lfn.22.2020.01.09.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:07:06 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: use proper initializers for property entries
In-Reply-To: <f2f41b28-2ca5-7fad-5b19-2ad51c689e5a@samsung.com>
References: <20191213174623.GA20267@dtor-ws> <CGME20191215164117eucas1p159471bd0b90b76b6ff64f26f17a6580e@eucas1p1.samsung.com> <2a8a5e6b-9372-978e-03d0-350ab65a2d0a@redhat.com> <f2f41b28-2ca5-7fad-5b19-2ad51c689e5a@samsung.com>
Date:   Thu, 09 Jan 2020 11:08:00 +0200
Message-ID: <87tv55ro9b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hi All,
>
> On 15.12.2019 17:41, Hans de Goede wrote:
>> Hi,
>>
>> On 13-12-2019 18:46, Dmitry Torokhov wrote:
>>> We should not be reaching into property entries and initialize them by
>>> hand, but rather use proper initializer macros. This way we can alter
>>> internal representation of property entries with no visible changes to
>>> their users.
>>>
>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>>
>>> It would be good if this could go through Rafael's tree as it is needed
>>> for the rest of my software_node/property_entry rework patch series
>>> which I would love not to delay till 5.6.
>>
>> Patch looks good to me:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>
> This patch is instantly needed as the issue it fixes is again triggered=20
> in current (20200107) linux-next by commit e6bff4665c59 "software node:=20
> replace is_array with is_inline".
>
> Felipe: could You ack it, so it could be merged via Rafael's tree=20
> together with related device property changes?

Here you go:

Acked-by: Felipe Balbi <balbi@kernel.org>

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4W7XAACgkQzL64meEa
mQZvdhAAsehbAbHtoUuojeSDyiU+fSa02kFNFXtBkJFnvQED6w3Z9z0aNs4hyUnT
jQQB9AI84fnR6u8c1XbuMSaQbpfdlzynqfUqEvVTgAizKsyQu4+I10E1/DM6Axhx
1o79WwM31uQbp96+C4BdJGLeSmgKMZLezYY+Sh63DwbTPH4oUg0VNUgVVA4wSD4r
nz8XZ3dRDjD/neCMqAJh1ILGh9RDMle+LRBRzgNCeDlRIilkRq0WpyNev1aNvc7Q
DxvS4AUt1vI0CNsLj4aatjUOaLaMsVRXX1Yszn8sG7EotSxMrqzxBFDQJKAuyYkI
lsL9uDA+daI173P26eELf0rCrsv0E7FGCefW2qKMNr1SD7rx7Bz/5ZiC34xLKKab
IHf/2B6al5psi/eqmGa1Sby0noY+kfPMZYLsPOjlahl7HPz1Ecq2L20DHI3uqsfs
sRBiz6oGKsvbQ5ht2vG7aKG1MIunklhUj/gpVxyA8A2ax7PMC4/ytXFL/qImMeTI
dRBXgiGWG4G4z1aeuJ0xMe5PMLQ62xwLe5orhsQx+Z/D8vgKyKfFGHV4bK7E5aU/
If0dW7VWGfo83ZmnzcXzCmfdr8f3vwNO5kuV3ChEJWNMFHXa2Yl/zLKAbMjOR3Gv
nn5wrZ3Hlsv788ebZgai13E3LwkO98HuFyhtEsNlhdW1axqbx9Y=
=m1L8
-----END PGP SIGNATURE-----
--=-=-=--
