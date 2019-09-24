Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0ADC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B88021841
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otbE6VJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfIXVgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:36:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45578 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfIXVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:36:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so1491292pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20g5pcefWYMZbg5OQuQOYYuPriSXZI58bfB24WDyypM=;
        b=otbE6VJo2S2sgGi85ftEzs+KTi98mb4JmHr15er5HtypacGZeOSVIgJLfdfGiifyxo
         KvhH2vGqZnOo02JMNkk6VT1lswAa5YMoGWpg7GSWG4M7Fc5hv0xrHw0BoSlN6zSlECCk
         8ojf5scwc5Hm4MMdeUhXlpAk/yhTpDshOI9Iu5C0YzanSwYG9iX+sJbSV6v6UsDLA2cw
         j+WwMrdzLjMjbmBTYCgDV/2KfzUOiRTk7Xbpl5OBonuncSIuEURutHwK39PCZUsWl/s5
         ZD2Ja4DUJ+qJUZ/FeaAeN1eFk72y0QLKlGbWC4q8MiGBWt3HYbvZaxUede/UnxqhVmV9
         RRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20g5pcefWYMZbg5OQuQOYYuPriSXZI58bfB24WDyypM=;
        b=bbftbSzinx9ONVFutEYkzCfHCQ8WZodxPfhQ2sXrSGbpGU+oJhKwZ0aIWXDK2gFdKZ
         g88TWrBHQDYNinBP1RBEbDENEdZtZ5aKYwP7G5na76M6XkG/p2WX6bS9Zrn++Ru371Hw
         YcNbaDHXBciCJM3KxUTgPXHNEEfAobb43O4Wol6SdI5tXgelu7bZvfaiA+JUNwttGrUh
         vk4trmpJ92J7K2TfLebV3w8LXmvfZIqgKabl06WYDNh1Jl025U9CYdwz4E0xH2HJgTa3
         gJm+NIDkpvltxJuJZhixZ8OynGouYX7i66wnbenQzcDI+PnGu6udwaELzFTc2e5kWEki
         faWQ==
X-Gm-Message-State: APjAAAX7qQCb140GWJZgByZa9j30UlGisZZMy026KCmQ5BQtYVcMHcFn
        Mws5OQU64IGA190Ru2wlu5qAjw==
X-Google-Smtp-Source: APXvYqyrzRwuSt6/KZkXUcRX+LSiF16lfhZJ+1Ma4HB0VDYdTgc0ZPFElVl7iDcF1tA3ed92RQYrxw==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr5362473pll.323.1569360979622;
        Tue, 24 Sep 2019 14:36:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id v1sm7648119pfg.26.2019.09.24.14.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:36:18 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:36:13 -0700
From:   Benson Leung <bleung@google.com>
To:     Daniel Campello <campello@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v5] platform/chrome: wilco_ec: Add debugfs test_event file
Message-ID: <20190924213613.GB210752@google.com>
References: <20190924203716.209420-1-campello@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190924203716.209420-1-campello@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Sep 24, 2019 at 02:37:16PM -0600, Daniel Campello wrote:
> This change introduces a new debugfs file 'test_event' that when written
> to causes the EC to generate a test event.
> This adds a second sub cmd for the test event, and pulls out send_ec_cmd
> to be a common helper between h1_gpio_get and test_event_set.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>

LGTM.
Reviewed-by: Benson Leung <bleung@chromium.org>

Merge window is open right now for v5.4, so we can't quite merge this change
for chrome-platform-5.5 yet.

Enric, can you queue this for the next branch if you have no objections?

Thanks,
Benson

> ---
> Changes for v2:
>   - Cleaned up and added comments.
>   - Renamed and updated function signature from write_to_mailbox to
>     send_ec_cmd.
> Changes for v3:
>   - Switched NULL format string to empty format string
>   - Renamed val parameter on send_ec_cmd to out_val
> Changes for v4:
>   - Provided a format string to avoid -Wformat-zero-length warning
> Changes for v5:
>   - Updated commit message to include more implementation details
>   - Restored removed empty line between functions
>=20
>  drivers/platform/chrome/wilco_ec/debugfs.c | 47 +++++++++++++++++-----
>  1 file changed, 37 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platfor=
m/chrome/wilco_ec/debugfs.c
> index 8d65a1e2f1a3..df5a5f6c3ec6 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -160,29 +160,29 @@ static const struct file_operations fops_raw =3D {
>=20
>  #define CMD_KB_CHROME		0x88
>  #define SUB_CMD_H1_GPIO		0x0A
> +#define SUB_CMD_TEST_EVENT	0x0B
>=20
> -struct h1_gpio_status_request {
> +struct ec_request {
>  	u8 cmd;		/* Always CMD_KB_CHROME */
>  	u8 reserved;
> -	u8 sub_cmd;	/* Always SUB_CMD_H1_GPIO */
> +	u8 sub_cmd;
>  } __packed;
>=20
> -struct hi_gpio_status_response {
> +struct ec_response {
>  	u8 status;	/* 0 if allowed */
> -	u8 val;		/* BIT(0)=3DENTRY_TO_FACT_MODE, BIT(1)=3DSPI_CHROME_SEL */
> +	u8 val;
>  } __packed;
>=20
> -static int h1_gpio_get(void *arg, u64 *val)
> +static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_v=
al)
>  {
> -	struct wilco_ec_device *ec =3D arg;
> -	struct h1_gpio_status_request rq;
> -	struct hi_gpio_status_response rs;
> +	struct ec_request rq;
> +	struct ec_response rs;
>  	struct wilco_ec_message msg;
>  	int ret;
>=20
>  	memset(&rq, 0, sizeof(rq));
>  	rq.cmd =3D CMD_KB_CHROME;
> -	rq.sub_cmd =3D SUB_CMD_H1_GPIO;
> +	rq.sub_cmd =3D sub_cmd;
>=20
>  	memset(&msg, 0, sizeof(msg));
>  	msg.type =3D WILCO_EC_MSG_LEGACY;
> @@ -196,13 +196,38 @@ static int h1_gpio_get(void *arg, u64 *val)
>  	if (rs.status)
>  		return -EIO;
>=20
> -	*val =3D rs.val;
> +	*out_val =3D rs.val;
>=20
>  	return 0;
>  }
>=20
> +/**
> + * h1_gpio_get() - Gets h1 gpio status.
> + * @arg: The wilco EC device.
> + * @val: BIT(0)=3DENTRY_TO_FACT_MODE, BIT(1)=3DSPI_CHROME_SEL
> + */
> +static int h1_gpio_get(void *arg, u64 *val)
> +{
> +	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +}
> +
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
>=20
> +/**
> + * test_event_set() - Sends command to EC to cause an EC test event.
> + * @arg: The wilco EC device.
> + * @val: unused.
> + */
> +static int test_event_set(void *arg, u64 val)
> +{
> +	u8 ret;
> +
> +	return send_ec_cmd(arg, SUB_CMD_TEST_EVENT, &ret);
> +}
> +
> +/* Format is unused since it is only required for get method which is NU=
LL */
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, "%llu\n"=
);
> +
>  /**
>   * wilco_ec_debugfs_probe() - Create the debugfs node
>   * @pdev: The platform device, probably created in core.c
> @@ -226,6 +251,8 @@ static int wilco_ec_debugfs_probe(struct platform_dev=
ice *pdev)
>  	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
>  	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
>  			    &fops_h1_gpio);
> +	debugfs_create_file("test_event", 0200, debug_info->dir, ec,
> +			    &fops_test_event);
>=20
>  	return 0;
>  }
> --
> 2.23.0.351.gc4317032e6-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXYqMTQAKCRBzbaomhzOw
wplVAP9N888mqe7ww7x4eAvmlaKbyIiHSHVIiNQdth2k65p1GwD+I4Gu1N0WOWis
t916V21cG8UjzVAE3P21sxzUs37oqAs=
=FJ7V
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
