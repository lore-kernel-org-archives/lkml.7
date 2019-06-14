Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6032BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3042821848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mFSmNdWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFNRsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:48:17 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14416 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:48:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03dde00000>; Fri, 14 Jun 2019 10:48:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 10:48:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 10:48:16 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 17:48:14 +0000
Subject: Re: [PATCH] drm/nouveau/dmem: missing mutex_lock in error path
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-mm@kvack.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190614001121.23950-1-rcampbell@nvidia.com>
 <1fc63655-985a-0d60-523f-00a51648dc38@nvidia.com>
 <f67784db-dada-c827-f231-35549fc046dc@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6e412091-faf4-64b6-bcd8-95193b11a6ec@nvidia.com>
Date:   Fri, 14 Jun 2019 10:48:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f67784db-dada-c827-f231-35549fc046dc@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560534496; bh=8ZilaY5NOYwAFhaPvzhLk/MxmC8VICubaNjNx3N4a0o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mFSmNdWdXrunL+Kmfxc2GVVcBRexDPEWN8Cf9I5nt85sOkU+bpOYcsFznhq/NaaeX
         a5iKxXQ2H9+C9AGr3nzU5XEjAX2ZDLPo0DxYeTQD+ID7+125ebw8k9BdVWuuwQ9MEK
         6gTPjhKY8ZBko1repTxcCB7eqT6Kzv3hFJgAFJefMAJFYF/n4hpe5mXW5wc6tTTPl9
         YocB5IVfiwI2RQEvosnpfO4NcI8dsS1obRGYloyAYJTYyA2VZ5pkZu23SjLUJ/eS9C
         yWds3z5rmjGyRmqsXnVxfjqtmHjBJzI9otX3ep/mV2T9yxsJvt7TCG1A5+06qZWnIu
         j28SxoSKocCEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 10:39 AM, Ralph Campbell wrote:
> On 6/13/19 5:49 PM, John Hubbard wrote:
>> On 6/13/19 5:11 PM, Ralph Campbell wrote:
...
>> Actually, the pre-existing code is a little concerning. Your change pres=
erves
>> the behavior, but it seems questionable to be doing a "return 0" (whethe=
r
>> via the above break, or your change) when it's in this partially allocat=
ed
>> state. It's reporting success when it only allocates part of what was re=
quested,
>> and it doesn't fill in the pages array either.
>>
>>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mut=
ex_lock(&drm->dmem->mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0
>>
>> The above comment is about pre-existing potential problems, but your pat=
ch itself
>> looks correct, so:
>>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>
>>
>> thanks,
>>
> The crash was the NULL pointer bug in Christoph's patch #10.
> I sent a separate reply for that.
>=20
> Below is the console output I got, then I made the changes just based on
> code inspection. Do you think I should include it in the change log?

Yes, I think it's good to have it in there. If you look at git log,
you'll see that it's common to include the symptoms, including the
backtrace. It helps people see if they are hitting the same problem,
for one thing.

>=20
> As for the "return 0", If you follow the call chain,
> nouveau_dmem_pages_alloc() is only ever called for one page so this
> currently "works" but I agree it is a bit of a time bomb. There are a
> number of other bugs that I can see that need fixing but I think those
> should be separate patches.
>=20

Yes of course. I called it out for the benefit of the email list, not to
say that your patch needs any changes.=20

thanks,
--=20
John Hubbard
NVIDIA
