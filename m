Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FBC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365E21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFZRlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:41:46 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:43102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbfFZRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:41:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DA62C18038B43;
        Wed, 26 Jun 2019 17:41:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: roof68_8382be6ddc757
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 17:41:43 +0000 (UTC)
Message-ID: <0ecf55be612b2ac5f40045796e54bb1ee758d3e4.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to
 improve code style
From:   Joe Perches <joe@perches.com>
To:     Tobias =?ISO-8859-1?Q?Nie=DFen?= 
        <tobias.niessen@stud.uni-hannover.de>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Sabrina Gaube <sabrina-gaube@web.de>
Date:   Wed, 26 Jun 2019 10:41:41 -0700
In-Reply-To: <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
         <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 16:28 +0200, Tobias Nießen wrote:
> This commit uses the fact that
> 
>     if (a) {
>             if (b) {
>                     ...
>             }
>     }
> 
> can instead be written as
> 
>     if (a && b) {
>             ...
>     }
> 
> without any change in behavior, allowing to decrease the indentation
> of the contained code block and thus reducing the average line length.

unrelated and trivially:

> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
[]
> @@ -4507,20 +4507,19 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
[]
> +			if (sd_lock_state &&
> +			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
> +				sd_card->sd_lock_status |= (
> +					SD_UNLOCK_POW_ON | SD_SDR_RST);

This could go on a single line like the &= ~() equivalent below.
It hardly matters if it's > 80 chars.

> +				if (CHK_SD(sd_card)) {
> +					retval = reset_sd(chip);
> +					if (retval != STATUS_SUCCESS) {
> +						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> +						goto sd_execute_write_cmd_failed;
>  					}
> -
> -					sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
>  				}
> +
> +				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
>  			}
>  		}
>  	}

