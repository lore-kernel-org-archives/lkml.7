Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13352CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA7420663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OEkUCuCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503666AbfJYP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:58:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:46101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbfJYP6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572019109;
        bh=eNYeWKDIB22/x3+hJ1wYKceqzT/kR7P9oYg/eZ1Fqww=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=OEkUCuCspvUNR0kn5yFz1mMXNQhBcBvCEzIFXsgcy9rp46FQqTqk2aqXlKPWYL6n2
         NDU8x3LDJ0Gix3DpA8rHig+fra8dqMUAr+vc57wOEg4+kg4XD6T/MEEiPseSW3DicS
         Hi/mt12e3GN3jSJhWSnFsHuDYffTA0Y7usEbOh50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1iNTkd3Fis-000enE; Fri, 25
 Oct 2019 17:58:29 +0200
Message-ID: <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 17:58:28 +0200
In-Reply-To: <20191025140029.GL17610@dhcp22.suse.cz>
References: <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
         <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
         <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
         <20191025132700.GJ17610@dhcp22.suse.cz>
         <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
         <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8k2hW5NuA1biyDwFEWxoiO3W0XVbwSBLRBjQSA+bqybFSFXtRzO
 fitmfcOpKDDj8s1Yhvst2xIsD6Xv/Kz3Ilyem7Us1oKc0C52meIfEHKCdYw3SZQia6wWT/p
 fSzzIsWMyovVleoQdb06hgfyrTSID6iBKx1o6FZ/fk6gFUTAUP9wf/KNEN7YloWeXeKsEtZ
 HIHDD5R+hYUKTc6UbG9fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Y10tAzUers=:WWHIy8YxpWIn3qV2z7BFYn
 9TkMWv4IZA1WB610G20wZb1T1gz9agd694E/Y+uX9JVVHzqMxJaDevVLw9yQ7jJwEORICIX4Z
 Vi/PzPlkFWclaV5qm8MyvXQwJ33EMtSjpmGXLiPt3hf5TUnOtMiTExYukHa1JQAXXbU8FBHNV
 fEdBIkemc03EaImNMtfnDUIPQ5bxo3eoFyRNINYd7ErgUO2Rb7ZZeG8GUwqb50QIAxQblRRyY
 +A+pEzGKTid4aBdAC6Ts4OZenJcePmWBw18FI2I/PAjPaD+kN60ZFI6sSwIFupLip5lRYPK96
 umuHuoQa6qEHfsPmN61wFjW5BDqjoZbp5Skk8zwlyqCNy6qfHQH9s8hQr/FTTLjBtkbrq+ifS
 WShVkdz5DMw6AgVKlbBt0r6quRwt+YcR9j4t87SOZNzHXUU8KBPk+Qv2zPWUl8pOlj8J1MYP0
 C3fCdePq9l8VrieTh30rK/JrFotedZgfSdVZ2k6rp+9WD9Wg2cGTqW6tT+f6SASk/GCw98M/Q
 gTmMDHUjAgzFNlUCddUAIIW6ACwSfGeiX4wsI3cVBZMEQCJUJrqoNaJMIIvQzlpUNLTXowGSs
 2jUGmkTmGw42N7M+ko/Fx1ez9G2GCwxW4IPKoOpctLXVDEbpj+vH4/14HUnTMrMuMrn2wrXs4
 9YUOzM3jEQZRMyDmEERuzfga5NB/r3bdwHGWrzKjJ+Ysv+MVIY1Vl8rUZ+fZVcFPVD2uQ770t
 0CvDaxcRojA9TJWbqLhDTPl6ppdFlYMt/HTmp/W7dVPrYSrhhUJyFtv4G209Ri9UzsccY9rKp
 47wcatiHuFKLxJemsAwVO74nqYGBqC7oTsnIZe3bj3mF3U6N7Gy0H40d3wGbgow/8KMR6q9/Z
 jbC9FH2b1NSKxKdacDFQSA2kWaNXG4u00i2ZBQObM/0qUBKqB2bCOs6XQ35pgnSev5JWjgYqv
 w5G1y4KlbMITY64dQW8SlfLVzwtJ8Zny3b3PNw4Adhl4mszkJ12e/comCbDSYxjqkZzLvmEdC
 NilZAzqPRpfiU1Hf5zA8ZBIj2uvsFT8aP3gZsYR4P7/Lq7A/sUQSwyNXPq+l2rCk9mz/Q+GOo
 hjuJODvk8yCtHVUhEW4enyLVairB9BZr50467XQ7WAhpM/waxPG5ZHDtLSg4FLnHPolz4FD6W
 YP06VpUOi9BdKeKB7Y7vl8gPYBkybgoBHo7kowmLPXYQ2UnrVto2mstHQRFRflE8X3l+jJKGz
 Ugs+CEDnk2QRpl+g8nblUobCOABJl2zC5yAcjZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 16:00 +0200, Michal Hocko wrote:
> And one more thing. Considering that you are able to reproduce and
> you
> have a working kernel, could you try to bisect this?

Yikes - running self-built kernels brings back a lot of memories ;)

Anyway, going this route (using the `config` from Ubuntu 5.1.x as a
base and accepting the defaults for `make oldconfig`):

git checkout v5.1-rc1
git bisect start
git bisect bad
git bisect good v5.0

... first try @ e266ca36da7de45b64b05698e98e04b578a88888 is a `git
bisect good`

Will report back, when I've got a result...


