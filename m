Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EDC21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9VPMozj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfJ2C7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:59:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730875AbfJ2C73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572317968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guRxEaafCMKN/sKcNa0Bpbo9BDPpQ1IEEO+7hLEaV3M=;
        b=i9VPMozjGhHhdhA3VOR1Hk3TALeck0msWy/L17E/L/jY8lE34z6m94zXBcNsGFXK5rv80/
        ruJ7zv6ro9weYkRNAbHM7Z4G5BdiTF9LlJmJsSzIovBdgUbQ01qi+X+yjqNEL4O5tAaHyE
        QUe74WawyY5ki1dEmWwEXlPZUJomEJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-66m4ld0LMQu_59lhjOtq_Q-1; Mon, 28 Oct 2019 22:59:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A305180496F;
        Tue, 29 Oct 2019 02:59:24 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A485D6C3;
        Tue, 29 Oct 2019 02:59:23 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:59:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Adjust the padding size for KASLR
Message-ID: <20191029025920.GO8527@MiWiFi-R3L-srv>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 66m4ld0LMQu_59lhjOtq_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masa,

On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Any plan about this patchset?

Thanks
Baoquan

>=20
> The system sometimes crashes while memory hot-adding on KASLR
> enabled system. The crash happens because the regions pointed by
> kaslr_regions[].base are overwritten by the hot-added memory.
>=20
> It happens because of the padding size for kaslr_regions[].base isn't
> enough for the system whose physical memory layout has huge space for
> memory hotplug. kaslr_regions[].base points "actual installed
> memory size + padding" or higher address. So, if the "actual + padding"
> is lower address than the maximum memory address, which means the memory
> address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> the overwritten.
>=20
>   address
>     ^
>     |------- maximum memory address (Hotplug)
>     |                                    ^
>     |------- kaslr_regions[0].base       | Hotadd-able region
>     |     ^                              |
>     |     | padding                      |
>     |     V                              V
>     |------- actual memory address (Installed on boot)
>     |
>=20
> Fix it by getting the maximum memory address from SRAT and store
> the value in boot_param, then set the padding size while KASLR
> initializing if the default padding size isn't enough.
>=20
> Masayoshi Mizuma (5):
>   x86/boot: Wrap up the SRAT traversing code into subtable_parse()
>   x86/boot: Add max_addr field in struct boot_params
>   x86/boot: Get the max address from SRAT
>   x86/mm/KASLR: Cleanup calculation for direct mapping size
>   x86/mm/KASLR: Adjust the padding size for the direct mapping.
>=20
>  Documentation/x86/zero-page.rst       |  4 ++
>  arch/x86/boot/compressed/acpi.c       | 33 +++++++++---
>  arch/x86/include/uapi/asm/bootparam.h |  2 +-
>  arch/x86/mm/kaslr.c                   | 77 +++++++++++++++++++++------
>  4 files changed, 93 insertions(+), 23 deletions(-)
>=20
> --=20
> 2.18.1
>=20

