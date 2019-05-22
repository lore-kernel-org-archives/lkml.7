Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E81EC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7345B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdwyQq62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfEVJYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:24:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36098 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:24:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M9OGtK174736;
        Wed, 22 May 2019 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9IPMfVTY25vatSS0rekM5Mp3zOdIvyjUj7a4OsqASVQ=;
 b=sdwyQq62FkEtrx+6BlhW7QBH5p8j/so8Jz/mLtkvu2Wlz8H9nih0TtC/ezTKs/w5dIlI
 t3SjNHfv2m4BcLnYitOPUmznD3nM68aRMP2TBSazrVMqOHBzRTdawDrLxZPUqX01Ja3b
 5q4aMGBHfBoex7Sukj94hgNYD5RUyctBtaynGjO/eIdc7ZyIOu+hdVQ8FUy5qHNJKvYW
 peJC2p5Rv89YwkQPJTWCU0ec7+OUieMWBiVby7MYvszJ8/IA9G6fGutKVraoNYKt5/iY
 XlB1GAILsQKN30J+858GaN2Xl9SJkSZLd8qOElYY372XORezRwfMkbXTPTspF1ro19Kb pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2smsk5aewc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 09:24:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M9OBWw193984;
        Wed, 22 May 2019 09:24:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2smsh1gaq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 09:24:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4M9OLjb018487;
        Wed, 22 May 2019 09:24:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 09:24:20 +0000
Date:   Wed, 22 May 2019 12:24:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Richard Smith <richardsmith@google.com>
Subject: Re: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
Message-ID: <20190522092412.GR31203@kadam>
References: <20190521174221.124459-1-natechancellor@gmail.com>
 <CAKwvOdmgpx0+d905PdRqUFeg8Fj8zf3mrWVOho_dajvEWvam9w@mail.gmail.com>
 <CAKwvOdmpHOMwVM+d_W3eeu3xC+nZqBTO_hx9Wf1z10yivxSe7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmpHOMwVM+d_W3eeu3xC+nZqBTO_hx9Wf1z10yivxSe7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:57:46PM -0700, Nick Desaulniers wrote:
> > > -       if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
> > > -           (param->u.wpa_ie.len && !param->u.wpa_ie.data))
> >
> > Right so, the types in this expression:
> >
> > param: struct ieee_param*
> > param->u: *anonymous union*
> > param->u.wpa_ie: *anonymous struct*
> > param->u.wpa_ie.len: u32
> > param->u.wpa_ie.data: u8 [0]
> > as defined in drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295
> > https://github.com/ClangBuiltLinux/linux/blob/9c7db5004280767566e91a33445bf93aa479ef02/drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295-L322
> >
> > so this is a tricky case, because in general array members can never
> > themselves be NULL,


Unless they array was the first struct member, obviously.


> >  and usually I trust -Wpointer-bool-conversion, but
> > this is a special case because of the flexible array member:

Nah.  It's the same thing.  That patch is fine.

regards,
dan carpenter

