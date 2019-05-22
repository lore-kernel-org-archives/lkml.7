Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30939C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5932173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfEVLsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:48:37 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:45688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727464AbfEVLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:48:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4038A100E86C0;
        Wed, 22 May 2019 11:48:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon28_6812e54d5f51b
X-Filterd-Recvd-Size: 1441
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 11:48:35 +0000 (UTC)
Message-ID: <7e2a727333d1d764ae3c0099e050a0521e87d9d8.camel@perches.com>
Subject: Re: [PATCH] message/fusion/mptbase.c: Use kmemdup instead of memcpy
 and kmalloc
From:   Joe Perches <joe@perches.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 04:48:33 -0700
In-Reply-To: <20190522095335.GA3212@bharath12345-Inspiron-5559>
References: <20190522095335.GA3212@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 15:23 +0530, Bharath Vedartham wrote:
> Replace kmalloc + memcpy with kmemdup.
> This was reported by coccinelle.
[]
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
[]
> @@ -6001,13 +6001,12 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
>  	if (mpt_config(ioc, &cfg) != 0)
>  		goto out;
>  
> -	mem = kmalloc(iocpage2sz, GFP_KERNEL);
> +	mem = kmemdup((u8 *)pIoc2, iocpage2sz, GFP_KERNEL);

You should remove the unnecessary cast here.


