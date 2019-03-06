Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06707C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECA0206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHhzIFR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfCFCRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:17:37 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:44752 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:17:36 -0500
Received: by mail-qk1-f182.google.com with SMTP id r21so5951216qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rKVuYxndthxwIxvm7uoAEtmr4WSz/5XHWeK7SxIzlns=;
        b=eHhzIFR7QKm0RokBG7ZxdshbkCo/ydup2HjpMBG6IMsvoF+NL1jrPKZH6etQoeBe6u
         1X1sxQnLdfBh0KjN/+njPzRGj2I05YkdZ5Fwk3gAlPZXS4IZqGnCu15PlSCGGaDRE66O
         MqEMkwqvJF2iN8SGQejdIx+IUau3fmJktsG8Tp3yVfeDwvxqKOcqlM+rwzyHBxf6wAE9
         l/tqhEAXl19vwhw6a49sVpu/iR/7PsFhGIu2H89yOU+F6ThbO70Gmet1Qwnb3Hq+a1iQ
         YnhZct3K2Vmcy2NoocD2/j9BPKCH0tKwC6cFRPZi7TeLwjcqPHnsr8Y89AqcR0M3DHHH
         LbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rKVuYxndthxwIxvm7uoAEtmr4WSz/5XHWeK7SxIzlns=;
        b=hO25MrDBHl0VrYUImNEtY3J4Tqs83oMDeuyJs3RADuJtvEXe0FbGGXap70g6yMo4Pl
         Kq3AZp/yO/8VM/db/+xVVzjx2k0wrjIB4YfqenhpvqSWHm0vkwtRfdEznUstFEmg04Dr
         THqmqbOm76O6Yizib6CsekNwmZeANzhs6Xo8Hv2UMUHYs/ao0s7bXOuFx8beTJ8K4MB/
         qsAUEysrn7zbp1UPSyde9Eu+fGXFw49BO6GVw4lBz6Mpsag2OrYf8KrFp66iagswPDI3
         7EFuw9r2z2xzmGvDJBUR/9RGiDfabcWxKtpX34XVLpbjIjxhUo7OMNLMaoHJUJ+nIYnR
         wtYg==
X-Gm-Message-State: APjAAAWEbjhGUB+Bmb6/wFZI7UQIeWuPUHdnii+VlP6+Rg1NNH/A+QKX
        NFPJ/urCvlLAbBGxRR2+7GdoSB57
X-Google-Smtp-Source: APXvYqxTUih0azlEDjWNTCwQVNdxCiWqT55ppoxKd9AlsyL3/tXrhdtdnemIikESjvKgrRTVIrvZlA==
X-Received: by 2002:a37:d98c:: with SMTP id q12mr3926328qkl.286.1551838655573;
        Tue, 05 Mar 2019 18:17:35 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id 46sm203996qty.59.2019.03.05.18.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 18:17:34 -0800 (PST)
Date:   Tue, 5 Mar 2019 21:17:32 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.1 branch
Message-ID: <20190306021731.GA25368@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please git pull the

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.1

which expands the SWIOTLB to have debugfs support (along with bug-fixes), and a tiny fix.

Thank you!

 kernel/dma/swiotlb.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

Dongli Zhang (3):
      swiotlb: fix comment on swiotlb_bounce()
      swiotlb: add debugfs to track swiotlb buffer usage
      swiotlb: checking whether swiotlb buffer is full with io_tlb_used

YueHaibing (1):
      swiotlb: drop pointless static qualifier in swiotlb_create_debugfs()



--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfy27AAoJEFKlDoTx2wm/9uIP/0pz60U0cFlbqQlxzfyOhtIY
n4rrXWxk6abv+DfGSN+fsK4mksnGthlQeZRL0E8daoJ7dVO/3lgjZMgRGN1J5cX5
Cz59Eckt0T7FVnjQUc2j5nukkrgwAMS/diSZzbnEYHn21iHx1/wFaWlelafJo31R
m/qmpg25UgsapztxLvDerwrQpxOFNscQp2twpNeh7ZaTiFTRuZuezPtqSvuruuYQ
w7upcyfQyw+NyK4s9GUcwqFQbmg5qP+XYjR+Z0iPPfI3TT1X6em4VTjTaqxfi3vZ
TKg/oLNzD++L8pK/aMo4i3Bmxf0NVHR/Ju4WdyL3pApFxnT23PnQwi25FTqivm6a
hqXAd+5sRw1kaPh4YhZpSvF+8RLrfsf9w0PdVQwSI5yLBVn2Yy5aAACCyHmUohsr
EAvW7TtNZU3Ki7RkpofZkOgzSiLF18qMlDZ4TVt0I8S9mHehxq8P5Q+xrLb9HuFs
KbsuGcc2OPEK0JIRJSFUgifeksYdQN6lLTb78YzblnpUI6+6haqVFnw/VFzMbtFP
lh8vSHhTv5Z2dUkQ+NshJTo//OVMA3IQuJ29JR2NNsTJS4l/fpMBWuOumsnJW1Ct
sIG+z1v38i5WLmX5VTCZ05bQfT/NRrYiZbtNhQDItGPmz00hJcis7/aRk9gugyD9
+BCglEIHVP3d4QJqG7WI
=4emX
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
