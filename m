Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113862196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfKLRMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:12:01 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:56135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbfKLRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:12:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 74F6D18224083;
        Tue, 12 Nov 2019 17:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cats71_68b4d1f30855c
X-Filterd-Recvd-Size: 1580
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 17:11:59 +0000 (UTC)
Message-ID: <c243860eeabf9406d166deb6204a69255c51867d.camel@perches.com>
Subject: Re: [PATCH 7/9] staging: rtl8723bs: Fix incorrect type in argument
 warnings
From:   Joe Perches <joe@perches.com>
To:     "Javier F. Arias" <jarias.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Date:   Tue, 12 Nov 2019 09:11:42 -0800
In-Reply-To: <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
References: <cover.1573577309.git.jarias.linux@gmail.com>
         <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 11:55 -0500, Javier F. Arias wrote:
> Fix incorrect type in declarations to solve the 'incorrect
> type in argument 3' warnings in the rtw_get_ie function calls.
> Issue found by Sparse.
[]
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
[]
> @@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
>  {
>  	struct iw_event iwe;
>  	u16 cap;
> -	u32 ht_ielen = 0;
> +	sint ht_ielen = 0;

more likely the rtw_get_ie function should used u32
and not sint.

one day a sed of 's/\bsint\b/int/g' would be good too.



