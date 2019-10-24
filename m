Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7818DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570BC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409769AbfJXQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:27:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56946 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405586AbfJXQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:27:57 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGRuTc029169
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:27:56 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGRpdZ003156
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:27:56 -0400
Received: by mail-qk1-f199.google.com with SMTP id k67so24048105qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=bsN59ZY0yNzgZCIBp0VQtgU1UUq95H4MJw3f/UhzjmQ=;
        b=NIVmaXkqomzUuTOn9azDCcJnh4ZwX5ZzkyuOai3B+zXT9j/tcGDMpibMixIPSrs3ee
         HUCaVHY1df6J6nRkY1z31cdsWdVJGS0R6/eogAYJVtsC+KZr/0dIamXjhB5nzDKQsZdg
         A9DA0o+Y8/So4mU1MjPxPw1qTsTXMGvx7lor4sFF+/wnjEKWSOB9OqfGsclbff9tTrIn
         2Owyu7yOTbi1Y97IUOrwLoA5i6ZI90BtyIjEFvAEwXKA2GOuT3EyUH05d00juNaUVVqO
         FvtyDXmBbeWuWe603Q0RYlveZlE/nqnniXgCFx8cmppPkOyUgTxpXcvPXj92i+Ebd1QH
         OZcw==
X-Gm-Message-State: APjAAAVnXqwVT+yipscWLecXgu/esayVrk0Wy71UOGzEZ4ZVlNRBZbxC
        nauUy9sLzfQorGYX10e/u3Mx7Ujs5wcDGjMHcTgUTe13MPsa63zbkgZjJzU4waiO5Mj5dPDCVQ/
        8FP/d65ztiSxSt1Bqs6SOffx9S5C1SK4W0ds=
X-Received: by 2002:a0c:92dc:: with SMTP id c28mr15714534qvc.26.1571934470701;
        Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkQAmcVf+6706DClmV4SjT0O16B06ZuqsaMrMGTqHXVbTS3u02dKBqi7McVkGiv/fbSgjmkQ==
X-Received: by 2002:a0c:92dc:: with SMTP id c28mr15714469qvc.26.1571934470085;
        Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d126sm10733461qkc.93.2019.10.24.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:27:48 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: exfat: Clean up return codes - FFS_PERMISSIONERR
In-Reply-To: <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu> <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
 <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571934467_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:27:47 -0400
Message-ID: <1107916.1571934467@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571934467_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:23:33 -0700, Joe Perches said:
> On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:

> >  	if (err) {
> > -		if (err == FFS_PERMISSIONERR)
> > +		if (err == -EPERM)
> >  			err = -EPERM;
> >  		else if (err == FFS_INVALIDPATH)
> >  			err = -EINVAL;
>
> These test and assign to same value blocks look kinda silly.

One patch, one thing.  Those are getting cleaned up in a subsequent patch.:)

--==_Exmh_1571934467_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHRAgdmEQWDXROgAQLonRAAgmgi1IyWgKM8Z+fUANqetKRbDPtKzie3
y57H8MYZukD2LXLVrzSbZAZxEZzOr5/UXll3daYEWN6FH2nmXBpmMZO9La7jFEll
m7wEEG0ET6g03Kke3ZYyEFntLjnFEhmYxk2lWy03zFpJQ292BU+TmH0AFob8S5Xg
M665oOaEB6Biv+4jJ5+cgBGDyiDgxED6G6qLStbLC2lbERJ3jfoDuR2WegOA6zu5
ZTGY2/fWCJ/ejYfVF5rM7mTlg0FQD+9xYHgNRZdRg2YsNDhk5Osnisols8OVk3im
H0Y5xsBgzhtZljIlwk1PI/IlWIGn/f3dgNH9LTdsXxm4aKE76VUFnZAk1/y2wMRP
ZXieXPr8D9VvSLD5YpINE1hkBRNb/fVbm0zpiSnWN/U4jNtvAYAeFrEfhOiDc+Dn
VCKBiOmUrrb0AkaZJt5D6+BgEZFnYaO1hHUqkL83R8QAK6d+azSTgVVvHDNc4Fif
iTt/pKW7kN6YP+M6pi07uZI7uEzGsGwSrigiJXE+nOv0xe/BbeDGSDMO4Env3Wym
laF62431/LAMsQxv7SJ1+i64AI1vLcOIw11avtsgIGnbNyAF0INfQs+GPTlGOQvA
j3cNLGrfw6bDIKloyLfUA7+P8iCTBaTX2tpO+FyX2Sg9N0nfPFH6yqPLvqhznwPi
Dt+U26hCtuM=
=Ofym
-----END PGP SIGNATURE-----

--==_Exmh_1571934467_59326P--
