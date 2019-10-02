Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07C7C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803E21929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsoanE9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJBMDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:03:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:03:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92BwidV115138;
        Wed, 2 Oct 2019 12:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5f9WP1t5ZUCUnAU3TFbU22auufKBsGd2ReO5WAV1EVQ=;
 b=gsoanE9ypOdaIJvz2Lmkws6zLs50sjloWhfxTGFIniRY5XGdYQxqfshsvI7qZ7QVVoaH
 YtY0w9g6HoZWV8rDGohb4keAR73zQY2nhrKRUYtwJ8FXZhoC3nUU7wi5fXKVvhf2IdxC
 bEufY9WBp3AkTmNLA2/vkFkUqoDzL8KGVYgE1hY/dd7JTL3+AwK+Hgwbt2TsjkI4G73O
 CNlx9HpqUTjesEmSJUTAyolzL8wPV9u4GRDqgQoym0z1ro3D/0py18majTtuN2oneM8O
 qiZL+FisqUOl4WUi+mwM+qs3h+3VAU/ZhKhK+DTtBzTT1xifbJzmzI7Yr2GtH8vvEdp3 wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v9yfqcen5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 12:02:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92Bw3kx076918;
        Wed, 2 Oct 2019 12:00:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vckyntqya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 12:00:29 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x92C0OHP020718;
        Wed, 2 Oct 2019 12:00:24 GMT
Received: from tomti.i.net-space.pl (/10.175.221.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 05:00:23 -0700
Date:   Wed, 2 Oct 2019 14:00:18 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
Message-ID: <20191002120018.d7wbpf3zusl4dcsc@tomti.i.net-space.pl>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-2-daniel.kiper@oracle.com>
 <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
 <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
 <c9eb5a39-ced5-b35d-616d-6ffbe15c1396@zytor.com>
 <20191001114133.xy5nuhepzzixhuh4@tomti.i.net-space.pl>
 <dda802de-2efe-3d22-7816-6da36bf9ebf8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda802de-2efe-3d22-7816-6da36bf9ebf8@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:28:01PM -0700, H. Peter Anvin wrote:
> On 2019-10-01 04:41, Daniel Kiper wrote:
> >
> > OK, so, this is more or less what I had in my v3 patch before sending
> > this email. So, it looks that I am on good track. Great! Though I am not
> > sure that we should have magic for chunked objects. If yes could you
> > explain why? I would just leave len for chunked objects.
> >
>
> It makes it easier to validate the contents (bugs happen...), and would allow
> for multiple chunks that could come from different object files if it ever
> becomes necessary for some reason.

OK.

> We could also just say that dynamic chunks don't even have pointers, and let
> the boot loader just walk the list.

Yeah... That seams simpler. I will do that.

> >> Also "InfO" is a pretty hideous magic. In general, all-ASCII magics have much
> >> higher risk of collision than *RANDOM* binary numbers. However, for a chunked
> >> architecture they do have the advantage that they can be used also as a human
> >> name or file name for the chunk, e.,g. in sysfs, so maybe something like
> >> "LnuX" or even "LToP" for the top-level chunk might make sense.
> >>
> >> How does that sound?
> >
> > Well, your proposals are more cryptic, especially the second one, than
> > mine but I tend to agree that more *RANDOM* magics are better. So,
> > I would choose "LToP" if you decipher it for me. Linux Top?
> >
>
> Yes, Linux top [structure].

Thx!

Daniel
