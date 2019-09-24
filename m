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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5372064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UteJF7NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503574AbfIXALZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:11:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35411 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIXALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:11:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so10294772pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGFoDqFSfJUXal4c6Npj9VdPgTyBiAoRp6KoyLY2mGo=;
        b=UteJF7NGMZ4beo9w7vwHkysoQCN92gszctTgcjtbhxU2gKkdiGjiqkrSY3hgMqMQny
         btXKS4ODCg9xRcCb5as30XBL2kfTwC2pX7XyOZgqeaCZS0XjKVplE2rRyc4blXwfYAh3
         PvpfHXZ0Tenr/Vg/cErUsOqs50H5Fb7OlUm7cy8eU1kg3jgQB4mn/Zn9ZgFCunXJBBwK
         D7g8stn5SwrHupfoShDAQX2hoqw+dT1PoSI8MGfFgrSkMPbIfKCEUm8xDwTSd2R0y6my
         /22CZgdM8H9IV2OUwnKwgKxwxScjdxMlyj+QLnIrHzBRPB4M2kSzQy4Qyo/rljyKgcGg
         LUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGFoDqFSfJUXal4c6Npj9VdPgTyBiAoRp6KoyLY2mGo=;
        b=iJG9yP3VrY7XUZMzwFsbTj432WgdNnafDAX3COAT3QY5mCkDb0j+LuUFqP0ICCluCO
         puqY4P6anLYcbZowonfYYEsaOA2DetQ6cuENkRhf0Lmy8/JMK9Adh0huXjQGXs74wiWf
         t4UBSvmIfeVI273QZwyWs7WpY07NUW2FPWtHDtLEc843GRA+ckq5wWmCJ1F96RGdEqOe
         l398x9DnzHpj3h/OcbTp696OhzoEk77wCkqgjmRn2+2AGtt4Kfo5Htf0V71NpqPrql1C
         al192/WaMupNvLdF+tt8bjBxANzq2MdRxE+LxSbWUmRku2IG/S9G6Wt9M27FIJzkV6xa
         yLgg==
X-Gm-Message-State: APjAAAWU56mfRR44h7kTFSAL1Dmdhr+rbIx0DvysVL6bFUi/Rj0ukQSt
        FgVUTUO990Ej7CKSM/vDqENMBQ==
X-Google-Smtp-Source: APXvYqzN1omtHLkqG2JcYpdHq1MKBUuIN2x0vdg0p3vElg3l5lwRpWLQUMa0tST4+0uEPPavU8GsaA==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr2353812pjb.32.1569283882025;
        Mon, 23 Sep 2019 17:11:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id c6sm15870pgd.79.2019.09.23.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 17:11:21 -0700 (PDT)
Date:   Mon, 23 Sep 2019 17:11:16 -0700
From:   Benson Leung <bleung@google.com>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v4] platform/chrome: wilco_ec: Add debugfs test_event file
Message-ID: <20190924001116.GA73943@google.com>
References: <20190918204316.237342-1-campello@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20190918204316.237342-1-campello@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for sending this.

On Wed, Sep 18, 2019 at 02:43:16PM -0600, Daniel Campello wrote:
> This change introduces a new debugfs file 'test_event' that when written
> to causes the EC to generate a test event.

Please mention that this adds a second sub cmd for the test event, and
pulls out send_ec_cmd to be a common helper between h1_gpio_get and
test_event_set.

>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
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
>=20
>  drivers/platform/chrome/wilco_ec/debugfs.c | 46 +++++++++++++++++-----
>  1 file changed, 36 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platfor=
m/chrome/wilco_ec/debugfs.c
> index 8d65a1e2f1a3..ba86c38421ff 100644
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
> @@ -196,13 +196,37 @@ static int h1_gpio_get(void *arg, u64 *val)
>  	if (rs.status)
>  		return -EIO;
>=20
> -	*val =3D rs.val;
> +	*out_val =3D rs.val;
>=20
>  	return 0;
>  }
> +/**

Minor nit. Add one line of whitespace before this comment start.

> + * h1_gpio_get() - Gets h1 gpio status.
> + * @arg: The wilco EC device.
> + * @val: BIT(0)=3DENTRY_TO_FACT_MODE, BIT(1)=3DSPI_CHROME_SEL
> + */
> +static int h1_gpio_get(void *arg, u64 *val)
> +{
> +	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +}
>=20
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
> @@ -226,6 +250,8 @@ static int wilco_ec_debugfs_probe(struct platform_dev=
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
> 2.23.0.237.gc6a4ce50a0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXYlfJAAKCRBzbaomhzOw
wsjIAPwJf4Y5bncTZxeGiHevARnCv4P2KhOFZRa0NN4goTPksAD+NrajjKvvTr0o
8rnDl4z3JHALb3k/CqLeDkoppK/y8gI=
=U2Xm
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
