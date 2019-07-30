Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A56C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8532089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfG3M7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:59:02 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53836 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfG3M7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:59:02 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsRiL-0002Us-CN; Tue, 30 Jul 2019 08:58:49 -0400
Message-ID: <7fabadbad16242139cd601a0f1e53fd54d309219.camel@surriel.com>
Subject: Re: [PATCH 09/14] sched,fair: refactor enqueue/dequeue_entity
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Tue, 30 Jul 2019 08:58:48 -0400
In-Reply-To: <20190730093617.GV31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
         <20190722173348.9241-10-riel@surriel.com>
         <20190730093617.GV31398@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IEEtM5JqPFAsI0aZR+xY"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IEEtM5JqPFAsI0aZR+xY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 11:36 +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 01:33:43PM -0400, Rik van Riel wrote:
> > @@ -3870,6 +3873,24 @@ static inline void
> > check_schedstat_required(void)
> >   * CPU and an up-to-date min_vruntime on the destination CPU.
> >   */
> > =20
> > +static bool
> > +enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity
> > *se, int flags)
> > +{
> > +	/*
> > +	 * When enqueuing a sched_entity, we must:
> > +	 *   - Update loads to have both entity and cfs_rq synced with
> > now.
> > +	 *   - Add its load to cfs_rq->runnable_avg
> > +	 *   - For group_entity, update its weight to reflect the new
> > share of
> > +	 *     its group cfs_rq
> > +	 *   - Add its new weight to cfs_rq->load.weight
> > +	 */
> > +	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
> > +		return false;
> > +
> > +	update_cfs_group(se);
> > +	return true;
> > +}
> > =20
>=20
> No functional, but you did make update_cfs_group() conditional. Now
> that
> looks OK, but maybe you can do that part in a separate patch with a
> little justification of its own.

Good idea, I will split that out.

--=20
All Rights Reversed.

--=-IEEtM5JqPFAsI0aZR+xY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1APwgACgkQznnekoTE
3oPHsQgArvMih+KfhxrafZrsS2tRDAm3iYy+5CQK8wJ3uUAVt6hjG6tBxOmGA9hm
3ZvQMHdj5lw/YDaLRX3SjKV7Zqt2kYe9W0v5LRKWFxXL4NCVuWjnh0P/ZRiAtxxo
0EAjSXYcvLmnQ50acG/yqskdpB/8G+1kSj+nwG8DLB4iPg1+1Vb9C8n3Tji0QhzJ
RMnc7MQXTjS/AecUdCnlOX9nhNs/GBEvK0eh0OJYkCenqaFEFC7o5CQCFwwmmik0
Em+xmh7TNo5KaXPCWwOrKOBZ9TNyhDQDS6rBqz2LStw/UKdU8MxMf0iTaZ9OXT8Y
EwvV8Xaef+acXwTVRzuncLXaWXfY6A==
=mrlW
-----END PGP SIGNATURE-----

--=-IEEtM5JqPFAsI0aZR+xY--

