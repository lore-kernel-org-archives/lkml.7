Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC22C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A921670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfD3K4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:56:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfD3K4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:56:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2264AD12;
        Tue, 30 Apr 2019 10:56:13 +0000 (UTC)
Date:   Tue, 30 Apr 2019 12:56:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, brgl@bgdev.pl,
        arunks@codeaurora.org, geert+renesas@glider.be, mhocko@kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        ldufour@linux.ibm.com, rppt@linux.ibm.com, mguzik@redhat.com,
        mkoutny@suse.cz, vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190430105609.GA23779@blackbody.suse.cz>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
 <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
 <20190430093808.GD2673@uranus.lan>
 <1a7265fa-610b-1f2a-e55f-b3a307a39bf2@virtuozzo.com>
 <20190430104517.GF2673@uranus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190430104517.GF2673@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2019 at 01:45:17PM +0300, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> It setups these parameters unconditionally. I need to revisit
> this moment. Technically (if only I'm not missing something
> obvious) we might have a race here with prctl setting up new
> params, but this should be harmless since most of them (except
> stack setup) are purely informative data.
FTR, when I reviewed that usage, I noticed it was missing the
synchronization. My understanding was that the mm_struct isn't yet
shared at this moment. I can see some of the operations take place after
flush_old_exec (where current->mm = mm_struct), so potentially it is
shared since then. OTOH, I guess there aren't concurrent parties that
could access the field at this stage of exec.

My 2 cents,
Michal

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAlzIKcMACgkQK2l36XSZ
9y43Zw//ShZK7DYk6l3lLVR4pXSaBs8MdnbIYo7kKlPHwKewLyueV6qPL2+k7sD9
M0bduFp4pZsGf/v2IG/1k6qStCpTYRFhLwiq9fiNee3j7pUhmxLTbTB6bIHtcU3p
96TrUAJK0J9Ll3vPRHvi3t6pGARq3M/3I7mVs/oWFGYT8wWy5yKoP1B+BHHbKcky
4xx3EaFJlwDeBZA8FgxxyrfbMvzLFJ1PgdSuaifuG8VH0wKYZhhzRtVB0U6o2DYF
MPce7LipyB4FG8NPWk0rWcrS/EjWDLV6zqRaOqYHKBryTYrLo2kyxp42QcbBSHsN
vSOimjkHLc6wnGE2798Pfsmy53aNucWE1s+vfuoqaGd4hXflp8hYU9MuM8MrV52C
OHkjozbWRkW0y6E0UGQ3H//7lYU2CTXOatHB0wRn3XeVhDynWaOXwZdcbG4WuzmM
wM04m8KsDFkLoY/uxSOeDKPPJUdwx/CGfzMvI7or47ic/BkN7GOtbsz4ktNiDg66
c6hgOEp8jUi+PPsAcEfzIRX7NKpWhpi5MLLTqfY3KGg6UnszjSOb1us4/XTr1Ok+
WRhUZy+lkVI6/sLy6JlDyCDPQGkM96ZmJC/yRsUqvQeiaUhG99DiU5tL2IZqmbN3
XQSp5NcX0a7or597DEf0zJXfqO0vkHugAenNGardDU17d0iJH9w=
=qs9v
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
