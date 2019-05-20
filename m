Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A37C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RitRrcOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392238AbfETPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:38:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392222AbfETPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:38:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so6981363pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uCWJzdwhd+1tcKYTw9hbwn1gSRk4OfXO/IfxBU/gQqU=;
        b=RitRrcORQKf+bf+V7kUhKt/VteE8EfoRgt6oDx2NkazjO092KWhyXfIY8cz5KRbghJ
         DcRA19lvMkL8cE+Tgz+8inpbO252vrn1vn6b2VC6u28Gb3mVoCTriA0eX6wvYkfem+SZ
         Ls/RvRHjLd28SZWWXGdgUP0zwz6+cvcXx+TMYCcpvMsx/ea99XtJ6rh89MVMTzrSz9s7
         r+R7cw5ZPYHyN0abG/lwThCl+sJ8q8dF9i0O1fM+4q9hxOdEaXry7Q71Uc+PbqX1e78U
         t8niY6F3SXz43iWmsZqeTGTxte2bKw5nYdNQCKBqLm0xBvCygJRBgg93g6c3lVMBJxWp
         jWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCWJzdwhd+1tcKYTw9hbwn1gSRk4OfXO/IfxBU/gQqU=;
        b=RblYFX66i68pzFVcBDbSV//VFpTRgZVLZJlpiDp4KQn0NIHsuCCtfmzUR9Pst+bwLR
         gks06hcj2t2fh98iLEv2ett9/eb4sO73jJQ4ZLL4ymZwT/LfMt+J0CPg6PD1dThIfAEZ
         xmkPZF4bi/8BzQITnBnow05gXUgmVTEc1gHVwoNvEGynx5vBlG73xNNlneuFHnKxYpfc
         BDppAGmS0msaJS2FH6bVcDQTpOX7FNrEz1hTvUTGxzgPv56JL6Fm1RcDKmu9AzD8teYf
         9b9xXs8rMTDEL4tFkC1+NdfqmlUvqR9xYfOkG1XlcrBptuWiFnvAirzPlnnOIkwoQ5X2
         6w4g==
X-Gm-Message-State: APjAAAVO/D/Zjw0kYvQf9Mh/eSLxrlcUpa+RDlv4O0+BmNY9cOgn67ub
        WtKEcGuTdZ/V4hsdafT+t75l9g==
X-Google-Smtp-Source: APXvYqz3pl2TAuMTOYMc3sgPvfPgTTg/TRNOne3MjnLr9w2cCjHNOmjNjfTZKgGDGgKwzoKkFxJEhg==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr73970975pgv.22.1558366700866;
        Mon, 20 May 2019 08:38:20 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e10sm37179794pfm.137.2019.05.20.08.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:38:20 -0700 (PDT)
Date:   Mon, 20 May 2019 08:38:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net,
        ilias.apalodimas@linaro.org, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] net: qualcomm: rmnet: fix struct rmnet_map_header
Message-ID: <20190520153847.GP2085@tuxbook-pro>
References: <20190520135354.18628-1-elder@linaro.org>
 <20190520135354.18628-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135354.18628-2-elder@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 06:53 PDT 2019, Alex Elder wrote:

> The C bit-fields in the first byte of the rmnet_map_header structure
> are defined in the wrong order.  The first byte should be formatted
> this way:
>                  +------- reserved_bit
>                  | +----- cd_bit
>                  | |
>                  v v
>     +-----------+-+-+
>     |  pad_len  |R|C|
>     +-----------+-+-+
>      7 6 5 4 3 2 1 0  <-- bit position
> 
> But the C bit-fields that define the first byte are defined this way:
>     u8 pad_len:6;
>     u8 reserved_bit:1;
>     u8 cd_bit:1;
> 
> And although this isn't portable, I can state that when I build it
> the result puts the bit-fields in the wrong location (e.g., the
> cd_bit is in bit position 7, when it should be position 0).
> 
> Fix this by reordering the definitions of these struct members.
> Upcoming patches will reimplement these definitions portably.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> index 884f1f52dcc2..b1ae9499c0b2 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> @@ -40,9 +40,9 @@ enum rmnet_map_commands {
>  };
>  
>  struct rmnet_map_header {
> -	u8  pad_len:6;
> -	u8  reserved_bit:1;
>  	u8  cd_bit:1;
> +	u8  reserved_bit:1;
> +	u8  pad_len:6;
>  	u8  mux_id;
>  	__be16 pkt_len;
>  }  __aligned(1);
> -- 
> 2.20.1
> 
