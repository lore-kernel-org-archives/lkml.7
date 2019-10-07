Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E562133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAR6H5Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJGF27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:28:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGF27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:28:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so1642871pga.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CXK/TfIsFpbZLDTPIgvREp06YCnBiMnqmaYjisViyY=;
        b=LAR6H5ZasQ8iPevuWF+vXdOwHJGt5uk3xJbaFv6C3Wd9u8HmgtJ7Qg1L9LdY53wOkb
         VlAWraIS3WJAoWfzYnoOTrCajo64NTbKw29mvKtcijueTi461E0NhHneWYXchgRAwGPo
         OMLFjD8p8ob0dUXytONE0BJpczSF3nlVSXdXrh3BvIgv9AY1c+ZtfF4K81uinVuGJm9i
         mQEgpVY2dy5APQJBUNydRXtQtV7aEMZRBSm4hbPfzEv8nh+cXOUbiOHDsZXfpH+oefTi
         0P5coqYfZJRXraFDBNiwdwdnLyo4W/A77yzEzLD85hCoSy5o8VgzOEZabEEgo/QzXanB
         qnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CXK/TfIsFpbZLDTPIgvREp06YCnBiMnqmaYjisViyY=;
        b=Hz5oolbYimrYMCaOrJl5C0gQNvWT7LNK8Nb4EOUtEv0N3SN9Ddf+++XP6iNtzB5k9H
         t5pvk4pluIY7duLRM8Qj21RYSzolVWvPesMqT9cgvCibd4XWVe//BQTkojXNBw3EB2S8
         5mhx4kyk9RPsw2JNWwm9TtVWd1VNXyLZ6ZkXS0RU/iFyxMhYjVq8Duosfq5pRId79ZfF
         TSKXoJR8o/eXI3YsaHWZNj0kqmmtA8oAHMhzmzduzWDSDRTd/uo+woE8Dhapd/hokZ6s
         T+z4fDTKvWJr+z84xZf2klyG2pkR808FBQEv2tKRK0UlCkqRf8D2CZ8jrdj1ubr6g+HN
         XeZQ==
X-Gm-Message-State: APjAAAUaMDEPN8XG6w2XzERAXgObqLcvkU9Gp/PU8Xtf052aaSKyBcBq
        fhyGNKgFV15IokwWlTUOFGL7cQ==
X-Google-Smtp-Source: APXvYqwARGPm8j9a3QW8CuObVYB93bhWW7qnb5wALsOagBKs4r23n5w4xw65KVbYM5DnmJnWEkGMBA==
X-Received: by 2002:a62:8683:: with SMTP id x125mr30083504pfd.108.1570426138723;
        Sun, 06 Oct 2019 22:28:58 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d20sm18058167pfq.88.2019.10.06.22.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 22:28:57 -0700 (PDT)
Date:   Sun, 6 Oct 2019 22:28:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, robh+dt@kernel.org,
        agross@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] soc: qcom: smd-rpm: Create RPM interconnect proxy
 child device
Message-ID: <20191007052855.GE2999@tuxbook-pro>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-3-georgi.djakov@linaro.org>
 <20191007020152.GA16902@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007020152.GA16902@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 06 Oct 19:01 PDT 2019, Brian Masney wrote:

> On Thu, Jun 13, 2019 at 06:13:20PM +0300, Georgi Djakov wrote:
> > Register a platform device to handle the communication of bus bandwidth
> > requests with the remote processor. The interconnect proxy device is part
> > of this remote processor (RPM) hardware. Let's create a icc-smd-rpm proxy
> > child device to represent the bus throughput functionality that is provided
> > by the RPM.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Brian Masney <masneyb@onstation.org> # msm8974
> 
> I think this patch may have fell through the cracks since I don't see
> it in linux-next. The qcs404 patches in this series were merged.
> 

Yes, I was expecting Georgi to pick the entire series through his tree,
but see now that I didn't actually ask Georgi to do so. Sorry about
that.

I picked the this and the dts patch last week, so if it's not in
linux-next yet it should show up in the next one.

Thanks,
Bjorn

> Brian
> 
> > ---
> > 
> > v4:
> > - Return error if platform_device_register_data() fails
> > - Remove platform_set_drvdata() on the child device.
> > 
> > v3:
> > - New patch.
> > 
> >  drivers/soc/qcom/smd-rpm.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> > index fa9dd12b5e39..34cdd638a6c1 100644
> > --- a/drivers/soc/qcom/smd-rpm.c
> > +++ b/drivers/soc/qcom/smd-rpm.c
> > @@ -19,12 +19,14 @@
> >  /**
> >   * struct qcom_smd_rpm - state of the rpm device driver
> >   * @rpm_channel:	reference to the smd channel
> > + * @icc:		interconnect proxy device
> >   * @ack:		completion for acks
> >   * @lock:		mutual exclusion around the send/complete pair
> >   * @ack_status:		result of the rpm request
> >   */
> >  struct qcom_smd_rpm {
> >  	struct rpmsg_endpoint *rpm_channel;
> > +	struct platform_device *icc;
> >  	struct device *dev;
> >  
> >  	struct completion ack;
> > @@ -193,6 +195,7 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
> >  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  {
> >  	struct qcom_smd_rpm *rpm;
> > +	int ret;
> >  
> >  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
> >  	if (!rpm)
> > @@ -205,11 +208,23 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  	rpm->rpm_channel = rpdev->ept;
> >  	dev_set_drvdata(&rpdev->dev, rpm);
> >  
> > -	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> > +	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> > +						 NULL, 0);
> > +	if (IS_ERR(rpm->icc))
> > +		return PTR_ERR(rpm->icc);
> > +
> > +	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> > +	if (ret)
> > +		platform_device_unregister(rpm->icc);
> > +
> > +	return ret;
> >  }
> >  
> >  static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
> >  {
> > +	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> > +
> > +	platform_device_unregister(rpm->icc);
> >  	of_platform_depopulate(&rpdev->dev);
> >  }
> >  
