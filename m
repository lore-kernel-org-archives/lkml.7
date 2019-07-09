Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B99C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3B2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGIA6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:58:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51432 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfGIA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:58:32 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x690wVaE028615
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 20:58:31 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x690wQFA018650
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 20:58:31 -0400
Received: by mail-qt1-f197.google.com with SMTP id s22so17910089qtb.22
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 17:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=gzjvIBvyoxXf9yZx+IjvTDWM/EMMxHOR9DhJMARvWU4=;
        b=PqLuGz8nhv3fHYlPYDc33PJO90b45LssCSRtyKBwcoj5kWIvsqJjxIl04FRlJr/0Kj
         gxghC3VIKrEOKEobxJxC3nmFGllrtcULkieNeImjLZQQEWiuSWJr3vpibBnrRebiCiDO
         ilcsL3D219Uaa6c5uS0159gh7QawJRIBjqCzlr5uBrumS9RMJqbN0xtQy6AkRVXuRKen
         IzTEBRYaGfaFmN2zWwfoOX81gJo70PfJSXnminqnBZapwPOqcnGjvZn6UkltbJg0GCr4
         S5AqzWJYCOpvJo7dwrU2GrzkTGVgkGxKDagiHOR9IFO9p830WawIslk+SqnS2zrZNoNo
         S0jg==
X-Gm-Message-State: APjAAAURupoTrN9U8qFZa71uFE75R8r4DgixGaZ0vD7J7YJwALfHFxuy
        6wSSzP9aPGMdR97Bjkfuymc0xnAsLYtfNtgUDXzmiciReRgwmpsCkip3Uq8r3aY5KwaH3th6uVU
        Yv7fcvoUFMmmGgWoFEuBVfiXMCwe/uSHpaOo=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr16325648qtf.204.1562633906032;
        Mon, 08 Jul 2019 17:58:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysL21EgSuDTcXeor1Ws1wtBJMH7dhipNrrhZP3IsCALzATUekN4qK2xdB6CIFg63K4PfkUCw==
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr16325637qtf.204.1562633905878;
        Mon, 08 Jul 2019 17:58:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id r40sm7679907qtk.2.2019.07.08.17.58.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:58:24 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
In-Reply-To: <20190709005220.GZ17978@ZenIV.linux.org.uk>
References: <21080.1562632662@turing-police>
 <20190709005220.GZ17978@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562633903_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jul 2019 20:58:23 -0400
Message-ID: <3099.1562633903@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1562633903_2389P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jul 2019 01:52:20 +0100, Al Viro said:
> On Mon, Jul 08, 2019 at 08:37:42PM -0400, Valdis Klētnieks wrote:
> > I have an out-of-tree driver for the exfat file system that I beaten into shape
> > for upstreaming. The driver works, and passes sparse and checkpatch (except
> > for a number of line-too-long complaints).
> >
> > Do you want this taken straight to the fs/ tree, or through drivers/staging?
>
> First of all, post it...

OK... Ill post it as if it's going in fs/ and if people disagree, I'll repost it for
drivers/staging (once any other complaints have been corrected)...


--==_Exmh_1562633903_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSPmrgdmEQWDXROgAQKCHxAAurpyzrYfy7Qc1FjCJnO+WfvaWzgpnXOC
tD2BSYOKhkrsKYl2phZvfPT+O4jbhq3dgSZ0z/ibewHPe4+9ePTaahxGArr0YZ1a
eogU7nGc5RDE/PGQhfR/Aawk853YMxyDCZs5EWSjjR+gYbVCt2LsN6A2DcEMjPPt
Af9/Qa3Jl8fkJIJgEd3Y7ysjmos+9caFDSvGC0n1xG3OgRHvyDkNFR32CbXsQQ/n
gZT/D6HCzYkL8+x1b7jBD4Ow+tMolC00Itw+8Bn9hsvd6fVqWOH/gs2QatyPUzum
2kbQmq6qHUNBr3qiDwwLyegBHvkzlX+pwZN9djGnKz313uxBZTQxJOQHTVjLJ5Ct
AVwzYYGloc3eiGniTTWKLzO/KEe10UapSwhH0kVih1q4NKWHYXAewPMsfQssWPjZ
dhcxSt5pKULnm3TCTM3oqcOuprx3FRzsR4GAKDy92H2tK6oqfuiJL3yLVWiUa6/v
2BV6e6q3jq8CRwNuU1d1Ko6WOBfWFJXUd9ALsmg9JVlFpjmUZdhkD3oWeYOY0pV9
1n5Ceyt3jOrxi58qyX1CQsA0lvYVUPYMmjvCjk68/pQ5TByMs6YF3A1CArihRPuP
/kcD3GFFjx9WC2bmE+yaednjs/SEUBUHBKfGbJ7K3fCaBhJJHOASyuh+aRpn0zTF
6zCXSRzm+bQ=
=6ylh
-----END PGP SIGNATURE-----

--==_Exmh_1562633903_2389P--
