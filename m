Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17B62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEOIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEOIi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:38:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B52BAAF95;
        Wed, 15 May 2019 08:38:27 +0000 (UTC)
Date:   Wed, 15 May 2019 10:38:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     khlebnikov@yandex-team.ru
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, oleg@redhat.com
Subject: Re: mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
Message-ID: <20190515083825.GJ13687@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <155790847881.2798.7160461383704600177.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
making this holder of mmap_sem killable was for the reasons of /proc/...
diagnostics was an idea I was pondeering too. However, I think the
approach of pretending we read 0 bytes is not correct. The API would IMO
need to be extended to allow pass a result such as EINTR to the end
caller.
Why do you think it's safe to return just 0?

Michal


--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAlzbz/sACgkQK2l36XSZ
9y72Dw//WSCQl+uR7hQKCcZgc6M3EGW5FhKKiFTfagIYPeGFx8co6rAG2XFCBn89
PiCHJjcjY5BtRaCnLV/AmLbSGSj/j7aX0FIM/nKkP7z78HTrSBjkd30HIXV1Vig8
wQY4JGC5bK2rUkd/D5Fjjrg93wMvwRfyj3wZ6/dXObPU8tfbrbOTeD+JNFlk1WZf
WitkTbX3mD/xC3P3ItZ9+mTRXK+0MCMu/Bazf90yDFRB2uXvA788CTGVzsqzyfpG
vkZmBDTzT/jJJhYKd4gR4ecaQbD3zzZdJiz5AEZFGJFSpK6nwYXz9jarjIWP2T6e
OSZ4mGj+RjL3YBk9sqNgHPXMMS6IQoIgbpjVxwQlNN+6sSfGVm4qVGLn5N+69LwR
iQtCQSv2JS5afnWSaahWQsxzvmkE/6OC6Qs1D1EdclP7ph1PgrkV2NJ+0VVBZfRA
m0VNzZ6APLLoPc7yGaBP36yw6pjgycrVQaDtgZa1hqf1bpLnoqwrSlUQTTN2475Q
ig/ZEnDjlB/X85OkdEB26SLw5CtH35EL64DhfNU9l1dZ5Ygw5O4nOevkPwL2XC3F
mtftFgxxtFN2zDqg3s5gz7K5AAef7jn9TySNze2l7OVFwfpd96b8SXfyPxRMOgcy
aUFG3qyAdXEoPQHQPWtTrKsnhbu+qNCaIbhxZAL9j5iVKnHc/cA=
=vcUI
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
