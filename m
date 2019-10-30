Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxRUvdWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfJ3XZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 19:25:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbfJ3XZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572477918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ1MSZzMLDEO0OgbsgxLdqPc9Wad6rEGEERX1y/YXuc=;
        b=AxRUvdWVU/6hEgZcrTSJwW/JyS0uVmxw82HO3MWTbTxv7LlahI6GqqfaOLLY1gJRkybLYt
        fjEsVb1vggFgCoVtNce24oPnk6cUnCkWZkQjypbApkAFLiqNYM79ZfjLTIQ+w6ViM90xSj
        HXKPc/zNREMk51Ky2sEkJJWkc3lyGAE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-uSCEycfVOsyhzNy2N8-fpg-1; Wed, 30 Oct 2019 19:25:16 -0400
Received: by mail-qt1-f200.google.com with SMTP id f2so4198989qtv.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 16:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQFkVyYFi8hag3At5ZE72O/aG1IU1WcgEzzZGm8W/yY=;
        b=S4+XZqgerRAkfjypDkU5gLFtV2FXrygR+ygeqbAfDgOFhHB/9cf6hobZekZBzH1u+0
         mDfXdCYIXG08r0VQVgK624EtFKAj6ONgGXsBaBno1iiYCIhZdXzk5/Y2ZnjXbR17ZGjy
         0njFFB3BzFDZ7vuTEIAZqVmZLphqhV6/1H2gGuHHUuV0qPsbaYYQL68BO/85PInUeTle
         kb3YZ9cgk5jH+pcu4qiR389zEEYOCeduR25MiyXNJlTris8xTfhWL7VdL/LALOKwVxpT
         s8zMKeN6Nm+sREstuY7YfkTBGcdmhgXws30Eifye1vNWaln6Vh2T1lzms9idUkhTHCc2
         bx9Q==
X-Gm-Message-State: APjAAAWOKpki/nH7wxPEgYmBgH05E38bQI7G2mNHx6c/lB0CaoeT7JE9
        UnIgCGD4jjMvt6XMIRIPH1Z4nuvdr1SJR1AXUzoHUBXEYOFUugIOFojHT9kEUj73g/kTigJ6d1r
        akfLvm4eqLtys9a7U4HUysO+/
X-Received: by 2002:a0c:fd63:: with SMTP id k3mr1679810qvs.185.1572477915995;
        Wed, 30 Oct 2019 16:25:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqya63mUMpcS/++yI/vMJ7TUMWDzAtmYepIWeYl2T0nCu7UdIJ2I0dwkq34m7+mgWtvRrwkPPw==
X-Received: by 2002:a0c:fd63:: with SMTP id k3mr1679787qvs.185.1572477915731;
        Wed, 30 Oct 2019 16:25:15 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
        by smtp.gmail.com with ESMTPSA id v13sm791419qkv.132.2019.10.30.16.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 16:25:15 -0700 (PDT)
Date:   Wed, 30 Oct 2019 19:25:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yin Fengwei <fengwei.yin@intel.com>
Subject: Re: linux-next: manual merge of the vhost tree with the pm tree
Message-ID: <20191030192308-mutt-send-email-mst@kernel.org>
References: <20191029151928.780c8ede@canb.auug.org.au>
 <2535052.Q9mzRWFaI7@kreacher>
MIME-Version: 1.0
In-Reply-To: <2535052.Q9mzRWFaI7@kreacher>
X-MC-Unique: uSCEycfVOsyhzNy2N8-fpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:13:57PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, October 29, 2019 5:19:28 AM CET Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the vhost tree got a conflict in:
> >=20
> >   drivers/acpi/processor_idle.c
> >=20
> > between commit:
> >=20
> >   fa583f71a99c ("ACPI: processor_idle: Skip dummy wait if kernel is in =
guest")
> >=20
> > from the pm tree and commit:
> >=20
> >   a04c0533b07c ("ACPI: disable extra P_LVLx access on KVM")
>=20
> Well, if this touches code under drivers/acpi/, it should have been CCed =
to
> linux-acpi@vger.kernel.org, but I don't recall seeing it.

It's an old RFC, posted a couple of years ago.
I guess I can drop it for now.


> > from the vhost tree.
> >=20
> > I fixed it up (I just used the pm tree version) and can carry the fix a=
s
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> >=20
> >=20
>=20
>=20
>=20

