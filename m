Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC28FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C682064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405725AbfJPPqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:46:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404969AbfJPPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:46:37 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKlVQ-0005gA-Bo; Wed, 16 Oct 2019 15:46:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191016150119.154756-1-jannh@google.com>
Date:   Wed, 16 Oct 2019 17:46:31 +0200
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/2] binder: Don't modify VMA bounds in ->mmap handler
Cc:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>, <jannh@google.com>
Message-Id: <BXR2DIW8IZSX.16Y0Y9PLOTGTS@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 16, 2019 at 5:01 PM Jann Horn wrote:
> binder_mmap() tries to prevent the creation of overly big binder mappings
> by silently truncating the size of the VMA to 4MiB. However, this violate=
s
> the API contract of mmap(). If userspace attempts to create a large binde=
r
> VMA, and later attempts to unmap that VMA, it will call munmap() on a ran=
ge
> beyond the end of the VMA, which may have been allocated to another VMA i=
n
> the meantime. This can lead to userspace memory corruption.
>=20
> The following sequence of calls leads to a segfault without this commit:
>=20
> int main(void) {
>   int binder_fd =3D open("/dev/binder", O_RDWR);
>   if (binder_fd =3D=3D -1) err(1, "open binder");
>   void *binder_mapping =3D mmap(NULL, 0x800000UL, PROT_READ, MAP_SHARED,
>                               binder_fd, 0);
>   if (binder_mapping =3D=3D MAP_FAILED) err(1, "mmap binder");
>   void *data_mapping =3D mmap(NULL, 0x400000UL, PROT_READ|PROT_WRITE,
>                             MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>   if (data_mapping =3D=3D MAP_FAILED) err(1, "mmap data");
>   munmap(binder_mapping, 0x800000UL);
>   *(char*)data_mapping =3D 1;
>   return 0;
> }
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Hm, aerc kept crashing for me so I'm not sure whether or not prior
messages made it so sorry if this arrives multiple times.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
