Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB43206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfGaNsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:48:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45470 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfGaNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:48:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsoxZ-0000KL-F1; Wed, 31 Jul 2019 09:48:05 -0400
Message-ID: <c91e6104acaef118ae09e4b4b0c70232c4583293.camel@surriel.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>
Date:   Wed, 31 Jul 2019 09:48:04 -0400
In-Reply-To: <b5a462b8-8ef6-6d2c-89aa-b5009c194000@redhat.com>
References: <20190729210728.21634-1-longman@redhat.com>
         <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
         <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
         <8021be4426fdafdce83517194112f43009fb9f6d.camel@surriel.com>
         <b5a462b8-8ef6-6d2c-89aa-b5009c194000@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xAvz8PAt4EpYAA5Kq7uu"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xAvz8PAt4EpYAA5Kq7uu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 17:01 -0400, Waiman Long wrote:
> On 7/29/19 8:26 PM, Rik van Riel wrote:
> > On Mon, 2019-07-29 at 17:42 -0400, Waiman Long wrote:
> >=20
> > > What I have found is that a long running process on a mostly idle
> > > system
> > > with many CPUs is likely to cycle through a lot of the CPUs
> > > during
> > > its
> > > lifetime and leave behind its mm in the active_mm of those
> > > CPUs.  My
> > > 2-socket test system have 96 logical CPUs. After running the test
> > > program for a minute or so, it leaves behind its mm in about half
> > > of
> > > the
> > > CPUs with a mm_count of 45 after exit. So the dying mm will stay
> > > until
> > > all those 45 CPUs get new user tasks to run.
> > OK. On what kernel are you seeing this?
> >=20
> > On current upstream, the code in native_flush_tlb_others()
> > will send a TLB flush to every CPU in mm_cpumask() if page
> > table pages have been freed.
> >=20
> > That should cause the lazy TLB CPUs to switch to init_mm
> > when the exit->zap_page_range path gets to the point where
> > it frees page tables.
> >=20
> I was using the latest upstream 5.3-rc2 kernel. It may be the case
> that
> the mm has been switched, but the mm_count field of the active_mm of
> the
> kthread is not being decremented until a user task runs on a CPU.

Is that something we could fix from the TLB flushing
code?

When switching to init_mm, drop the refcount on the
lazy mm?

That way that overhead is not added to the context
switching code.

--=20
All Rights Reversed.

--=-xAvz8PAt4EpYAA5Kq7uu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1BnBUACgkQznnekoTE
3oP8LggAs4XburHZ+HTI3IJjkgfu6S82BUog14l4Iqg4Pk4/KMkf5dPrftjy8atc
BcB98mXDlfQCjyPd3gj8JZVlxmpwcendnEKgh1ErkLh5cDDTUnhil7dSQjCVLCBi
KRxakwewtyuK1MwCtcDM0fd1GhNJS/VWfGzDh5BxSLFbQSNlhGZyxR92xMMe9ra0
xIaIzzSdYJ9B9Uno9ZlaJdZwenrS/zEpE4iet6MSFaf/yy0gU0Bk07/x2IYNwsOB
0diPL3V6VWTPG7k0fjfiaBoDjSdBaogMAPWEO+0fG2g4KQMsxyPg1Kgfrayw2NW7
RSzLXBmZNFvkqJZMnErK1bmn937QQg==
=14CR
-----END PGP SIGNATURE-----

--=-xAvz8PAt4EpYAA5Kq7uu--

