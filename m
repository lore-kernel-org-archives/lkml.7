Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F79213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axp4PAGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfETPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:10:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37792 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfETPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:10:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so6865588pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zf/b75c5bSD4qvEIIv/t+c3t9VM2ZbZd5sbL+Pqt2/A=;
        b=axp4PAGTZM3hbODFyEUuqLrn6uI5P/Kg9MvWlfIiXTe15qdoZWMSpo+ZzlLIPrXywu
         e4tzGjPDk6ZF+TIK5y9iTEkdRVtMoaBaD8kT+5xiTSWZbs5RxOBDQeoYFcGAt6fALWQK
         +deE2WHpizsTr9UUYtj+Sd0HWwmLTufGrI0++xAboUkMP2obDwrJHYDdAmnU7SCJiKjY
         tBQxR9kQxVaKa/JWh+bhSFNExbFO09vT4dXNlllSxeSL4wE6tetSzUi4Yz3M33+/aLNp
         pRsLLynl7xNONdQZHKqUb9Bn2u3gGwgtkD++CzB8ThT02XfzOe8eNw7oO6NjRym28QCc
         wV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zf/b75c5bSD4qvEIIv/t+c3t9VM2ZbZd5sbL+Pqt2/A=;
        b=NyNmn2l6ju903J1PeR6I2YQmARLHFx3+g//PEVKJRRMwMPrLxsHn2STvsytmKU83cN
         XeRr8tt5RaEy5pm8YIwzIaNbqwcHMtv1OkR/KOe4l3yHhD5IQjCIed8C2614eQhZjikB
         Peeg+k9JbcSYrfhSfErJ9Q/t4v2xTBsX2Z2PvCKHCd+AI4BBfsZKMsnQvdUz7hBA8juP
         6DUaDTHzi0DGBc6G2ATIpXB8KieQoGiNtVKTbbh6XbPPoLhk8TNRG/oJqdUMKuW70fFR
         LBty1bGLQUZFu2T1XpZbR09yBFVwAVk5MLZrtCCUMnC14puJDI/pOVAsjVKn9rPVLSGM
         Fjrg==
X-Gm-Message-State: APjAAAUm+aBYuRhyq7C9XYFAOee3kSQSgatEMxiISOb16wPYJFtm+sWm
        BUMd4zLnTw24xZLlx51PFRj7gA==
X-Google-Smtp-Source: APXvYqyIbxhF72Gddpb/bXpKewAASsv+q88oJd8k2OIHZXaugro0tQWP23rMQUZmDPFL6LFBkt1pqg==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7mr26678451plg.192.1558365034795;
        Mon, 20 May 2019 08:10:34 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o66sm21164864pfb.184.2019.05.20.08.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:10:34 -0700 (PDT)
Date:   Mon, 20 May 2019 08:11:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        agsumit@qti.qualcomm.com
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
Message-ID: <20190520151101.GN2085@tuxbook-pro>
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
 <20190520145110.7BDAE21721@mail.kernel.org>
 <254704a2-ee20-30cd-8362-6e1bd23ec090@linaro.org>
 <f0c89b84-7c3d-596d-06e1-cb5172e62970@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c89b84-7c3d-596d-06e1-cb5172e62970@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 07:58 PDT 2019, Jorge Ramirez wrote:

> On 5/20/19 16:56, Jorge Ramirez wrote:
> > On 5/20/19 16:51, Stephen Boyd wrote:
> >> Quoting Jorge Ramirez-Ortiz (2019-05-20 03:34:35)
> >>> When the tty layer requests the uart to throttle, the current code
> >>> executing in msm_serial will trigger "Bad mode in Error Handler" and
> >>> generate an invalid stack frame in pstore before rebooting (that is if
> >>> pstore is indeed configured: otherwise the user shall just notice a
> >>> reboot with no further information dumped to the console).
> >>>
> >>> This patch replaces the PIO byte accessor with the word accessor
> >>> already used in PIO mode.
> >>
> >> Because the hardware only accepts word based accessors and fails
> >> otherwise? I can believe that.
> >>
> >> I wonder if the earlier UART hardware this driver used to support (i.e.
> >> pre-DM) would accept byte access to the registers. It's possible, but we
> >> don't really care because those boards aren't supported.
> > 
> > ok.
> > 
> > also the PIO path uses iowrite32_rep to write a number of bytes (from 1
> > to 4) so I think it is also appropriate to use it for XON/XOFF.
> > 
> >>
> >>>
> >>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >>> ---
> >>
> >> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >>
> >>>  drivers/tty/serial/msm_serial.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> >>> index 109096033bb1..23833ad952ba 100644
> >>> --- a/drivers/tty/serial/msm_serial.c
> >>> +++ b/drivers/tty/serial/msm_serial.c
> >>> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
> >>>                 else
> >>>                         tf = port->membase + UART_TF;
> >>>  
> >>> +               buf[0] = port->x_char;
> >>> +
> >>>                 if (msm_port->is_uartdm)
> >>>                         msm_reset_dm_count(port, 1);
> >>>  
> >>> -               iowrite8_rep(tf, &port->x_char, 1);
> >>> +               iowrite32_rep(tf, buf, 1);
> >>
> >> I suppose it's OK to write some extra zeroes here?
> >>
> >>
> > 
> > yeah, semantically confusing msm_reset_dm_count is what really matters:
> > it tells the hardware to only take n bytes (in this case only one) so
> > the others will be ignored
> 
> um after I said this, maybe iowrite32_rep should only be applied to
> uartdm ... what do you think?
> 

If I read the history correctly this write was a writel() up until
68252424a7c7 ("tty: serial: msm: Support big-endian CPUs").

So I think you should just change this back to a iowrite32_rep() and add
a Fixes tag.

Regards,
Bjorn
