Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9B3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407D421873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfHHGIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:08:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35468 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbfHHGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:08:24 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7868NKF013009
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 02:08:23 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7868ITu004116
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 02:08:23 -0400
Received: by mail-qt1-f198.google.com with SMTP id q26so84709382qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 23:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=//3h4E8VoC24wx7WM5WKExXqnh8y6JbPvWf21T+Yr0M=;
        b=NG8RC43FbJLEYKeu+AcNaKVcEODry80dEv0LwCxy6+cqo/4V/loTIW8C52OPnE8qRJ
         qm4k/36+RzCASYIxxfSZzOMs8p2ISJnnw7e8f1rChkvDo9JviT3rdVz4SeD4jXzeoAvo
         4Sy4SW3+CGQJREkLJn63FoZmJ0rfVbYS+xu/grP3NLjmuFMfuBefx1XNljEwbUWAIvqQ
         ezIa0y3IYR5Kj1DKmAg8/RhDb8DSKZYnlFjQ1rfULHjUmxVss3X2jk5XH9kzubHM6O1C
         EAp8nJORWSvsrfmJC5FVwUPj26macn6eU20e76XaHW5qAn31PZVNBBZo5KVlcgNt39Yd
         DVlA==
X-Gm-Message-State: APjAAAWENHiRohwGS7RISgg2HJqiBzBypDOVg3f25PfF6Hxk5AgjEKEI
        q+27Ob4VIP/UjDoA236lr4sP+Q+ZHMZpcduv9NP9F7EweVGOMrxLbDe0MwbLU5ISwMokwFw2Mdu
        wsfq3a1UlZPzm4H2O2AKXODsYMXbc3yJIK3A=
X-Received: by 2002:ae9:e916:: with SMTP id x22mr1914508qkf.296.1565244497784;
        Wed, 07 Aug 2019 23:08:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXGyOQMiS6YkEKeQKZCudGwW3weVcAz9pQIvSdFoSUaUagbeHmgpOQq597BXogeQYsTQCTQQ==
X-Received: by 2002:ae9:e916:: with SMTP id x22mr1914494qkf.296.1565244497495;
        Wed, 07 Aug 2019 23:08:17 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id u28sm3702894qtc.18.2019.08.07.23.08.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 23:08:16 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
In-Reply-To: <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
References: <33485.1565228181@turing-police>
 <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565244495_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 02:08:15 -0400
Message-ID: <56763.1565244495@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1565244495_4269P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Aug 2019 22:50:47 -0700, Joe Perches said:
> On Wed, 2019-08-07 at 21:36 -0400, Valdis Klētnieks wrote:

> >  				^.DEFINE_$Ident\(\Q$name\E\)|
> >  				^.DECLARE_$Ident\(\Q$name\E\)|
> >  				^.LIST_HEAD\(\Q$name\E\)|
> > -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
>
> Perhaps also better to convert all the '\Q$name\E' to '\s*\Q$name\E\s*'

Yes, but that would need to be a separate patch.  The question would be if we
consider 'DEFINE_foo( barbaz )' and similar with whitespace to be desirable
style or not.

[/usr/src/linux-next] grep '\\Q$name\\E' scripts/checkpatch.pl
				^.DEFINE_$Ident\(\Q$name\E\)|
				^.DECLARE_$Ident\(\Q$name\E\)|
				^.LIST_HEAD\(\Q$name\E\)|
				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()

We already have the \s* in one place. Somebody else can decide if it should
be in the other 5 places or not. :)


--==_Exmh_1565244495_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUu8TgdmEQWDXROgAQLnuRAAqXGr2OzjeF9ReHEBjpb5UkyDrI6wS1E9
Z0bLd+hNvhINoJpwG8EkhCG6m2wzjaALCxZK9B5rZrxMB1UcsmciFW1dHxqfkyzk
IENvO1aQgcxHPTXoMnlrKHHvKy6MHszoE8MhEBI22KBEAe1L93fnnni2YVvELKHn
DV77q7yMmXcOnzbMZzCtFlmCc9ElfyBmqXtfN8dTE89F9RndH8XO2F0cplY8GZhg
2DRMPsvgnWqYg8rprVWfzxcOAYzy2dYpBoYQuElYmS1lwznogoyl5ikKqexVrm3c
2UqRcHDLMuUgV9hMcpq+zUwIWGranHkLlQqIBoZN3xxBCAHAaHhoh3p7ASBQcF1i
gkCqIWlaEqnb6POL1mQ+BfX0IdJwFfLSbFYkCx9ROrOfAySVXRkfbIrfhLouK23p
tK97EFNY9vFSug2kM/30Z7x/CDjWXFt2DwsKgFbStUATHDRdK8+BNh8U0LfYDpVO
KLVFnc5dd0sAYaXDo9/Ybv3bEDOeI1/6LJw8xpjfaR5EtFfvs56HpqRvnvjle189
sDMEetuGYr2Av/GXlkjz0FCPqPuHknJjhKfi77PDQTyKjnY0HOPZ+R79NsAhhCuB
EuHkFdhmqM1RZmp6+WAiUJFuWdkkI4TvgY9nCM6IRA/wQDrwd8p4Ly4D/PpgIz0/
c3vktDEc1I0=
=pZtC
-----END PGP SIGNATURE-----

--==_Exmh_1565244495_4269P--
