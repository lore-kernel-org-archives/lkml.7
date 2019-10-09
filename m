Return-Path: <SRS0=gBIz=YF=kvack.org=owner-linux-mm@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4FEC4360C
	for <linux-mm@archiver.kernel.org>; Sat, 12 Oct 2019 22:57:43 +0000 (UTC)
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by mail.kernel.org (Postfix) with ESMTP id 05319206CD
	for <linux-mm@archiver.kernel.org>; Sat, 12 Oct 2019 22:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hgOaZG0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05319206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=owner-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix)
	id 69AED6B0003; Sat, 12 Oct 2019 18:57:42 -0400 (EDT)
Received: by kanga.kvack.org (Postfix, from userid 40)
	id 670D46B0005; Sat, 12 Oct 2019 18:57:42 -0400 (EDT)
X-Delivered-To: int-list-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 4EB8B6B0006; Sat, 12 Oct 2019 18:57:42 -0400 (EDT)
X-Delivered-To: linux-mm@kvack.org
Received: from forelay.hostedemail.com (smtprelay0138.hostedemail.com [216.40.44.138])
	by kanga.kvack.org (Postfix) with ESMTP id 1F99F6B0003
	for <linux-mm@kvack.org>; Sat, 12 Oct 2019 18:57:42 -0400 (EDT)
Received: from smtpin11.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by forelay03.hostedemail.com (Postfix) with SMTP id A1E368188229
	for <linux-mm@kvack.org>; Sat, 12 Oct 2019 22:57:41 +0000 (UTC)
X-FDA: 76036646322.11.cows91_8de997882a37
X-HE-Tag: cows91_8de997882a37
X-Filterd-Recvd-Size: 16326
Received: from listssympa-test.colorado.edu (listssympa-test.colorado.edu [128.138.129.156])
	by imf08.hostedemail.com (Postfix) with ESMTP
	for <linux-mm@kvack.org>; Sat, 12 Oct 2019 22:57:40 +0000 (UTC)
Received: from listssympa-test.colorado.edu (localhost [127.0.0.1])
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/sympa) with ESMTPS id x9CMvTxo003852
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Oct 2019 16:57:29 -0600
Received: (from root@localhost)
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/submit) id x9CMvS2t003842;
	Sat, 12 Oct 2019 16:57:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=linux-foundation.org;
 s=google;       
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to       
  :cc;        bh=irS7MxIYNB2GnGgL6wf/xO0qtWPCVd7suxRiO2KO4D4=;       
 b=hgOaZG0duKaUR4d25pSryy7RdP9qviemEvzHvt19d0TSAxr0BfqQR3ZWYSTwR0r+9u        
 i9iGymA9O3sH36uqhsrDUmdMcx0o8kfeXMJ8ye9WqAc6tizygENJM3wRYYfRkyG/AtPb        
 7SOGImdQZPDoEJKjK/Y9RwyexInoc9meO+hR0=
Received: from DM6PR03MB3482.namprd03.prod.outlook.com (2603:10b6:a03:14b::17) by
 BYAPR03MB4376.namprd03.prod.outlook.com with HTTPS via
 BYAPR06CA0040.NAMPRD06.PROD.OUTLOOK.COM; Wed, 9 Oct 2019 20:44:15 +0000
Received: from BYAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:a02:a8::14) by
 DM6PR03MB3482.namprd03.prod.outlook.com (2603:10b6:5:ae::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
 id 15.20.2327.24; Wed, 9 Oct 2019 18:18:54 +0000
Received: from SN1NAM01FT008.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e40::200) by BYAPR03CA0001.outlook.office365.com
 (2603:10b6:a02:a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 18:18:54 +0000
Received: from ipmx7.colorado.edu (128.138.128.233) by
 SN1NAM01FT008.mail.protection.outlook.com (10.152.64.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
 id 15.20.2347.16 via Frontend Transport; Wed, 9 Oct 2019 18:18:53 +0000
Received: from mx.colorado.edu ([128.138.128.150])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 11:24:12 -0600
Received: from ipmx4.colorado.edu ([128.138.67.75])  by mx.colorado.edu with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 10:44:52 -0600
Received: from vger.kernel.org ([209.132.180.67])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 10:21:30 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand        id
 S1731805AbfJIQV3 (ORCPT <rfc822;michael.gilroy@colorado.edu>);        Wed, 9
 Oct 2019 12:21:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41361 "EHLO       
 mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org       
 with ESMTP id S1729644AbfJIQV2 (ORCPT       
 <rfc822;linux-kernel@vger.kernel.org>);        Wed, 9 Oct 2019 12:21:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so2109441lfn.8        for
 <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:21:27 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])   
     by smtp.gmail.com with ESMTPSA id g3sm561999lja.61.2019.10.09.09.21.25  
      for <linux-kernel@vger.kernel.org>        (version=TLS1_3
 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Wed, 09 Oct 2019
 09:21:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y23so3088426lje.9        for
 <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:21:25 -0700 (PDT)
Authentication-Results: spf=none (sender IP is 128.138.128.233) smtp.mailfrom=vger.kernel.org;
 o365.colorado.edu; dkim=pass (signature was verified)
 header.d=linux-foundation.org;o365.colorado.edu; dmarc=bestguesspass
 action=none header.from=linux-foundation.org;
Received-SPF: None (protection.outlook.com: vger.kernel.org does not designate permitted
 sender hosts)
IronPort-SDR: 9wYZ4LKv8WpFOJwcsOHZ6TOw+W9PbzprRcXLtdRlVwUbh1VMkDa+zxoYqbgcahpPj/DTRPe/qL
 UIuD7zoWVt8L0Ogj0VmTidyfS2paOxjdI=
IronPort-SDR: +e9ukjPIr7i0iSS77lp/nNymx6H8aCdp40u4bIdiEFWaQBB3bZNTehCZ8ABM2W1ljMK79rNPie
 JIJQ197v02JW1piBcMe2283UNn0gpxQro=
IronPort-SDR: io8+2YqAO9zqU+UNkUjwkuX9opZi2DUDJbv8dAd8C33jNXk5LkisdUFLzwHIU74vZbf/ocyW+I
 Fc1pgt7NA1tyFoV6nesAyMl99TSMpbQdQ=
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Authentication-Results-Original: mx.colorado.edu; dkim=pass (signature verified) header.i=@linux-foundation.org
IronPort-PHdr: =?us-ascii?q?9a23=3AQbufChbjFj44OaN0NO7fv3z/LSx+5ufYHS8wr7?=
 =?us-ascii?q?c5grZTe7ii+JK+YheN+6A03xfACJ/A4rdfi+OM7v6zEWdV+5uFuWAPfNtWWh?=
 =?us-ascii?q?sMmcgazGlCSIbNQQWzZLbmOig7GtlSEVFi4ne3OFRUH8C4YEfd8TWpuDEVHR?=
 =?us-ascii?q?r7OFkQRKy9Usaax4z/17W3+pjeJhtFniG8ZrUgNhi4oB/csMIbmtljLOMrxw?=
 =?us-ascii?q?PNsz5UfLZY32Rtd16agxuu48qr55ds/mFRt6A66sRCXK7mLbg/KN4QRHxuey?=
 =?us-ascii?q?h9rIW5vhKQKGnHrjNUGi1e2hBIVgnf107fTrbAlAGgmexS1w3EIsOxXZdsQC?=
 =?us-ascii?q?id14xVREDzlTc9Nhlj00aLppAl38c56Frp71Q3i8beNYGaE/NMUfvRYPATeF?=
 =?us-ascii?q?AdUpwMTxdbE5LjVYc3XvMfPOtdgpfvh0US9EqyXTWXLfP1khVGn0bMhp8F4t?=
 =?us-ascii?q?8dDjuexk9xArds+Dyc5J29fO9aULG047jN5GTkNOh2gmng8YjTaDwcpP2pVq?=
 =?us-ascii?q?IodprSx0QfMiGVn1jBlpXMNG2J1/YcvEW9zc87StieumAdqBBe5RGz/s1J6M?=
 =?us-ascii?q?GBzspdghiMvXpC56kUINGBenZXZvOGM5lz8BDLDZRnT9MDRWZj6SM37f4Gg8?=
 =?us-ascii?q?buL2AajZU9wBjHbOabNpKF+Q/nSLOJKCxj1yg/Kpuimxa/91ShweTgV86ylW?=
 =?us-ascii?q?xHtTdBjsKT5iIIx1rY7cyAUPJx+QGs1SvcnwzQ6+QROUkvjuKbMJ8uxLcsi4?=
 =?us-ascii?q?Ae+VrOBC74mUj6zeeWe0wo9/Lu6rHPZrTgu4/ZOYhpjA33LqUpnIq4G+s1?=
IronPort-PHdr: =?us-ascii?q?9a23=3AJBrhrhYnSt3L7Ufti4jMDaf/LSx+5ufYHS8wr7?=
 =?us-ascii?q?c5grZTe7ii+JK+YheN+6A03xfACJ/A4rdfi+OM7v6zEWdV+5uFuWAPfNtWWh?=
 =?us-ascii?q?sMmcgazGlCSIbNQQWzZLbmOig7GtlSEVFi4ne3OFRUH8C4YEfd8TWpuDEVHR?=
 =?us-ascii?q?r7OFkQRKy9Usaax4z/17W3+pjeJhtFniG8ZrUgNhi4oB/csMIbmtljLOMrxw?=
 =?us-ascii?q?PNsz5UfLZY32Rtd16agxuu48qr55ds/mFRt6A66sRCXK7mLbg/KN4QRHxuey?=
 =?us-ascii?q?h9rIW5vhKQKGnHrjNUGi1e2hBIVgnf107fTrbAlAGgmexS1w3EIsOxXZdsQC?=
 =?us-ascii?q?id14xVREDzlTc9Nhlj00aLppAl38c56Frp71Q3i8beNYGaE/NMUfvRYPATeF?=
 =?us-ascii?q?AdUpwMTxdbE5LjVYc3XvMfPOtdgpfvh0US9EqyXTWXLfP1khVGn0bMhp8F4t?=
 =?us-ascii?q?8dDjuexk9xArds+Dyc5J29fO9aULG047jN5GTkNOh2gmng8YjTaDwcpP2pVq?=
 =?us-ascii?q?IodprSx0QfMiGVn1jBlpXMNG2J1/YcvEW9zc87StieumAdqBBe5RGz/s1J6M?=
 =?us-ascii?q?GBzspdghiMvXpC56kUINGBenZXZvOGM5lz8BDLDZRnT9MDRWZj6SM37f4Gg8?=
 =?us-ascii?q?buL2AajZU9wBjHbOabNpKF+Q/nSLOJKCxj1yg/Kpuimxa/91ShweTgV86ylW?=
 =?us-ascii?q?xHtTdBjsKT5iIIx1rY7cyAUPJx+QGs1SvcnwzQ6+QROUkvjuKbMJ8uxLcsi4?=
 =?us-ascii?q?Ae+VrOBC74mUj6zeeWe0wo9/Lu6rHPZrTgu4/ZOYhpjA33LqUpnIq4G+s1?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0FVBADqEJ5dh0tDioBlHgELHIQWgXU?=
 =?us-ascii?q?qhCOJAoVZgg+bGxQBAQEBAQEBAQEHARgVAgEBAYcRIzgTAgECCQEBAQMBAQE?=
 =?us-ascii?q?CAQUCAQECAhABAQEKCwkIKYU0DIQwLA1UYwEBAQECAQECDxEdAQE3AQQBCQE?=
 =?us-ascii?q?BCgsNAgImAgIDHxIBBQEcBhMFHYMAgXwPo3yBAzyKMXWBMoJ9AQEFhzQJEno?=
 =?us-ascii?q?ojA4YgX+EIz6HUoJYjQWCM4YSgSWHZY5zgiyCL5JqG4I6h06Dc4tFLac2Ago?=
 =?us-ascii?q?HBg8jgUaBe00wCGwGgjVQEBSBTziIT4VfIzGBCJNdAQE?=
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0FfBABnDZ5dh0O0hNFlHgELHIQWgUQ?=
 =?us-ascii?q?xKoQjiQKFWoIPFJsHFAEBAQEBAQEBAQcBGBQBAgEBAYcRIzgTAgECCQEBAQM?=
 =?us-ascii?q?BAQECAQUCAQECAhABAQEKCwkIKYU0DIQwLA1UYwEBAQECAQECDxEdAQE3AQQ?=
 =?us-ascii?q?BCQEBCgsNAgImAgIDHxIBBQEcBhMFHYMAgXwPpAaBAzyKMXWBMoJ9AQEFhzc?=
 =?us-ascii?q?JEnoojA4YgX+EIz6HUoJYjQWCM4YSgSWHZY5zgiyCL5JqG4I6h06Dc4tFLac?=
 =?us-ascii?q?2AgoHBg8jgUaBe00wCGwGgjVQEBSBTziIT4VfIjKBBgEBk10BAQ?=
X-IPAS-Result: =?us-ascii?q?A0FVBADqEJ5dh0tDioBlHgELHIQWgXUqhCOJAoVZgg+bG?=
 =?us-ascii?q?xQBAQEBAQEBAQEHARgVAgEBAYcRIzgTAgECCQEBAQMBAQECAQUCAQECAhABA?=
 =?us-ascii?q?QEKCwkIKYU0DIQwLA1UYwEBAQECAQECDxEdAQE3AQQBCQEBCgsNAgImAgIDH?=
 =?us-ascii?q?xIBBQEcBhMFHYMAgXwPo3yBAzyKMXWBMoJ9AQEFhzQJEnoojA4YgX+EIz6HU?=
 =?us-ascii?q?oJYjQWCM4YSgSWHZY5zgiyCL5JqG4I6h06Dc4tFLac2AgoHBg8jgUaBe00wC?=
 =?us-ascii?q?GwGgjVQEBSBTziIT4VfIzGBCJNdAQE?=
X-IPAS-Result: =?us-ascii?q?A0FfBABnDZ5dh0O0hNFlHgELHIQWgUQxKoQjiQKFWoIPF?=
 =?us-ascii?q?JsHFAEBAQEBAQEBAQcBGBQBAgEBAYcRIzgTAgECCQEBAQMBAQECAQUCAQECA?=
 =?us-ascii?q?hABAQEKCwkIKYU0DIQwLA1UYwEBAQECAQECDxEdAQE3AQQBCQEBCgsNAgImA?=
 =?us-ascii?q?gIDHxIBBQEcBhMFHYMAgXwPpAaBAzyKMXWBMoJ9AQEFhzcJEnoojA4YgX+EI?=
 =?us-ascii?q?z6HUoJYjQWCM4YSgSWHZY5zgiyCL5JqG4I6h06Dc4tFLac2AgoHBg8jgUaBe?=
 =?us-ascii?q?00wCGwGgjVQEBSBTziIT4VfIjKBBgEBk10BAQ?=
X-IronPort-AV: E=Sophos;i="5.67,276,1566885600";    d="scan'208";a="287111711"
X-IronPort-AV: E=Sophos;i="5.67,276,1566885600";    d="scan'208";a="369161952"
X-Original-Recipients: gasiewsk@o365.colorado.edu
X-Original-Recipients: migi9492@g.colorado.edu
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;       
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date        
 :message-id:subject:to:cc;       
 bh=irS7MxIYNB2GnGgL6wf/xO0qtWPCVd7suxRiO2KO4D4=;       
 b=s7qNf92+8rGOw0CTPGshX55OfmaeOfOa7+icxWPft9EuMagAAZf/ZfPAKdYSNxJt+8        
 +Qlzk/AbjGQwf7wqM/TNVh81otUcbbaoVjcXenf0iMcEvsg56C/hYrNROGbusq9BfkEg        
 K3vPGIe7yEAav8Bh7ectR3zDuguPLxdtumz265H1T3pxhuUjmquIoK8pMJUCAk+J2o2u        
 ncdbh3e6pMKlvyoSrk1DvNNoBA5favPsaxlIbXi/3KZ3sJVK8WfYcMUZQhx5UJ+bRgZj        
 BK/MU5Iv0oPH3Y4sImkuiB3whjpDs7kSHi8tHPLr6DL5hJz2WpnJQo+7mmqPdGuuXXZC        
 vu5A==
X-Gm-Message-State: APjAAAVzxZsd9zLN0me4+ZEIUaQ0MJWm8XDW0xGKAzITGMYoy4WU07XW       
 IZ7bHWs9M4QQ+XAWRh5jeLhW0JH97vk=
X-Google-Smtp-Source: APXvYqx6Hzcam3Ypq+uO0EThIbAXbuamzgKedPDH9H04UCAxe/N17wkL0ltqQAX02aff/F4sfTqLiQ==
X-Received: by 2002:a19:4b8f:: with SMTP id y137mr2730491lfa.19.1570638086080;       
 Wed, 09 Oct 2019 09:21:26 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr2891882ljh.133.1570638084772; Wed, 09
 Oct 2019 09:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
In-Reply-To: <20191009152737.p42w7w456zklxz72@box>
From: "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 9 Oct 2019 09:21:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
Message-ID:
 <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a pmd_entry
 is present
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0gKFZNd2FyZSk=?= <thomas_os@shipmail.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux-MM
 <linux-mm@kvack.org>,
        "Thomas Hellstrom" <thellstrom@vmware.com>,
        "Matthew
 Wilcox" <willy@infradead.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "Peter
 Zijlstra" <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>, "Minchan Kim" <minchan@kernel.org>,
        "Michal Hocko" <mhocko@suse.com>, "Huang
 Ying" <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-MS-Exchange-Organization-ExpirationStartTime: 09 Oct 2019 18:18:53.8367 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: ec4045b8-44ee-4d8e-1310-08d74ce5246a
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-Forefront-Antispam-Report: CIP:128.138.128.233;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:DM6PR03MB3482;H:ipmx7.colorado.edu;FPR:;SPF:None;LANG:en;;SKIP:1;
X-MS-Exchange-Organization-AuthSource: SN1NAM01FT008.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: colorado.edu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec4045b8-44ee-4d8e-1310-08d74ce5246a
X-MS-TrafficTypeDiagnostic: DM6PR03MB3482:|DM6PR03MB3482:
X-MS-Exchange-Organization-SCL: -1
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Microsoft-Antispam: BCL:0;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 18:18:53.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4045b8-44ee-4d8e-1310-08d74ce5246a
X-MS-Exchange-CrossTenant-Id: 3ded8b1b-070d-4629-82e4-c0b019f46057
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3ded8b1b-070d-4629-82e4-c0b019f46057;Ip=[128.138.128.233];Helo=[ipmx7.colorado.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3482
X-MS-Exchange-Transport-EndToEndLatency: 02:25:22.6979855
X-MS-Exchange-Processed-By-BccFoldering: 15.20.2347.014
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(750127)(520002050)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WnJ3I5LnwXB5i+KzJBsMYjbHNyHfcPTpzOurVQpKJ6ul2GxyyCb33PG2P2bT?=
 =?us-ascii?Q?CD7eitaHSHM0uAlqe4IyNbIlazAohUIGvjVTjipKX3a+jhdIRKt46cRy+zQl?=
 =?us-ascii?Q?sIL42RKUVp2Ity0vI2L1XXerHfXll+f1P05zuRKKGKSlS74wuADoiz0IPRbw?=
 =?us-ascii?Q?e2tFtc0U9WKzsWYmR/O0JhlKvdmFarKwyK4qNiGh5vjsI8q18fEL6FGHnDzv?=
 =?us-ascii?Q?G4EpAJb7FWx/oBlsdBwyNQN/Eg9jN/Nkl7twicJ45fcExP2VsJk9UyuiHddI?=
 =?us-ascii?Q?+myWGT1BDIDCTwbR/zgew8YLf7XFss40KobIZ2ZCNCaLJ74QpUf4zTZnpqaj?=
 =?us-ascii?Q?WR8KUKSTf9Y2Kmg7oOAE9dobHpJI4qeIJaATlMlfBIdq298A8LDZtwfRXgsX?=
 =?us-ascii?Q?7SgWKQDS8w20ck4ylh/UYGJcigkuWleuEGfw81lSfyqTGsqw/OZdiNrmZt1H?=
 =?us-ascii?Q?oHtuoWR4MRtewbrJwL/duMMaQacr2vxUsUzslttls503mTvMGquOXZmf86Gz?=
 =?us-ascii?Q?OULjbudBEBT2WO8MoCHTgZ3Ab4UUEx0T0Z0yq+5lfbYkTruFTx1vrJ0k0Gec?=
 =?us-ascii?Q?pdG4Qn3VkthuCATQ74HSKnRzD+jNGLjCCy+WUdvT55z6M6Pi+7iQhSZvGcLT?=
 =?us-ascii?Q?koz7xNH8qD1g21g7mV+sx3L3dY13MYG42OVYJtLKpRzB/HzPY5IVBx4fCSYo?=
 =?us-ascii?Q?Eyp4yJSbZcjp2X8vV6uVhXa4GM12LyP3g2wUm3sZvnIh/FRDHMGJKTxyayxG?=
 =?us-ascii?Q?ru+vtbEJY7LdUrcHl7A++sagGqlTAGhzw8hmQfHQWnlJY+vpXzmMVcfAw90j?=
 =?us-ascii?Q?H0YWBZr9syB6hi/g6/R+fmeRTLmmY8mIp8m0CxjGlkh8HzhyC0njl3cnPZH5?=
 =?us-ascii?Q?gljUjrjWwxPM1nGPsHmbHrtgRVUYOJvud7EBif8bsMxdOBv0vw+MjbJmAh2n?=
 =?us-ascii?Q?5raz6pSIMIAyb9ZazkGx3/wDsgNDIE6qFSgV5ZjLcRLIigu52boNj4HwOo+O?=
 =?us-ascii?Q?IflAcC4f3MzQM7zogmQTfbgD9sqSS6zrb83/RiMs1kTNp2j065Ya0zvpM6z3?=
 =?us-ascii?Q?FUR5DeUlHiVhnfjkkOyyKUIIc1mFjMcTK7k/5IxLy45ZguQpxqc=3D?=
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.4
Sender: owner-linux-mm@kvack.org
Precedence: bulk
X-Loop: owner-majordomo@kvack.org
List-ID: <linux-mm.kvack.org>
Message-ID: <20191009162108.Uy05_u6JT2yoEQ3fAyM2waElD8qgu80t0tkbpQsi4zU@z>

On Wed, Oct 9, 2019 at 8:27 AM Kirill A=2E Shutemov <kirill@shutemov=2Ename=
> wrote:
>
> Do we have any current user that expect split_huge_pmd() in this scenario=
=2E

No=2E There are no current users of the pmd callback and the pte
callback at all, that I could find=2E

But it looks like the new drm use does want a "I can't handle the
hugepage, please split it and I'll fo the ptes instead"=2E

> That's hacky=2E
>
> Maybe just use an error code for this? -EAGAIN?

I actually like the PAGE_WALK_FALLBACK thing as more documentation
than "it's an error, but not one you return", although I do detest the
particular value chosen, which is just a nasty bitpattern=2E

Maybe it could use an error value, just one that makes no sense, and
is hidden by the PAGE_WALK_FALLBACK define, ie something like

  #define PAGE_WALK_FALLBACK (-ECHILD)

or something like that=2E

And I suspect the conditional would be cleaner if it was written something =
like

        if (!err)
                continue;
        if (err !=3D PAGE_WALK_FALLBACK)
                break;
        err =3D 0;
        if (pmd_trans_unstable(pmd))
                goto again;
        =2E=2E do the split =2E=2E

and skip the WARN_ON() and the odd "non-zero but smaller than MAX test"

            Linus


