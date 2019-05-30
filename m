Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE02C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162F25ECA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+dsQCNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE3Rx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:53:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Rx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:53:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id c9so1166695pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=us/uLpXxX0XlW29JLOVcCBD/zOVj+gQgjXP5kfUDV14=;
        b=A+dsQCNsCBu227ebNwXajuLaso+SeGxYLM8g0qcwl9rBNKiLYoVtvV84eYn0bwjCID
         sACU/H0bVWagyUhJL0COAWQ4M1CUK4ewXrXXwCRJ9q0qTClg2voRDDwKSg2sUW9jBGqp
         5kylgc4UqrN/WQ7kMMuwsJbag1UoP9SEWke16huo0lkaVi700eU4AWuroFwGbbfSx4y1
         vCK3wrAd+czwEJtQfYdPFzY9W1E1tAnvJohBLbrExpvoZU7yc440E8ophHReQiHCy28m
         jol1li44M6Yzo+CWbO7vPIxzqZfj3ZiAiEKv1gPiLqEo8SxNjOFzAZMLQYo8DNuNMBdp
         /r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=us/uLpXxX0XlW29JLOVcCBD/zOVj+gQgjXP5kfUDV14=;
        b=mwy2qqsWmGqg+wGWoyDSo+dOyoutyRKZ+88kAF9TfV5UowFE3PZdsTnc0ewoqkkla4
         VcZ7G87DljLjrwnZ6WFomlej5efHJmXUZQ+P2t3BtzAdwwCfpdsi1UsyR7CXPBjWoy1J
         RrIWI6CZGJ7TsGJO8CmeDNT2oiaZ3SgcH6+it2E++KP2rJQUl08XrylvlGW9g2q1I6zN
         0cR35hOPaHpjSLT5F0s7ilCtI8aisTOmJtfZFuEaCBlQOlxQnjDPLvPWsMU1QiBpf2u2
         NpxSUF+5CTwIG265WsU9pCFclVH4VkSrtXTnn1jWUI+sZdJFiFd3CtOiY0nCfgBRV0yr
         3kCA==
X-Gm-Message-State: APjAAAXeGpPAozSnsE79opVQ+wj/nIGepkVxTN59SvKumBY0/0ngzty5
        ToAVFwP2kYInl40lUw5Kf3nAQA==
X-Google-Smtp-Source: APXvYqyqSqAx/bfaFV+24kpMx30pZuZcASKWxObI0kR/+ipX5lG1SbfBpJ/hnfKLQ8ohnQN1hEA9Ng==
X-Received: by 2002:a17:90a:bf84:: with SMTP id d4mr4507082pjs.124.1559238836224;
        Thu, 30 May 2019 10:53:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id q193sm4108849pfc.52.2019.05.30.10.53.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 10:53:54 -0700 (PDT)
Date:   Thu, 30 May 2019 10:53:49 -0700
From:   Benson Leung <bleung@google.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH v2 -next] platform/chrome: cros_ec: Make some symbols
 static
Message-ID: <20190530175349.GA24982@google.com>
References: <20190529150749.8032-1-yuehaibing@huawei.com>
 <20190530084932.2576-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20190530084932.2576-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello YueHaibing,

On Thu, May 30, 2019 at 04:49:32PM +0800, YueHaibing wrote:
> Fix sparse warning:
>=20
> drivers/platform/chrome/cros_ec_debugfs.c:256:30: warning: symbol 'cros_e=
c_console_log_fops' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_debugfs.c:265:30: warning: symbol 'cros_e=
c_pdinfo_fops' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_lightbar.c:550:24: warning: symbol 'cros_=
ec_lightbar_attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_sysfs.c:338:24: warning: symbol 'cros_ec_=
attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_vbc.c:104:24: warning: symbol 'cros_ec_vb=
c_attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_lpc.c:408:25: warning: symbol 'cros_ec_lp=
c_pm_ops' was not declared. Should it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> v2: fix patch title
> ---
>  drivers/platform/chrome/cros_ec_debugfs.c  | 4 ++--
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
>  drivers/platform/chrome/cros_ec_lpc.c      | 2 +-
>  drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
>  drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform=
/chrome/cros_ec_debugfs.c
> index 4c2a27f6a6d0..4578eb3e0731 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -241,7 +241,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>  				       read_buf, p - read_buf);
>  }
> =20
> -const struct file_operations cros_ec_console_log_fops =3D {
> +static const struct file_operations cros_ec_console_log_fops =3D {
>  	.owner =3D THIS_MODULE,
>  	.open =3D cros_ec_console_log_open,
>  	.read =3D cros_ec_console_log_read,
> @@ -250,7 +250,7 @@ const struct file_operations cros_ec_console_log_fops=
 =3D {
>  	.release =3D cros_ec_console_log_release,
>  };
> =20
> -const struct file_operations cros_ec_pdinfo_fops =3D {
> +static const struct file_operations cros_ec_pdinfo_fops =3D {
>  	.owner =3D THIS_MODULE,
>  	.open =3D simple_open,
>  	.read =3D cros_ec_pdinfo_read,
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platfor=
m/chrome/cros_ec_lightbar.c
> index d30a6650b0b5..23a82ee4c785 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -547,7 +547,7 @@ static struct attribute *__lb_cmds_attrs[] =3D {
>  	NULL,
>  };
> =20
> -struct attribute_group cros_ec_lightbar_attr_group =3D {
> +static struct attribute_group cros_ec_lightbar_attr_group =3D {
>  	.name =3D "lightbar",
>  	.attrs =3D __lb_cmds_attrs,
>  };
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index c9c240fbe7c6..aaa21803633a 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -405,7 +405,7 @@ static int cros_ec_lpc_resume(struct device *dev)
>  }
>  #endif
> =20
> -const struct dev_pm_ops cros_ec_lpc_pm_ops =3D {
> +static const struct dev_pm_ops cros_ec_lpc_pm_ops =3D {
>  	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
>  };
> =20
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/c=
hrome/cros_ec_sysfs.c
> index fe0b7614ae1b..3edb237bf8ed 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -335,7 +335,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *k=
obj,
>  	return a->mode;
>  }
> =20
> -struct attribute_group cros_ec_attr_group =3D {
> +static struct attribute_group cros_ec_attr_group =3D {
>  	.attrs =3D __ec_attrs,
>  	.is_visible =3D cros_ec_ctrl_visible,
>  };
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chr=
ome/cros_ec_vbc.c
> index 8392a1ec33a7..2aaefed87eb4 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] =
=3D {
>  	NULL
>  };
> =20
> -struct attribute_group cros_ec_vbc_attr_group =3D {
> +static struct attribute_group cros_ec_vbc_attr_group =3D {
>  	.name =3D "vbc",
>  	.bin_attrs =3D cros_ec_vbc_bin_attrs,
>  };
> --=20
> 2.17.1
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXPAYqQAKCRBzbaomhzOw
wtaPAP9KsM8qo6MLA6xp1KjTzg9OXO2/8q54Q9hpMycMSy7fBQD/ba98HzAnMz9U
5EAdojpwqI5/P4YaQ/dppZ7gEmt1uQk=
=Nqos
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
