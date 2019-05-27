Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67564C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CE921479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwyLnWMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfE0RP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:15:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38811 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfE0RP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:15:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so6168222lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQYcUfzJ2eNZWZPGMl/JEm3foS8Vd5oiqQcXqPz07kw=;
        b=IwyLnWMZV/lpbMMff8AmQ9B448MJe0hJfxwb0ybe6SaMC0lAuX1ECzmNaHNcN0Fa8/
         TZkEKkQQbEF1yrnnVZ0455tihokSvF0U2ll4z1nsJYIk4r89GxDcO4BKABRGZ35FeOHa
         JRcgJyHcrufrWvWj/HC80jNc8vqhmNVdGzyDsLPxwjAu+UasKMS9VjdT7wc1ZuuQIQLJ
         KIUbeCkVLS1APL5fNmRXP+Ad1nqkwvGH4TYMMeAPTLudHITt/L/lOSWGK2+axIJeIH+p
         sbxzFZSFJr8mPrv4POl+WTkJJ2aQA8CUgilP6GATfXEHzDBhATBuQWF3UXVkj5mnqshm
         ACtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQYcUfzJ2eNZWZPGMl/JEm3foS8Vd5oiqQcXqPz07kw=;
        b=YCCbsAguke1lbxUqb3ih7/abBxcYCbJD8iQwEKK+o4/uSsPIGt8N3zRJBI0iGnzulj
         Uu+oA4Rd5MakXk0bMqTLotBhy0ZrnMGktefcUY1wubNnDtm0QQBgQWZ+iQNZuB37xPrQ
         XDeELYeeZnxhe8wmzUJgd5MHolcoVgh1TcU7zEmUIivkxh4r0VvrER/dkt4yJVWQ0Tqb
         aZYFBz/JHFuk4+feKqp/tGYJROWo31BuPaYj+CUOdnQVImWGTe8YgosFKsnG8jZ7pxES
         kf6t2Max/9OiPPX0so7F97ut2wVj9CPzGrSRBI2qCb410nK5doYk6cf42QVxNHY2d8uB
         UtVg==
X-Gm-Message-State: APjAAAW1UTXMQEUZyBct+0h/sUENXR2bmGYm2BfPrJOJqeBg6JBVbbEv
        dGCEo82EO4QSGTAFaTiS5Laluw==
X-Google-Smtp-Source: APXvYqwsEdFVhYeFfyhJrlzePl5Iuv+PqsOCTx5ry/jO/7Fo47egn7d+efqzPXCU53fFtTFc+KItfg==
X-Received: by 2002:ac2:510b:: with SMTP id q11mr1072378lfb.11.1558977325355;
        Mon, 27 May 2019 10:15:25 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id t13sm2382792lji.47.2019.05.27.10.15.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 10:15:24 -0700 (PDT)
Date:   Mon, 27 May 2019 19:15:21 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least
 100 ms
Message-ID: <20190527171521.GA7936@centauri>
References: <20190523194409.17718-1-niklas.cassel@linaro.org>
 <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 02:43:00PM +0200, Marc Gonzalez wrote:
> On 23/05/2019 21:44, Niklas Cassel wrote:
> 
> > Currently, there is only a 1 ms sleep after asserting PERST.
> > 
> > Reading the datasheets for different endpoints, some require PERST to be
> > asserted for 10 ms in order for the endpoint to perform a reset, others
> > require it to be asserted for 50 ms.
> > 
> > Several SoCs using this driver uses PCIe Mini Card, where we don't know
> > what endpoint will be plugged in.
> > 
> > The PCI Express Card Electromechanical Specification specifies:
> > "On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
> > the power rails achieving specified operating limits."
> > 
> > Add a sleep of 100 ms before deasserting PERST, in order to ensure that
> > we are compliant with the spec.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 0ed235d560e3..cae24376237c 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
> >  	if (IS_ENABLED(CONFIG_PCI_MSI))
> >  		dw_pcie_msi_init(pp);
> >  
> > +	/* Ensure that PERST has been asserted for at least 100 ms */
> > +	msleep(100);
> >  	qcom_ep_reset_deassert(pcie);
> >  
> >  	ret = qcom_pcie_establish_link(pcie);
> 
> Currently, qcom_ep_reset_assert() and qcom_ep_reset_deassert() both include
> a call to usleep_range() of 1.0 to 1.5 ms
> 
> Can we git rid of both if we sleep 100 ms before qcom_ep_reset_deassert?

These two sleeps after asserting/deasserting reset in qcom_ep_reset_assert()/
qcom_ep_reset_deassert() matches the sleeps in:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1942

and

https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1949

I would rather not remove these since that might affect existing devices.


This new sleep matches matches the sleep in:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n3926

> 
> Should the msleep() call be included in one of the two wrappers?

This new sleep could be moved into qcom_ep_reset_deassert(),
added before the gpiod_set_value_cansleep(pcie->reset, 0) call,
if Stanimir prefers it to be placed there instead.


Kind regards,
Niklas
