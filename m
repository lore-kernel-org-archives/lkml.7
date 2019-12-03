Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136E520684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkv8ikEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLCH2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:28:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39027 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLCH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:28:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so1398688pfo.6;
        Mon, 02 Dec 2019 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=R6U0GcPeiOTSDJN9vYWUrl/mXSJ+twEFCHLNL07RteI=;
        b=Gkv8ikEqAvGXa4C/nS6QG+mzJQD6ZDAM7RgpE+gV2oPukRRuHUxobKdgfo1h0uMDSt
         DqsZXQHj868Czh1ZO3lIci14NMTkSxJX87jl6z6dRdUBNkH14mtrQVAaGz71KsMPdIJ7
         E3vQzm/LTEeTXBDVVed53u+q2iulxbufIrlP6gTP/DUodA6oMm6LPS2XRJPe5IADN5FY
         D8pAakuGq4WOCdxuCLl7S9uj8+GPSHvU4H2VPqklTYRxINp7nIXkPhsKTNC0KTZ8V8Sh
         nxZKl6vDBJmiLb218gh6V4LIIW4OjYd1+Rrjr+cSmE0jFzh40hrc9GxTp6PUBxfuew/Y
         bepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=R6U0GcPeiOTSDJN9vYWUrl/mXSJ+twEFCHLNL07RteI=;
        b=bTWyPRK6AzRAABZ7+MMptkM4Cr7TbQS65gtodbtKTIni1Zi32qM9JyQbIwXrp4jYzL
         LDIm7z2epOZXJFuxht2jwvRtJmOC3zIPvKAkrHlNSRbwCXc33XWhULdFXNZ3akdCQtXm
         wHRxxsL7tiqgRjB49/RkLSQynoCRX/ktc/roVCHtmphr2fB60CHF5e2HuHN6q0AyBMv5
         d093723q4+hk72/JBcTCUhFxjb8x7mZeV475QWuwtX/NshjzpSLFSS/BHLyu3kAE9bcW
         jKFhRvyHYn8XoNkIaEIXN6eETyR1i4j9Bom/ki9TTDXsws49nWGLUkVb+4cribXlGgrf
         mGdQ==
X-Gm-Message-State: APjAAAX5e2Y6wyw5qvUrN8QwR0RINybUQ93U/69kWHBM6ncCfMUgtoQM
        CM0oyZ98vlYzjpsDQttKuy5mzSHy
X-Google-Smtp-Source: APXvYqzNHQ7PqOFt6LNlKWWK74aKneMHjhueWjNIn7ggg/t4CAI+pB1Dy+kDaoW/K8Mv9y5bqzsBeg==
X-Received: by 2002:a63:5b59:: with SMTP id l25mr3973442pgm.382.1575358098928;
        Mon, 02 Dec 2019 23:28:18 -0800 (PST)
Received: from ArchLinux ([103.231.91.74])
        by smtp.gmail.com with ESMTPSA id q7sm2106904pfb.44.2019.12.02.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:28:17 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:58:02 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        rdunlap@infradead.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC scripts] Modules info in one liner script
Message-ID: <20191203072802.GA224932@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        rdunlap@infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Masahiro/Michal/Randy.

This is very trivial and one line script to extract out the running
kernel modules with descriptions, like below

filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/ata/libata.ko.xz
description:    Library module for ATA devices
depends:        scsi_mod
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/usb/host/xhci-pci.ko.xz
description:    xHCI PCI Host Controller Driver
depends:        xhci-hcd
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/usb/host/xhci-hcd.ko.xz
description:    'eXtensible' Host Controller (xHC) Driver
depends:
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/scsi/scsi_mod.ko.xz
description:    SCSI core
depends:
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/arch/x86/crypto/crc32c-intel.ko.xz
description:    CRC32c (Castagnoli) optimization using Intel Hardware.
depends:
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/usb/host/ehci-pci.ko.xz
description:    EHCI PCI platform driver
depends:        ehci-hcd
filename:
/lib/modules/5.4.1-arch1-1ArchLinux-5.4.1/kernel/drivers/usb/host/ehci-hcd.ko.xz
description:    USB 2.0 'Enhanced' Host Controller (EHCI) Driver


and the code to do this :

 awk '{print $1}' "/proc/modules" | xargs modinfo | awk
 '/^(filename|desc|depends)/'

 Can we put in a script called "kernel_modules_info.sh"
 under scripts dir??

 Kindly let me know your thoughts.

 Thanks,
 Bhaskar


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl3mDn4ACgkQsjqdtxFL
KRUkXwgAmIiDFEZql6FvNcZsP5QNpnORHt97Ui6Ev4v/JveigLr62ROuaWi+4Y0U
qrnUtVWN+3OZMuktdFNoiP+9EbVZA7XWbp6SVGJHdUmrHG4nPvV3DcZtKaaWHieL
Bfh/seBe6PTmbYEYn11o3unDmBROLyVthYPd4B8tj4AMbqny+dH9iJszVkuuA3kf
0QMBCyc72hB4bfGjAn7ujkXF7bOaEZe4SKImqNnV+gdAj7VBdR15CHptLO3VicWu
r0YWa/X+wCWKGdHwPHBDyFtTlJnda93wzhCCf9Q3z0i8V3Pof9rP/ch+ZKeipsaF
ogpMRUPCGLhebP7dmeDtSJaAlscsiA==
=Ogyh
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
