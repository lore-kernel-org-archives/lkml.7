Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169A20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4ZDS5Wql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfC1Sia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfC1Sia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SIIWL7070308;
        Thu, 28 Mar 2019 18:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VaExLmQemnn9CDijBVicEhjrqH1R+DbKf1057t7VzpQ=;
 b=4ZDS5WqlekdO97wCf2B0yiUj5sDGM0ld5mcd6S/b4gScgS27eS0v8i43XrxOFPz8YtzA
 u24R0ZG7PWuDcuptZbXnZY5kY4CRCbsxVaS9I36WyFEqPT2g+h4JXNhgDVYn1toAtSzX
 rE89vjaQ0d7gWke1c9LxRieX4lo0Y0ETVfaU/Z96U+qLZgG1YtQ/zZo0ZhfZW/oHksuP
 sCq7bpETKlNH15z7qu/P3v9uQcNBGYzgRK1aQ6nI1BzfqKZvwpVkV9V32l+GuOlQZigv
 bNzAZN4ZU6YHMiFcmHKhmAUHCMmY5/qgwG8QvHtPqTObwUcQGNfVgHtjJ2hF2IfM+zR9 yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1ge7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 18:38:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SIc8Di031153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 18:38:08 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2SIc5le010805;
        Thu, 28 Mar 2019 18:38:05 GMT
Received: from tomti.i.net-space.pl (/10.175.199.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 11:38:05 -0700
Date:   Thu, 28 Mar 2019 19:37:58 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        corbet@lwn.net, konrad.wilk@oracle.com, kanth.ghatraju@oracle.com,
        boris.ostrovsky@oracle.com, dpsmith@apertussolutions.com
Subject: Re: [PATCH 0/1] [RFC] Secure Launch boot protocol
Message-ID: <20190328183758.zv2xtqrdrehwpcpp@tomti.i.net-space.pl>
References: <20190311150423.15979-1-ross.philipson@oracle.com>
 <54a6bc26-584f-322a-2089-be96472e2d4f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a6bc26-584f-322a-2089-be96472e2d4f@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9209 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=825 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:15:53AM -0700, H. Peter Anvin wrote:
> So, per our conversation today, lets create a new, readonly, data structure
> pointed to by a single field in setup_header, in order to preserve what little
> space we have left in that structure (a whopping 24 bytes...)
>
> The new data structure will have a header consisting of a magic number and a
> length field; if we want to be really paranoid we could add a checksum/crc.
>
> The existence of this new readonly structure will be announced by bumping the
> boot protocol to 2.15.
>
> The presence of your new boot launch capability (trenchboot) will be indicated
> by a new bit in xloadflags.
>
> I thought hard about this, and I have come to the conclusion that the new
> structure is better off in the .rodata section of the compressed kernel rather
> than in the setup area, for the following reasons, some of which are
> theoretical and unlikely to apply anywhere in the near future, but don't
> actually hurt to address right off the bat:
>
> a. The future size of the structure would not be artificially constrained by
>    the 32K hard limit on the setup area;
> b. It is one less level of indirection in the build tools;
> c. It adds a possibly unnecessary dependency on the setup area, which could
>    possibly be awkward for some boot loaders (unlikely, but...);
> d. It would allow this new structure to also carry information that might be
>    useful to the decompressor for whatever reason.

Thank you for your help. I will try to post the patches next week.

Daniel
