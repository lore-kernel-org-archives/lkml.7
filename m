Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0051C2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="e5Kxa585"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfCHPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:10:30 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:36509 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfCHPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:10:29 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 10:10:26 EST
Received: from [129.217.43.37] (kalamos.cs.uni-dortmund.de [129.217.43.37])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.41) with ESMTPSA id x28FAKj7028039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Mar 2019 16:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1552057824;
        bh=NBw3osffrBFpz7BPKBjz7Q5gVgGuTrAK2EMXFlHjPZs=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=e5Kxa585d0eSimEik5VI0kEHF3mvAniev1+p91/931nvjkzUPYUcUAaL3gkOWSuWG
         ONn+dV0Vxgw/YmjV5SnBsd4OkC0xQQH7WaNJVSW7PU79woa8FMIel+kypf4WuVSF3e
         dx/IGIFtIco3OPZoz0v0lUoCmX6Nru/qsowsKID8=
Subject: Re: [PATCH] Abort file_remove_privs() for non-reg. files
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
 <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
 <20181208004944.GA2217@ZenIV.linux.org.uk>
 <20181210094722.GB29289@quack2.suse.cz>
 <cbdc8071-de76-bb0a-6890-15ef21023a70@tu-dortmund.de>
 <20181217082800.GA28270@quack2.suse.cz>
 <3273d690-488f-b13c-5988-f600c4f83192@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Message-ID: <85b502ee-d20e-d3c4-eb6e-cff40c079a8d@tu-dortmund.de>
Date:   Fri, 8 Mar 2019 16:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3273d690-488f-b13c-5988-f600c4f83192@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LkWpmHZwI4nDewicSWEVL2HvtrPvhaCSz"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkWpmHZwI4nDewicSWEVL2HvtrPvhaCSz
Content-Type: multipart/mixed; boundary="4nejmpwSAnVQfMgorXdbf4XDy74Hw4YLl";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Message-ID: <85b502ee-d20e-d3c4-eb6e-cff40c079a8d@tu-dortmund.de>
Subject: Re: [PATCH] Abort file_remove_privs() for non-reg. files
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
 <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
 <20181208004944.GA2217@ZenIV.linux.org.uk>
 <20181210094722.GB29289@quack2.suse.cz>
 <cbdc8071-de76-bb0a-6890-15ef21023a70@tu-dortmund.de>
 <20181217082800.GA28270@quack2.suse.cz>
 <3273d690-488f-b13c-5988-f600c4f83192@tu-dortmund.de>
In-Reply-To: <3273d690-488f-b13c-5988-f600c4f83192@tu-dortmund.de>

--4nejmpwSAnVQfMgorXdbf4XDy74Hw4YLl
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello Al,

Meanwhile, have you had the opportunity to review our patch?

Regards,
Alex

On 11.01.19 16:42, Alexander Lochmann wrote:
> Hello Al,
>=20
> Have you had the opportunity to review our patch?
>=20
> Cheers,
> Alex
>=20
> On 17.12.18 09:28, Jan Kara wrote:
>> On Fri 14-12-18 11:55:52, Alexander Lochmann wrote:
>>>
>>> file_remove_privs() might be called for non-regular files, e.g.
>>> blkdev inode. There is no reason to do its job on things
>>> like blkdev inodes, pipes, or cdevs. Hence, abort if
>>> file does not refer to a regular inode.
>>> The following stacktrace shows how to get there:
>>> 13: entry_SYSENTER_32:460
>>> 12: do_fast_syscall_32:410
>>> 11: _static_cpu_has:146
>>> 10: do_syscall_32_irqs_on:322
>>> 09: SyS_pwrite64:636
>>> 08: SYSC_pwrite64:650
>>> 07: fdput:38
>>> 06: vfs_write:560
>>> 05: __vfs_write:512
>>> 04: new_sync_write:500
>>> 03: blkdev_write_iter:1977
>>> 02: __generic_file_write_iter:2897
>>> 01: file_remove_privs:1818
>>> 00: inode_has_no_xattr:3163
>>>
>>> Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
>>> Spinczyk)
>>>
>>> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>=

>>> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
>>
>> The patch looks good to me. You can add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> 								Honza
>>
>>> ---
>>>  fs/inode.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/inode.c b/fs/inode.c
>>> index 35d2108d567c..682088190413 100644
>>> --- a/fs/inode.c
>>> +++ b/fs/inode.c
>>> @@ -1820,8 +1820,13 @@ int file_remove_privs(struct file *file)
>>>  	int kill;
>>>  	int error =3D 0;
>>>
>>> -	/* Fast path for nothing security related */
>>> -	if (IS_NOSEC(inode))
>>> +	/*
>>> +	 * Fast path for nothing security related.
>>> +	 * As well for non-regular files, e.g. blkdev inodes.
>>> +	 * For example, blkdev_write_iter() might get here
>>> +	 * trying to remove privs which it is not allowed to.
>>> +	 */
>>> +	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
>>>  		return 0;
>>>
>>>  	kill =3D dentry_needs_remove_privs(dentry);
>>> --=20
>>> 2.19.2
>>>
>>
>>
>>
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--4nejmpwSAnVQfMgorXdbf4XDy74Hw4YLl--

--LkWpmHZwI4nDewicSWEVL2HvtrPvhaCSz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAlyChdwACgkQWT7tBbw+
9v20txAAnCgmDp2zZ8igkgz+2VQW2Vk+Nobbt2ml3IzrrNQDAVwAoPgBwzZTNaQE
U+HAC82zgPzjqkuJldj9cXQP6yjpCfnUFrPBG75ff4CF2/t+KviFKFPDS369m2g2
alJsr9bdyPiD4f34HrSFepIqiZWEb23tlOEFmGvpp3sOCLjTK7oaadPMBusozHm4
QCPoreaKpceWt71+8sVMLOEgpWP6A699uevJTTYIvz2HOP73WCVzUsSFR6NwmmyW
f+i7jbTllz/798neM5xksE24NqSofMqO+mUtadrmku8mQ7YipOsuT0CkohA20ToX
unO9EdSJNs3v95bHk2aITB/1pT1rArghroFYiyIBFV1/7hYzOd+LOWq1xGXlWwpd
WWTWGhy+4pEyqCImd1byInahOd9i+hRnjBc4Hu+iiF/EnUQ8uzyGesPs92u2IEdm
x2ybM1/ZKxzF3AgRHo/zVaEcd9UtL92Uc1t3F80Sh3GQR5bHk7yQ/8X9A7Wzcfsm
a0YkXS/Ks8NLmQjXt7JLJ51L6UXT8XLlujosKlyU3L1zVLuE9j4wwWRYjmFCLxCG
ysoPgwe+AE+vuxuGJdEkaZ6p+eVMOBpxcFD0n1/MDZZM9HoUBk653tFZvLVmIndW
XBJzZtD5Jw2UeU5kDxzcr5ODKP3DKdnLM5ULNgNpaOHh4p7Bk3o=
=jAWp
-----END PGP SIGNATURE-----

--LkWpmHZwI4nDewicSWEVL2HvtrPvhaCSz--
