Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C1CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52915222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMxe2FgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfKDAde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:33:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26100 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728106AbfKDAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572827611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsgpqfrvQX1j+XaheyDAtYumgm5eRmMOUuqFcUhViNs=;
        b=hMxe2FgUdw0WeQyCWLEenApO1xtrGzWhkcVbz21DRFPAtHK+KQfESlI3NKUwEG09l8yeBA
        v2nwKq7nAFvVKqN7gspHeawXpqidh0L4TCwnC1zwnBCZnTLDFLOucHtgDK29wMHdpaj181
        RIQ+HER7LKdLX+hdCM3ttla/oFW+mcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-VLx-r0ZXM6qPOo2ImxQ5iQ-1; Sun, 03 Nov 2019 19:33:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51967107ACC2;
        Mon,  4 Nov 2019 00:33:26 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A80E31001B23;
        Mon,  4 Nov 2019 00:33:25 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:33:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] x86/boot: Get the max address from SRAT
Message-ID: <20191104003322.GB14560@MiWiFi-R3L-srv>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
 <20191102010911.21460-4-msys.mizuma@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191102010911.21460-4-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VLx-r0ZXM6qPOo2ImxQ5iQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 at 09:09pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> Get the max address from SRAT and write it into boot_params->max_addr.
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/a=
cpi.c
> index a0f81438a..764206c23 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -362,17 +362,25 @@ static unsigned long get_acpi_srat_table(void)
>  =09return 0;
>  }
> =20
> -static void subtable_parse(struct acpi_subtable_header *sub_table, int *=
num)
> +static unsigned long subtable_parse(struct acpi_subtable_header *sub_tab=
le,
> +=09=09=09=09    int *num)
>  {
>  =09struct acpi_srat_mem_affinity *ma;
> +=09unsigned long addr =3D 0;
> =20
>  =09ma =3D (struct acpi_srat_mem_affinity *)sub_table;
> =20
> -=09if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> -=09=09immovable_mem[*num].start =3D ma->base_address;
> -=09=09immovable_mem[*num].size =3D ma->length;
> -=09=09(*num)++;
> +=09if (ma->length) {
> +=09=09if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)
> +=09=09=09addr =3D ma->base_address + ma->length;
> +=09=09else {
> +=09=09=09immovable_mem[*num].start =3D ma->base_address;
> +=09=09=09immovable_mem[*num].size =3D ma->length;
> +=09=09=09(*num)++;

Here maybe add code comment or doc above the subtable_parse() to explain
why we only get the end address of hotpluggable region. We assume hot
pluggable memory board will be added above the existed system RAM,
right?

Otherwise, this patch looks good to me. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> +=09=09}
>  =09}
> +
> +=09return addr;
>  }
> =20
>  /**
> @@ -391,6 +399,7 @@ int count_immovable_mem_regions(void)
>  =09struct acpi_subtable_header *sub_table;
>  =09struct acpi_table_header *table_header;
>  =09char arg[MAX_ACPI_ARG_LENGTH];
> +=09unsigned long max_addr =3D 0, addr;
>  =09int num =3D 0;
> =20
>  =09if (cmdline_find_option("acpi", arg, sizeof(arg)) =3D=3D 3 &&
> @@ -409,7 +418,9 @@ int count_immovable_mem_regions(void)
>  =09=09sub_table =3D (struct acpi_subtable_header *)table;
>  =09=09if (sub_table->type =3D=3D ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> =20
> -=09=09=09subtable_parse(sub_table, &num);
> +=09=09=09addr =3D subtable_parse(sub_table, &num);
> +=09=09=09if (addr > max_addr)
> +=09=09=09=09max_addr =3D addr;
> =20
>  =09=09=09if (num >=3D MAX_NUMNODES*2) {
>  =09=09=09=09debug_putstr("Too many immovable memory regions, aborting.\n=
");
> @@ -418,6 +429,9 @@ int count_immovable_mem_regions(void)
>  =09=09}
>  =09=09table +=3D sub_table->length;
>  =09}
> +
> +=09boot_params->max_addr =3D max_addr;
> +
>  =09return num;
>  }
>  #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
> --=20
> 2.20.1
>=20

