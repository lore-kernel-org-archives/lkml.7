Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F7ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BDE21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhSJpgBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503379AbfJQTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:08:21 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35785 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441359AbfJQTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:08:21 -0400
Received: by mail-yb1-f195.google.com with SMTP id i6so1057121ybe.2;
        Thu, 17 Oct 2019 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XGjJBGWBzNHoBfXlGLk+OFOUnYWPc8VecafOj7/Jo8=;
        b=VhSJpgBrLMCK1kZpbEwgcDek/uMN0XUbiXNrZCe8gK9eZn7uvq7SKxl4VmPjSHioUh
         KJtE7K/HQddcP2uXNS/wLBzBQmEOzHAr8XxoK4n4lhOEGrqcvgaN3FVcxNDCin9KlP+6
         /Au77xgl+afURlUk0KY+dBCYlIe5+tSLx0qgaQ72mtDzLQAFTHTkZmmZPB2qZzstRL40
         BQIVyO4jnQedWySrc7E2azJUqKYnNgGjqcCJOIhd3o97oR5knc3xGUW2Wo8qhmVfT+tp
         B5vNK3n/DVpe9UWyglHNgBRv4ghi8TLU3jkbuDmKnh0dzNuoUq1ujVav0akjEE3NeLk5
         X+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XGjJBGWBzNHoBfXlGLk+OFOUnYWPc8VecafOj7/Jo8=;
        b=CzLs/KTgO5rdZC4rKkeuTN3V6W7yV/DfnVqEcHbL+r/2lsg1N01I3m5CwcU0lMpyOt
         T9RCe23/FKh6CDpkYsBqMkK8/jE7wM5wAVzC4OiYfijWifes7yiesyF6Fr3y9T80Fhmd
         fxcUYySE3GqRFrs7zS4+/esIcTDpYTp1KYS0PMorppgeEcZIFKMJRzmF8XE3qjDP+Ps8
         lOWH2d+nUZLJ0FRhmImO0c/m6NW3xb26tbmWNMm2QChwURC8MFGbxyXyrS1PlO/Dr+6I
         Fx+Jr4Xk+0GuPLFCCd9J9N4frnNJFvZxiZo+lbwoC7dY+veHGtHmmva0s/fTSBWY0l2f
         VYvA==
X-Gm-Message-State: APjAAAXKCidn12MtgMzCeTldgagbF8wXagOWQwoo5tj3EkjBLl+1qLC6
        83xtMel9Y7KcMeE5XJI2PkAFw4Cv
X-Google-Smtp-Source: APXvYqwJLh+hMtSO+Bw+p8QZlDDig5Lb+bOqC9lSM8DmwCTTMj+7tQTS3nDUweew7iQSoT3+AbNLvg==
X-Received: by 2002:a25:cf01:: with SMTP id f1mr3556762ybg.386.1571339300559;
        Thu, 17 Oct 2019 12:08:20 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a64sm737640ywe.92.2019.10.17.12.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 12:08:19 -0700 (PDT)
Subject: Re: [PATCH] dtc: fix spelling mistake "mmory" -> "memory"
To:     Colin King <colin.king@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <20190911093123.11312-1-colin.king@canonical.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4aa3bcde-1ad1-98ec-8deb-4a8ab1bbb41c@gmail.com>
Date:   Thu, 17 Oct 2019 14:08:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190911093123.11312-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 09/11/2019 04:31, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  scripts/dtc/fdtput.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/fdtput.c b/scripts/dtc/fdtput.c
> index a363c3cabc59..3755e5f68a5a 100644
> --- a/scripts/dtc/fdtput.c
> +++ b/scripts/dtc/fdtput.c
> @@ -84,7 +84,7 @@ static int encode_value(struct display_info *disp, char **arg, int arg_count,
>  			value_size = (upto + len) + 500;
>  			value = realloc(value, value_size);
>  			if (!value) {
> -				fprintf(stderr, "Out of mmory: cannot alloc "
> +				fprintf(stderr, "Out of memory: cannot alloc "
>  					"%d bytes\n", value_size);
>  				return -1;
>  			}
> 

This is a very old version of the upstream file.  update-dtc-source.sh does
not pull new versions of this file.

We don't actually build fdtput, is there any reason to not just remove
scripts/dtc/fdtput.c?

-Frank
