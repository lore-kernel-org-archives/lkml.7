Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02125CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66AA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bekM1Zv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfJ2M5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:57:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbfJ2M5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:57:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TCunl9081036;
        Tue, 29 Oct 2019 12:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ekEQjLDbbm8ZMI/y+AQ/ISG2wMrHvsYf9NqMlkttQWw=;
 b=bekM1Zv1UT4/zMGEDvJLpyWrlkRCeKaYWzyeH882db96FgRw3l5qHyrPHjtnnV2Md2Kj
 xzkVMOjR+uvGAFTiVDbZ3AXSA729A6UpZQ4Adhx3TVrn0oXwKaLOwb2xqmO5if7dpA5+
 GKaatmiYkTlTUe5SqbE4AfgweaA8umSNunaw6HL5Z2xMSwoD46JO7NJgR5TE0IBGMeJB
 Zqyv+KQRUPZEx38hF7osqf8AsW9sW8tYb6rbTBiTCaJSCRyWnjBX5wEl+sHUHGfPcC0B
 TTTIcB0B5G+MtNYQ9nltyPfElXvEoidbsticef+RipU8Gq3l+fqrOoOSU+H0gTlYR/Lz hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vvdju950a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 12:57:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TChecX130593;
        Tue, 29 Oct 2019 12:55:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vxh9y1ttw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 12:55:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TCtQmg011003;
        Tue, 29 Oct 2019 12:55:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 05:55:25 -0700
Date:   Tue, 29 Oct 2019 15:55:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191029125519.GA1705@kadam>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
 <20191029114750.a7inago2vd2o4lzl@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029114750.a7inago2vd2o4lzl@ltop.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:47:50PM +0100, Luc Van Oostenryck wrote:
> On Tue, Oct 29, 2019 at 01:50:58PM +0300, Dan Carpenter wrote:
> > +static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
> > +{
> > +	struct expression *left = expr->left;
> > +	struct symbol *type;
> > +
> > +	type = get_type(left);
> > +	if (!type || type->type != SYM_PTR)
> > +		return;
> > +	type = get_base_type(type);
> > +	if (type_bits(type) == 8)
> > +		return;
> > +	if (type->type == SYM_RESTRICT)
> > +		return;
> 
> Wouldn't this also silently accept assignments to any bitwise
> type: __le32, __be16, ... ? 

It does, yes.  I'm not sure how big of an issue that is...  I always
just throw a check together and test it before I decide if it's worth
investing more time into it.

regards,
dan carpenter
