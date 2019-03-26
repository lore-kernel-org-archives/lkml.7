Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D962084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ipxJtVHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCZNwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:52:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44242 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:52:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QDheMM025966;
        Tue, 26 Mar 2019 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=hlceh8J3UDHjopzvH0T6OmT5CXF+sN3ZUycoWQT6P2o=;
 b=ipxJtVHVa8TePkRxY9VPWO/oNkzjmPCNqh9NxijVEQsVYVq8MvQbS929Nj8+8NnAadQw
 tPT77xcbL4bJS3Tf4+RSCiT3LctyrFNwAdRvlz/s/q5DHrypZiTw8DtpnFiiErGMA/iZ
 hDy8EfbmGt/Q8j0NHc4RVqRz+HRSc0I0OWEZB5LJYv/vCJbcYxAjGJ/Cb+O9alEl47SB
 MwjzN6G1Ey/Ys6n+W2iMIDFfJYcElDTTepuboG3TOmxAq7CTO56k6F+lnenLlv03Q0Yd
 cWDmHI7OsGZlnwXGfl/uPJGwrzOVZOZKKy8g90bg4BQ6jKQsJ7ePXrNHqly3Ir/Gs5a+ kg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g0tgbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:52:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2QDqBpC027245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:52:11 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2QDq9e2020614;
        Tue, 26 Mar 2019 13:52:09 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 06:52:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CONFIG_DEBUG_VIRTUAL breaks boot on x86-32
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
Date:   Tue, 26 Mar 2019 07:52:07 -0600
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1B7F481-4BF6-4441-8019-AE088F8A8939@oracle.com>
References: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
To:     Meelis Roos <mroos@linux.ee>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=991 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this still happen on 5.1-rc2?

Do you have idea as to what max_low_pfn() gets set to on your system at =
boot time?

=46rom the screen shot I'm guessing it MIGHT be 0x373fe, but it's hard =
to know for sure.


> On Mar 21, 2019, at 2:22 PM, Meelis Roos <mroos@linux.ee> wrote:
>=20
> I tried to debug another problem and turned on most debug options for =
memory.
> The resulting kernel failed to boot.
>=20
> Bisecting the configurations led to CONFIG_DEBUG_VIRTUAL - if I turned =
it on
> in addition to some other debug options, the machine crashed with
>=20
> kernel BUG at arch/x86/mm/physaddr.c:79!
>=20
> Screenshot at http://kodu.ut.ee/~mroos/debug_virtual-boot-hang-1.jpg
>=20
> The machine was Athlon XP with VIA KT600 chipset and 2G RAM.
>=20
> --=20
> Meelis Roos <mroos@linux.ee>
>=20

