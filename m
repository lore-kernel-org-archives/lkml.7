Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09757C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14C820678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578559978;
	bh=XKqLCU7IGfaThm/vIQIF0wLKD9umZtyxjr/tdPmokWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=TTlQwEe8tkpOMie8Ycg7M+tFmPluns4LE1R8uzGKA8irSZlWsxbYUuXuPVgiITVa2
	 mzmsWzSUkLuYua1qmEnJlMlu030L51U/5h3kwNBNc2BDnQit/dkTGFBz9+q24dYDfo
	 zeUbVMJwXqB/uqaL5UCr9vCizAO5vDjJRm2puUz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgAIIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:52:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34605 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgAIIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:52:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so6366900ljg.1;
        Thu, 09 Jan 2020 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pa+VUcms1G+AHxJVPMm8WUTSFExJoXoBaf03mkKjAPQ=;
        b=i1OJEqeUqzz80wI9KuHtx8elrrKZEAg6QEAf/+T0NZiZV3NWOiB2mon6n2XW6eEN7c
         Dedv7mbW+bMXdVzSfa0mK8Pb3k3R7tlQ0z5Q59DkFla9Q7RagRS+IbwFPQDKtDr0CvGz
         CqZExJ/4oZadn96A4otTrDnPM445qXH/ayo9/lFqUghe8cUfiDnN5OzSOF9fFim8+sXO
         eSacaDVVVyWkE6btZ4PVXykxl9YXvZV+ZjmYByxEM28VEQlbInGZ5hTVhLPPeps8+M9E
         CGvxVesjFd69DjoVi5xbVJ4vbT643PH0Gc6Sl4fUrMLprbbD5rkh/jug5mJ6339LphLV
         DDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=pa+VUcms1G+AHxJVPMm8WUTSFExJoXoBaf03mkKjAPQ=;
        b=Kqj311kochfDC0yGFudbrgcFgchEQ5MDsK4Kx7ArVGgOFnuhHMLCulwpnv0YvnZj+q
         HhOW/GZoYRqn6ikPyO9McFPfotKARzmt7AFqzxac1aLhs4BQaQtrOMpJf5vjj8nMmDRd
         K0ym2M0j9DA1uUUZZki3sQ8GZq+PyGUE9fBZGPnDa62Kpazt4tHnAOHBd3/fqvhpRY0Z
         mNxbCaPEgOT7lpwLsoIOT6rgV8AW3oimAEd8opNm+Hs26QWrLz9gx0G9a6++/lybzDa1
         CLlzia9t3B8CtirBR/R7xsg+WqfJH2uReIksYg3wJhk/RphR/ixlpRcRGehL1141ORn9
         oDKg==
X-Gm-Message-State: APjAAAWgMqoguiV6BfOmrvjAxByXmA9DLbWFScizOTEqaRWdWFXr8sxY
        9meRhCBXcPBb20+/aJ9uHXsncPIK
X-Google-Smtp-Source: APXvYqzUJoCsI+xbEXodTQHbFziiCC+PJyVFaPj/trjiB8M+aEjN4sfGzdga/OrJGOYkPXLOHEJu9g==
X-Received: by 2002:a2e:9692:: with SMTP id q18mr5670714lji.177.1578559974763;
        Thu, 09 Jan 2020 00:52:54 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id w19sm2664474lfl.55.2020.01.09.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:52:53 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <greg@kroah.com>, Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in xhci_trb_virt_to_dma.part.24+0x1c/0x80
In-Reply-To: <20200103110451.GJ465886@lahna.fi.intel.com>
References: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de> <20180720095410.GA11904@kroah.com> <107dbdd1-4e45-836f-7f8f-85bc63374e4f@molgen.mpg.de> <30b069b5-63f6-dd9e-b323-668f06bff6cf@molgen.mpg.de> <20200103110451.GJ465886@lahna.fi.intel.com>
Date:   Thu, 09 Jan 2020 10:53:47 +0200
Message-ID: <875zhlt3hg.fsf@kernel.org>
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

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Thu, Jan 02, 2020 at 03:10:14PM +0100, Paul Menzel wrote:
>> Mika, as you fixed the other leak, any idea, how to continue from the
>> kmemleak log below?
>>=20
>> ```
>> unreferenced object 0xffff8c207a1e1408 (size 8):
>>   comm "systemd-udevd", pid 183, jiffies 4294667978 (age 752.292s)
>>   hex dump (first 8 bytes):
>>     34 01 05 00 00 00 00 00                          4.......
>>   backtrace:
>>     [<00000000aea7b46d>] xhci_mem_init+0xcfa/0xec0 [xhci_hcd]
>
> There are probably better ways for doing this but you can use objdump
> for example:
>
>   $ objdump -l --prefix-addresses -j .text --disassemble=3Dxhci_mem_init =
drivers/usb/host/xhci-hcd.ko
>
> then find the offset xhci_mem_init+0xcfa. It should show you the line
> numbers as well if you have compiled your kernel with debug info. This
> should be close to the line that allocated the memory that was leaked.

addr2line helps here. So does gdb (gdb vmlinux l *(xhci_mem_init+0xcfa))

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4W6hsACgkQzL64meEa
mQahAw//eVR5E4c0CZ9GI782MazL/BmWTpoHqKhbEONjRiqeFy8tdytMt7Ea4j1g
VTo/hWfLp7JIR7TY6DL1OYHBTjjM/vWG5NNI5qzXKAZJ8pAc/33IWlUnhrF35sks
DTsB0H0IJdwvqDgcNGBCSwufVbaHbk7M65fxkjcmLGiYUJ/YaZn5qIHi/5/4OHff
PGuZhV8fvrYMAUyfyVnlks3rN+545nW2yaiQfuVGZEK+QGupMTgGZMYh7ZfkMnAh
l/uWczDQKLAuIu/NvRin+nZWSIvc5JJn8DbIlI3Y8e8J0oHUSV2Icfkou6TW/c7J
YB7rIr74QOfS6PqG1xvLtCO1wv/JWsBpbdwUV8F0nrbYp7AupN1QKhVaYMBukESP
9KJTEYYjG0RdYVwE3SnjSiMJXGnIwt/s7bcZN7kbeHPFPE3DdIJ2yVCK22JeN7fp
scts2s15m+FWb+bsPO1wve5rci7L5uDrUpq45fnPqIE/W0r5ffUXdYnEyKuLbMoJ
/e61PNRLrXL2ptSsYq7eu4HybBlJzFBj8t9tMDdg4YAuChjVUD1YIvOIcBPCq4L3
MbLW3CbG8AjFDHpWWMFK/F010lvemVDMuSEJFF2afc5ZuHK4915Urve1gncWB0CF
OsJW0wA+3YafO8ULyn+BTUEc13SBJsFRIW90ojcQDRrDCXsdP6c=
=152o
-----END PGP SIGNATURE-----
--=-=-=--
