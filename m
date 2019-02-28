Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FA7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CdHdgI4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfB1N4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:56:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54236 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbfB1N4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:56:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SDrkUx072980;
        Thu, 28 Feb 2019 13:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AnSV16BWU6ZICyMuI2YDl0upxNWLL2KYJXjKVaKDYuk=;
 b=CdHdgI4XFAAmkFKHJEAxZ6YwzdSerPUhFayIy893RRVBJv9vVdd24gB1xWjw9j5fXAXH
 ZAZFYjwgNIusuMTq5QgUbMbQi9lwmcrlSG5lPuE5rM24Np4b9qyTLKTesQY24zXlT4Yk
 iKjHwdG8Vqfa3JArqgUX3v/Byu6hIfKLWSZkPAmxYvjC5WgBoNZaoz6bBtgYhkKcK1NM
 1RoVkijZ8tdyUNcForUttJQOw8SbajQbf1dpGXWbd6gnhwynoFDZ8NbMZh0dFEy7ox1w
 SXO36q6z1YV99dx6s0A93mDkGm3o8NieYzirGwBMOYibvZcAffcCjaSsbh0hlLxR+kYZ pQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qtupeh9h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 13:54:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1SDsRon025517
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 13:54:27 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1SDsLk6017266;
        Thu, 28 Feb 2019 13:54:21 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 05:54:20 -0800
Date:   Thu, 28 Feb 2019 16:54:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, wfg@linux.intel.com
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
Message-ID: <20190228135403.GD9806@kadam>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
 <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
 <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9180 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=676 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 01:03:24AM -0800, Brendan Higgins wrote:
> you could do:
> 
> if (IS_ERR_OR_NULL(ptr)) {
>         KUNIT_FAIL(test, "ptr is an errno or null: %ld", ptr);
>         return;
> }

It's best to not mix error pointers and NULL but when we do mix them,
it means that NULL is a special kind of success.  Like we try to load
a feature and we get back:

    valid pointer <-- success
    null          <-- feature is disabled.  not an error.
    error pointer <-- feature is broken.  fail.

regards,
dan carpenter
