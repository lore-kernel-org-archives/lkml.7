Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D265ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6932070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfJGPOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:14:20 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38058 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:14:19 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iHUi5-0008Tu-LJ; Mon, 07 Oct 2019 11:14:05 -0400
Message-ID: <bc879bcb34f089e5888f6721aa2365f0832b69da.camel@surriel.com>
Subject: Re: [PATCH v3 09/10] sched/fair: use load instead of runnable load
 in wakeup path
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Date:   Mon, 07 Oct 2019 11:14:05 -0400
In-Reply-To: <1568878421-12301-10-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-10-git-send-email-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WuD0OLaHXmYk47Pie627"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WuD0OLaHXmYk47Pie627
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> runnable load has been introduced to take into account the case where
> blocked load biases the wake up path which may end to select an
> overloaded
> CPU with a large number of runnable tasks instead of an underutilized
> CPU with a huge blocked load.
>=20
> Tha wake up path now starts to looks for idle CPUs before comparing
> runnable load and it's worth aligning the wake up path with the
> load_balance.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

On a single socket system, patches 9 & 10 have the
result of driving a woken up task (when wake_wide is
true) to the CPU core with the lowest blocked load,
even when there is an idle core the task could run on
right now.

With the whole series applied, I see a 1-2% regression
in CPU use due to that issue.

With only patches 1-8 applied, I see a 1% improvement in
CPU use for that same workload.

Given that it looks like select_idle_sibling and
find_idlest_group_cpu do roughly the same thing, I
wonder if it is enough to simply add an additional
test to find_idlest_group to have it return the
LLC sg, if it is called on the LLC sd on a single
socket system.

That way find_idlest_group_cpu can still find an
idle core like it does today.

Does that seem like a reasonable thing?

I can run tests with that :)

--=20
All Rights Reversed.

--=-WuD0OLaHXmYk47Pie627
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2bVj0ACgkQznnekoTE
3oNkvAf9EIx4XCf3dXuBIbnv/VDATAw7RpjAhjca32QZlF2v2HCNkxQsuEWAaPBr
t7grHeoD5jQIvyMulh2+uUJMZylURuPNdDs6+OyF3pHRSGNTMKhPkNGQVlwTmuvf
GHayc0dHmYN/LjzcIGGdKYUnte7laSweKFGckYwSBnCLGwZyNNsIFJVIoohiqrRJ
zf3LlBGrx0HisQdrywzdSJmXQVhCknycNU9N4zhUQkOBShY2r+a/2Q6xXFiw8Nuk
oK0WKqbk09Erqy3sazKJpYy/Lgnf8ji/wT32OO+rwbf/i4RJYcLakSccooyNxdVm
Gb24a8dg/MIyUfUn/vetydJrMNjtwQ==
=rSUF
-----END PGP SIGNATURE-----

--=-WuD0OLaHXmYk47Pie627--

