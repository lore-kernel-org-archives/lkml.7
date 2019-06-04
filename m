Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85647C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528CA24B60
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KmwlRJfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFDFJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:09:08 -0400
Received: from mout.web.de ([212.227.17.12]:49653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFDFJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559624924;
        bh=x/ZTtMl4KzW7mPCHtGOE5z5y2Afk0j8EdxXs9Lq03PI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KmwlRJflVZKkTL9iuhKCVlt89C9chMS9/GhQyFy5f2r2rAeb4HAxeaZRZU5TOe+Ln
         DZAiv6GZfHk2ZVtbzcE199HiWp1pHmPkiHdBkvU3dJAYKlr4UlxZ9oqRn81nDH47qM
         i/E27WXmkhWMexBiU0On6IAC4Ul5Mmh512lc7wq8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.105.210]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJCWU-1halmA1Fik-002lNU; Tue, 04
 Jun 2019 07:08:44 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201905171432571474636@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fa3b24ba-1c57-3115-6a01-ee98fd702087@web.de>
Date:   Tue, 4 Jun 2019 07:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201905171432571474636@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUlu5FKPHL/GTSBDDFr+9lP0OqyqmXER/DI3IOMOjLieuxIKZN6
 +fWOV0xTaklLO4P77yIZnCQDkiE5rgWPL5w8L/ADAADbK332bL0plD+NFU0LZ60aIuhJvOT
 PFJgUQXU/lqQCEWAVb7CobrW0eHpVY1MnthajQvrevjS3O5cl1Bc3cXoVU+WNS+wio8PF0y
 blIMq27kHD/suhk9oxA6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m285Zgw06a4=:iwJywvYU+dNCRrVKDlsKll
 tVAYrQVt0GNDxz60B/zf68ibG8M3wCwH+o81Sv5FHViLWf5CicmvJfVmZ4x97fJnW2d77OWdk
 uBFnMP6k9GGPqS5ZRvfNEoS7XarEO9N69bCGlr66JeI48qg/JZ9pI3o/puagCuDqhGCKNlEPL
 /qLvbabe7B2c28vmKfO5nof44SKoERuH0Neq85hvCimdg7/YNcapI9Who1sjeI5PO2mQEwqIa
 g6TzZ4BA3B2q32mIsY+nnlvKGgLAg8s8GAyc8JGXhnimIJdttKZ/sg8cp8FCZcvg5UYf2seId
 EjBs6R389L94tQlPQBOO5u3DD2Q7cf3WjVl/l84CDImFE2LmJYHZrW8nRqgRPKKW82uDIM4Vz
 9qjrbWkfRtU9I02fUiSpDbAjKuCEOQyAzrg7rZU1MWqmtyQYVpuuDmksyY0qt/9SgZCJvr0dQ
 ssW5P8+pdhCai5zXgBZjms5VmY/m610JOXKQ8rcNKg+XaZIjMySIrdYjirV4CXyS7tsLtF636
 p6QvjKh5Umt4vBkcvx3D9wX0JNN3Scvy3oYqrkrSip1hpbC/HpKumyHa5x7b1MWK3OnewYX+6
 hA2pEmTvd/ezZPHXppG0jmLraCBIVyPkrXoJF4q1Lkujiay3ppif4Cr642bXOYOXxKeTai5vS
 xcPqCQGSotRYTKvyiPIF2wlfpMzWV+SK8MoA3yro/Pcy+S1o/7Bq0Kwf9WfIJRdfsBr8koW1Z
 Qdekd+ddkehpM39bjhp2LVIzYpkqSEGArRFGiPOhrDN/MgpG8q0nWyYg/AycGRcbuPh0h6b9K
 3FkPnOgxfrFWG6ADido80g7ypO5jCpLoCxurH3VLLiN+RGEJKFzQ6IP+LvnOfv6JfJoeS0fym
 z6/J5tygsC+bKgyPBcF8T/640P7Sg3gegVz5pflBXfrFvytwSeFd9IDG/9BEjcVrCRY9regb+
 J5dFreRCzX1a7meP/zUI0JbEU5b8MFVRvjpHAzOjWblSIhIifCrPF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2, A general method.
> We also try to get the list of functions to consider by writing a SmPL,
> but this method is not feasible at present, because it is not easy to pa=
rse the comment
> header information of these functions.

The situation was improved once more also for the Coccinelle software.
How do you think about to develop any more variants based on information
from a script (like the following) for the semantic patch language?

@initialize:python@
@@
import re, sys
filter =3D re.compile(" when done")

@find@
comments c;
identifier x;
type t;
@@
 t@c x(...)
 { ... }

@script:python selection@
input << find.c;
@@
if filter.search(input[0].before, 2):
   sys.stderr.write(input[0].before + "\n=3D=3D=3D=3D=3D\n")
else:
   cocci.include_match(False)

@display@
identifier find.x;
type find.t;
@@
*t x(...)
 { ... }


Does such a source code analysis approach indicate any details
which should be improved for the affected software documentation?

Regards,
Markus
