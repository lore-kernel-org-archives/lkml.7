Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3490AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0216A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMz9MSnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfH0RHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:07:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37161 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:07:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so14142851pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=q0kT6PQbzsiYnhvqFPwiKFm2QLDcZ2zSEw+IGcRlCgw=;
        b=UMz9MSnCnlqAH0ef2rjlxORz8VWWoTKMmaRn9gq0OLWJi4wz4barRmZLN7ehtpm3WF
         JHeqcatfU5j/JrHTooZ6EJiLJnc+ijM5wOQez3NJ9I9aF3/GFmf+WKlWxobjXjkeUgcv
         gh0aWARzpvlUWMRMoU2BOVMwkRpZcqQcFrAlBOiu4a3KvGFvf1p21dmQm8fKHBLA1c/V
         pCBzot5KdW6lnP/FxMKqyoYy8bV9LGSmDowjSXXNd5bBgy6gIuEk7fpg1R2VZFYR36LD
         ZOORYvKVnP/880fmbwgeS868Jza/KV6pc6GPR3ZW0hToDi0gSvo3c1fTcALgeOGIOsen
         7g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=q0kT6PQbzsiYnhvqFPwiKFm2QLDcZ2zSEw+IGcRlCgw=;
        b=GHollMqJxQPe7Hk1WUMgkGjrxgyPkdUKtokAm2wnbzviGGEHi/78tUXCg54lM9V2VZ
         XXZIbQka+EiN/FKK3808AGJnuis6ywmfUt0AnFSgR8eOpqlXlWii2MluW31LHvYZZvEr
         gbAGS3xiXl9GxtlxjGgnjzUo7PKkt1uJM/nAedCTdwEmkkV+I9GdNecUP87zZVUM44fb
         Zlnrp7/EeEH2T1jfBYA2s9K37jlKZOf6F0A/jEYDqIxCAxFL/rPtV6fAc5sbLFKtKB7p
         Ph0g8eUJwe0j9Z2T67QjLA2kOkpYrL6NKChifdu7nrMeZ6Ut29NY107TDLsNXxFzLzAm
         mfJg==
X-Gm-Message-State: APjAAAXDxhvumlNwny3d/g0qzgjCsr2x64dVuZYVJQorXiPDzXLsJNst
        E8QcoWMCi30G5zgUIMY6mEc=
X-Google-Smtp-Source: APXvYqyjWTE+SdJ/Ko+rR9A0KMt3tPEs6juc+GO5EUHf9F+pdqDZePthnY5d78eO4O1sIlIYipZ8Mg==
X-Received: by 2002:a05:6a00:8e:: with SMTP id c14mr26613244pfj.241.1566925669586;
        Tue, 27 Aug 2019 10:07:49 -0700 (PDT)
Received: from ?IPv6:2601:641:c100:83a0:7543:d89b:60ad:490f? ([2601:641:c100:83a0:7543:d89b:60ad:490f])
        by smtp.gmail.com with ESMTPSA id 97sm2905491pjz.12.2019.08.27.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:07:48 -0700 (PDT)
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.COM>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Subject: [GIT PULL] ARC fixes for 5.3-rc7
Openpgp: preference=signencrypt
Autocrypt: addr=vineetg76@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtC1WaW5lZXQgR3Vw
 dGEgKHBlcnNvbmFsKSA8dmluZWV0Zzc2QGdtYWlsLmNvbT6JAj4EEwECACgCGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJe9TAP/3ljkSlRwToH
 O0E9QimJJqF52uZ0phSg1ZoavgHhGtz1mRykgeOzOITpFmYGBnf3v2Z33fDltIxTaN5TkRwl
 DjYvz1NTBlTLyPRbYwdCn6YyVSWj75hiGwdD0/N5M7Rb3XYsyDHvZ/tns1oGwipPmu9G+JoB
 VOkZw/bviE8AmGEK54PWdU1t3AnJ/3wtT6FSIPlTtCREiuZdQItjFkH0sYL1/BOXcE+XoBoQ
 9hx6IEb46pop9ix/IRov2y6ZBUtDbF+SOSvImRadvD8A1ttvH51naP21Bra3ypV/GmZOR1/U
 8azvgKmimYvC0345za/dS8eqrDuSh2IbEkDR0juQsFbkWS4IY5uqckzRWxHVZBas9CjpjipO
 C4iTzxq3CgmCyAD5qlQndJdhbsTgN18PXVAAI/phC1BtjNOoCgWgNsr8JK2TbXNF9wSR17T7
 jDWCZ+Up8k5CTVQywLwJl91u5dV82WAnHnv3U1dwUX46DFMenV16ADfRrm7ib+D/O0XZMP7B
 sGC7PPleU+Ej/rt6V4H6VZ5RC9CXVCdUjM+ZZsqJc6/f5od4gSyswWQzCb/izU5ebxrehTUJ
 lPh2QCa6e46G1WzLWwZCFmQU3uUQtCXU1BBId/nL+Y3hQW0XKapvTx+zr8cZAZDXb83YE8Qs
 inBoGE5y9nj+ZveaVZHZRy63
Message-ID: <41adb7d8-dcf5-3ee9-0ae8-53fe0d614de9@gmail.com>
Date:   Tue, 27 Aug 2019 10:07:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Late pull request for ARC as I was off to land of monsoons.
Please pull.

P.S. Using my private email (also on pgp key) due to some interim IT email
shenanigans being sorted out.

Thx,
-Vineet
--------->
The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.3-rc7

for you to fetch changes up to 2f029413cbfbfe519d294c6ac83a0c00e2a48a97:

  arc: prefer __section from compiler_attributes.h (2019-08-26 22:37:12 +0530)

----------------------------------------------------------------
ARC updates for 5.3-rc7

 - Support for Edge Triggered IRQs in ARC IDU intc

 - other fixes here and there

----------------------------------------------------------------
Alexey Brodkin (1):
      ARCv2: entry: early return from exception need not clear U & DE bits

Eugeniy Paltsev (2):
      ARC: fix typo in setup_dma_ops log message
      ARC: [plat-hsdk]: allow to switch between AXI DMAC port configurations

Gustavo A. R. Silva (1):
      ARC: unwind: Mark expected switch fall-throughs

Mischa Jonker (3):
      ARCv2: IDU-intc: Add support for edge-triggered interrupts
      dt-bindings: IDU-intc: Clean up documentation
      dt-bindings: IDU-intc: Add support for edge-triggered interrupts

Nick Desaulniers (1):
      arc: prefer __section from compiler_attributes.h

 .../interrupt-controller/snps,archs-idu-intc.txt   | 30 +++++---
 arch/arc/boot/dts/Makefile                         |  3 +
 arch/arc/include/asm/entry-arcv2.h                 |  2 +-
 arch/arc/include/asm/linkage.h                     |  8 +-
 arch/arc/include/asm/mach_desc.h                   |  3 +-
 arch/arc/kernel/mcip.c                             | 60 +++++++++++++--
 arch/arc/kernel/unwind.c                           |  4 +-
 arch/arc/mm/dma.c                                  |  2 +-
 arch/arc/plat-hsdk/platform.c                      | 87 +++++++++++++++++++---
 include/soc/arc/mcip.h                             | 11 +++
 10 files changed, 172 insertions(+), 38 deletions(-)
