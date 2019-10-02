Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B393ECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E9C20842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stwcx.xyz header.i=patrick@stwcx.xyz header.b="ovYg3uWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJBDAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:00:45 -0400
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21995 "EHLO
        sender4-of-o59.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfJBDAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 23:00:45 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 23:00:44 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1569984317; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=X+x1fBqLgbkQ/HGOvQ90VVYlVocTC4Qrkes4dnMtaoUTUnFUOIX0PTKGAHCYQz4Ew9Z6eF+VRzg0U9sSJB+8EExz9wmEa5PGhti+54XuVxhzD2dSMSBN6qkSkvVZ4OJkxX76tG+FpL3tTYbQM2uOCGju39n7wgmBhgb8FN8iexw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1569984317; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Y65TYuhuLI2LCKd2i7wZHzGe+IIxg6hi6mtRxdTLakM=; 
        b=Plsfb1j5YyX1QIHQ3OvdQtkRyPWTtXiD03lqAyQFJS9YWK+QU+Z8xyGtlGuM26Iqvb7wQEmH3/gioYz0lObrDjmy0AXDhY8VJDnXN6rM5l2eZ7+A3sfJfY9ih4shpOAjNjvb/hrOqlsIHRF9rK7q9BRf68fQ6EnlHY7NB3wloXY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=stwcx.xyz;
        spf=pass  smtp.mailfrom=patrick@stwcx.xyz;
        dmarc=pass header.from=<patrick@stwcx.xyz> header.from=<patrick@stwcx.xyz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1569984317;
        s=zoho; d=stwcx.xyz; i=patrick@stwcx.xyz;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1010; bh=Y65TYuhuLI2LCKd2i7wZHzGe+IIxg6hi6mtRxdTLakM=;
        b=ovYg3uWA5rMVaSuCeYchem58/Xrkynnsaxu9bhooWA++/jiu92W0pC9tRx8+Y2x+
        vtWL6HrG5PEqCrXx/Vp++M02OiCoaisWMiGMBnbmCjxdlzDnaZvJa4pDlD0pgUWaz2E
        wxu/zMPd+eYXKb3KV+9EhMk/zgvB7NtQ2XxX01GA=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1569984310604701.88758278745; Tue, 1 Oct 2019 19:45:10 -0700 (PDT)
Date:   Tue, 01 Oct 2019 19:45:10 -0700
From:   Patrick Williams <patrick@stwcx.xyz>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     "Patrick Williams" <alpawi@amazon.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        "linux-hwmon" <linux-hwmon@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <16d8a5b6d4b.118d8b6f685481.1504538702961589684@stwcx.xyz>
In-Reply-To: <20191001230210.GA15354@roeck-us.net>
References: <20191001160407.6265-1-alpawi@amazon.com> <20191001230210.GA15354@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus) add VR12/VR13 mode support write paths
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---- On Tue, 01 Oct 2019 16:02:10 -0700 Guenter Roeck <linux@roeck-us.net> =
wrote ----
=20
 > > -    val =3D clamp_val(val, 500, 1600);=20
 > > +    switch (data->info->vrm_version) {=20
 > > +    case vr11:=20
 > > +        val =3D clamp_val(val, 500, 1600);=20
 > > +        return 2 + DIV_ROUND_CLOSEST((1600 - val) * 100, 625);=20
 > > +    case vr12:=20
 > > +        val =3D clamp_val(val, 0, 1520);=20
 > > +        return ((val - 250) / 5) + 1;=20
 > > +    case vr13:=20
 > > +        val =3D clamp_val(val, 0, 2500);=20
 > > +        return ((val - 500) / 10) + 1;=20
 > =20
 > Both vr12 and vr13 converts low values into negative values,=20
 > which are then converted into more or less random register=20
 > values. That can not be correct. The resulting register values=20
 > must always be valid.=20
 > =20
 > Guenter=20

Thanks for catching this.  It may be as simple as me adjusting the lower
bound on the clamp_val.  I=E2=80=99ll check with one of the device specs an=
d
confirm the appropriate behavior on the lower bounds.

