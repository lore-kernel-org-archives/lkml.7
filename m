Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B3C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEEF20637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0gfvgn+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfLHWsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 17:48:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41749 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfLHWsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 17:48:15 -0500
Received: from [10.4.50.147] (50-193-22-81-static.hfc.comcastbusiness.net [50.193.22.81])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xB8MlQjN3526742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 8 Dec 2019 14:47:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xB8MlQjN3526742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1575845247;
        bh=0j4XwvkeiVxl2ckN6DsMNci+NMWig7UFR8cpbVjYAcs=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=0gfvgn+DKpe+7VF55vAyC943bk53Jo6fIXUPgSCJ9CQRoxaI1WhKBpOjleUfqhAQA
         vaAGgKtJDMEudcEBer4wzpWAmZ5KNMQXaU+qimT87eYfU77imaGXDpn33/kzXrA9VP
         iktTKbf7qvziytH1UL4crOBPiMT7X/Nq0SlTj0iCjdk90Lj05d7VZi14deRugaAsf9
         DwY9LMLEr5O02efWa/sv1aw6dA4RE5zk5qAh3XTp9KsBoviT2CHlW3TyGS/gn6f4Rs
         DykYZPz/sPKSovl0auZDWDUD7iOzZ9POtVA+bTtBs3tPyKODxYJk0yUZzkUOTTDbHn
         Z88f+t4EwBdxw==
Date:   Sun, 08 Dec 2019 14:47:22 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20191208224357.ex5uxseu45og7s37@tomti.i.net-space.pl>
References: <20191202172939.29271-1-daniel.kiper@oracle.com> <20191208224357.ex5uxseu45og7s37@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GRUB PATCH 1/1] loader/i386/linux: Fix an underflow in the setup_header length calculation
To:     Daniel Kiper <daniel.kiper@oracle.com>, grub-devel@gnu.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
CC:     bp@alien8.de, eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, phcoder@gmail.com,
        rdunlap@infradead.org, ross.philipson@oracle.com,
        krystian.hebel@3mdeb.com, maciej.pijanowski@3mdeb.com,
        michal.zygowski@3mdeb.com, piotr.krol@3mdeb.com
From:   hpa@zytor.com
Message-ID: <C4B79E8A-F6FB-4FAC-B621-6F70AB4EDBE0@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2019 2:43:57 PM PST, Daniel Kiper <daniel=2Ekiper@oracle=2Ec=
om> wrote:
>Hmmm=2E=2E=2E Nobody cares? Strange=2E=2E=2E
>
>Adding 3mdeb folks=2E=2E=2E
>
>Daniel
>
>On Mon, Dec 02, 2019 at 06:29:39PM +0100, Daniel Kiper wrote:
>> Recent work around x86 Linux kernel loader revealed an underflow in
>the
>> setup_header length calculation and another related issue=2E Both lead
>to
>> the memory overwrite and later machine crash=2E
>>
>> Currently when the GRUB copies the setup_header into the linux_params
>> (struct boot_params, traditionally known as "zero page") it assumes
>the
>> setup_header size as sizeof(linux_i386_kernel_header/lh)=2E This is
>> incorrect=2E It should use the value calculated accordingly to the
>Linux
>> kernel boot protocol=2E Otherwise in case of pretty old kernel, to be
>> exact Linux kernel boot protocol, the GRUB may write more into
>> linux_params than it was expected to=2E Fortunately this is not very
>big
>> issue=2E Though it has to be fixed=2E However, there is also an underfl=
ow
>> which is grave=2E It happens when
>>
>>   sizeof(linux_i386_kernel_header/lh) > "real size of the
>setup_header"=2E
>>
>> Then len value wraps around and grub_file_read() reads whole kernel
>into
>> the linux_params overwriting memory past it=2E This leads to the GRUB
>> memory allocator breakage and finally to its crash during boot=2E
>>
>> The patch fixes both issues=2E Additionally, it moves the code not
>related to
>>
>grub_memset(linux_params)/grub_memcpy(linux_params)/grub_file_read(linux_=
params)
>> section outside of it to not confuse the reader=2E
>>
>> Signed-off-by: Daniel Kiper <daniel=2Ekiper@oracle=2Ecom>
>> ---
>>  grub-core/loader/i386/linux=2Ec | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/grub-core/loader/i386/linux=2Ec
>b/grub-core/loader/i386/linux=2Ec
>> index d0501e229=2E=2Eee95cd374 100644
>> --- a/grub-core/loader/i386/linux=2Ec
>> +++ b/grub-core/loader/i386/linux=2Ec
>> @@ -761,17 +761,12 @@ grub_cmd_linux (grub_command_t cmd
>__attribute__ ((unused)),
>>      goto fail;
>>
>>    grub_memset (&linux_params, 0, sizeof (linux_params));
>> -  grub_memcpy (&linux_params=2Esetup_sects, &lh=2Esetup_sects, sizeof
>(lh) - 0x1F1);
>> -
>> -  linux_params=2Ecode32_start =3D prot_mode_target + lh=2Ecode32_start=
 -
>GRUB_LINUX_BZIMAGE_ADDR;
>> -  linux_params=2Ekernel_alignment =3D (1 << align);
>> -  linux_params=2Eps_mouse =3D linux_params=2Epadding10 =3D  0;
>>
>>    /*
>>     * The Linux 32-bit boot protocol defines the setup header end
>>     * to be at 0x202 + the byte value at 0x201=2E
>>     */
>> -  len =3D 0x202 + *((char *) &linux_params=2Ejump + 1);
>> +  len =3D 0x202 + *((char *) &lh=2Ejump + 1);
>>
>>    /* Verify the struct is big enough so we do not write past the
>end=2E */
>>    if (len > (char *) &linux_params=2Eedd_mbr_sig_buffer - (char *)
>&linux_params) {
>> @@ -779,10 +774,13 @@ grub_cmd_linux (grub_command_t cmd
>__attribute__ ((unused)),
>>      goto fail;
>>    }
>>
>> +  grub_memcpy (&linux_params=2Esetup_sects, &lh=2Esetup_sects, len -
>0x1F1);
>> +
>>    /* We've already read lh so there is no need to read it second
>time=2E */
>>    len -=3D sizeof(lh);
>>
>> -  if (grub_file_read (file, (char *) &linux_params + sizeof (lh),
>len) !=3D len)
>> +  if ((len > 0) &&
>> +      (grub_file_read (file, (char *) &linux_params + sizeof (lh),
>len) !=3D len))
>>      {
>>        if (!grub_errno)
>>  	grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"),
>> @@ -790,6 +788,9 @@ grub_cmd_linux (grub_command_t cmd __attribute__
>((unused)),
>>        goto fail;
>>      }
>>
>> +  linux_params=2Ecode32_start =3D prot_mode_target + lh=2Ecode32_start=
 -
>GRUB_LINUX_BZIMAGE_ADDR;
>> +  linux_params=2Ekernel_alignment =3D (1 << align);
>> +  linux_params=2Eps_mouse =3D linux_params=2Epadding10 =3D 0;
>>    linux_params=2Etype_of_loader =3D GRUB_LINUX_BOOT_LOADER_TYPE;
>>
>>    /* These two are used (instead of cmd_line_ptr) by older versions
>of Linux,
>> --
>> 2=2E11=2E0

Please fix these problems=2E It is a huge headache for us in the kennel co=
mmunity=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
