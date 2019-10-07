Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B142084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDl+GYCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJGIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:50:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727306AbfJGIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570438232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ej/PWbHITWnqSA/Ufk3jQXz4f2f3Wl/p3PkSHByTCFI=;
        b=YDl+GYCPtTlYrlggtwEhXPv//c2pGfQ8W7xT1RvhGgcpL+X/zFZ0MGL/WwJUW4FVKEUdEx
        P0aN6Q+5w2O7AKIRfpTO3b59Q55a/loyotcqHGzbyiMDz4IN/zQiSfDz+0kuQ3xNzFajrg
        7KMiEc3eS2XZvd+3K7dxClHqMGwmo3M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-iFdphpNzPTG_9pUcywiwhw-1; Mon, 07 Oct 2019 04:50:30 -0400
Received: by mail-ed1-f70.google.com with SMTP id t13so8528546edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=QcOf6V+gVv/cON0pMv4VkUPGYgoEn5vDearY3unE1oc=;
        b=UlJ5JIglF7chAII3CaNUyZE9YRxtBLd3Y5dSpIrmBdotse1bolnisXSxbVBHK64b5t
         GM/fmudWbaFgeHZy/BDgMSMGJb4jydjyUk4u52VNK1RMsgsHv5PxIyZNrawjsSfw612G
         gSc4r5i7sw7nCBa82D+PpMZtBgf7ixH6e8geL0Bco9wY4M2RVc4quT+LviwG13dPZj9D
         ZkQIT5q0gStBRCP8lpJsHEGcldn+IoIgt0UkfJktYZ0fNQYoGFJVpdsGUO0IPxKKk/ca
         zclP8rqX6cIdTmVfwHGjtHkl4ysetkpv8LVQ4cgToa2lk0SdVxWUCm9MesLI9uSWcEdU
         lqAQ==
X-Gm-Message-State: APjAAAWrSKF9bpGHs97GXIzPEHebGycGQM5+ZEs8SOo/V3kCx1Ot1vf6
        ZNk5QZZllRrFk0VuFrFnqbmBQ/LcGquMYPbsPgeV/KGWsWv6vgupOD/7gG3tHQpnEMl2rDJ/a4f
        k5olTnizZnRsnTsU25a83WmLh
X-Received: by 2002:a50:9e26:: with SMTP id z35mr27737494ede.265.1570438229341;
        Mon, 07 Oct 2019 01:50:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySxQkIkzTuzQ1GvkBNJaElVj6MRTH/Dbw3Dzz2kaHvc26mSJHYrjgTF7ErEOHJKQ0Iv0MDBA==
X-Received: by 2002:a50:9e26:: with SMTP id z35mr27737483ede.265.1570438229195;
        Mon, 07 Oct 2019 01:50:29 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id i5sm3142944edq.30.2019.10.07.01.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 01:50:28 -0700 (PDT)
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
References: <20191007030939.GB5270@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
Date:   Mon, 7 Oct 2019 10:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007030939.GB5270@rani.riverdale.lan>
Content-Language: en-US
X-MC-Unique: iFdphpNzPTG_9pUcywiwhw-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed;
 boundary="------------E29579C119562803E61F6625"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E29579C119562803E61F6625
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

On 07-10-2019 05:09, Arvind Sankar wrote:
> Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
> memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
> sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> according to git bisect.

Hmm, it (obviously) does build for me and using kexec still also works
for me.

But it seems that you are right and that this should not build, weird.

Thank you for reporting this. I've attached a patch which should fix this,
I'm also sending this the regular way, so that the x86 maintainers can pick=
 it up.

Can you please give this a try and let us know if it fixes things for you?

Regards,

Hans

--------------E29579C119562803E61F6625
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-boot-Provide-memzero_explicit.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-x86-boot-Provide-memzero_explicit.patch"

From d371dbdef635b57d993bda428a9eb6b929f4472d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 7 Oct 2019 10:43:00 +0200
Subject: [PATCH] x86/boot: Provide memzero_explicit

The purgatory code now uses the shared lib/crypto/sha256.c sha256
implementation. This needs memzero_explicit, implement this.

Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get in=
put, memzero_explicit")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/boot/compressed/string.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/s=
tring.c
index 81fc1eaa3229..511332e279fe 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -50,6 +50,11 @@ void *memset(void *s, int c, size_t n)
 =09return s;
 }
=20
+void memzero_explicit(void *s, size_t count)
+{
+=09memset(s, 0, count);
+}
+
 void *memmove(void *dest, const void *src, size_t n)
 {
 =09unsigned char *d =3D dest;
--=20
2.23.0


--------------E29579C119562803E61F6625--

