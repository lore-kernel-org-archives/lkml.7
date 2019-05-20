Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9422C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B621734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363872;
	bh=KxVzuRz+VMTUFhknDdKVGc3wrqC8JIymUA+D2BFiRnc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=u5pSDF3VmkvdGeiS57xY1C2mliDbjYlBI5R4Al7fc8/8JBnAbro+L/OeA9Dynwi8E
	 BXVikpt9+nQnIiKvbYW/BChEwRTDVjLFF/y0yqYoy0pix/DOkXNLUx7i0w+cIlfgMc
	 aIUEf3y4dfjfL9egtoqXZC0jo8J/Mh8KVZFIfsnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbfETOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732283AbfETOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:51:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BDAE21721;
        Mon, 20 May 2019 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558363870;
        bh=KxVzuRz+VMTUFhknDdKVGc3wrqC8JIymUA+D2BFiRnc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fhMCSaVq4D/iqwBFHFK2VQBG5q4sBcI7jYbwMkbFUGwdEOd4hIJEzim5k48Us29Vf
         6ifK4tfZpmqc24N80eSlPhMb68GMek5D7avcpcuGKHm3beXUlN5UxrMLhBvBW8hbwh
         C5IgqI/fqKKgXhbBSK3wrokub+f3hN6ArALnc73M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     jslaby@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        agsumit@qti.qualcomm.com
To:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, jorge.ramirez-ortiz@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 20 May 2019 07:51:09 -0700
Message-Id: <20190520145110.7BDAE21721@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-05-20 03:34:35)
> When the tty layer requests the uart to throttle, the current code
> executing in msm_serial will trigger "Bad mode in Error Handler" and
> generate an invalid stack frame in pstore before rebooting (that is if
> pstore is indeed configured: otherwise the user shall just notice a
> reboot with no further information dumped to the console).
>=20
> This patch replaces the PIO byte accessor with the word accessor
> already used in PIO mode.

Because the hardware only accepts word based accessors and fails
otherwise? I can believe that.

I wonder if the earlier UART hardware this driver used to support (i.e.
pre-DM) would accept byte access to the registers. It's possible, but we
don't really care because those boards aren't supported.

>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  drivers/tty/serial/msm_serial.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_ser=
ial.c
> index 109096033bb1..23833ad952ba 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>                 else
>                         tf =3D port->membase + UART_TF;
> =20
> +               buf[0] =3D port->x_char;
> +
>                 if (msm_port->is_uartdm)
>                         msm_reset_dm_count(port, 1);
> =20
> -               iowrite8_rep(tf, &port->x_char, 1);
> +               iowrite32_rep(tf, buf, 1);

I suppose it's OK to write some extra zeroes here?

