Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA89C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F41F206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZoPUQ1RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbfHBW15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:27:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38941 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfHBW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:27:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so32706477pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=g7V5hQ6elfu1kz6NU7RYSeBU7IePPTkmL4DXTcpRTqM=;
        b=ZoPUQ1RH+hvLiLmgazq42vDf1Nvp+bTU/AnK2F1nD+KujWzTjS58qfsuns2usept4I
         9PqsX/jhebix9aKH/q0hdjGKtWhWELKWWqwhsq5R4S9zCA6vd32AsMW4WAJxlMVtbu1k
         j37ns1UPoS9KSI12MvoiM4HFH7ElIAR5PBBIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=g7V5hQ6elfu1kz6NU7RYSeBU7IePPTkmL4DXTcpRTqM=;
        b=IkxGs3CMTqZGwmEeXWroiPdaW3IjZkn0c88NeZUEKHLwyC3eGWkUxiyM+fa/eQXU2c
         DbwwQBuvQJETgTpNzsIST2AsV21ALNd40Hup5S8zUR+0Rzt+ULLDCTw+nDJ3w+6FzgGZ
         zdki9z5WipLzmF2FJGW6hseUcT7hVMITIhLoVfB2tq/B5zdhH2GZFC+N3tQsHb3+Br6D
         FyJ+NM6U8FR0AZER6nOJsu91iPq+ulwyMiDEqWZP1EfDhO3w2wJL676U3sV+5CL8UkYZ
         zsZqJN+ZNYBSKwnT++VHo9jsUlx9nu4KYUFmzmFUkBAJCVyttjyIVxNg9oUaHc76dR5l
         gt9g==
X-Gm-Message-State: APjAAAW9MCGkL0pIN4cu6H3cctvfgJhta5YGIJTLhkqttccww+ZGQyXa
        Scs33VXyjt3tXFgtZldw5E22UQ==
X-Google-Smtp-Source: APXvYqxdpgiE33UyGB3vNOHgh/vL9esOvNoerfOowq5Mpjl/aDgzOfgZYqlqCL5YyR68jKorWtNj/Q==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr6370821pjw.90.1564784876202;
        Fri, 02 Aug 2019 15:27:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q24sm8761388pjp.14.2019.08.02.15.27.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:27:55 -0700 (PDT)
Message-ID: <5d44b8eb.1c69fb81.6d1c1.7d80@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190802082035.79316-1-hungte@chromium.org>
References: <20190802082035.79316-1-hungte@chromium.org>
Subject: Re: [PATCH] firmware: google: update vpd_decode from upstream
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
To:     Hung-Te Lin <hungte@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 15:27:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hung-Te Lin (2019-08-02 01:20:31)
> The VPD implementation from Chromium Vital Product Data project has been
> updated so vpd_decode be easily shared by kernel, firmware and the user
> space utility programs. Also improved value range checks to prevent
> kernel crash due to bad VPD data.

Please add a Fixes: tag here to fix the commit that introduces the
problem. It would also be nice to get a description of the problem that
this patch is fixing. For example, explaining why the types change from
signed to unsigned.

>=20
> Signed-off-by: Hung-Te Lin <hungte@chromium.org>
> ---
>  drivers/firmware/google/vpd.c        | 38 +++++++++------
>  drivers/firmware/google/vpd_decode.c | 69 +++++++++++++++-------------
>  drivers/firmware/google/vpd_decode.h | 17 ++++---
>  3 files changed, 71 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index 0739f3b70347..ecf217a7db39 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -73,7 +73,7 @@ static ssize_t vpd_attrib_read(struct file *filp, struc=
t kobject *kobp,
>   * exporting them as sysfs attributes. These keys present in old firmwar=
es are
>   * ignored.
>   *
> - * Returns VPD_OK for a valid key name, VPD_FAIL otherwise.
> + * Returns VPD_DECODE_OK for a valid key name, VPD_DECODE_FAIL otherwise.

Maybe we should convert these things to use linux conventions instead of
VPD error codes?

>   *
>   * @key: The key name to check
>   * @key_len: key name length
> @@ -86,14 +86,14 @@ static int vpd_section_check_key_name(const u8 *key, =
s32 key_len)
>                 c =3D *key++;
> =20
>                 if (!isalnum(c) && c !=3D '_')
> -                       return VPD_FAIL;
> +                       return VPD_DECODE_FAIL;
>         }
> =20
> -       return VPD_OK;
> +       return VPD_DECODE_OK;

Can you split this rename out into it's own patch. That way we can
confirm that there are no changes due to the rename of the enum.

>  }
> =20
> -static int vpd_section_attrib_add(const u8 *key, s32 key_len,
> -                                 const u8 *value, s32 value_len,
> +static int vpd_section_attrib_add(const u8 *key, u32 key_len,
> +                                 const u8 *value, u32 value_len,
>                                   void *arg)
>  {
>         int ret;
> @@ -246,7 +246,7 @@ static int vpd_section_destroy(struct vpd_section *se=
c)
> =20
>  static int vpd_sections_init(phys_addr_t physaddr)
>  {
> -       struct vpd_cbmem *temp;
> +       struct vpd_cbmem __iomem *temp;
>         struct vpd_cbmem header;
>         int ret =3D 0;
> =20
> @@ -254,7 +254,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
>         if (!temp)
>                 return -ENOMEM;
> =20
> -       memcpy(&header, temp, sizeof(struct vpd_cbmem));
> +       memcpy_fromio(&header, temp, sizeof(struct vpd_cbmem));
>         memunmap(temp);
> =20
>         if (header.magic !=3D VPD_CBMEM_MAGIC)
> @@ -316,7 +316,19 @@ static struct coreboot_driver vpd_driver =3D {
>         },
>         .tag =3D CB_TAG_VPD,
>  };
> -module_coreboot_driver(vpd_driver);
> +
> +static int __init coreboot_vpd_init(void)
> +{
> +       return coreboot_driver_register(&vpd_driver);
> +}
> +
> +static void __exit coreboot_vpd_exit(void)
> +{
> +       coreboot_driver_unregister(&vpd_driver);
> +}
> +
> +module_init(coreboot_vpd_init);
> +module_exit(coreboot_vpd_exit);
> =20
>  MODULE_AUTHOR("Google, Inc.");
>  MODULE_LICENSE("GPL");

The above three hunks should be dropped. They're undoing other patches
that have gone upstream.

> diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/goog=
le/vpd_decode.c
> index 92e3258552fc..5531770e3d58 100644
> --- a/drivers/firmware/google/vpd_decode.c
> +++ b/drivers/firmware/google/vpd_decode.c
> @@ -9,19 +9,19 @@
> =20
>  #include "vpd_decode.h"
> =20
> -static int vpd_decode_len(const s32 max_len, const u8 *in,
> -                         s32 *length, s32 *decoded_len)
> +static int vpd_decode_len(const u32 max_len, const u8 *in, u32 *length,

Is there a reason why max_len and length changes to be unsigned?
Presumably to fix something.

> +                         u32 *decoded_len)
>  {
>         u8 more;
>         int i =3D 0;
> =20
>         if (!length || !decoded_len)
> -               return VPD_FAIL;
> +               return VPD_DECODE_FAIL;
> =20
>         *length =3D 0;
>         do {
>                 if (i >=3D max_len)
> -                       return VPD_FAIL;
> +                       return VPD_DECODE_FAIL;
> =20
>                 more =3D in[i] & 0x80;
>                 *length <<=3D 7;
> @@ -30,24 +30,43 @@ static int vpd_decode_len(const s32 max_len, const u8=
 *in,
>         } while (more);
> =20
>         *decoded_len =3D i;
> +       return VPD_DECODE_OK;
> +}
> +
> +static int vpd_decode_entry(const u32 max_len, const u8 *input_buf,
> +                           u32 *consumed, const u8 **entry, u32 *entry_l=
en)
> +{
> +       u32 decoded_len;
> +
> +       if (vpd_decode_len(max_len - *consumed, &input_buf[*consumed],

Can you add a local variable for *consumed? So _consumed is passed in
and then u32 consume =3D *_consumed.

> +                          entry_len, &decoded_len) !=3D VPD_DECODE_OK)
> +               return VPD_DECODE_FAIL;
> +       if (max_len - *consumed < decoded_len)
> +               return VPD_DECODE_FAIL;
> =20
> -       return VPD_OK;
> +       *consumed +=3D decoded_len;
> +       *entry =3D input_buf + *consumed;
> +
> +       /* entry_len is untrusted data and must be checked again. */
> +       if (max_len - *consumed < *entry_len)
> +               return VPD_DECODE_FAIL;

Is consumed supposed to have move forward here on failure? Is entry
supposed to point to something, or should it be pointing to NULL on a
failure?

> +
> +       *consumed +=3D *entry_len;
> +       return VPD_DECODE_OK;
>  }
> =20
> -int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consu=
med,
> +int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consu=
med,
>                       vpd_decode_callback callback, void *callback_arg)
>  {
>         int type;
> -       int res;
> -       s32 key_len;
> -       s32 value_len;
> -       s32 decoded_len;
> +       u32 key_len;
> +       u32 value_len;
>         const u8 *key;
>         const u8 *value;
> =20
>         /* type */
>         if (*consumed >=3D max_len)
> -               return VPD_FAIL;
> +               return VPD_DECODE_FAIL;
> =20
>         type =3D input_buf[*consumed];
> =20
> @@ -56,25 +75,13 @@ int vpd_decode_string(const s32 max_len, const u8 *in=
put_buf, s32 *consumed,
>         case VPD_TYPE_STRING:
>                 (*consumed)++;
> =20
> -               /* key */
> -               res =3D vpd_decode_len(max_len - *consumed, &input_buf[*c=
onsumed],
> -                                    &key_len, &decoded_len);
> -               if (res !=3D VPD_OK || *consumed + decoded_len >=3D max_l=
en)
> -                       return VPD_FAIL;
> -
> -               *consumed +=3D decoded_len;
> -               key =3D &input_buf[*consumed];
> -               *consumed +=3D key_len;
> -
> -               /* value */
> -               res =3D vpd_decode_len(max_len - *consumed, &input_buf[*c=
onsumed],
> -                                    &value_len, &decoded_len);
> -               if (res !=3D VPD_OK || *consumed + decoded_len > max_len)
> -                       return VPD_FAIL;
> +               if (vpd_decode_entry(max_len, input_buf, consumed, &key,
> +                                    &key_len) !=3D VPD_DECODE_OK)
> +                       return VPD_DECODE_FAIL;
> =20
> -               *consumed +=3D decoded_len;
> -               value =3D &input_buf[*consumed];
> -               *consumed +=3D value_len;
> +               if (vpd_decode_entry(max_len, input_buf, consumed, &value,
> +                                    &value_len) !=3D VPD_DECODE_OK)
> +                       return VPD_DECODE_FAIL;
> =20
>                 if (type =3D=3D VPD_TYPE_STRING)
>                         return callback(key, key_len, value, value_len,
> @@ -82,8 +89,8 @@ int vpd_decode_string(const s32 max_len, const u8 *inpu=
t_buf, s32 *consumed,
>                 break;
> =20
>         default:
> -               return VPD_FAIL;
> +               return VPD_DECODE_FAIL;
>         }
> =20
> -       return VPD_OK;
> +       return VPD_DECODE_OK;
>  }
> diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/goog=
le/vpd_decode.h
> index cf8c2ace155a..4113ac2f4a70 100644
> --- a/drivers/firmware/google/vpd_decode.h
> +++ b/drivers/firmware/google/vpd_decode.h
> @@ -13,28 +13,27 @@
>  #include <linux/types.h>
> =20
>  enum {
> -       VPD_OK =3D 0,
> -       VPD_FAIL,
> +       VPD_DECODE_OK =3D 0,
> +       VPD_DECODE_FAIL =3D 1,

I wonder why this is an enum vs. just using the typical kernel error
codes from errno.h.

>  };
> =20
>  enum {
>         VPD_TYPE_TERMINATOR =3D 0,
>         VPD_TYPE_STRING,
> -       VPD_TYPE_INFO                =3D 0xfe,
> +       VPD_TYPE_INFO =3D 0xfe,
>         VPD_TYPE_IMPLICIT_TERMINATOR =3D 0xff,
>  };

Please drop this change, it's just unaligning things.

> =20
>  /* Callback for vpd_decode_string to invoke. */
> -typedef int vpd_decode_callback(const u8 *key, s32 key_len,
> -                               const u8 *value, s32 value_len,
> -                               void *arg);
> +typedef int vpd_decode_callback(const u8 *key, u32 key_len, const u8 *va=
lue,
> +                               u32 value_len, void *arg);
> =20
>  /*
>   * vpd_decode_string
>   *
>   * Given the encoded string, this function invokes callback with extract=
ed
> - * (key, value). The *consumed will be plused the number of bytes consum=
ed in
> - * this function.
> + * (key, value). The *consumed will be incremented by the number of bytes

Use @consumed to refer to the argument. Split this out into a different
patch as it's just updating the documentation to say the same thing.

> + * consumed in this function.
>   *
>   * The input_buf points to the first byte of the input buffer.
>   *
