Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69445C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C892084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JB2tig1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfDCHzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:55:32 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58122 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfDCHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:55:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 717DB24E06AE;
        Wed,  3 Apr 2019 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554278131; bh=/AyTKlrTiH8cGokMrJ3esXunW9Mq/NOh4DeLrZKE9yU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JB2tig1h38Q44xossERVCKJV3ANAC5WT1p8cS0oJ54GuauFhA6wvFS2+lQiThKwuH
         17HT9Fv7LkjjekuB2INs6CBfXD2hoQBKBlaCgIpnK1d+mGM//lnL7ywGV86hg/oHMB
         i/BUaH9m3p0HatbNvN66Yqow4V9nFtUcT0XAM1d8nm6RpKPM9dAsWMR75L48sc3pTM
         iTq481q+UugjpCScxPXhKOISH2XFlXFsrKx5iZyt/jYvcsFkq/fPxGMxT4XTpQuedB
         6RqL2S/eqw5U7HKsXuvrFgWlGpjluJgIYcGyGnF9qFx8RS6zJfTrKmfIJBruRCUQGY
         ngk2n/Pqt3jWQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 415A2A008B;
        Wed,  3 Apr 2019 07:55:29 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Apr 2019 00:55:28 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 3 Apr 2019 09:55:26 +0200
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Jose Abreu <jose.abreu@synopsys.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?Windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        =?Windows-1252?Q?Christoph_M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Topic: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Index: AQHU6Ld2BNOIyyJamEeC//pMtZni+6YnhciAgAADZICAAAGHgIAA920AgAAfNACAACI8cIAAipiAgAALMwCAALjx8A==
Date:   Wed, 3 Apr 2019 07:55:25 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
In-Reply-To: <1554245296.1271.0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?Windows-1252?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJl?=
 =?Windows-1252?Q?dVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?Windows-1252?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWQ1YjZiODY0LTU1ZTUtMTFlOS1i?=
 =?Windows-1252?Q?NjNiLWY0ZDEwOGU2NmE0MVxhbWUtdGVzdFxkNWI2Yjg2Ni01NWU1LTEx?=
 =?Windows-1252?Q?ZTktYjYzYi1mNGQxMDhlNjZhNDFib2R5LnR4dCIgc3o9Ijk3OCIgdD0i?=
 =?Windows-1252?Q?MTMxOTg3NTE3MjQzMDc5OTI3IiBoPSJSSzJINXQ0YVk3WHpGQjVvQjNx?=
 =?Windows-1252?Q?cFlnL1lzS009IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVS?=
 =?Windows-1252?Q?SFUxUlNSVUZOQ2dVQUFCUUpBQUQzUEErWTh1blVBWmJxT09CN1IyaVJs?=
 =?Windows-1252?Q?dW80NEh0SGFKRU9BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFD?=
 =?Windows-1252?Q?a0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQStGV2Rx?=
 =?Windows-1252?Q?d0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdCaEFHNEFZd0JsQUY4?=
 =?Windows-1252?Q?QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFBWlFCeUFHMEFZ?=
 =?Windows-1252?Q?UUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?Windows-1252?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?Windows-1252?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?UUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFC?=
 =?Windows-1252?Q?ZkFIQUFZUUJ5QUhRQWJnQmxBSElBY3dCZkFITUFZUUJ0QUhNQWRRQnVB?=
 =?Windows-1252?Q?R2NBWHdCakFHOEFiZ0JtQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVB?=
 =?Windows-1252?Q?RjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFHMEFjd0IxQUc0?=
 =?Windows-1252?Q?QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?Windows-1252?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?Windows-1252?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhNQWRBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dC?=
 =?Windows-1252?Q?NUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6QUcwQVl3QUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlB?=
 =?Windows-1252?Q?SGtBWHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJ?=
 =?Windows-1252?Q?QWJ3QmtBSFVBWXdCMEFGOEFkQUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFITUFY?=
 =?Windows-1252?Q?d0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJnQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dC?=
 =?Windows-1252?Q?ZkFIRUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZB?=
 =?Windows-1252?Q?R3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHNEFjQUJ6QUY4?=
 =?Windows-1252?Q?QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBBWHdCekFIUUFk?=
 =?Windows-1252?Q?UUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0Fa?=
 =?Windows-1252?Q?UUI1QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonidas P. Papadakos <papadakospan@gmail.com>
Date: Tue, Apr 02, 2019 at 23:48:16

> I can confirm that snps,no-pbl-x8, currently set by uboot for the fdt
> basically fixes the tx-checksumming issue.
> I get 700~800 Mbps myself but that might come down to the setup.
> You could say it affects performance slightly, as I saw in a previous=20
> email.
>=20
> Without the setting The rate consistently drops to 0.
> ethtool reports tx-checksumming is on in both cases
>=20
> Pretty cool!
> Does that give you guys an idea on how to tackle it "officially"?
>=20
>=20
>=20

Thank you all for testing !

It's been on my todo list to cook up a patch that limits PBL according to
FIFO size but I didn't manage to have the time yet so for now it would
be better if you fix it by submitting the DT bindings changes.

Thanks,
Jose Miguel Abreu
