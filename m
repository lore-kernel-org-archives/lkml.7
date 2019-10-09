Return-Path: <SRS0=89K8=YG=kvack.org=owner-linux-mm@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD7C4360C
	for <linux-mm@archiver.kernel.org>; Sun, 13 Oct 2019 01:31:08 +0000 (UTC)
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by mail.kernel.org (Postfix) with ESMTP id 8C6FB2089C
	for <linux-mm@archiver.kernel.org>; Sun, 13 Oct 2019 01:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TPnX+oMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6FB2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=owner-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix)
	id CB6796B0003; Sat, 12 Oct 2019 21:31:06 -0400 (EDT)
Received: by kanga.kvack.org (Postfix, from userid 40)
	id C40888E0001; Sat, 12 Oct 2019 21:31:06 -0400 (EDT)
X-Delivered-To: int-list-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id AB84B6B0006; Sat, 12 Oct 2019 21:31:06 -0400 (EDT)
X-Delivered-To: linux-mm@kvack.org
Received: from forelay.hostedemail.com (smtprelay0179.hostedemail.com [216.40.44.179])
	by kanga.kvack.org (Postfix) with ESMTP id 8942F6B0003
	for <linux-mm@kvack.org>; Sat, 12 Oct 2019 21:31:06 -0400 (EDT)
Received: from smtpin01.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by forelay04.hostedemail.com (Postfix) with SMTP id 2AC704DA4
	for <linux-mm@kvack.org>; Sun, 13 Oct 2019 01:31:06 +0000 (UTC)
X-FDA: 76037032932.01.bean37_26a1930366232
X-HE-Tag: bean37_26a1930366232
X-Filterd-Recvd-Size: 13685
Received: from listssympa-test.colorado.edu (listssympa-test.colorado.edu [128.138.129.156])
	by imf10.hostedemail.com (Postfix) with ESMTP
	for <linux-mm@kvack.org>; Sun, 13 Oct 2019 01:31:05 +0000 (UTC)
Received: from listssympa-test.colorado.edu (localhost [127.0.0.1])
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/sympa) with ESMTPS id x9D1UqYT007273
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Oct 2019 19:30:52 -0600
Received: (from root@localhost)
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/submit) id x9D1UohR007236;
	Sat, 12 Oct 2019 19:30:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=linux-foundation.org;
 s=google;       
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to       
  :cc;        bh=rELG+/plJf3q+d36O9HDInY1Dcun/TTnnrXLzjvo97I=;       
 b=TPnX+oMwcZyLImXtu7vSmBJQjvRZnSeQpjwCcSjIw1iXfTFPyHdDvmfv+2sxkpfUyj        
 JFzZ1ddVjpVh5f2wFQpWMAb1+pTNRk6pnMCBs485QzCeAoFiVhQRRIOvJXJq1c8093k8        
 4e41ajmn2pB8buojmlyKC7PzJa0CJ57eJp4cM=
Received: from BN6PR03MB2753.namprd03.prod.outlook.com (2603:10b6:a02:bc::19) by
 BYAPR03MB4376.namprd03.prod.outlook.com with HTTPS via
 BYAPR07CA0006.NAMPRD07.PROD.OUTLOOK.COM; Wed, 9 Oct 2019 19:49:33 +0000
Received: from BYAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:a02:a8::48) by
 BN6PR03MB2753.namprd03.prod.outlook.com (2603:10b6:404:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Wed, 9 Oct
 2019 18:00:28 +0000
Received: from BY2NAM01FT034.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e42::201) by BYAPR03CA0035.outlook.office365.com
 (2603:10b6:a02:a8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 18:00:28 +0000
Received: from ipmx2.colorado.edu (128.138.128.232) by
 BY2NAM01FT034.mail.protection.outlook.com (10.152.69.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2347.16 via Frontend Transport; Wed, 9 Oct 2019 18:00:27 +0000
Received: from mx.colorado.edu ([128.138.128.150])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 11:09:51 -0600
Received: from mx.colorado.edu ([128.138.128.150])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 10:31:29 -0600
Received: from vger.kernel.org ([209.132.180.67])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 10:07:23 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand        id
 S1731683AbfJIQHW (ORCPT <rfc822;michael.gilroy@colorado.edu>);        Wed, 9
 Oct 2019 12:07:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35935 "EHLO       
 mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org       
 with ESMTP id S1731234AbfJIQHW (ORCPT       
 <rfc822;linux-kernel@vger.kernel.org>);        Wed, 9 Oct 2019 12:07:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so2098514lff.3        for
 <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:07:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])   
     by smtp.gmail.com with ESMTPSA id i6sm568201lfo.83.2019.10.09.09.07.17  
      for <linux-kernel@vger.kernel.org>        (version=TLS1_3
 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Wed, 09 Oct 2019
 09:07:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y23so3040363lje.9        for
 <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:07:17 -0700 (PDT)
Authentication-Results: spf=none (sender IP is 128.138.128.232) smtp.mailfrom=vger.kernel.org;
 o365.colorado.edu; dkim=pass (signature was verified)
 header.d=linux-foundation.org;o365.colorado.edu; dmarc=bestguesspass
 action=none header.from=linux-foundation.org;
Received-SPF: None (protection.outlook.com: vger.kernel.org does not designate permitted
 sender hosts)
IronPort-SDR: PCQZCy0ACVqgAQU+YRufnwZIhyYYLIEPEi8+MXrl9h67sEfGHKfKRSzuDY+n1+jgOT/idQ4reM
 bdlW7y0Nwt4vBQ01NWxif64QRbj057yu4=
IronPort-SDR: UhArpILFg1e97oZElb7G7T7fU7B0DwmBKyR50o+Tymk/Tftui7vIWUsSkNspiZViDneq/I3QhT
 XXffTlNnR6dZ9FMe7O3adwHqZSNw21AnU=
IronPort-SDR: Z1TtrTHYycADHbKrhCeCR2s47jkWb8RtQ5XuvXf6Ova/v7mSN0vkkeevoFTC8+Naa+mCrf1p88
 6klS3lNOndu1ryo0z23bB5s7LgQ4HsPTU=
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-Original-Recipients: gasiewsk@o365.colorado.edu
X-Original-Recipients: migi9492@g.colorado.edu
Authentication-Results-Original: mx.colorado.edu; dkim=pass (signature verified) header.i=@linux-foundation.org
IronPort-PHdr: =?us-ascii?q?9a23=3Au9U7nRaGeJwU4uQYifX9Yq7/LSx+5ufYHS8wr7?=
 =?us-ascii?q?c5grZTe7ii+JK+YheN+6A03xfACJ/A4rdfi+OM7v6zEWdV+5uFuWAPfNtWWh?=
 =?us-ascii?q?sMmcgazGlCSIbNQQWzZLbmOig7GtlSEVFi4ne3OFRUH8C4YEfd8TWpuDEVHR?=
 =?us-ascii?q?r7OFkQRKy9Usaax4z/17W3+pjeJhtFniG8ZrUgNhi4oB/csMIbmtljLOMrxw?=
 =?us-ascii?q?PNsz5UfLZY32Rtd16agxuu48qr55ds/mFRt6A66sRCXK7mLbg/KN4QRHxuey?=
 =?us-ascii?q?h9rIW5vhKQKGnHrjNUGi1e2hBIVhLoyD65GY/1kCWhr6lxg3e9bO3abLYFAB?=
 =?us-ascii?q?ip8qEsdCPujj03Eyw77maG1e0l38c56Frp71Q3i8beNb2tMso9eYbCduELYU?=
 =?us-ascii?q?tEbtpMCDJ6B6meVokRNdgHButht4vijFA1rzqhXAicCt/B8i5oilPo2KMkkL?=
 =?us-ascii?q?46AQLe0jExHbds+Dyc5J29fO9ac86n/vDEwQvBd81WhDmn96bxai8EiPvVHq?=
 =?us-ascii?q?pMV/DSl1EpMijvlQnA9LX3FD680coMjWii1dBBcvyNu0w+8goh+mn0xZdJ6M?=
 =?us-ascii?q?GBzspdghiMvXl0nN88J9i+ElZRMdS5F5lVszC5HNROUOErG0pK5Xk36KVasr?=
 =?us-ascii?q?vuL2AajZU9wBjHbOabNpKF+Q/nSLOJKCxj1yg/Kpuimxa/91ShweTgV86ylW?=
 =?us-ascii?q?xHtTdBjsKT5iIIx1rY7cyAUPJx+QGs1SvcnwzQ6+QROUkvjuKbMJ8uxLcsi4?=
 =?us-ascii?q?Ae+VrOBC74mUj6zeeWe0wo9/Lu6rHPZrTgu4/ZOYhpjA33LqUpnIq4G+s1?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0GfAwCmBZ5dh0O0hNFlHQEBAQkBEQU?=
 =?us-ascii?q?FAYF7ghuBRDEqhCOJAoVagg8UmwwPAQEBAQEBAQEBBwEYFAECAQEBhxEjOBM?=
 =?us-ascii?q?CAQIJAQEBAwEBAQIBBQIBAQICEAEBAQoLCQgphTQMhDAsDVRkAQEBAwECDxE?=
 =?us-ascii?q?EGQEBNwEFCQEBCgsNAgImAgIDHxIBBQEcBhMFHYMAggujdYEDPIoxdX8zgn0?=
 =?us-ascii?q?BAQWHNgkSeiiMDhiBf4QjPodSgliPOIYSgSWWWIIsgi+SahuCKhCLQYtFLY8?=
 =?us-ascii?q?/l3cCCgcGDyOBRoF7TTAIbAaCNVAQFIFPiQeFXyIygQYBAZNdAQE?=
X-IPAS-Result: =?us-ascii?q?A0GfAwCmBZ5dh0O0hNFlHQEBAQkBEQUFAYF7ghuBRDEqh?=
 =?us-ascii?q?COJAoVagg8UmwwPAQEBAQEBAQEBBwEYFAECAQEBhxEjOBMCAQIJAQEBAwEBA?=
 =?us-ascii?q?QIBBQIBAQICEAEBAQoLCQgphTQMhDAsDVRkAQEBAwECDxEEGQEBNwEFCQEBC?=
 =?us-ascii?q?gsNAgImAgIDHxIBBQEcBhMFHYMAggujdYEDPIoxdX8zgn0BAQWHNgkSeiiMD?=
 =?us-ascii?q?hiBf4QjPodSgliPOIYSgSWWWIIsgi+SahuCKhCLQYtFLY8/l3cCCgcGDyOBR?=
 =?us-ascii?q?oF7TTAIbAaCNVAQFIFPiQeFXyIygQYBAZNdAQE?=
X-IronPort-AV: E=Sophos;i="5.67,276,1566885600";    d="scan'208";a="414040373"
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;       
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date        
 :message-id:subject:to:cc;       
 bh=rELG+/plJf3q+d36O9HDInY1Dcun/TTnnrXLzjvo97I=;       
 b=s/0Ln7Pld1jfikZMtrj/rGlVbsb0DDsTE1j/vxlPfRmojqO38derewYzNo+G0Eln0B        
 RxsnVNBIMNL3mOKyt+aqZpgqk4WqWz4FzHzD5Fiav7OFe730jvFwjRsEtFVVvBewNAFt        
 5bswWTBhQ8quiUO+kGdCXpTwX1cNNIhWXFk5YS90evR8YBKEvRo9Bp5Au0Rm+YCG0Tv6        
 iib09cVZsED6OkX30Us6G9fDVFx07tKiglYeq0rwVaxHGfDpZFiFvZbBHrRRBLx2/Mo5        
 JycvD28Gttqzqf09oLq8lz8OzO1WRkoqLlapYUwcDxo+kYPmwjeABEpk0RJ2WJ5FaUwT        
 UlDA==
X-Gm-Message-State: APjAAAWMeJtV/H/ZEs5bzCqdw3bYQF5zR9wJKKuIFIqWZUQ7xqMmfsBF       
 7nPc5JWrVYMWsuZLFS1OnI3JM6rp5m8=
X-Google-Smtp-Source: APXvYqw3G2cuz7qdvPPQi9EMel/ifloICn7seBmuSxhsZ++7U2pzlKrdyXqCerIocL5HakIaU2PSgw==
X-Received: by 2002:a19:f707:: with SMTP id z7mr2511154lfe.162.1570637239228;        Wed,
 09 Oct 2019 09:07:19 -0700 (PDT)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr2902767ljg.82.1570637236839; Wed, 09 Oct
 2019 09:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-3-thomas_os@shipmail.org>
 <20191009151400.bserdtpoczmawqn5@box>
In-Reply-To: <20191009151400.bserdtpoczmawqn5@box>
From: "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 9 Oct 2019 09:07:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=zsXPmSTJJgEgVr4ebgwTQ-wx-P1c7+koJAK-h2f_vQ@mail.gmail.com>
Message-ID:
 <CAHk-=wh=zsXPmSTJJgEgVr4ebgwTQ-wx-P1c7+koJAK-h2f_vQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] mm: pagewalk: Take the pagetable lock in walk_pte_range()
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
X-MS-Exchange-Organization-ExpirationStartTime: 09 Oct 2019 18:00:27.3421 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: c03a7ee0-edec-4391-63c3-08d74ce290e4
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-Forefront-Antispam-Report: CIP:128.138.128.232;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:BN6PR03MB2753;H:ipmx2.colorado.edu;FPR:;SPF:None;LANG:en;;SKIP:1;
X-MS-Exchange-Organization-AuthSource: BY2NAM01FT034.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: colorado.edu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03a7ee0-edec-4391-63c3-08d74ce290e4
X-MS-TrafficTypeDiagnostic: BN6PR03MB2753:|BN6PR03MB2753:
X-MS-Exchange-Organization-SCL: -1
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Microsoft-Antispam: BCL:0;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 18:00:27.1112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03a7ee0-edec-4391-63c3-08d74ce290e4
X-MS-Exchange-CrossTenant-Id: 3ded8b1b-070d-4629-82e4-c0b019f46057
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3ded8b1b-070d-4629-82e4-c0b019f46057;Ip=[128.138.128.232];Helo=[ipmx2.colorado.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2753
X-MS-Exchange-Transport-EndToEndLatency: 01:49:07.5629438
X-MS-Exchange-Processed-By-BccFoldering: 15.20.2347.014
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(750127)(520002050)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yn8/hJmnmQCOJJiLC8hEAQRGXCq4bdA4gEygKwTaLzECdUMzVum52UPb5tlt?=
 =?us-ascii?Q?B5Glydl3KTDPzVAu9ucBqS9vgXO2eWpwQLLMk78ZbbkqvolLXk5huqmtpVWZ?=
 =?us-ascii?Q?vo4ul2ywYM2n50m8wDhOCWVwGYX+FyRmYqa5a+Igd7vq04CbDpkjbqYYap2C?=
 =?us-ascii?Q?f4Hi4RotOXugNFQ7hZkNy7cNfm275X/mBbUDAsGNcXGy2kXyYLkr6prIVn/q?=
 =?us-ascii?Q?Go15e2svl98+zLkBaiFKldlBxRyDqsBChrxXPtJBSpzzQeNdb5jHsnwCSvI9?=
 =?us-ascii?Q?o7VMA4cm34TeRmrgopK89L1dz7T/N6pv+qr0+x8XuA/hbYLKP4DH55/sa7xI?=
 =?us-ascii?Q?jqcHBLJMPAIjqATmImS4miVBa+S+sKgRhOSz3nKe+DPG8QRDQjkDDz0I/UdT?=
 =?us-ascii?Q?o7DfpAlSL9Z/8Yhv+UvBFlRxq7c8oi3HlNlhCM5CKACm6QmlNZTLFsVr//5J?=
 =?us-ascii?Q?d3qsLEuxH4eQs8pu4nnw0Nqqf1UynBU/wWCVwPvJhx+GbTf5I/P5I9seYs9c?=
 =?us-ascii?Q?z7rXhPXTW2kZFq5hac1kt2n8GYgjYJAH6teKF24PmBXdZimIi20L/bDUaz5M?=
 =?us-ascii?Q?BaT6+AZiVxI/L7CtlGWJGYylB60DBPt4ylNC4wOXN9pzaTanCw6NsPrCobKW?=
 =?us-ascii?Q?Pz3I1M6bf59QCG2oghJZEHodgqfBoUMOqyr4TWM+M/EqVmInYI9KrECGwrN4?=
 =?us-ascii?Q?0b2obcpkOfuKS5pNw4hg3UlymURn0wdUUv3RmEy5U7f36n/gKrk0gArd81E7?=
 =?us-ascii?Q?I+GXwX8MopopPZvSCffMiR9l8rCzD4RzHhiIJ7FRqTfJ6DKKQlwWPmWlWcOQ?=
 =?us-ascii?Q?qr5W7yAguZM/B9zJNI0/RNEJe26TQUrRo39FDXllG1N9QyIOf0qPhRMrh70N?=
 =?us-ascii?Q?mrddQK55TDwpZQG9vOAcPpiEa02+Yw95mjpC2JC6VYvkK/gWGq6OstnUzf3r?=
 =?us-ascii?Q?ZtSFdtWYhyDLs1/euTdNJw3Xe9Z4T/gVKRbURi9cs67MUhbRUfZkhsKUkGlz?=
 =?us-ascii?Q?0zj7gDTGZ8m9NTtKyTDTKlhRrmKyJ038uI6XZucd3w9anC/viee4i+BgHt+7?=
 =?us-ascii?Q?N5Gi4AKQK65aEfmFbqVI1IiXvFzzL+nlu5SbcoEU4dmJjXiZuSaBlJy+U+rG?=
 =?us-ascii?Q?ZY3cEwDFZqAZQKCXU3fu5gDn6JhB70+WeTt1Xc55fdtC2509PyhiQPvIxzi2?=
 =?us-ascii?Q?1YwPYG/xLxBjTpKoG0Z7d2Sl8bjIcG5HeaqaGp2ssW9gvqfHsdXg1/f1CJ4?=
 =?us-ascii?Q?=3D?=
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.4
Sender: owner-linux-mm@kvack.org
Precedence: bulk
X-Loop: owner-majordomo@kvack.org
List-ID: <linux-mm.kvack.org>
Message-ID: <20191009160700.-GwsyNHQHn14due1gvjwHii6_pRmaEXcZmd9yoGN2Ks@z>

On Wed, Oct 9, 2019 at 8:14 AM Kirill A=2E Shutemov <kirill@shutemov=2Ename=
> wrote:
>
> If ->pte_entry() fails on the first entry of the page table, pte - 1 will=

> point out side the page table=2E
>
> And the '- 1' is totally unnecessary as we break the loop before pte++ on=

> the last iteration=2E

Good catch=2E Too much copying the wrong pattern from other sources=2E

I do wish we didn't have this pattern of "update pte, then do
pte_unmap as long as it's in the same page"=2E Yeah, it avoids a
variable, but still=2E=2E=2E But it is what it is, and we just need to be
careful=2E

             Linus


