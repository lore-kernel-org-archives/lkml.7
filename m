Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5278FC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E9F20843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VPAqTble"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfEPBqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46152 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfEPAeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:34:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so1881969qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ScXaFeR9V6kuvpwBg/U8HCbHPSnAvCsxxSit7yP9Jc8=;
        b=VPAqTble6hRyhsj3VGsjmxvb/J600GeROXMLfbdJ6vJcB2QKVPQa4totwCIhVpAi0n
         fN/2i4xmqUU2K3TkH6isLjLJWlQD30QnMNLx8EUdVTEeWVFZvh/vKoY1nb5krg2tHLCS
         Fub3F2MxHS9blqY/JPQ6blDIYMbCWD0iZTBf3fBxRQFxKqrAD3LbAXUOp4cf1ahMj5mg
         IfS3mvd2iAFmLvH5NZnPLrV+7UsTHdP5gMb058Qqqz20YZd/Hs+TPC9AHHmAkTecNF2H
         MsjLMEBD8xE8AEmL8feaD27CqUASJ7om3ksk/ydwDkv9n/7EMizkt6HnwSCwiQs02cii
         YXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ScXaFeR9V6kuvpwBg/U8HCbHPSnAvCsxxSit7yP9Jc8=;
        b=FbKwH6rKh+RttCTcpGbmGE5Niso7hSzS8H2wYDLXVx9xfKUlW+UYuhjYP8CUgX3FN3
         pdZnTUNGa3yAER3kvPM4XRV4/rPSTri6Pq1zDlxk9eUtPaZYlQrsezUdOdyhQN54Xaqb
         ZKVVQAtxckkiDhJCLLiLXd9Y+EBne83jiP5SkbVD64kHwnZMFjhE2pl/sKJh7Ki1M0vz
         8aKR1itvhNRXpCTTDqtI5H6SqTYf9P/ou6I8a+Z+pthxlOBosl5IvSn4xUV2Og8bVKzS
         qQxZeCF5BWVc0pBEUD+FprpZ5Xt6AqMRWkUQ8Ixq4ZkBvmphsHqqQFHMIX1hbfCrW60I
         L8Xg==
X-Gm-Message-State: APjAAAXP1fAY3n9NL/u4cE2yk/6RJ+Q6shFsVuiVDL1L4si6vZEfDeE8
        wkVun3Y4U9dYkohPiSj6T+daMA==
X-Google-Smtp-Source: APXvYqxhnAL2MaTuSVRizp2xd9h/At7dau6miw7VR54nxw0WijrnCLeY+lfrVIB7bfiMVF28SDOghw==
X-Received: by 2002:aed:20c4:: with SMTP id 62mr39762062qtb.256.1557966861491;
        Wed, 15 May 2019 17:34:21 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b22sm2287417qtc.37.2019.05.15.17.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 17:34:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Date:   Wed, 15 May 2019 20:34:19 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BCECDBE-EC7B-47C6-AF7F-15C67AAA1D6F@lca.pw>
References: <20190514150735.39625-1-cai@lca.pw>
 <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 15, 2019, at 7:25 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>=20
> On Tue, May 14, 2019 at 8:08 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> Several places (dimm_devs.c, core.c etc) include label.h but only
>> label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
>> instead.
>> In file included from drivers/nvdimm/dimm_devs.c:23:
>> drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined =
but
>> not used [-Wunused-const-variable=3D]
>>=20
>> The commit d9b83c756953 ("libnvdimm, btt: rework error clearing") =
left
>> an unused variable.
>> drivers/nvdimm/btt.c: In function 'btt_read_pg':
>> drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
>> [-Wunused-but-set-variable]
>>=20
>> Last, some places abuse "/**" which is only reserved for the =
kernel-doc.
>> drivers/nvdimm/bus.c:648: warning: cannot understand function =
prototype:
>> 'struct attribute_group nd_device_attribute_group =3D '
>> drivers/nvdimm/bus.c:677: warning: cannot understand function =
prototype:
>> 'struct attribute_group nd_numa_attribute_group =3D '
>=20
> Can you include the compiler where these errors start appearing, since
> I don't see these warnings with gcc-8.3.1

This can be reproduced by performing extra compiler checks, i.e, "make =
W=3Dn=E2=80=9D.=
