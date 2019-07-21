Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F539C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A120828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGUSEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:04:10 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:46445 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfGUSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:04:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8D5AC18029122;
        Sun, 21 Jul 2019 18:04:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: care78_23d5a97d6b148
X-Filterd-Recvd-Size: 1889
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 18:04:06 +0000 (UTC)
Message-ID: <4154c43331e4d1d361db41194587d3d41cf991b0.camel@perches.com>
Subject: Re: [PATCH] slimbus: fix duplicated argument to ||
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sun, 21 Jul 2019 11:04:04 -0700
In-Reply-To: <20190721174715.GA10747@hari-Inspiron-1545>
References: <20190721174715.GA10747@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 23:17 +0530, Hariprasad Kelam wrote:
> Remove duplicate argument SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION.
> 
> fix below issue reported by coccicheck
> ./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/slimbus/slimbus.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
> index 9be4108..46a6441 100644
> --- a/drivers/slimbus/slimbus.h
> +++ b/drivers/slimbus/slimbus.h
> @@ -438,8 +438,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
>  	return (mt == SLIM_MSG_MT_CORE &&
>  		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
>  		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
> -		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
> -		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
> +		 mc == SLIM_MSG_MC_REQUEST_VALUE));
>  }

Perhaps this was intended to be
		mc ==  SLIM_MSG_MC_REQUEST_CHANGE_VALUE ?


