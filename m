Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE2C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B356720872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WghLOMh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfERHVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:21:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:21:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4I7JNQR174161;
        Sat, 18 May 2019 07:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=pzUeYhNTyTFhn2BzHGEtd88/1n15zyJy5iw5Ni9edjk=;
 b=WghLOMh9jtUKlzHlcn0SFvkiFaWUxruNkMjq7QxdYJIhXE90l26aiF1RgnBVYlQJeZVl
 +IgdAlxpKi7t3fvtCFY+kfr68BHePcpjuSVeEryvNtTX9/q6vqxPk1z4HsZBNcHodC4D
 ApnL8M8jtS/PKQA3dvWDZY5mewOUoZf7LSz0PxXPFWLmS7naZJXgtfeOmHgX4uEYdMju
 17s/OeFzwMt/apJ4Y7KF9LelRxXsx1Gf1O8lyzNs/W0KcQIwboNuPHWOQl3mBWKX84PE
 wAVYMPU+oqNg+TgmB3w+ayh3iQ5IiPoxb361qWc4DQ26r1Th8cw7b7i3YWS8Soz1bBT5 Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sj9ft0d03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 May 2019 07:21:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4I7L29h065782;
        Sat, 18 May 2019 07:21:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sj75sb2vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 May 2019 07:21:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4I7L7bA030412;
        Sat, 18 May 2019 07:21:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 May 2019 07:21:06 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.1+ merge window
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1558104285.3050.8.camel@HansenPartnership.com>
        <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
Date:   Sat, 18 May 2019 03:21:04 -0400
In-Reply-To: <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 17 May 2019 14:20:14 -0700")
Message-ID: <yq1bm009qjj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905180054
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905180054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

> No. That code is insane. It looks very fishy indeed to me, and I'm not
> pulling it this late in the game.

Yeah, my mess. Sorry.

A couple of people poked me about this issue last week. I merged the
patch without much scrutiny since several people had commented and
tested when it was originally posted a few months back. In looking over
the changes again, however, I agree with your assertion that it is
fishy.

> Just revert the oneliner SCSI change that caused the regression.

My patch wasn't exclusively trying to address the regression wrt. drives
that temporarily come up read-only. Device or fabric events can also
trigger revalidate and there's a whole can of worms in that department
thanks to the intersection between device characteristics changing and
the partition table potentially being updated. This was my feeble
attempt at fixing several long-standing issues in the read-only device
handling which we occasionally hit.

I'll drop the offending patch and revert Jeremy's change for now. And
then revisit the gorge of eternal peril that is revalidate...

-- 
Martin K. Petersen	Oracle Linux Engineering
