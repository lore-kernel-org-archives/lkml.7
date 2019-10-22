Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105072184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E59v9vBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbfJVUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:20:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388342AbfJVUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571775611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mLe5fr4Rcj9l0aGmOkYC8WIu+5iwHZBKsP7Jqa+8JM=;
        b=E59v9vBAiFixxeeVNaSKU8YAp6q0jLPOYTkGgX4LrlohDdWAH5+AvqKo121wEfvK98utfZ
        CBnneUVC4jAdb1RsJesg4b7i1OMrNPfPfhAgnMoSemlyU0QK3TU8IpivZltLu1/x4aDQ41
        wEnAa4BWZ4EqqexTG4iuXQHJzCb1oeQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-EUzTEBTNPfaosMYHevuZiA-1; Tue, 22 Oct 2019 16:20:09 -0400
Received: by mail-wr1-f70.google.com with SMTP id 4so5554211wrf.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=is3i2Uy6uftQ7uth5vCaIrveGENUjfRXA0+ex4HKooA=;
        b=fXa0AnbtfjZJbcrJpsjwxwAmmyEbyO20JhaIsQeUEsJwDGmPHqjpAM2CSuyadjcmut
         7vq1nEbCp9bvkRBkd004dKfzT1Upbquyx3YsUKI9uLW8kAlClz1Ruo6oQQjolByjGofV
         OJLCkB1X7rFy6zoTyAz9PQADIAyxv1W5fku6GM9xAjxSEqdhxNHWh+YCa7FNfRRy14lY
         VVVGHDGLUphhKophpUo51zthRUodgDSNdYs8ArxYLSFIZhBAzwmI15Q2dE2F9Up5859R
         wxcy4/c+VFSBsRxk4Xeb4+AdnOLSp8fgfqFsj9laTPmk/BVytEBogWcsulCnNFw4iV1i
         y9nA==
X-Gm-Message-State: APjAAAVF54nVvGJ32oaxlCcUaXDOF9YE+spfOVGSaSBDev6tqcE6Zaxl
        ov9GR4VajsOUYLwYRoVq0FX24wD54EkGFdHsJWAtFYIRQ5B6U6flmUCW+L/VQD9xgKGQNHM4CwF
        i06sOx2DQvVFxMoc/YRh7JhEh
X-Received: by 2002:a1c:7401:: with SMTP id p1mr4378823wmc.144.1571775608164;
        Tue, 22 Oct 2019 13:20:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQ/5bZv78ma0pjD8AU5HfwQOysVzDzPZjbfOd0cqRpmUniu5vax102hw6wJ0xIPNJD49sytw==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr4378809wmc.144.1571775607973;
        Tue, 22 Oct 2019 13:20:07 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id a4sm18478849wmm.10.2019.10.22.13.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 13:20:07 -0700 (PDT)
Subject: Re: [PATCH] reset: fix reset_control_get_exclusive kerneldoc comment
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20191022162936.15234-1-p.zabel@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <89f5cbc2-77cf-2a19-4ce5-ef487fd94a34@redhat.com>
Date:   Tue, 22 Oct 2019 22:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022162936.15234-1-p.zabel@pengutronix.de>
Content-Language: en-US
X-MC-Unique: EUzTEBTNPfaosMYHevuZiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/22/19 6:29 PM, Philipp Zabel wrote:
> Add missing parentheses to correctly hyperlink the reference to
> reset_control_get_shared().
>=20
> Fixes: 0b52297f2288 ("reset: Add support for shared reset controls")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   include/linux/reset.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index e7793fc0fa93..eb597e8aa430 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -143,7 +143,7 @@ static inline int device_reset_optional(struct device=
 *dev)
>    * If this function is called more than once for the same reset_control=
 it will
>    * return -EBUSY.
>    *
> - * See reset_control_get_shared for details on shared references to
> + * See reset_control_get_shared() for details on shared references to
>    * reset-controls.
>    *
>    * Use of id names is optional.
>=20

