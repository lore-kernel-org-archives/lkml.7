Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E66C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2713B20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKVIX617"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfEVTSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:18:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35524 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVTSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:18:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id t1so1805393pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/Du+FF9jZmkoEm4dZ7uDWlZ8zsfm9ENkRvTiOOUFA8=;
        b=IKVIX617wDndWWMa0oiDtelm9oc2IPwtlUQsEl7CE+JGK2g75amhzDch8pleewd5bn
         rOgPxRPTYKYWARFz8P6Nddtygah87WOeJh/I3Bz4MHlvoHiY8OhaGbxMQBBZlHhTOFNL
         8ORzQbPMsj5yV84pb2/7dScujA79pl2xKb5oVywf2SzKGNNBixlOBnTHON1sZ9ncvNwR
         fJMYt+OeyAkAQakf0g9GUMJ2vCJDUWnLuprKu97wvDmkpNlBtakY9R2gw5t+u9tkBYiP
         p1NF0jJt1/XsdoIamYBXkkdSxvUj5bOglqclsYwrMQXlz4qpRjK5EDUffStrix0govKH
         agtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/Du+FF9jZmkoEm4dZ7uDWlZ8zsfm9ENkRvTiOOUFA8=;
        b=nClWauDnOBK+rz15iyF7qhoEsoEW3xa3kz5Sjkfa1mvxV96XGHe5qbf59iyXPjTa2b
         XaOv8INT4R4fNRv5k4/ZO4QwVBREf3ghKS0zLQBtV7ZUxTfc1c2YX5yHn1F2aHMNmepQ
         ICuZT6M4kAiqeTLjjSXgNbc2IS8bSu6gWt7Bs2jbD6frcmufh+3/OdVgCN3z+UmC97UE
         H4fMSj8By3uNBwQ9vfGsteKZeWBQJ1iG08Cz38DbNcf6RiyAuhM7+45ZgzVMvZCMrwNx
         ERjF90Ry8rlTrNbKi1vG/3DOrLBb+uXkxjVlUMcwO1rVsWEdrjpZeo1WjC8ZWKcJC3F6
         EBqw==
X-Gm-Message-State: APjAAAUR6Op/nGyqzRjnzH+9xdX/7bujwVnxaPo78tWB1SgGqN93sH0O
        F6a/BFhXu7njv02CxYm7K2NOOQ==
X-Google-Smtp-Source: APXvYqwzDDsrBCVISvfzJqV2pxURJPnWgDreriNczsw0BFiGBdQawAqH4Wq9CZZLPuogdOEbuHXGfg==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr89216931pge.218.1558552696104;
        Wed, 22 May 2019 12:18:16 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id t7sm30375410pfh.156.2019.05.22.12.18.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 12:18:14 -0700 (PDT)
Date:   Wed, 22 May 2019 12:18:10 -0700
From:   Benson Leung <bleung@google.com>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>
Cc:     kernel@collabora.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: cros_ec_sensors: support protocol v3
 message
Message-ID: <20190522191810.GA166315@google.com>
References: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabien,

On Wed, May 22, 2019 at 04:09:52PM +0200, Fabien Lahoudere wrote:
> Version 3 of the EC protocol provides min and max frequencies and fifo
> size for EC sensors.
>=20
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

It looks like this is mainly based on patches from the chromium kernel:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
490495
and a subsequent revert of a revert:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
529686

originally by Nick Vaccaro <nvaccaro@chromium.org>.
Please put links to that original work here, and include Nick in the
Signed-off-by. Also, don't forget to CC him when posting to the list.

Thanks,
Benson

> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 98 ++++++++++++++++++-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++
>  include/linux/mfd/cros_ec_commands.h          | 21 ++++
>  3 files changed, 125 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..d5c8b4714ad6 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -19,12 +19,84 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> =20
> +/*
> + * Hard coded to the first device to support sensor fifo.  The EC has a =
2048
> + * byte fifo and will trigger an interrupt when fifo is 2/3 full.
> + */
> +#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
> +
>  static char *cros_ec_loc[] =3D {
>  	[MOTIONSENSE_LOC_BASE] =3D "base",
>  	[MOTIONSENSE_LOC_LID] =3D "lid",
>  	[MOTIONSENSE_LOC_MAX] =3D "unknown",
>  };
> =20
> +static void get_default_min_max_freq_and_fifo_size(enum motionsensor_typ=
e type,
> +						   u32 *min_freq,
> +						   u32 *max_freq,
> +						   u32 *max_fifo_events)
> +{
> +	/* we don't know fifo size, set to size previously used by sensor HAL */
> +	*max_fifo_events =3D CROS_EC_FIFO_SIZE;
> +
> +	switch (type) {
> +	case MOTIONSENSE_TYPE_ACCEL:
> +	case MOTIONSENSE_TYPE_GYRO:
> +		*min_freq =3D 12500;
> +		*max_freq =3D 100000;
> +		break;
> +	case MOTIONSENSE_TYPE_MAG:
> +		*min_freq =3D 5000;
> +		*max_freq =3D 25000;
> +		break;
> +	case MOTIONSENSE_TYPE_PROX:
> +	case MOTIONSENSE_TYPE_LIGHT:
> +		*min_freq =3D 100;
> +		*max_freq =3D 50000;
> +		break;
> +	case MOTIONSENSE_TYPE_BARO:
> +		*min_freq =3D 250;
> +		*max_freq =3D 20000;
> +		break;
> +	case MOTIONSENSE_TYPE_ACTIVITY:
> +	default:
> +		*max_fifo_events =3D 0;
> +		*min_freq =3D 0;
> +		*max_freq =3D 0;
> +		break;
> +	}
> +}
> +
> +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_d=
ev,
> +					     u16 cmd_offset, u16 cmd, u32 *mask)
> +{
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_get_cmd_versions params;
> +			struct ec_response_get_cmd_versions resp;
> +		};
> +	} __packed buf;
> +	struct ec_params_get_cmd_versions *params =3D &buf.params;
> +	struct ec_response_get_cmd_versions *resp =3D &buf.resp;
> +	struct cros_ec_command *msg =3D &buf.msg;
> +	int ret;
> +
> +	memset(&buf, 0, sizeof(buf));
> +	msg->command =3D EC_CMD_GET_CMD_VERSIONS + cmd_offset;
> +	msg->insize =3D sizeof(*resp);
> +	msg->outsize =3D sizeof(*params);
> +	params->cmd =3D cmd;
> +	ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> +	if (ret >=3D 0) {
> +		if (msg->result =3D=3D EC_RES_SUCCESS)
> +			*mask =3D resp->version_mask;
> +		else
> +			*mask =3D 0;
> +	}
> +	return ret;
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -33,6 +105,8 @@ int cros_ec_sensors_core_init(struct platform_device *=
pdev,
>  	struct cros_ec_sensors_core_state *state =3D iio_priv(indio_dev);
>  	struct cros_ec_dev *ec =3D dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform =3D dev_get_platdata(de=
v);
> +	u32 ver_mask;
> +	int ret;
> =20
>  	platform_set_drvdata(pdev, indio_dev);
> =20
> @@ -47,8 +121,16 @@ int cros_ec_sensors_core_init(struct platform_device =
*pdev,
> =20
>  	mutex_init(&state->cmd_lock);
> =20
> +	/* determine what version of MOTIONSENSE CMD EC has */
> +	ret =3D cros_ec_get_host_cmd_version_mask(state->ec,
> +						ec->cmd_offset,
> +						EC_CMD_MOTION_SENSE_CMD,
> +						&ver_mask);
> +	if (ret < 0 || ver_mask =3D=3D 0)
> +		return -ENODEV;
> +
>  	/* Set up the host command structure. */
> -	state->msg->version =3D 2;
> +	state->msg->version =3D fls(ver_mask) - 1;
>  	state->msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  	state->msg->outsize =3D sizeof(struct ec_params_motion_sense);
> =20
> @@ -66,6 +148,20 @@ int cros_ec_sensors_core_init(struct platform_device =
*pdev,
>  		}
>  		state->type =3D state->resp->info.type;
>  		state->loc =3D state->resp->info.location;
> +		if (state->msg->version < 3) {
> +			get_default_min_max_freq_and_fifo_size(
> +					state->resp->info.type,
> +					&state->min_freq,
> +					&state->max_freq,
> +					&state->fifo_max_event_count);
> +		} else {
> +			state->min_freq =3D
> +				state->resp->info_3.min_frequency;
> +			state->max_freq =3D
> +				state->resp->info_3.max_frequency;
> +			state->fifo_max_event_count =3D
> +				state->resp->info_3.fifo_max_event_count;
> +		}
>  	}
> =20
>  	return 0;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/li=
nux/iio/common/cros_ec_sensors_core.h
> index ce16445411ac..4742a9637a85 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -78,6 +78,13 @@ struct cros_ec_sensors_core_state {
>  				    unsigned long scan_mask, s16 *data);
> =20
>  	int curr_sampl_freq;
> +
> +	/* Min and Max Sampling Frequency in mHz */
> +	u32 min_freq;
> +	u32 max_freq;
> +
> +	/* event fifo size represented in number of events */
> +	u32 fifo_max_event_count;
>  };
> =20
>  /**
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index dcec96f01879..27d71cbf22f1 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1744,6 +1744,27 @@ struct ec_response_motion_sense {
>  			uint8_t chip;
>  		} info;
> =20
> +		/* Used for MOTIONSENSE_CMD_INFO version 3 */
> +		struct __ec_todo_unpacked {
> +			/* Should be element of enum motionsensor_type. */
> +			uint8_t type;
> +
> +			/* Should be element of enum motionsensor_location. */
> +			uint8_t location;
> +
> +			/* Should be element of enum motionsensor_chip. */
> +			uint8_t chip;
> +
> +			/* Minimum sensor sampling frequency */
> +			uint32_t min_frequency;
> +
> +			/* Maximum sensor sampling frequency */
> +			uint32_t max_frequency;
> +
> +			/* Max number of sensor events that could be in fifo */
> +			uint32_t fifo_max_event_count;
> +		} info_3;
> +
>  		/* Used for MOTIONSENSE_CMD_DATA */
>  		struct ec_response_motion_sensor_data data;
> =20
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXOWgcgAKCRBzbaomhzOw
wvlQAQDQztClN9sSYgX+UEbA9gHpYwuxii3ZuqmgeL2rnp+VzQD/c8b2Ifvl6ES0
JdUy3AoZ4O7m/ChKF3xo1mO3tD95zAQ=
=Mz9n
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
