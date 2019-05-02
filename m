Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC31C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719922081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEBFV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:21:29 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49254 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbfEBFV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:21:28 -0400
Received: from mr2.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x425LRuo022714
        for <linux-kernel@vger.kernel.org>; Thu, 2 May 2019 01:21:27 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x425LMLZ012938
        for <linux-kernel@vger.kernel.org>; Thu, 2 May 2019 01:21:27 -0400
Received: by mail-qk1-f199.google.com with SMTP id t63so1339917qkh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 22:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Rx+2vo/TQ6owQB261ooRLIT5wjP1j/4C+RPHBVgcfrM=;
        b=Se59xXEE/uKg4LUPY4GlxRbmkXh3AHlNu1cECfcEa7wTzeOfBt469hyWY+H3ImUWUu
         wClABfTaGs3yjCKPViXEBplFcxV2W6XS7HDK2n6+w97XR/waYII5bWxV9ZLHvatiL770
         dqv7eHvltVUS4PlokiOFj4lVBVe5UDZs7S8ebIvdIfuhpvgMdlDbooHNro78YkJojQ5v
         rhjpQYoYN6wIgIsvu2diC3r1C3eAIKxXuef/pkLh39ltF8lybyFZezwH6pHAMpTOG12c
         OqCgStURFyH251jgnx9YtIN8qdHKSp0RbylKtVjFHPI9ooXxm2SzxWcI8ZziCR8nXJOZ
         3hZw==
X-Gm-Message-State: APjAAAWbEq3/ztSCPaMtu5OoBJwFlpf/e13A6fbldhNJfMhGkxzL8z5s
        1vgXZ0MdjECr1nJdSDRlLqRXVxfSCeaXOmeakvizZ5BFpHMlKX59G/i8m1AoCuwai1ad9t0ftey
        9btkrhIM6e4t242Eye+AqyacBVPLg1n1/3Gk=
X-Received: by 2002:a37:a849:: with SMTP id r70mr1429444qke.315.1556774481833;
        Wed, 01 May 2019 22:21:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwLjpP4A6jqS3Zqp7sRPBxXNgbo11PiZnuIkaWlHlIKSOnrNhJ4RmhH2xvW9R+LAOL5QtoToA==
X-Received: by 2002:a37:a849:: with SMTP id r70mr1429435qke.315.1556774481608;
        Wed, 01 May 2019 22:21:21 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341:5952:f06b:5958:9b7c])
        by smtp.gmail.com with ESMTPSA id g206sm20904586qkb.75.2019.05.01.22.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 22:21:20 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernelnewbies@kernelnewbies.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org
Subject: Re: Page Allocation Failure and Page allocation stalls
In-Reply-To: <CACDBo57s_ZxmxjmRrCSwaqQzzO5r0SadzMhseeb9X0t0mOwJZA@mail.gmail.com>
References: <CACDBo57s_ZxmxjmRrCSwaqQzzO5r0SadzMhseeb9X0t0mOwJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1556774478_11736P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 May 2019 01:21:19 -0400
Message-ID: <11029.1556774479@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1556774478_11736P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 May 2019 04:56:05 +0530, Pankaj Suryawanshi said:

> Please help me to decode the error messages and reason for this errors.=


> =5B 3205.818891=5D HwBinder:1894_6: page allocation failure: order:7, m=
ode:0x14040c0(GFP_KERNEL=7C__GFP_COMP), nodemask=3D(null)

Order 7 - so it wants 2**7 contiguous pages.  128 4K pages.

> =5B 3205.967748=5D =5B<802186cc>=5D (__alloc_from_contiguous) from =5B<=
80218854>=5D (cma_allocator_alloc+0x44/0x4c)

And that 3205.nnn tells me the system has been running for almost an hour=
. Going
to be hard finding that much contiguous free memory.

Usually CMA is called right at boot to avoid this problem - why is this
triggering so late?

> =5B =A0671.925663=5D kworker/u8:13: page allocation stalls for 10090ms,=
 order:1, mode:0x15080c0(GFP_KERNEL_ACCOUNT=7C__GFP_ZERO), nodemask=3D(nu=
ll)

That's.... a *really* long stall.

> =5B =A0672.031702=5D =5B<8021e800>=5D (copy_process.part.5) from =5B<80=
2203b0>=5D (_do_fork+0xd0/0x464)
> =5B =A0672.039617=5D =A0r10:00000000 r9:00000000 r8:9d008400 r7:0000000=
0 r6:81216588 r5:9b62f840
> =5B =A0672.047441=5D =A0r4:00808111
> =5B =A0672.049972=5D =5B<802202e0>=5D (_do_fork) from =5B<802207a4>=5D =
(kernel_thread+0x38/0x40)
> =5B =A0672.057281=5D =A0r10:00000000 r9:81422554 r8:9d008400 r7:0000000=
0 r6:9d004500 r5:9b62f840
> =5B =A0672.065105=5D =A0r4:81216588
> =5B =A0672.067642=5D =5B<8022076c>=5D (kernel_thread) from =5B<802399b4=
>=5D (call_usermodehelper_exec_work+0x44/0xe0)

First possibility that comes to mind is that a usermodehelper got launche=
d, and
it then tried to fork with a very large active process image.  Do we have=
 any
clues what was going on?  Did a device get hotplugged?

--==_Exmh_1556774478_11736P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXMp+TQdmEQWDXROgAQJZqxAAnxreoU88EHeovAeSkoiTH8XPfW74dkjJ
YUtiENuZTAiZBz+nMedbFkKpbNYb0eZWoJ8DMZQKhJ4ausU1uXhFT5NKVOZySX8P
a4vnlAABdw4n2n3weAVGTx/Drvr0wHgrwhZAQRCKDwXmmnRn91RUsX5expYmHRIg
/h6zZU+CLp0fWQZzUEsstUpV3ExUc/+3/5Jd+/0e0gWtCuK0Sbl7iCnb9TrG6xLW
7repzilTRzOYrGg9wSpT+FpmHJUoWfhW8Dn02tT0fflVBOlrs9JeFZituXv2+Zos
7BSoo1QrTYH5l2tQmIqKvkP7DZvwK1tYPcNSzlkISPS6+WcV/pd4YF1E+sPKi1j/
t3k7pUR76UrQ/yGqnqQyzfHZSYjRDdpeA4G3NBymrwUe7kVvGiUeIdGJ43QhHFnp
4jBOcR1gmDMkML9sW17pJgYAT5LLrVEonBIEYkje8niIG4D2KJWVjaUryefON33K
6/GFJGXHpaeT9ZENYEnfjB6viGeMresPs6pky4m1+XgqjZ4DHc6Gpat0gNzEUHid
wez5Zt4HCSgtifjdycsEyg7Bd4fYkXih/5+5MKwo0djvFT/PeervNyV896+quAP3
rswghjdziQRts67CakcgNs2+7HGyBAobpJDmr1Be/aWN6bMndk8m8CxENv2yL95p
ZYh7SZH5Y28=
=GETR
-----END PGP SIGNATURE-----

--==_Exmh_1556774478_11736P--
