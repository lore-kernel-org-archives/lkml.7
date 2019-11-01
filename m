Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75905CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407122067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="MQLCFnGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKANQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:16:31 -0400
Received: from mx1.riseup.net ([198.252.153.129]:57026 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfKANQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:16:31 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 474N4T6P5nzFcJ6;
        Fri,  1 Nov 2019 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1572614189; bh=FgBE6xxqMnDh8R5p+eGsaBsU02MatiZtn1CIEGmCCdk=;
        h=To:References:From:Subject:Date:In-Reply-To:From;
        b=MQLCFnGxI+2Kcv9mQ8qKQCKYjkOtbQUe/E3W53TrWo/sa/YGOQXdlcBWTTMNCQlFW
         cf6kZdnPGUZ7WGY6Tyvsmt41tcUqVMFiZyTnJUGwvWd+wTUMRVnBJxgxJaGCs6+Srs
         PSTzTl/hhCzchvUks27Pi5q8ETFAPHErOx/T4XFE=
X-Riseup-User-ID: A77413114152033575A26406B4726DBADAD7B718E316A6CE1F36915C1855729C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 474N445NyFz8tVk;
        Fri,  1 Nov 2019 06:16:04 -0700 (PDT)
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
References: <20191101042706.2602-1-gabrielabittencourt00@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeida@riseup.net>
Autocrypt: addr=andrealmeida@riseup.net; keydata=
 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 mNGb
Subject: Re: [Lkcamp] [PATCH] drm/doc: Adding VKMS module description and use
 to "Testing and Validation"
Message-ID: <fa6b780f-a866-d092-4ff8-268ad602c524@riseup.net>
Date:   Fri, 1 Nov 2019 10:14:39 -0300
MIME-Version: 1.0
In-Reply-To: <20191101042706.2602-1-gabrielabittencourt00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriela!

On 11/1/19 1:27 AM, Gabriela Bittencourt wrote:
> Add a description on VKMS module and the cases in which it should be us=
ed.
> There's a brief explanation on how to set it and use it in a VM, along =
with
> an example of running an igt-test.
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
>
> ---
>
> Hi DRM-community,
> this is my first (of many, I hope)  patch in this subsystem. I hope to =
have
> a lot of learning (and fun :)) working with you guys.
> I'm starting by documenting the VKMS driver in "Userland interfaces", i=
f I
> have been inaccurate in my description or if I misunderstood some conce=
pt,
> please let me know.
Cool! It would be nice also to know if you have tested this patch and
checked the output .html file.
> ---
>  Documentation/gpu/drm-uapi.rst | 38 ++++++++++++++++++++++++++++++++++=

>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uap=
i.rst
> index 94f90521f58c..7d6c86b7af76 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,44 @@ run-tests.sh is a wrapper around piglit that will =
execute the tests matching
>  the -t options. A report in HTML format will be available in
>  ./results/html/index.html. Results can be compared with piglit.
> =20
> +Using VKMS to test DRM API
> +--------------------------
> +
> +VKMS is a software-only model of a KMS driver that is useful for testi=
ng
> +and for running compositors. VKMS aims to enable a virtual display wit=
hout
> +the need for a hardware display capability. These characteristics made=
 VKMS
> +a perfect tool for validating the DRM core behavior and also support t=
he
> +compositor developer. VKMS helps us to test DRM core function in a vir=
tual
> +machine, which makes it easy to test some of the core changes.
"test DRM core function" ... "test some of the core changes", maybe this
can be reworded to avoid repetition.
> +
> +To Validate changes in DRM API with VKMS, start setting the kernel. Th=
e
> +VKMS module is not enabled by defaut, so enable it in the menuconfig::=

> +
> +	$ make menuconfig
> +
Not sure if we need to teach people how to enable a module.
> +Compile the kernel with the VKMS enabled and install it in the target
> +machine. VKMS can be run in a Virtual Machine (QEMU, virtme or similar=
).
> +It's recommended the use of KVM with the minimum of 1GB of RAM and fou=
r
> +cores.
> +
> +It's possible to run the IGT-tests in a VM in two ways:
> +1. Use IGT inside a VM
> +2. Use IGT from the host machine and write the results in a shared dir=
ectory.
> +
> +As follow, there is an example of using a VM with a shared directory w=
ith
> +the host machine to run igt-tests. As example it's used virtme::
> +
> +	$ virtme-run --rwdir /path/for/shared_dir --kdir=3Dpath/for/kernel/di=
rectory --mods=3Dauto
> +
> +Run the igt-tests, as example it's ran the 'kms_flip' tests::
> +
> +	$ /path/for/igt-gpu-tools/scripts/run-tests.sh -p -s -t "kms_flip.*" =
-v
Should we run this command at the host or guest?
> +
> +In this example instead of build the igt_runner it's used Piglit

I'm feeling that there should be more commas in this sentence. How about
"In this example, instead of building igt_runner, Piglit is used"

> +(-p option); it's created html summary of the tests results and it's s=
aved
> +in the folder "igt-gpu-tools/results"; it's executed only the igt-test=
s
> +matching the -t option.
> +
>  Display CRC Support
>  -------------------
> =20
Thanks,
=C2=A0=C2=A0=C2=A0 Andr=C3=A9

