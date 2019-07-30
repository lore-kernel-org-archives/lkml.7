Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2814C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89484206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SJcJ5Fmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfG3QOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:14:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34743 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfG3QOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:14:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id q128so23997953ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9MpfSgkGCnSje8H9mA2izkiuK0kqTLnZkcT+mvy7Z6I=;
        b=SJcJ5FmoPGTOo5WYdwowLs6YmtfNfpe2ZLcJN+aAMXSYtZ0nWCHoGG37HZnNJ7H2kv
         ZVjWKYzva7JPPQlqr/yp/xM7t/Vr8HHlSBERBpjUrbs1fjd1omsJ2OMjajnUUM8s5228
         LR83VVIwznftfwRKwA777HP3t0HEymbA6lsX++vhP9NmWv986lmEqUMYsp8NiXw8Ock0
         TJyDOkapxtv89Gfgaum2kk+zvPYr4lTNNSnFM74RgDIruOz3e8tDf+A4hi2hA7RRE2hp
         o1/wOfQkMzE5OTw1owIuocb6vEcsvlvgZU5FdZgUYU7gbQEXYWRmbpz8SEISdKE3yca0
         xZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MpfSgkGCnSje8H9mA2izkiuK0kqTLnZkcT+mvy7Z6I=;
        b=TqxrrJ5Tgi0JMicMRRdrOA7jSvlhAP7SbncPMeHtZTmP25mVXFSt0tLRJCFTbin9yc
         /2yPQw04NM/GcYtD9IA8gMyRJYdd/15u3fXClZsYbIMqec+deDfChpSQcwy5FB0jUKFf
         mLcFguBMUo4TY+hO9KioPSO155XbQ8w2caxvrneBP6yVTJWJioYaBa69vxQhpqJayogs
         kiNJQwB75gUPqhzqj3j3xDivxSuC/vdLBl3/HkaJqDt5iUvFtxgYdrO1WUTbj1NZlAdR
         rLsb9JmDDGLvjDSycusjcI9g33nYQd12sy1YP4w7hDn8weTe4mcR6exj704QB1BdYs5k
         Qkag==
X-Gm-Message-State: APjAAAUzFuSM1AQUH8GrYq96ziotjSLdSX03x7mgpsMrbKAqIRe8NaVC
        E2UQLTfEFQePh1F3xjcYawTLcA==
X-Google-Smtp-Source: APXvYqxIUiM8pj4HbXTH0Gjcik1/NQLYcK7sffYMLl1yH2GjBJS0ug4Nd+NI/f9vmL9+2GTUkJWelQ==
X-Received: by 2002:a81:3d7:: with SMTP id 206mr66248427ywd.411.1564503275686;
        Tue, 30 Jul 2019 09:14:35 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id z9sm15173307ywj.84.2019.07.30.09.14.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 09:14:34 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:14:34 -0400
From:   Sean Paul <sean@poorly.run>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Sean Paul <sean@poorly.run>, Matthias Kaehlcke <mka@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Jackson <ajax@redhat.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
Message-ID: <20190730161434.GQ104440@art_vandelay>
References: <20190722181945.244395-1-mka@chromium.org>
 <20190722202426.GL104440@art_vandelay>
 <20190722210207.GZ250418@google.com>
 <20190725174927.GN104440@art_vandelay>
 <ea3219fd-b8eb-279b-aa08-c77705a31249@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3219fd-b8eb-279b-aa08-c77705a31249@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:38:23PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 25/07/2019 19:49, Sean Paul wrote:
> > On Mon, Jul 22, 2019 at 02:02:07PM -0700, Matthias Kaehlcke wrote:
> >> On Mon, Jul 22, 2019 at 04:24:26PM -0400, Sean Paul wrote:
> >>> On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
> >>>> The DDC/CI protocol involves sending a multi-byte request to the
> >>>> display via I2C, which is typically followed by a multi-byte
> >>>> response. The internal I2C controller only allows single byte
> >>>> reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> >>>> supported when the internal I2C controller is used. The I2C
> >>>
> >>> This is very likely a stupid question, but I didn't see an answer for it, so
> >>> I'll just ask :)
> >>>
> >>> If the controller supports xfers of 8 bytes and 1 bytes, could you just split
> >>> up any of these transactions into len/8+len%8 transactions?
> >>
> >> The controller interprets all transfers to be register accesses. It is
> >> not possible to just send the sequence '0x0a 0x0b 0x0c' as three byte
> >> transfers, the controller expects an address for each byte and
> >> (supposedly) sends it over the wire, which typically isn't what you
> >> want.
> >>
> >> Also the 8-byte reads only seem to be supported in certain
> >> configurations ("when the DWC_HDMI_TX_20 parameter is enabled").
> > 
> > Thanks for the detailed answers (both you and Doug)!
> > 
> > This change looks good to me, but I'll leave it to a dw-hdmi expert to apply. So
> > fwiw,
> 
> I'm not qualified as a dw-hdmi expert but until the internal i2c controller
> is exposed as a "standard" i2c adapter (which is a valuable feature),
> blacklisting a fixed address is wrong, and we should detect invalid/malformed
> transactions instead that doesn't fit in the HW model OR really stop emulating
> an i2c adapter.

I think we all agree on this (and Doug mentioned it upthread). That said, the
driver is currently returning successful status and garbage data. I think that's
objectively worse than returning an error, and this patch really doesn't
prevent us from doing it right in the future.

If the code wasn't already upstream, I agree we should pivot to the correct
solution. But unless someone volunteers to fix this the right way, I don't have
a problem with this patch for now.

Sean

> 
> Moving to drm_do_get_edid() would need to entirely rewrite or refactor communication
> code to handle the SCDC transactions, since they use an i2c adapter...
> 
> Neil
> 
> > 
> > Reviewed-by: Sean Paul <sean@poorly.run>
> > 
> > 
> >>
> >>>> transfers complete without errors, however the data in the response
> >>>> is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> >>>> -EOPNOTSUPP, to make it evident that the communication is failing.
> >>>>
> >>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>>> ---
> >>>> Changes in v2:
> >>>> - changed DDC_I2C_ADDR to DDC_CI_ADDR
> >>>> ---
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> index 045b1b13fd0e..28933629f3c7 100644
> >>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> @@ -35,6 +35,7 @@
> >>>>  
> >>>>  #include <media/cec-notifier.h>
> >>>>  
> >>>> +#define DDC_CI_ADDR		0x37
> >>>>  #define DDC_SEGMENT_ADDR	0x30
> >>>>  
> >>>>  #define HDMI_EDID_LEN		512
> >>>> @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> >>>>  	u8 addr = msgs[0].addr;
> >>>>  	int i, ret = 0;
> >>>>  
> >>>> +	if (addr == DDC_CI_ADDR)
> >>>> +		/*
> >>>> +		 * The internal I2C controller does not support the multi-byte
> >>>> +		 * read and write operations needed for DDC/CI.
> >>>> +		 */
> >>>> +		return -EOPNOTSUPP;
> >>>> +
> >>>>  	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
> >>>>  
> >>>>  	for (i = 0; i < num; i++) {
> >>>
> > 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
