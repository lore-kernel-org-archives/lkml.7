Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B7F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561519091;
	bh=/mDvuyD26A4qdq2oB+YzRqpoFB8ffDIWGec8EUtv9Mc=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=N55adxjUGJDxnyAuWsTvYZNXzEm4LuoOpkqgPv4nGOffazxh34LkEY98wJTXnvhLJ
	 L/9i8i/UzfHqBTJSk3JFzXrZFH+pCycRDTrHhJy499H6kkbJZqXVHCxtDmFrCKvyHi
	 j47vmuWukaOc1o/DsbVQOojjg6n5KwyO4wmjoJYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFZDSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZDSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:18:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0AF42146E;
        Wed, 26 Jun 2019 03:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561519084;
        bh=/mDvuyD26A4qdq2oB+YzRqpoFB8ffDIWGec8EUtv9Mc=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=IBGUfwE3uX0RZCHqj7LgTxWmczTTY6PGWyUFZK+M30AKwGFqygy18CVAdZ4U6nWZV
         XEaG1WyI56B5Fz68/AhNdXam9c1+IaEyHnwtnTGHqtP94/PEQ08lgqdcqsmdZUOjEt
         TS0ZUU46ymCfTSIql2UZvNHwGnzLw2+VDO2ab/fs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c948628041311cbf1b9b4cff3dda7d2073cb3eaa.1561492937.git.leonard.crestez@nxp.com>
References: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com> <c948628041311cbf1b9b4cff3dda7d2073cb3eaa.1561492937.git.leonard.crestez@nxp.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] scripts/gdb: add helpers to find and list devices
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 20:18:03 -0700
Message-Id: <20190626031804.A0AF42146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-06-25 13:05:12)
> Add helper commands and functions for finding pointers to struct device
> by enumerating linux device bus/class infrastructure. This can be used
> to fetch subsystem and driver-specific structs:
>=20
> (gdb) p *$container_of($lx_device_find_by_class_name("net", "eth0"), "str=
uct net_device", "dev")
> (gdb) p *$container_of($lx_device_find_by_bus_name("i2c", "0-004b"), "str=
uct i2c_client", "dev")
> (gdb) p *(struct imx_port*)$lx_device_find_by_class_name("tty", "ttymxc1"=
)->parent->driver_data
>=20
> Several generic "lx-device-list" functions are included to enumerate
> devices by bus and class:
>=20
> (gdb) lx-device-list-bus usb
> (gdb) lx-device-list-class
> (gdb) lx-device-list-tree &platform_bus
>=20
> Similar information is available in /sys but pointer values are
> deliberately hidden.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

