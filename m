Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E990CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4578208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnHiuN/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbfJ2M5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:57:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2M5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:57:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TCuq2u050432;
        Tue, 29 Oct 2019 12:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=K23I0fHCuQa32+M7xTwe3H0uAQYUSo/omP+J7PzvdJY=;
 b=ZnHiuN/DpHGrlQgU6+5am1guW/1LKNAoS9NN1ZnWWUd3IpmtUZvHoE+zkM/NEgDEz7wR
 cj0a0hNUClAWowCYX5YcLswJFUABQELPeQE27HbqPmCczzFpf+Ew28kHqWqY5FhZvjS5
 Pkj5OkOeZoiOwdSftEtoTOUdvrMfS+diISHd/j4Xy/9RKS//BgZBZiCGIDLc18Nz0XyN
 tN9LTVO70d2Gg0jXE5iu3PfeoxXdffxCoKc12DbJJASQlPyQWLgp6bWiZLFlKJRSNxek
 RcZMn4S+ialvUFWjNSL2O1463+pVVQ2zDx1rGSiAj0gYV+/OzP/emtJ3VVCirjZAvQq4 gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vvumfdtcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 12:57:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TChNZp042107;
        Tue, 29 Oct 2019 12:57:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vwam12pks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 12:57:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TCvGs5008542;
        Tue, 29 Oct 2019 12:57:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 05:57:16 -0700
Date:   Tue, 29 Oct 2019 15:57:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191029125606.GH1922@kadam>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
 <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2019 at 12:43:24PM +0100, Rasmus Villemoes wrote:
> On 29/10/2019 11.50, Dan Carpenter wrote:
> > This should probably work?
> 
> I haven't tested it, but yes, something like that. Can you also do the
> case of struct property::value, i.e. handling
> 
>   struct property *p = ...;
>   u32 *v = p->value;

Attached.

This has a bunch of flaws like "void *value = p->value;" doesn't
generate a warning.  A function that returns a u32 pointer doing
"return p->value;" doesn't generate a value.

Anyway, it's a starting point to experiment with.

regards,
dan carpenter


--0F1p//8PRICkK4MW
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_of_get_property.c"

/*
 * Copyright (C) 2019 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"

static int my_id;

static bool is_u8_or_endian(struct expression *expr)
{
	struct symbol *type;

	type = get_type(expr);
	if (!type || type->type != SYM_PTR)
		return true;
	type = get_base_type(type);
	if (type == &void_ctype)
		return true;
	if (type_bits(type) == 8)
		return true;
	if (type->type == SYM_RESTRICT)
		return true;
	return false;
}

static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
{
	if (is_u8_or_endian(expr->left))
		return;
	sm_warning("'%s' returns big endian data", fn);
}

static void match_assign(struct expression *expr)
{
	struct expression *right;
	struct symbol *type;

	if (expr->op != '=')
		return;
	if (is_u8_or_endian(expr->left))
		return;

	right = strip_expr(expr->right);
	if (!is_void_pointer(right))
		return;
	if (right->type != EXPR_DEREF)
		return;
	if (!right->member || strcmp(right->member->name, "value") != 0)
		return;

	type = get_type(right->deref);
	if (!type || type->type != SYM_STRUCT || !type->ident ||
	    strcmp(type->ident->name, "property") != 0)
		return;

	sm_warning("'(struct property)->value' is big endian");
}

void check_of_get_property(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_function_assign_hook("of_get_property", &match_of_get_property, NULL);
	add_hook(&match_assign, ASSIGNMENT_HOOK);
}

--0F1p//8PRICkK4MW--
