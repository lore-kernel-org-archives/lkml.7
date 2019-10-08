Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8279DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BB721721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcTU11Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfJHSGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:06:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40316 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfJHSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:06:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so11227196pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h90Cd6MFGBRWfIimfxDnjpF0R2GtcjUaWODUBYbROSc=;
        b=bcTU11VhW9Rk4bFEn8L9uZiTfbCu3q1YDIve80+3ruXqCLIgHegYyZXYYE1mFyB68A
         VLzam38yk/JfzSNR1ezSKO6A4o9hl1Bafu8/69nZExRPm8aWtLheMURGyFI6kP7ilJ29
         iuB9ja5T9g+viozO8c6ZnepS2X7mVNAP0nAiuz1bME/8nssgefqS2YRm8DSDv42llzrk
         TQX8Xg7YtOKWVP7B+Tz0zEbBW7JEKnv37D6J4JPpn0eu5npTtLFKCA2BtFfAPEJyBJk/
         CzauLGDk6CsBOo/7KBCgRAL/7/7CFBpPjrki7KwpQCP4VRGdD1WlpUrzH/6hNpAK3eNb
         3Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h90Cd6MFGBRWfIimfxDnjpF0R2GtcjUaWODUBYbROSc=;
        b=EwW60qKmrLfFEA/c6vhqlexophrBi3kEfmyvol0ffuRjM2HQ30c7VUU9aALSDze0sU
         x+1av/RxV4A3mNsdaezLgl/tTZaGjgNJkagHwD3Q0YyRV+/pZePOMHb2fdapT8VrRzeS
         sgx2XeHPCntrXQXdasiE7Nw+n3dkE/Yqo69TLY+q/rny2svNcaaiVoyHVC0lbMC7astm
         bKxe20arlLdpmIb6+waEVyWToXMMVii8uEqBPnWkuJbBwUq4qzPnUASr4xZltVeN0zkN
         m2pUDF0jJAr9uuW6LfjyymeHsaBKZGV3qlwqPNFJkqTSw4Ue4/XkF5B1FZH2mtHBV5EQ
         DyjQ==
X-Gm-Message-State: APjAAAV8keqtIXHz/OlRqXG8gp+yXKiPLsKcMppiLrFaCZS3AA6cmOT0
        axUWLsRIE2tfcf50uUdRB9sKPw==
X-Google-Smtp-Source: APXvYqx79kSccdtkViHSGl14EAIVEHPyIzTMoHZYqqFCd0NqRcYa0dDt3iUZE3oGjGLlBHQZdHj/lg==
X-Received: by 2002:a63:c306:: with SMTP id c6mr36235226pgd.253.1570557993927;
        Tue, 08 Oct 2019 11:06:33 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q88sm2826700pjq.9.2019.10.08.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:06:33 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:06:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Murali Nalajala <mnalajal@codeaurora.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] base: soc: Handle custom soc information sysfs entries
Message-ID: <20191008180631.GI63675@minitux>
References: <1570480662-25252-1-git-send-email-mnalajal@codeaurora.org>
 <5d9cac38.1c69fb81.682ec.053a@mx.google.com>
 <20191008154346.GA2881455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008154346.GA2881455@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Oct 08:43 PDT 2019, Greg KH wrote:

> On Tue, Oct 08, 2019 at 08:33:11AM -0700, Stephen Boyd wrote:
> > Quoting Murali Nalajala (2019-10-07 13:37:42)
> > > Soc framework exposed sysfs entries are not sufficient for some
> > > of the h/w platforms. Currently there is no interface where soc
> > > drivers can expose further information about their SoCs via soc
> > > framework. This change address this limitation where clients can
> > > pass their custom entries as attribute group and soc framework
> > > would expose them as sysfs properties.
> > > 
> > > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > > ---
> > 
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > 
> 
> Nice, can we convert the existing soc drivers to use this interface
> instead of the "export the device pointer" mess that they currently
> have?  That way we can drop that function entirely.
> 

Unfortunately we can't just drop it, because it's used on some SoCs as
the parent of all platform_devices. 

But we can definitely get rid of all that uses it to create sysfs files.

Regards,
Bjorn
