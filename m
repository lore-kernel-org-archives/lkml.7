Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6576C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75053218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfB1U11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:27:27 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:46966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbfB1U10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:27:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 946DB182CED34;
        Thu, 28 Feb 2019 20:27:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coil39_5da1330438955
X-Filterd-Recvd-Size: 1572
Received: from XPS-9350 (unknown [172.56.44.28])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Feb 2019 20:27:23 +0000 (UTC)
Message-ID: <d169efc03143e1cec2f4d20f66381517c6c6bc55.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8192e: Fix space and suspect issue
From:   Joe Perches <joe@perches.com>
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Feb 2019 12:27:20 -0800
In-Reply-To: <1551377249-12142-1-git-send-email-oscargomezf@gmail.com>
References: <1551377249-12142-1-git-send-email-oscargomezf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 19:07 +0100, Oscar Gomez Fuente wrote:
> These changes fixed a checkpatch error for space required before the
> open brace '{' as well as a warning for suspect code indent for
> conditional statements.

Simple enough, thanks.

> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
[]
> @@ -541,8 +541,8 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
>  		if (idx < 1 || idx > NUM_WEP_KEYS)

trivia:

the idx < 1 here test is superfluous as idx
is an int masked with 0xff and can't be < 1
if also non-zero

Original code:

	idx = encoding->flags & IW_ENCODE_INDEX;
	if (idx) {
		if (idx < 1 || idx > NUM_WEP_KEYS)
			return -EINVAL;
		idx--;
	}


