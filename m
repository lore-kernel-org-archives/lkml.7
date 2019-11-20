Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05366208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKTTf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:35:27 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:35:26 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnWx3-1i5d7I1UTl-00jW2R for <linux-kernel@vger.kernel.org>; Wed, 20 Nov
 2019 20:35:25 +0100
Received: by mail-qv1-f51.google.com with SMTP id d3so381132qvs.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:35:25 -0800 (PST)
X-Gm-Message-State: APjAAAUU/mdAWK+CL9gIMtlS9tLJs1yEuv0r4MXIfevNECJmuV8VOrQq
        +4sP7tyzSteSURGB5GKoTseoa4Gjf4RhC1dfQMw=
X-Google-Smtp-Source: APXvYqwHVWU2Zw8xn9+Bv1356Zmszxab3TK1Pmn6hsvPWLI2rMNceeRYyQBX3HSMLK8D/gT8L6zA69sS3PvhoK8Z6J0=
X-Received: by 2002:ad4:50a4:: with SMTP id d4mr4074792qvq.211.1574278524246;
 Wed, 20 Nov 2019 11:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20191108203435.112759-1-arnd@arndb.de> <20191108203435.112759-4-arnd@arndb.de>
 <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
In-Reply-To: <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Nov 2019 20:35:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3BPhX_NRFj66WyRLQUOCV-FGRjmPCgB7gqxMoK8hfywg@mail.gmail.com>
Message-ID: <CAK8P3a3BPhX_NRFj66WyRLQUOCV-FGRjmPCgB7gqxMoK8hfywg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 3/8] powerpc: fix vdso32 for ppc64le
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:30KBopqabv3uotMIxEYqngrzt0Ck4jrEYYgPvK5NG/ZoYx7gIbm
 1yRmeMez6nymaFuiyoRXS2/nORduF5p6vPUkjtLa54rxqymNQyxKTZQvss/xKBoTiymK+MA
 B1b0urpCMKSHqIspfTQ/K8R4Bc3nsgBU437QyJaDgku4kSGbEhEKCicwjNyguFOd1indno+
 0HiDzSlHQoqqmD2pnRXhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9TUk0p3FXR4=:QvFvxbMS9Z+vkxL0gTUH/W
 eXIYdwwROxb/U7yaq4VdO5b6DHbzIzpcSek8VVi3R0GwD6jo+nwOv0AIABrj/rW2GL7sRHfXx
 Lkdr4WyhGPq/hG0TLaxS4Qt0xAaY98oEAulpcGuoHhMPLE//ADk+D4CCHlVYFwe9ypi/7KfDB
 c3XbqXAPIH8x4uIawQb6hENUXxMZO3uX8b00CsULTZykkw3ixfnvB20LYjKUHup4LGmovL/8Q
 u54nZHXZ1spcCbPrunKcN4rxlPbvtLxLQjnqOTW4thvdo4dcd1cD3YNigBFShAk1KHOv9tuah
 1875sT8yTJ/z33uPMd+Vr7agzSPUCaiKsfHi1U9FvXLykOfuxxo2/xYcx9lz6S34UU55Z4ka8
 BBdfr7Q8L5IkA39vKekyHEnIZUxckZupFvUpdu5BZDYMusPPtuJi74LB+Wch8HormUTABt514
 S7TKfF2p8Z6SU2+zTTpmtSBlQPR82lRhJveCWpVvUBaRL64/zlVAFU6qPFnNqknnTewxPsCWs
 owps2tVp+LSAq8dFzdA0kNTsPKgK3CrIuyJpqs8epWuepYsvnvtBaNTW8Njq4Mwglf523A/NP
 usoYMRZsQ5VJSNziP6BeZp6M38kP62otHppLSLr7Mj8pxjlDD3jX8HvAmRolX758qNpyPch0j
 MuZ5HZrPdULeCACTzIXmIrSdgaMHfo5tBKbQ3zhb17AbkqxBQqgsmX3UIzv7cAzwx7WzN2oJx
 jIgsH2PLLwZi62Etsb8uA1mjkzX7WblrzRLqWbD4S5UB4SZhxjIZfmA55lLZfk+9ulrJV+kVY
 ujts0YrcJInYcvU0gDUSzxAUWgx+L1NQk0uCmmR3fCgHvsGAD/glSWRgqGCmwGX04IFoRO9RM
 2KxZ9VBOVB/ZwfWj+koQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:13 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> > On little-endian 32-bit application running on 64-bit kernels,
> > the current vdso would read the wrong half of the xtime seconds
> > field. Change it to return the lower half like it does on
> > big-endian.
>
> ppc64le doesn't have 32-bit compat so this is only theoretical.

That is probably true. I only looked at the kernel, which today still
supports compat mode for ppc64le, but I saw the patches to disable
it, and I don't think anyone has even attempted building user space
for it.

       Arnd
