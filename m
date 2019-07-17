Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87105C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5956321743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgpTCd0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGQI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:58:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42729 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGQI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:58:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so10504019pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TV4qxs2n08gZo7racpvsLudptxi6rnkrvduj7r235gE=;
        b=SgpTCd0z62yKaM4dIK7cO/buQd33jmMoWt2boG/K0rBXZXRGsmx2ymLehL8QFzbUaQ
         1KiotepetWU1ZEZxnHObR66lw1OH0COUh0PRyWD7S7x1gKzH7dA/QPPIem3+lkT47hSk
         iNSf8H4plHWYt2BdAO254zOB4i+c4UNzw3+piAGExUNLXbaC0FVHIwaMgwdFZ27OeYuI
         SdvWuu5/0XyCc3VX1ZhoKB2bKoc8veckZV1sKh3KVlnXv+4BEKC3tIgGplaMiwkS2fDc
         Fx3p8pgoj9fijIe170TWpN8jWbagQeS92uRXe3ch2SSaWTZ4/Oeb7beszY5RQXF1yDR2
         npAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TV4qxs2n08gZo7racpvsLudptxi6rnkrvduj7r235gE=;
        b=GFYwiyVNNJMujQ5kGeOgFq6HZF2XE7oMgIKZy3dsoSwesEsMVtCqgt8l22OB4SIKpg
         UiyNXQkBjyLorUiJjx6lvbfzZGdtl09OKPNgk4futARHl8MjodtiVoq98xLV4HTN5MFW
         OfggKYVtttV208Lgncl5pI2U1CmL61QSAi3ponZkya7gjH4lMw47MHBqlPPocBonbG85
         9oRDc6HKNR4tkjtinjAyZRqaNzfbYvmrDlWNZewtRg1JwychVA6rlhm4GnhByNEkUkuu
         ArOIT5C94MmYeCshnf/KlNY4IAsAutilbtgBVcdOVr4jgrHaXWp3m0F1YwPIHjNQFMkw
         rPMQ==
X-Gm-Message-State: APjAAAVciwnqFzfkiAS1hbLhZpYCSY9IfuSNcozBZInmGIgr8RBq26CA
        BYChKVbCofXVq5L12iNRF8eKOHjWQlbeQw==
X-Google-Smtp-Source: APXvYqwfa0H2woIcnsTn2ce+Ce0XftkvpQt+auITRXk2EX1rd4s0C7yaC5sXbEdDs8zHkQZ8uEMbbQ==
X-Received: by 2002:a63:c203:: with SMTP id b3mr40335174pgd.450.1563353891884;
        Wed, 17 Jul 2019 01:58:11 -0700 (PDT)
Received: from ArchLinux ([103.231.91.34])
        by smtp.gmail.com with ESMTPSA id o11sm43398998pfh.114.2019.07.17.01.58.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:58:10 -0700 (PDT)
Date:   Wed, 17 Jul 2019 14:27:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: incoming
Message-ID: <20190717085758.GA2025@ArchLinux>
References: <20190716162536.bb52b8f34a8ecf5331a86a42@linux-foundation.org>
 <8056ff9c-1ff2-6b6d-67c0-f62e66064428@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <8056ff9c-1ff2-6b6d-67c0-f62e66064428@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Cool !!=20

On 10:47 Wed 17 Jul , Vlastimil Babka wrote:
>On 7/17/19 1:25 AM, Andrew Morton wrote:
>>
>> Most of the rest of MM and just about all of the rest of everything
>> else.
>
>Hi,
>
>as I've mentioned at LSF/MM [1], I think it would be nice if mm pull
>requests had summaries similar to other subsystems. I see they are now
>more structured (thanks!), but they are now probably hitting the limit
>of what scripting can do to produce a high-level summary for human
>readers (unless patch authors themselves provide a blurb that can be
>extracted later?).
>
>So I've tried now to provide an example what I had in mind, below. Maybe
>it's too concise - if there were "larger" features in this pull request,
>they would probably benefit from more details. I'm CCing the known (to
>me) consumers of these mails to judge :) Note I've only covered mm, and
>core stuff that I think will be interesting to wide audience (change in
>LIST_POISON2 value? I'm sure as hell glad to know about that one :)
>
>Feel free to include this in the merge commit, if you find it useful.
>
>Thanks,
>Vlastimil
>
>[1] https://lwn.net/Articles/787705/
>
>-----
>
>- z3fold fixes and enhancements by Henry Burns and Vitaly Wool
>- more accurate reclaimed slab caches calculations by Yafang Shao
>- fix MAP_UNINITIALIZED UAPI symbol to not depend on config, by
>Christoph Hellwig
>- !CONFIG_MMU fixes by Christoph Hellwig
>- new novmcoredd parameter to omit device dumps from vmcore, by Kairui Song
>- new test_meminit module for testing heap and pagealloc initialization,
>by Alexander Potapenko
>- ioremap improvements for huge mappings, by Anshuman Khandual
>- generalize kprobe page fault handling, by Anshuman Khandual
>- device-dax hotplug fixes and improvements, by Pavel Tatashin
>- enable synchronous DAX fault on powerpc, by Aneesh Kumar K.V
>- add pte_devmap() support for arm64, by Robin Murphy
>- unify locked_vm accounting with a helper, by Daniel Jordan
>- several misc fixes
>
>core/lib
>- new typeof_member() macro including some users, by Alexey Dobriyan
>- make BIT() and GENMASK() available in asm, by Masahiro Yamada
>- changed LIST_POISON2 on x86_64 to 0xdead000000000122 for better code
>generation, by Alexey Dobriyan
>- rbtree code size optimizations, by Michel Lespinasse
>- convert struct pid count to refcount_t, by Joel Fernandes
>
>get_maintainer.pl
>- add --no-moderated switch to skip moderated ML's, by Joe Perches
>
>

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl0u4xEACgkQsjqdtxFL
KRWrWwf8Cy7nQCi6JgRKYAQ4L1ZAV38WQCEe/uU0nfsMpVCABe01JZuWwavKS6Z0
WQddJZAQNzVXsAT4jmtj0KCABVIPoUMwaJ/H7wjN3uKIWgBfx+0d9pLWpVVa5DAK
KwNbjBwSXe4G1CiAJ0w0ZQ6mUdiHe8wwGE1sZI8V/SldhjFeBtlfUqcwcN24GCr5
dyjof/z8aa53uNPN5F+UVdwKU7GudPsVrohpnVgjmq3t2hn2epLbITFEwfNMUlBh
mcF7HIE+Jhs2V59EVKv/k4OiGOJoEYe2HeOvHN5QgvQA5qqU99tYxROWokggcVPS
9gKfzx3IdOoFLCvRq0YtgPfMZVBi2g==
=zmHX
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
