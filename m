Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCCC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF231216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGIAhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:37:52 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50282 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbfGIAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:37:52 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x690boMw011201
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 20:37:50 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x690bjXi008278
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 20:37:50 -0400
Received: by mail-qk1-f199.google.com with SMTP id d9so10617991qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 17:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=OjZRbgABpZBvMDOAUmYBmnCF4ZS/G+yWz40tVt9zM7o=;
        b=QWOWs7WpVOOlZREdQm7FWNMZRqQLVtBKnAdshLkVRVZvIN/w1kmFxR5Rv63OY3rxU7
         yd2xW8ERr82NoM79Ymg9QhyaiNfc7rpvOqDcDJZZVCRufD+KALwUR3/8wd2mPODm3Bn+
         U2evvM88yscGMPtwC92RcqpekpXbsJz9Rnr6GrJS+pv4NgkV4PAEvPHLl2l1b0P5RpEA
         efQ+0GmCj9Sr0zbs2E/5J9d4oX8QuhawzCFy0DCviA9lwfp/E1uirbikUVbbIBLLseLe
         aUzQODNxIQqKK8PmxJn+tMC61iy6ddYj13rEiPXitUAP3lsvpOKYfx4msx/rMEZmOIDZ
         YHKA==
X-Gm-Message-State: APjAAAUjjkbeWz0mSPtkmqWzqAEd1OIAWQD7sBhDkuMagIlFmFa54R8J
        eqYgh4gmPs0+5OpNBKPmCGtJQ/pPhDY19z4g9keLBj7kpbktjCGLPgHc3v0q4VlDt3dGQgD8u6s
        75TfM+N979grkueHvTYVKIvkAD5Tms8y0YLw=
X-Received: by 2002:a37:6813:: with SMTP id d19mr16780989qkc.454.1562632665372;
        Mon, 08 Jul 2019 17:37:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbFEeUXsRnbhMMEq2850586hL282ux6U2bioRM0L8JU0Om9HCOlfHqXfOGUn65sn/AuySwJA==
X-Received: by 2002:a37:6813:: with SMTP id d19mr16780979qkc.454.1562632665165;
        Mon, 08 Jul 2019 17:37:45 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id z33sm6958980qtc.56.2019.07.08.17.37.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:37:43 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Procedure questions - new filesystem driver..
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562632662_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jul 2019 20:37:42 -0400
Message-ID: <21080.1562632662@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1562632662_2389P
Content-Type: text/plain; charset=us-ascii

I have an out-of-tree driver for the exfat file system that I beaten into shape
for upstreaming. The driver works, and passes sparse and checkpatch (except
for a number of line-too-long complaints).

Do you want this taken straight to the fs/ tree, or through drivers/staging?

--==_Exmh_1562632662_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSPh1gdmEQWDXROgAQJUtQ/+NuCpOp32phoMWYvnTb21fwNfIzCEPXBH
RSyAHXRkx17XhCx4jgTbz6FN95SGVNdlTuMF0GJPwHthtfdmHLql1QB2ROHELCjY
faIk6BGAuTnHlAExeC4VgMBUA+SBgfMwaVTs9d4i4yQ6+Uy8whEPcdgeuKecctFi
jt76tj+gRgpRIhTTAKq+DlpaIu/tpORttvGv23x/a8txU2Y0EaBRkcWbUVXWYI8G
IQ4Sk1J6T1J/n8trp/nHdG3vriAv/w+iUcjVFSDikSrp2tVG4OdbFUzsFC4P+wR4
7cuBLC4cgYZCX2tj45Tc9qTd6SpvdEozR/SQfW1r4lL1j0N05TZpcsYKzLibIegi
xWHpAMqSkhwfC2mF8c9ZCvq1wakHaTLN18OxKM/dPUKUxrSPPnvYiLoQsORH9pUK
JLXY2YlEwdY6SroUfZMBssL8MgGBx+dDcfimyJ1D6oZx1ss4wPRccuk6BmQYBzyH
hyYbNiKcPGimgZEwg2tVnn86X7FCcAhFza+UuzqJ37c0g4ldr/CYa2C0RXsPHn2x
eiKlV99LYR0SDugx8rs74s+bSi41Qi1GvSPy4zDWhBsCwwqxo1xFVAcndAk9NIVL
pKkzVh/nJIoAq724EW2C9dOtasEJx1ogOSUH48hNigytNyLhmOK/gVb9LO8A0vSn
fKUr0veoCZo=
=cgVZ
-----END PGP SIGNATURE-----

--==_Exmh_1562632662_2389P--
