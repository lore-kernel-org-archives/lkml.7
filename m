Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46462081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="b6Guld/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCHV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:58:11 -0500
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:2882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfCHV6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfwysCAanpxLov1lbi+EGcubxAWHAw/CGWEjLtXXQKc=;
 b=b6Guld/tEeEWmOSoScewFrt9/GfPK6/2Z45AgvIYOA+nPwVF5i9uRVYpoT1Vm1G4EOceW9JSBFQbmuD5YnuQ531Ouyhc2J68+GvKkdbNvQVkAYkKwKiWywD+6TlD+2XvCeTRI222/KkAzlaOgsmX01FpflhudH2w6dyIP/TTqN0=
Received: from BL0PR01CA0015.prod.exchangelabs.com (2603:10b6:208:71::28) by
 DM5PR0102MB3589.prod.exchangelabs.com (2603:10b6:4:a4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.20; Fri, 8 Mar 2019 21:57:29 +0000
Received: from BY2NAM03FT052.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::207) by BL0PR01CA0015.outlook.office365.com
 (2603:10b6:208:71::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.17 via Frontend
 Transport; Fri, 8 Mar 2019 21:57:28 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT052.mail.protection.outlook.com (10.152.85.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Fri, 8 Mar 2019 21:57:28 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x28LvP7o014526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Mar 2019 16:57:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E973F423702; Fri,  8 Mar 2019 16:57:24 -0500 (EST)
Date:   Fri, 8 Mar 2019 16:57:24 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        <linux-kernel@vger.kernel.org>, <yamada.masahiro@socionext.com>,
        <michal.lkml@markovi.net>, <apw@canonical.com>, <joe@perches.com>,
        <linux-kbuild@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: Debian build polishing
Message-ID: <20190308215724.GA22319@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1552049064-32044-1-git-send-email-info@metux.net>
 <20190308175703.GA7178@lambda>
 <fe53cd84-5953-786a-3a4f-6eac652a1cdd@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe53cd84-5953-786a-3a4f-6eac652a1cdd@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(52956003)(486006)(6266002)(47776003)(8936002)(11346002)(476003)(1076003)(86362001)(6246003)(126002)(446003)(106466001)(2906002)(23726003)(336012)(88552002)(3480700005)(305945005)(4326008)(246002)(103686004)(2616005)(356004)(5660300002)(36756003)(229853002)(75432002)(478600001)(186003)(50466002)(42186006)(46406003)(33656002)(6916009)(8676002)(786003)(36906005)(4744005)(26826003)(316002)(97756001)(76176011)(26005)(58126008)(106002)(16586007)(54906003)(7116003)(90966002)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3589;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7126e7e8-de48-4d5f-98d0-08d6a4110e97
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR0102MB3589;
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3589:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3589;20:uOekqgrFGGA0r7K7a7VP6HnjzpAQfKbgZb3qgZiGV8fj6tlvAGZb+8Y+TL9RVbeanCbrWVBoK1Ih64mgYPiiiXIeYzhk5+7EzTtHs2t/y4iISLtO6k81wkhD2B72hh8oukfl/aBrfHA5vmcnjNzCAobd4x/TzmaVhHExft2JcXwAlMV/yzyM1YkK2vSK90WaYNz9QfZMeseX66PZC3DoK+2HU8kRthI6bQ+6q2y80OX/o5npiVUfCdo+nqKfUm0gAFCUUMS1nqhacvrTig4zaH/O7JYLrWm6cpNdzrXTrMFtCSL0vaCgVOpnieEItat7T4M9tSUDrVq9OLe+jUegkIIQh8Brhlkxgu8f0BF32U//w1lhHz/XivakaWI5P4G8NB7KoYiHeBoV3N0/P1NVLnEcUKrIQKxhH3bXE6q4VKnxLw9wxhxpOgMh4a3lYr5DjPvUoCAeeJghiNy1eGWNSkYZiSxj3F3f460J7vD+1jDlVr8IlboZhhGxuKRcJr2MfMvgQ5UKGwkRJjjwhvn9zIhRcabAHeweUxlAt2ETI2Psy/MbO8UUnuWUcAbnTCvAUTJluOHvcflEzda/eRtJsAs74mpf6cQSKomi5++SxFY=
X-Microsoft-Antispam-PRVS: <DM5PR0102MB3589723D05A72F06F6E0AAADB54D0@DM5PR0102MB3589.prod.exchangelabs.com>
X-Forefront-PRVS: 0970508454
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0102MB3589;23:RSJZhEZAz9BWH7vwWMkDgv4hAmKr4kjb3gOzOoo?=
 =?us-ascii?Q?R+uMPAao5j//CrcgPRzYhJqSFi0+Ui6BiGJGLkPgD3QhfPjUHYDlwoHSXJ+/?=
 =?us-ascii?Q?vWf2p+ko3aY471QEYnKrKEkbC+W0ksSZYy0Qvp6yAHzclFisD+j/4PtVyySO?=
 =?us-ascii?Q?HF/3/AVgyaCjfKYN31bu9oP9sRzWJKEA9mzAlxnM3m266AL+SBePQFAbl5z5?=
 =?us-ascii?Q?DvL8u8mSWejHGckYpw4j7AYMaudte5Lfv7sjMqxKJx5eHJYQ2o3AgH/LhEME?=
 =?us-ascii?Q?DHd/4ApZRNJBz2pV3ky1l0pucxuhDfZQkFHjklFj2V9lACJ3BUJsQNQkDZPO?=
 =?us-ascii?Q?wDzf5G9unQU71N5omazf5O588l606tyruZUWeeycCvIdxjPQSV7duI/F7+UF?=
 =?us-ascii?Q?85Knsr1kf8p4PqcAS/QZXqhVocpqTc/uWPwL6gmWD+LzFdEx4KkeAcNeokQV?=
 =?us-ascii?Q?+TMUyoI9/zKve4cPLCjjHdo2Gf2/BMwk0/vmKzgHSVKSLjx6/tKITd3vPXkU?=
 =?us-ascii?Q?fPQ6olRkF7paWIVLn+n5ZVkFvO6r5GzJHNM0z/QRhWyTp1IEX02sJ7LRW3k7?=
 =?us-ascii?Q?+Fy7WPJx5Uh0PEZD0IAcrzMfIEaqSLy93+KOXScFRmtbEJqkUPwY/bDA2COH?=
 =?us-ascii?Q?eXk6jGc9rDDaLmkj1m8vd58xKKYZeRf1w5+Euki+ss/R2OXept6SWcB3K2Nc?=
 =?us-ascii?Q?Iz1S6pe4+10iyxf/fwPYMibQAmRsB2TMjKrWC9o2a2/rA+XY7Q5MryePqbKd?=
 =?us-ascii?Q?eIIWx0sCAhHP5c1eMbg9FYHkurXppbYEvZugd/VMuJewAxm7mfZf/p7g+MTO?=
 =?us-ascii?Q?6u/fGO4JufPIQYNG7jh0rm5x+6//d/0gisGBKorYtiXtxuiEHcJHC0Ssug03?=
 =?us-ascii?Q?Oey0m87jsQW1XSUeP6t8uFDkNyO4KWsSoFlI6Y9Dx91taIUVYnd7INUACfIm?=
 =?us-ascii?Q?OUUeKgOIz31KvrsBT7t5qGBa7W+IWRJvcZl/THZoJPb51OynKtVGcqWLKjq4?=
 =?us-ascii?Q?j4Bf6ONm7oYV7kxzfRDIJ5IDayGHEibQqFQeBcVJX2BXYj55XpAsim0QDLwL?=
 =?us-ascii?Q?v/t4u4TQleukmrl0MO1Y4iSn+nwQRBahZVRct1pRJHK52lXaIjPG1k8xWagr?=
 =?us-ascii?Q?DI8Y8kVEC0pEnGw2Y12PgJRCVhp522cTqWf3ZH4PYqPTkDt64UfuG82tzcDq?=
 =?us-ascii?Q?Rfp8Wx0HAhMdcvHV379APtmmhUuGVc20uBADDaMPvLeAZgo/KbVUIuATkFC4?=
 =?us-ascii?Q?6P/XL3q4tQYzaIpYvgkhUvIEp+XDJQcdToRycVoqueqGWkZ9ncgBrD73dLd6?=
 =?us-ascii?Q?nog=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9PB9BGHrSQB0GJ3Dblxsd5Ezi6utNwnKeZSV36Mw32UDTIbsFhgTm9qtr8+khlZhpRY+DfDgF0kxYQiEaCz2azxwRPf0GfXOtebvJJox7sXnPi+OgHMgaEM7NUhQwc5x18UZg9LHGQXsZiG3k2HEiu0QMwpyo2rlU9aevi9Z0ex3mlcB6HGiNKjM8Q3KpQfDMPDr8qk+IZmuDKQdcqFm8FxOlZGZcn9WQV8gVi8CVAer71rWTw1Z4Uqez81oVR+8h3WxLNU9Yv0uDZurmXpirASfNv1HE1iTIQkrShvtFtRyrQ1yCbHAaLK7fJ2lh76ZyJqetnKAaEOMoxWTfDRSBcbMwHypxeLWIpQu/vvmBHBg8kJPGWMXI3uM1t7iahC6MBZPUPF5fwG4zwPdtlMxC15bnqXTtsH75jcJXWW37Kk=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2019 21:57:28.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7126e7e8-de48-4d5f-98d0-08d6a4110e97
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:10:19PM +0100, Enrico Weigelt, metux IT consult wrote:
> > So I really hope your patches don't break this.  
> 
> It shouldn't (at least I dont intend to). Haven't tried where exactly
> the generated debian/rules file lands in your case.

The full debian directory lands in the O= directory.  So presumably
you could make it work for use case if there was a "make O=/build/dir
debian-prepare" which copies the necessary debian/ files into the
build directory and then someone could cd into /build/dir and run
"dpkg-buildpackage"?

						- Ted
