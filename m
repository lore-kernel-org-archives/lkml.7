Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CAE218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlBzAb9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfDXNxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:53:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39194 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbfDXNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:53:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so14315441oih.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/bC6hLD/g3OgUa8hh5mrSXc3gwQP7B0A07LboDv49Wg=;
        b=GlBzAb9omtamPBJR2+cArV7a4ckFwyF38/OgZ9FtNYRJIg1cV8wF4/355v36l0BKF0
         dPUjLaD6AKTtnvbQnO5dluKZz1TqGKdHlqh0Kc2lD3kk1HNTWtWL8TB0sTjEDgKEzWuY
         pv1fZAkKsdUcpgjlCcF6YgqcG5alK/+kY/LgrWzCfdyMLGRTPlruHeQlWpcwwEhlhWiJ
         6WXYknn+BitfeId5sKsmwIkC0eBNwrR/+i8mStn2bOFXv+x+qN22HyH8KoI+8y6DUa9H
         yf8U9sn8h3O0z7dpLx+0HUe3ZugYkFSloNe6FFTtE12DpzffOE0Hx0r+Ez3Re3XP5Mmv
         2xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=/bC6hLD/g3OgUa8hh5mrSXc3gwQP7B0A07LboDv49Wg=;
        b=GQh4IDBDfVlK7C9nPRlhT2KQ5CGfKkd6qV34M1W2XlTLUUJVPa3nTMhS7wjrYfbG/h
         oTrQwVugLBAs4a/5QnIqUSJR7Ef8V9gTKUMt6dgqtar8S/CM6eCqxnH5dQBUox4gvkO+
         0dB8lgVchWrMrnJ2+qXUGda0k9a5TdjZ5LtCqNs1KsF4+zxV5OU4UswF8F0eXozYbek1
         rjW4Vhw6jrtJcHEWGnE3XB028+4J0CPzLYXUwF9BUMl+Gnt+DAQtuVn6dfkodT1YLkTD
         h1h08K142uaoBGHmmdzBkvA6LAaZkIc2zXbAogPf1gSNOhZEpzaEcL+FMfDHTfarAhLP
         k9FQ==
X-Gm-Message-State: APjAAAW+TMKPrXIgqQU5BPK0gUlVSIu881r29ubMltLGaxL2wc/LgTti
        Gv5BEMEev0bRV9bwACg+BMl9tk0=
X-Google-Smtp-Source: APXvYqz54UlY38ZpiwFflAQMicz/39nL4plqKYoCaaj5hU2QOi7A6xG58czYcwO+AboFZoAsyqj+Yg==
X-Received: by 2002:aca:ef8a:: with SMTP id n132mr1146603oih.98.1556114022977;
        Wed, 24 Apr 2019 06:53:42 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id k60sm7951096otc.42.2019.04.24.06.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:53:42 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 5D0501800CF;
        Wed, 24 Apr 2019 13:53:41 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:53:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kamlakant Patel <kamlakantp@marvell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] ipmi:ssif: compare block number correctly for multi-part
 return messages
Message-ID: <20190424135340.GD6623@minyard.net>
Reply-To: minyard@acm.org
References: <1556106615-18722-1-git-send-email-kamlakantp@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556106615-18722-1-git-send-email-kamlakantp@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:50:43AM +0000, Kamlakant Patel wrote:
> According to ipmi spec, block number is a number that is incremented,
> starting with 0, for each new block of message data returned using the
> Middle transaction.
> 
> Here, the 'blocknum' is data[0] which always starts from zero(0) and
> 'ssif_info->multi_pos' starts from 1.
> So, we need to add +1 to blocknum while comparing with multi_pos.

Indeed, I think you are right.  I hope there's no other hardware that
mis-interprets this like I did.  I'll need to fix my qemu simulation,
too.  The funny thing is, the comment is correct. Hmm.

I'll hand-apply this, as it has DOS newlines, too.

-corey

> 
> This change fixes ("ipmi:ssif: Fix handling of multi-part return
> messages").
> 
> Reported-by: Kiran Kolukuluru <kirank@ami.com>
> Signed-off-by: Kamlakant Patel <kamlakantp@marvell.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 8b5aec5..2b03845 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -727,7 +727,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  			/* End of read */
>  			len = ssif_info->multi_len;
>  			data = ssif_info->data;
> -		} else if (blocknum != ssif_info->multi_pos) {
> +		} else if (blocknum + 1 != ssif_info->multi_pos) {
>  			/*
>  			 * Out of sequence block, just abort.  Block
>  			 * numbers start at zero for the second block,
> -- 
> 1.8.3.1
> 
